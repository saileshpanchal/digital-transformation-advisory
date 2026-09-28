/*
 * Sonar field: the dot field behind the homepage hero.
 *
 * A vanilla port of the designer's SonarGrid (React + canvas), 28 Sep 2026.
 * Decorative infrastructure: the canvas is aria-hidden and takes no pointer
 * events; the ping listener on the host never calls preventDefault, so the
 * hero's links keep working; without this script the hero is a plain panel
 * and nothing is lost.
 *
 * Lifecycle is a four-state machine, written to the host as data-sonar so a
 * check can read a state instead of watching CPU:
 *   static  prefers-reduced-motion: the grid is drawn once; no timer, no rings
 *   idle    no ring alive, no frame requested, the ambient timer armed
 *   active  rings alive, exactly one frame requested at a time
 *   paused  tab hidden or hero off-screen: frame and timer cancelled, rings
 *           cleared, so a return never leaps
 * Ambient pings are scheduled by a timer outside the frame loop, never by
 * polling the clock inside requestAnimationFrame. A ping starts the loop; the
 * loop stops when the last live ring expires. Ring age advances by the frame
 * delta (clamped), never by wall-clock time since birth.
 */
(function () {
  'use strict';

  var host = document.querySelector('[data-sonar-host]');
  if (!host) return;
  var canvas = host.querySelector('canvas');
  var ctx = canvas && canvas.getContext ? canvas.getContext('2d') : null;
  if (!ctx) return;

  var O = {
    spacing: 26,         // px between dots
    dotRadius: 1.4,      // half the side of a resting dot
    baseOpacity: 0.28,   // resting opacity; a dot on a wavefront goes to 1
    pingEvery: 2.4,      // seconds between ambient pings
    speed: 260,          // wavefront speed, px per second
    ringWidth: 90,       // wavefront thickness, px
    amplitude: 2.2,      // growth at the wave peak (2.2 = 3.2x the side)
    maxRings: 6,         // older rings are dropped first
    maxDpr: 2,
    maxDelta: 0.05,      // seconds; a throttled frame cannot make a ring leap
    corner: 0.35,        // corner radius as a fraction of a dot's side
    pingArea: [0.22, 0.18, 0.78, 0.82] // where ambient pings spawn, as fractions of width and height
  };

  var reduce = window.matchMedia('(prefers-reduced-motion: reduce)');
  var color = getComputedStyle(canvas).color || '#29abe2';
  var roundRect = typeof ctx.roundRect === 'function';
  var width = 0, height = 0, rings = [], raf = 0, timer = 0, lastFrame = 0, state = '', onScreen = true;

  function setState(s) { if (state !== s) { state = s; host.setAttribute('data-sonar', s); } }
  // seconds until a ring's wavefront has left the canvas
  function lifetime() { return (Math.hypot(width, height) + O.ringWidth) / O.speed; }

  // a rounded square with side 2r (the brand override; the demo drew circles)
  function dot(cx, cy, r) {
    var side = 2 * r;
    if (roundRect) ctx.roundRect(cx - r, cy - r, side, side, side * O.corner);
    else ctx.rect(cx - r, cy - r, side, side);
  }

  function draw() {
    var life = lifetime(), live = [], i;
    for (i = 0; i < rings.length; i++) {
      var radius = rings[i].age * O.speed;
      live.push({ x: rings[i].x, y: rings[i].y, radius: radius, reach: radius + O.ringWidth, fade: 1 - rings[i].age / life });
    }
    ctx.clearRect(0, 0, width, height);
    ctx.fillStyle = color;
    var cols = Math.ceil(width / O.spacing) + 1, rows = Math.ceil(height / O.spacing) + 1;
    var ox = (width - (cols - 1) * O.spacing) / 2, oy = (height - (rows - 1) * O.spacing) / 2;
    var hot = [];
    // pass 1: every resting dot in one path and one fill
    ctx.globalAlpha = O.baseOpacity;
    ctx.beginPath();
    for (var c = 0; c < cols; c++) {
      var cx = ox + c * O.spacing;
      for (var r = 0; r < rows; r++) {
        var cy = oy + r * O.spacing, energy = 0;
        for (i = 0; i < live.length; i++) {
          var g = live[i];
          if (Math.abs(cx - g.x) > g.reach || Math.abs(cy - g.y) > g.reach) continue;
          var dist = Math.abs(Math.hypot(cx - g.x, cy - g.y) - g.radius);
          if (dist >= O.ringWidth) continue;
          var t = 1 - dist / O.ringWidth;
          var k = t * t * (3 - 2 * t) * g.fade; // smoothstep, fading with age
          if (k > energy) energy = k;
        }
        if (energy < 0.01) dot(cx, cy, O.dotRadius); else hot.push(cx, cy, energy);
      }
    }
    ctx.fill();
    // pass 2: only the dots on a wavefront get their own alpha and size
    for (i = 0; i < hot.length; i += 3) {
      var e = hot[i + 2];
      ctx.globalAlpha = O.baseOpacity + (1 - O.baseOpacity) * e;
      ctx.beginPath();
      dot(hot[i], hot[i + 1], O.dotRadius * (1 + O.amplitude * e));
      ctx.fill();
    }
    ctx.globalAlpha = 1;
  }

  function frame(now) {
    raf = 0;
    var dt = lastFrame ? Math.min((now - lastFrame) / 1000, O.maxDelta) : 0;
    lastFrame = now;
    var life = lifetime(), kept = [];
    for (var i = 0; i < rings.length; i++) {
      rings[i].age += dt;
      if (rings[i].age < life) kept.push(rings[i]);
    }
    rings = kept;
    draw();
    if (rings.length) raf = requestAnimationFrame(frame);
    else { lastFrame = 0; setState('idle'); }
  }

  function run() {
    if (!raf) { lastFrame = 0; raf = requestAnimationFrame(frame); }
    setState('active');
  }

  function addRing(x, y, age) {
    rings.push({ x: x, y: y, age: age || 0 });
    while (rings.length > O.maxRings) rings.shift();
    run();
  }

  function arm() { if (!timer && O.pingEvery > 0) timer = window.setTimeout(ambient, O.pingEvery * 1000); }
  function ambient() {
    timer = 0;
    if (reduce.matches || state === 'paused') return;
    var a = O.pingArea;
    addRing(width * (a[0] + Math.random() * (a[2] - a[0])), height * (a[1] + Math.random() * (a[3] - a[1])));
    arm();
  }

  function pause() {
    if (raf) { cancelAnimationFrame(raf); raf = 0; }
    if (timer) { window.clearTimeout(timer); timer = 0; }
    rings = []; lastFrame = 0;
    draw();
    setState(reduce.matches ? 'static' : 'paused');
  }
  function resume() {
    if (!onScreen || document.hidden) return;
    if (reduce.matches) { setState('static'); return; }
    if (state !== 'paused') return;
    setState('idle');
    arm();
  }

  function resize() {
    var rect = host.getBoundingClientRect();
    width = Math.max(1, Math.round(rect.width));
    height = Math.max(1, Math.round(rect.height));
    var dpr = Math.min(window.devicePixelRatio || 1, O.maxDpr);
    canvas.width = Math.round(width * dpr);
    canvas.height = Math.round(height * dpr);
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    draw();
  }

  host.addEventListener('pointerdown', function (e) {
    if (reduce.matches || state === 'paused') return;
    var rect = host.getBoundingClientRect();
    addRing(e.clientX - rect.left, e.clientY - rect.top);
  });
  document.addEventListener('visibilitychange', function () { if (document.hidden) pause(); else resume(); });
  if ('IntersectionObserver' in window) {
    new IntersectionObserver(function (entries) {
      onScreen = entries[0] ? entries[0].isIntersecting : true;
      if (onScreen) resume(); else pause();
    }, { threshold: 0 }).observe(host);
  }
  if ('ResizeObserver' in window) new ResizeObserver(resize).observe(host);
  else window.addEventListener('resize', resize);
  var onMotionChange = function () { if (reduce.matches) pause(); else { setState('paused'); resume(); } };
  if (reduce.addEventListener) reduce.addEventListener('change', onMotionChange);
  else if (reduce.addListener) reduce.addListener(onMotionChange);

  resize();
  if (reduce.matches) { setState('static'); return; }
  setState('idle');
  arm();
  var a = O.pingArea;
  // seed: one ring already mid-expansion, so the first paint shows the idea
  addRing(width * (a[0] + (a[2] - a[0]) * 0.68), height * (a[1] + (a[3] - a[1]) * 0.34), 0.5);
})();
