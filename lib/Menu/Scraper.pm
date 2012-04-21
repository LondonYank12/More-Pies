package Menu::Scraper;

use strict;
use warnings;

use File::Basename;
use XML::Writer;
use XML::Writer::String;

my @file;
my $file;
my $menu;

=head1 NAME

Menu::Scraper - The great new Menu::Scraper!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Menu::Scraper;

    my $foo = Menu::Scraper->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub new {
	my $class = shift;
	my %attr = @_;
	my $self = {};
	bless $self, $class;

	$self->{debug} = $attr{DEBUG};

	if ( $attr{DBH} ) {
		$self->{dbh} = $attr{DBH};
	}

	$self->{file_name} = basename($attr{FILE_NAME});
	$self->{file_path} = dirname($attr{FILE_NAME});
	$self->{abs_file_name} = $attr{FILE_NAME};

	$self->_init();

	return $self;
}

=head2 new

=cut

sub get_menu {
	my $self = shift;

	_top_level();

	$menu->{items} = _items();
	$menu->{hours} = _hours();

	return $menu;
}

=head2 get_menu

=cut

sub get_menu_xml {
  my $self = shift;

  my $menu = get_menu();
  
  my $xml = new XML::Writer::String;
  my $writer = XML::Writer->new(OUTPUT => $xml, NEWLINES=>0, DATA_MODE=>1);
  
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
  $writer->endTag('restaurant_info');
  
  $writer->startTag('menus');
  $writer->startTag('menu'); 
  my $items = $menu->{items};
  foreach my $key (sort keys %$items) {
    $writer->startTag('menu_item','uid'=>$key);
    $writer->dataElement('menu_item_name', $items->{$key}->{name} );
    $writer->dataElement('menu_item_size', $items->{$key}->{size} );
    $writer->dataElement('menu_item_price', $items->{$key}->{price} );
    $writer->endTag('menu_item');
  }
  $writer->endTag('menu'); 
  $writer->endTag('menus');
  
  $writer->endTag('omf');
  $writer->end();

  return $xml->value();

}

=head2 get_menu_xml

=cut

sub _items {
	my $self = shift;

	my $items;

	for ( my $i = 0; $i < $#file; $i++) {
	    if ($file[$i] =~ /(\d{1,3})\.$/ ) {
	        my $id = $1;
	        $items->{$id}->{name}=$file[$i+1];
	        if ( $file[$i+2] =~ /£/ ) {
	            $items->{$id}->{size}='n/a';
	            $items->{$id}->{price}=$file[$i+2];
	        } else {
	            $items->{$id}->{size}=$file[$i+2];
	            $items->{$id}->{price}=$file[$i+3];
	        }
	    }
	}

	return $items;

}

sub _hours {
	my $self = shift;

	my $hours;

	for ( my $i = 0; $i < $#file; $i++) {
	    if ($file[$i] =~ /(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday):/ ) {
	        my $day = $1;
	        $file[$i+1] =~ /(\d\d:\d\d).*(\d\d:\d\d)/;
	        $hours->{$day}->{open}=$1;
	        $hours->{$day}->{close}=$2;
	    }
	}

	return $hours;
}

sub _top_level {
	my $self = shift;

	$file =~ /(.*?)\n(.*?)\nOpening hours\n/m;
	$menu->{name}=$1;
	$menu->{address}=$2;

}


sub _init {
	my $self = shift;

	open FH, $self->{abs_file_name}
		or die "Could not open file: $!";

	while (<FH>) {
	    chomp;
	    push @file, $_;
	}
	close FH;

	open FH, $self->{abs_file_name}
		or die "Could not open file: $!";

	$file = join("", <FH>);
	close FH;

}

sub DESTROY {

}

=head1 AUTHOR

Owen Singleton, C<< <owen.singleton at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-menu-scraper at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Menu-Scraper>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Menu::Scraper


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Menu-Scraper>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Menu-Scraper>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Menu-Scraper>

=item * Search CPAN

L<http://search.cpan.org/dist/Menu-Scraper/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Owen Singleton.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Menu::Scraper
