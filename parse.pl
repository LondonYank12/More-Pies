#!/usr/bin/perl -w

use strict;

my $file = $ARGV[0];
my $line_no = 0;
my %menu;
my %hours;
my %items;
my %item;

open FH, $file;
my $data_file = join("", <FH>);
close FH;

$data_file =~ /(.*?)\n(.*?)\nOpening hours\n/m;
$menu{name}=$1;
$menu{address}=$2;

$data_file =~ /Delivery charges\.(.*?)BEVERAGES/ms;
$menu{delivery}=$1;

my @file;

open FH, $file;
while (<FH>) {
    chomp;
    push @file, $_;
}
close FH;
my $i;

for ( $i = 0; $i < $#file; $i++) {
    if ($file[$i] =~ /(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday):/ ) {
	my $day = $1;
	$file[$i+1] =~ /(\d\d:\d\d).*(\d\d:\d\d)/;

	$hours{$day}{open}=$1;
	$hours{$day}{close}=$2;
    }
}

for ( $i = 0; $i < $#file; $i++) {
    if ($file[$i] =~ /^(\d{1,3})\.$/ ) {
	my $id = $1;
	$items{$1}{name}=$file[$i+1];
	if ( $file[$i+2] =~ /£/ ) {
	    $items{$id}{size}='n/a';	    
	    $items{$id}{price}=$file[$i+2];
	} else {
	    $items{$id}{size}=$file[$i+2];
	    $items{$id}{price}=$file[$i+3];
        }
    }
}

print "Name: $menu{name}\n";
print "Address: $menu{address}\n";

print "Hours:\n";
foreach my $key (sort keys %hours) {
    print $key ."\t";
    print $hours{$key}{open} . "\t";
    print $hours{$key}{close} . "\n";
}

print "Items:\n";
foreach my $key (sort keys %items) {
    print "Id: $key\n";
    print "Name: $items{$key}{name}\n";
    print "Size: $items{$key}{size}\n";
    print "Price: $items{$key}{price}\n";
}
