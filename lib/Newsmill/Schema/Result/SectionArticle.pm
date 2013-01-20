package Newsmill::Schema::Result::SectionArticle;

use strict;
use warnings;

use DBIx::Class::Candy -autotable => v1;

primary_column section_acticle_id => {
    data_type => 'int',
    is_auto_increment => 1,
};

column article_id => {
    data_type => 'int',
};

column edition_section_id => {
    data_type => 'int',
};

column rank => {
    data_type => 'int',
    is_nullable => 0,
    default_value => 50,
};

unique_constraint 'unique_article_section' => [qw/ 
    article_id edition_section_id 
/];

belongs_to 'article' => 'Newsmill::Schema::Result::Article',
    'article_id';

belongs_to 'edition_section' => 'Newsmill::Schema::Result::EditionSection',
    'edition_section_id';
1;


