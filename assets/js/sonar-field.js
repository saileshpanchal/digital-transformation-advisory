/*
 * Sonar field: the dot field behind the homepage hero.
 *
 * A vanilla port of the designer's dot-field reference, 28 Sep 2026.
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
  var ctx = canvas && canvas.getContext('2d');
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
  var color = getComputedStyle(canvas).color;
  var roundRect = typeof ctx.roundRect === 'function';
  var width = 0, height = 0, dpr = 0, cols = 0, rows = 0, ox = 0, oy = 0, life = 0;
  var rings = [], hot = null, raf = 0, timer = 0, lastFrame = 0, state = '', onScreen = true;

  function setState(s) { if (state !== s) { state = s; host.setAttribute('data-sonar', s); } }

  // a rounded square with side 2r (the brand override; the reference drew circles)
  function dot(cx, cy, r) {
    var side = 2 * r;
    if (roundRect) ctx.roundRect(cx - r, cy - r, side, side, side * O.corner);
    else ctx.rect(cx - r, cy - r, side, side);
  }

  function draw() {
    if (!hot) return;
    var live = rings.map(function (g) {
      var radius = g.age * O.speed, inner = radius - O.ringWidth, outer = radius + O.ringWidth;
      return { x: g.x, y: g.y, radius: radius, in2: inner > 0 ? inner * inner : 0, out2: outer * outer, fade: 1 - g.age / life };
    });
    ctx.clearRect(0, 0, width, height);
    ctx.fillStyle = color;
    var n = 0;
    // pass 1: every resting dot in one path and one fill
    ctx.globalAlpha = O.baseOpacity;
    ctx.beginPath();
    for (var c = 0; c < cols; c++) {
      var cx = ox + c * O.spacing;
      for (var r = 0; r < rows; r++) {
        var cy = oy + r * O.spacing, energy = 0;
        for (var i = 0; i < live.length; i++) {
          var g = live[i], dx = cx - g.x, dy = cy - g.y, d2 = dx * dx + dy * dy;
          if (d2 >= g.out2 || d2 < g.in2) continue; // outside the wavefront's band
          var t = 1 - Math.abs(Math.sqrt(d2) - g.radius) / O.ringWidth;
          var k = t * t * (3 - 2 * t) * g.fade;      // smoothstep, fading with age
          if (k > energy) energy = k;
        }
        if (energy < 0.01) dot(cx, cy, O.dotRadius);
        else { hot[n++] = cx; hot[n++] = cy; hot[n++] = energy; }
      }
    }
    ctx.fill();
    // pass 2: only the dots on a wavefront get their own alpha and size
    for (i = 0; i < n; i += 3) {
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
    rings = rings.filter(function (g) { g.age += dt; return g.age < life; });
    draw();
    if (rings.length) raf = requestAnimationFrame(frame);
    else setState('idle');
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

  // a ring at fractions (fx, fy) of the ping area
  function pingAt(fx, fy, age) {
    var a = O.pingArea;
    addRing(width * (a[0] + fx * (a[2] - a[0])), height * (a[1] + fy * (a[3] - a[1])), age);
  }

  function arm() { if (!timer) timer = window.setTimeout(ambient, O.pingEvery * 1000); }
  function ambient() {
    timer = 0;
    if (reduce.matches || state === 'paused') return;
    pingAt(Math.random(), Math.random());
    arm();
  }

  function stop() { cancelAnimationFrame(raf); window.clearTimeout(timer); raf = timer = 0; }

  function pause() {
    if (state === 'paused' || state === 'static') return;
    stop();
    rings = [];
    draw();
    setState(reduce.matches ? 'static' : 'paused');
  }
  function resume() {
    if (!onScreen || document.hidden || reduce.matches || state !== 'paused') return;
    setState('idle');
    arm();
  }

  function resize() {
    var rect = host.getBoundingClientRect();
    var w = Math.max(1, Math.round(rect.width)), h = Math.max(1, Math.round(rect.height));
    var d = Math.min(window.devicePixelRatio || 1, O.maxDpr);
    if (w === width && h === height && d === dpr) return; // the observer's first callback repeats the explicit call
    width = w; height = h; dpr = d;
    canvas.width = Math.round(width * dpr);
    canvas.height = Math.round(height * dpr);
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    cols = Math.ceil(width / O.spacing) + 1;
    rows = Math.ceil(height / O.spacing) + 1;
    ox = (width - (cols - 1) * O.spacing) / 2;
    oy = (height - (rows - 1) * O.spacing) / 2;
    hot = new Float32Array(cols * rows * 3);
    life = (Math.hypot(width, height) + O.ringWidth) / O.speed; // seconds until a ring's wavefront has left the canvas
    draw();
  }

  host.addEventListener('pointerdown', function (e) {
    if (reduce.matches || state === 'paused') return;
    var rect = host.getBoundingClientRect();
    addRing(e.clientX - rect.left, e.clientY - rect.top);
  });
  document.addEventListener('visibilitychange', function () { if (document.hidden) pause(); else resume(); });
  // The site serves this file to any browser, so the observers keep their fallbacks.
  if ('IntersectionObserver' in window) {
    new IntersectionObserver(function (entries) {
      onScreen = entries[entries.length - 1].isIntersecting;
      if (onScreen) resume(); else pause();
    }).observe(host);
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
  pingAt(0.68, 0.34, 0.5); // seed: one ring already mid-expansion, so the first paint shows the idea
})();
