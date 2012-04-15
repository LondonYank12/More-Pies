#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Menu::Scraper' ) || print "Bail out!\n";
}

diag( "Testing Menu::Scraper $Menu::Scraper::VERSION, Perl $], $^X" );
