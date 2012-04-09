package ScrapedMenu;

use strict;

use DBI;
use File::Basename;

my @file;
my $file;
my $menu;

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

sub get_menu {
	my $self = shift;

	_top_level();

	$menu->{items} = _items();
	$menu->{hours} = _hours();

	return $menu;
}

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
1;
