use strict;
use warnings;
use ExtUtils::MakeMaker;

my $parms = {
    NAME                => 'Test::WWW::Mechanize',
    AUTHOR              => 'Andy Lester <andy@petdance.com>',
    VERSION_FROM        => 'Mechanize.pm',
    ABSTRACT_FROM       => 'Mechanize.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Carp::Assert::More'        => 0,
        'HTML::TreeBuilder'         => 0,
        'HTTP::Server::Simple'      => '0.42',
        'HTTP::Server::Simple::CGI' => 0,
        'LWP'                       => 6.02,
        'Test::Builder::Tester'     => '1.09',
        'Test::LongString'          => '0.15',
        'Test::More'                => 0,
        'URI::file'                 => 0,
        'WWW::Mechanize'            => '1.68',
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-WWW-Mechanize-*' },
};

if ( $ExtUtils::MakeMaker::VERSION =~ /^\d\.\d\d$/ and $ExtUtils::MakeMaker::VERSION > 6.30 ) {
    $parms->{LICENSE} = 'artistic_2';
}

if ( $ExtUtils::MakeMaker::VERSION ge '6.46' ) {
    $parms->{META_MERGE} = {
        resources => {
            license     => 'http://www.opensource.org/licenses/artistic-license-2.0',
            homepage    => 'https://github.com/petdance/test-www-mechanize',
            bugtracker  => 'http://code.google.com/p/www-mechanize/issues/list',
            repository  => 'https://github.com/petdance/test-www-mechanize',
        }
    };
    $parms->{LICENSE} = 'perl';
}
if ( $ExtUtils::MakeMaker::VERSION ge '6.48' ) {
    $parms->{MIN_PERL_VERSION} = 5.008;
}

WriteMakefile( %{$parms} );


sub MY::postamble {
    return <<'MAKE_FRAG';
.PHONY: critic tags

critic:
	perlcritic -1 -q -profile perlcriticrc Mechanize.pm t/

tags:
	ctags -f tags --recurse --totals \
		--exclude=blib \
		--exclude=.svn \
		--exclude='*~' \
		--languages=Perl --langmap=Perl:+.t \

MAKE_FRAG
}
