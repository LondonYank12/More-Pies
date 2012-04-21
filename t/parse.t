#!perl -T

use Test::More tests => 6;
use Test::XML;
use Test::XPath;

require_ok ( Menu::Scraper );
ok ( $scraper = new Menu::Scraper(FILE_NAME=>'data/restaurants-lhce_menu.txt.menu'), 'New scraper');

ok ( $xml = $scraper->get_menu_xml(), 'Got menu' );

is_well_formed_xml ( $xml, 'Check for valid XML');

my $tx = new Test::XPath(xml=>$xml);
$tx->ok( '/omf/restaurant_info/restaurant_name', 'There should be a restaurant_name');
$tx->is( '/omf/restaurant_info/restaurant_name', 'Lime House Spice Exp...', 'Check name');
