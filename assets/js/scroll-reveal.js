/*
 * Scroll word reveal: the homepage's hinge from the hero into the consequence.
 *
 * A port of the designer's scroll-word-reveal reference, 28 Sep 2026,
 * without the 220vh sticky stage: the statement sits in the flow at its
 * natural height and never pins. Progress is read from the statement's own
 * rectangle: 0 when its top reaches the lower 80% line of the viewport, 1 when
 * its bottom reaches the upper 35% line, linear between and clamped. Each word
 * brightens from 0.15 to 1 over its own slice of that progress (SPREAD and
 * WORD_DURATION as the source).
 *
 * Progressive enhancement: the stylesheet renders every word at full opacity
 * and the progress rule fully drawn. This script adds reveal--enhanced and
 * writes the inline opacities in the same frame, and does nothing at all under
 * prefers-reduced-motion, so the no-script and reduced-motion renders are the
 * same page.
 */
(function () {
  'use strict';

  var section = document.querySelector('[data-reveal]');
  if (!section) return;
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  var statement = section.querySelector('.reveal__statement');
  var rule = section.querySelector('.reveal__rule span');
  if (!statement) return;
  var words = Array.prototype.slice.call(statement.querySelectorAll('.reveal__word'));
  var count = words.length;
  if (!count) return;

  var START_LINE = 0.80, END_LINE = 0.35;      // viewport lines, as fractions of its height
  var START_OPACITY = 0.15, SPREAD = 0.8, WORD_DURATION = 0.2;
  var ranges = words.map(function (_, i) {
    var start = count <= 1 ? 0 : (i / (count - 1)) * SPREAD;
    return [start, Math.min(1, start + WORD_DURATION)];
  });
  var queued = false;

  function progress() {
    var rect = statement.getBoundingClientRect();
    var vh = window.innerHeight || document.documentElement.clientHeight;
    var p = (START_LINE * vh - rect.top) / ((START_LINE - END_LINE) * vh + rect.height);
    return p < 0 ? 0 : p > 1 ? 1 : p;
  }

  function paint() {
    queued = false;
    var p = progress();
    for (var i = 0; i < count; i++) {
      var s = ranges[i][0], e = ranges[i][1], o;
      if (p <= s) o = START_OPACITY;
      else if (p >= e) o = 1;
      else o = START_OPACITY + (1 - START_OPACITY) * ((p - s) / (e - s));
      words[i].style.opacity = o.toFixed(3);
    }
    if (rule) rule.style.transform = 'scaleY(' + p.toFixed(4) + ')';
  }

  function schedule() { if (!queued) { queued = true; window.requestAnimationFrame(paint); } }

  section.classList.add('reveal--enhanced');
  paint(); // the same frame as the class: no flash from 1 to 0.15
  window.addEventListener('scroll', schedule, { passive: true });
  window.addEventListener('resize', schedule);
  if (document.fonts && document.fonts.ready) document.fonts.ready.then(schedule);
})();
