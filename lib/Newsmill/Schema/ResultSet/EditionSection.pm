package Newsmill::Schema::ResultSet::EditionSection;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

sub ordered {
    return $_[0]->search({},{ order_by => 'rank' });
}

1;

