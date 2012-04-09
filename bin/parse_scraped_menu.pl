#!/usr/bin/perl -w

use strict;

use Getopt::Std;
use XML::Writer;
use IO::File;

use ScrapedMenu;

use vars qw( $opt_f );
getopts('f:');

my $scraped_menu = new ScrapedMenu(FILE_NAME=>$opt_f);
my $menu = $scraped_menu->get_menu();

my $output = IO::File->new(">output.xml");
my $writer = XML::Writer->new(OUTPUT => $output, NEWLINES=>0, DATA_MODE=>1);

$writer->startTag('omf','uuid'=>'1234','created_date'=>'9-APRIL-2012','accuracy'=>'poor');

$writer->startTag('restaurant_info');

$writer->startTag('restaurant_name');
$writer->characters($menu->{name});
$writer->endTag('restaurant_name');

$writer->startTag('address_1');
$writer->characters($menu->{address});
$writer->endTag('address_1');

$writer->startTag('environment');
$writer->startTag('operating_days');

my $hours = $menu->{hours};
foreach my $key (sort keys %$hours) {

	$writer->startTag('operating_day');

	$writer->startTag('day_of_week');
	$writer->characters($key);
	$writer->endTag('day_of_week');
	
	$writer->startTag('open_time');
	$writer->characters($hours->{$key}->{open});
	$writer->endTag('open_time');
	
	$writer->startTag('close_time');
	$writer->characters($hours->{$key}->{close});
	$writer->endTag('close_time');

	$writer->endTag('operating_day');

}

$writer->endTag('operating_days');

$writer->endTag('environment');

my $items = $menu->{items};
foreach my $key (sort keys %$items) {
	$writer->startTag('menu_item','uid'=>$key);
	$writer->dataElement('menu_item_name', $items->{$key}->{name} );
    	$writer->dataElement('menu_item_size', $items->{$key}->{size} );
	$writer->dataElement('menu_item_price', $items->{$key}->{price} );
	$writer->endTag('menu_item');
}

$writer->endTag('restaurant_info');

$writer->endTag('omf');
