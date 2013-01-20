package Newsmill::Schema::Result::EditionSection;

use 5.10.0;

use strict;
use warnings;

use DBIx::Class::Candy -autotable => v1;

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

primary_column edition_section_id => {
    data_type => 'int',
    is_auto_increment => 1,
};

column edition_id => {
    data_type => 'int',
    is_nullable => 0,
    is_foreign_key => 1,
};

column section_type_id => {
    data_type => 'int',
    is_nullable => 0,
};

column header => {
    data_type => 'text',
    is_nullable => 1,
};

column rank => {
    data_type => 'int',
    is_nullable => 0,
    default_value => 50,
};

belongs_to section_type => 'Newsmill::Schema::Result::SectionType',
    'section_type_id';

has_many section_articles => 'Newsmill::Schema::Result::SectionArticle',
    'edition_section_id';

many_to_many articles => 'section_articles', 'article';

belongs_to edition => 'Newsmill::Schema::Result::Edition',
    'edition_id';

1;

__END__

