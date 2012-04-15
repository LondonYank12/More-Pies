pjs.addSuite({
    // single URL or array
    url: 'http://www.just-eat.co.uk/area/ec1a-city-of-london',
    // single function or array, evaluated in the client
    scraper: function() {
        return $('href')
    }
});
