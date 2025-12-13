---
layout: single
title: 餐廳列表
permalink: /restaurants/
---

{% assign restaurants = site.restaurants | sort: "title" %}
<div class="grid__wrapper">
  {% for restaurant in restaurants %}
    <article class="archive__item" itemscope itemtype="https://schema.org/Restaurant">
      <h2 class="archive__item-title" itemprop="name">
        <a href="{{ restaurant.url | relative_url }}" rel="permalink">{{ restaurant.title }}</a>
      </h2>
      {% if restaurant.short_description %}
        <p class="archive__item-excerpt" itemprop="description">{{ restaurant.short_description }}</p>
      {% endif %}
      <p class="text-small">
        {% if restaurant.address %}<span itemprop="address">📍 {{ restaurant.address }}</span>{% endif %}
        {% if restaurant.phone %}<br />☎️ <a href="tel:{{ restaurant.phone }}">{{ restaurant.phone }}</a>{% endif %}
      </p>
      {% if restaurant.order_links %}
        <p>
          <a class="btn" href="{{ restaurant.order_links[0].url }}" target="_blank" rel="noopener">線上訂購</a>
        </p>
      {% endif %}
    </article>
  {% endfor %}
</div>
