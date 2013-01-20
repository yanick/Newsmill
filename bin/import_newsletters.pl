#!/usr/bin/env perl 

use 5.16.0;

use strict;
use warnings;

use JSON;
use Path::Class;

use Newsmill::Schema;
use DateTime::Format::Flexible;

my $schema = Newsmill::Schema->connect( 'dbi:SQLite:perlweekly.sqlite3' );

unlink 'perlweekly.sqlite3';

$schema->storage->dbh->do( 'PRAGMA journal_mode=WAL' );
$schema->storage->dbh->do( 'PRAGMA synchronous = OFF' );

$schema->deploy;

my $dir = dir('/home/yanick/work/perl-modules/perlweekly/src');

for my $file ( sort { $a->[0] <=> $b->[0] } 
               map { /(\d+)\.json$/ ? [ $1 => $_ ] : () } $dir->children ) {

    say "importing ", $file->[0];

    my $json = decode_json scalar $file->[1]->slurp;

    my $edition = $schema->resultset('Edition')->create({
        edition_id => $file->[0],
        title => $json->{subject},
        edition_date => DateTime::Format::Flexible->parse_datetime($json->{date}),
        header => maybe_paragraphs($json->{header}),
        footer => maybe_paragraphs($json->{footer}),
    });

    import_sections( $edition => @{ $json->{chapters} } );

}

sub import_sections {
    my ( $edition, @chapters ) = @_;

    my $rank = 0;
    for my $chap ( @chapters ) {
        say "\tadd section ", $chap->{title};
        my $section = $edition->add_to_edition_sections({
            section_type => { label => $chap->{title} },
            header => maybe_paragraphs( $chap->{header} ),
            rank => $rank++,
        });

        import_articles( $section, @{ $chap->{entries} } );
    }
}

sub import_articles {
    my( $section, @entries ) = @_;

    my $rank = 0;

    for my $art ( @entries ) {
        say "\t\tadd article ", $art->{title};

        my $pub;
        $pub = DateTime->new( year => $1, month => $2, day => $3 )
            if $art->{ts} =~ /(\d{4})\.(\d+)\.(\d+)/;

        $DB::single = 1;
        my $article = $section->add_to_articles({ 
            title => $art->{title},
            description => $art->{text},
            url => $art->{url},
            publication_date => $pub,
            article_tags => [
                map { 
                    { tag => { label => $_ } }
                } @{ $art->{tags} || [] }
            ],
        }, {
            rank => ++$rank,
        });
    }
}

sub maybe_paragraphs {
    my $block = shift;
    ref $block ? join( "\n\n", @$block ) : $block;
}

