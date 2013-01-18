use strict;
use warnings;

use Test::More tests => 1;

use DateTime;

use Test::DBIx::Class {
    schema_class => 'Newsmill::Schema',
    connect_info => ['dbi:SQLite:dbname=:memory:','',''],
}, 'Article', 'Tag';

ok my $article = Article->create({
    title         => 'Perl 6 released!',
    url           => 'http://www.perl.org/stuff',
    creation_date => DateTime->new( year => 2013, month => 12, day => 25 ),
}), 'article created';

$article->add_to_tags({ label => $_ }) for qw/ perl6 huzzah /;

is Tag->search->count => 2, '2 tags created';


