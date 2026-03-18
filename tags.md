---
layout: page
title: Tags
permalink: /tags/
---

<div class="tag-cloud">
{% assign tags = site.tags | sort %}
{% for tag in tags %}
  <a href="#{{ tag[0] | slugify }}" class="tag">{{ tag[0] }} ({{ tag[1].size }})</a>
{% endfor %}
</div>

{% for tag in tags %}
<div class="tag-group" id="{{ tag[0] | slugify }}">
  <h2>{{ tag[0] }}</h2>
  <ul>
    {% for post in tag[1] %}
    <li>
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%Y-%m-%d" }}</time>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    </li>
    {% endfor %}
  </ul>
</div>
{% endfor %}
