use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Menu::Scraper',
    license             => 'perl',
    dist_author         => q{Owen Singleton <owen.singleton@gmail.com>},
    dist_version_from   => 'lib/Menu/Scraper.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.006,
    },
    add_to_cleanup      => [ 'Menu-Scraper-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
