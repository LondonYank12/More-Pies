#!/usr/bin/perl -w

use strict;

my $file = $ARGV[0];
my $line_no = 0;
my %menu;
my %hours;
my %item;

open FH, $file;

while (<FH>) { 
	chomp;
	$line_no++;
	next if $_=~/\[*Please/;

	if ($line_no == 2) { 
		$menu{'rest_name'}=$_;
		next;
	}
	if ($line_no == 3) {
		$menu{'address'}=$_;
		next;
	}

	if ( $_ =~ /Opening Hours/ ) {
		next;
        }		

	print $menu{'rest_name'} . "\t" . $_ . "\n";
}
