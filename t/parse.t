#!perl -T

use Test::More tests => 9;
use Test::XML;
use Test::XPath;

require_ok ( Menu::Scraper );
ok ( $scraper = new Menu::Scraper(FILE_NAME=>'data/restaurants-lhce_menu.txt.menu'), 'New scraper');

ok ( $omg_xml = $scraper->get_menu_xml(), 'Got menu' );

is_well_formed_xml ( $omg_xml, 'Check for valid XML');

my $tx = new Test::XPath(xml=>$omg_xml);
$tx->ok( '/omf/restaurant_info/restaurant_name', 'There should be a restaurant_name');
$tx->is( '/omf/restaurant_info/restaurant_name', 'Lime House Spice Exp...', 'Check name');
$tx->ok( '/omf/menus', 'There should be a menu');

ok ( $load_xml = $scraper->get_load_xml(), 'Got Data Load XML' );
#is_well_formed_xml ( $load_xml, 'Check for valid Data Load XML');
