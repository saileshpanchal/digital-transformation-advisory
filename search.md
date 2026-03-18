---
layout: page
title: Search
permalink: /search/
---

<input type="text" class="search-input" id="search-input" placeholder="Search posts..." aria-label="Search posts" autofocus>
<ul class="search-results" id="search-results"></ul>

<script>
(function() {
  var searchInput = document.getElementById('search-input');
  var searchResults = document.getElementById('search-results');
  var posts = null;

  function loadPosts() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '{{ "/search.json" | relative_url }}');
    xhr.onload = function() {
      if (xhr.status === 200) {
        posts = JSON.parse(xhr.responseText);
      }
    };
    xhr.send();
  }

  function search(query) {
    if (!posts || !query) {
      searchResults.innerHTML = '';
      return;
    }
    var terms = query.toLowerCase().split(/\s+/);
    var results = posts.filter(function(post) {
      var searchable = (post.title + ' ' + post.content + ' ' + post.tags + ' ' + post.categories).toLowerCase();
      return terms.every(function(term) {
        return searchable.indexOf(term) !== -1;
      });
    });

    if (results.length === 0) {
      searchResults.innerHTML = '<li>No results found.</li>';
      return;
    }

    searchResults.innerHTML = results.map(function(post) {
      var excerpt = post.content.substring(0, 150) + '...';
      return '<li>' +
        '<h3><a href="' + post.url + '">' + post.title + '</a></h3>' +
        '<time>' + post.date + '</time>' +
        '<p>' + excerpt + '</p>' +
        '</li>';
    }).join('');
  }

  loadPosts();

  var debounce;
  searchInput.addEventListener('input', function() {
    clearTimeout(debounce);
    debounce = setTimeout(function() {
      search(searchInput.value);
    }, 200);
  });
})();
</script>
