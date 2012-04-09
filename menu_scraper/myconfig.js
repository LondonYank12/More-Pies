pjs.addSuite({
    // single URL or array
    url: 'http://www.just-eat.co.uk/restaurants-royalnepalesese3/menu',
    // single function or array, evaluated in the client
    scraper: function() {
        return $('tr').text();
    }
});
