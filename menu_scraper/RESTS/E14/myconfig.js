pjs.addSuite({
  url: 'http://www.just-eat.co.uk/restaurants-zeera-mile-end/menu',
  scraper: function() {
          return $('tr').text();
  }
});
