package Newsmill::Schema::Result::Edition;

use 5.10.0;

use strict;
use warnings;

use DBIx::Class::Candy -autotable => v1;

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

primary_column edition_id => {
    data_type => 'int',
    is_auto_increment => 1,
};

column title => {
    data_type => 'varchar',
    size => 200,
    is_nullable => 0,
};

column edition_date => {
    data_type => 'date',
    is_nullable => 0,
};

column header => {
    data_type => 'text',
    is_nullable => 1,
};

column footer => {
    data_type => 'text',
    is_nullable => 1,
};

has_many edition_sections => 'Newsmill::Schema::Result::EditionSection', 'edition_id';

1;

1;

__END__
