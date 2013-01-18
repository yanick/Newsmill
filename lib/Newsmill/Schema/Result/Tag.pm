package Newsmill::Schema::Result::Tag;

use strict;
use warnings;

use DBIx::Class::Candy -autotable => v1;

primary_column tag_id => {
    data_type => 'int',
    is_auto_increment => 1,
};

column label => {
    data_type => 'varchar',
    size => 80,
    is_nullable => 0,
};

unique_constraint unique_label => [ 'label' ];

1;
