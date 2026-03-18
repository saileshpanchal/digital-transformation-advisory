---
layout: page
title: Categories
permalink: /categories/
---

{% assign categories = site.categories | sort %}
{% for category in categories %}
<div class="category-group" id="{{ category[0] | slugify }}">
  <h2>{{ category[0] }} <small>({{ category[1].size }})</small></h2>
  <ul>
    {% for post in category[1] %}
    <li>
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%Y-%m-%d" }}</time>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    </li>
    {% endfor %}
  </ul>
</div>
{% endfor %}
