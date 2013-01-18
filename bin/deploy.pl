#!/usr/bin/perl 

use strict;
use warnings;

use Newsmill::Schema;

my $schema = Newsmill::Schema->connect( 'dbi:SQLite:newsmill.sqlite3' );

$schema->deploy;

