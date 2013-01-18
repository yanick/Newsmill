package Newsmill::Schema::Result::SectionType;

use 5.10.0;

use strict;
use warnings;

use DBIx::Class::Candy -autotable => v1;

primary_column edition_type_id => {
    data_type => 'int',
    is_auto_increment => 1,
};

column label => {
    data_type => 'varchar',
    size => 80,
    is_nullable => 0,
};

unique_constraint 'label_unique' => [ 'label' ];

1;

__END__

