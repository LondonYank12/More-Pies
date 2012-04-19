#!perl -T

use Test::More tests => 4;

require_ok ( Menu::Scraper );
ok ( $scraper = new Menu::Scraper(FILE_NAME=>'data/restaurants-lhce_menu.txt.menu'), 'New scraper');
ok ( $menu = $scraper->get_menu(), 'Got menu' );
ok ( $menu->{name} eq 'Lime House Spice Exp...', 'Check name'); 
