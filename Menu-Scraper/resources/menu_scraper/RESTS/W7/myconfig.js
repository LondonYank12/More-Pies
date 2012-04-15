pjs.addSuite({
  url: 'http://www.just-eat.co.uk/restaurants-zayka-indian/menu',
  scraper: function() {
          return $('tr').text();
  }
});
