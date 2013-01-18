package Newsmill::Schema::Result::ArticleTag;

use strict;
use warnings;

use DBIx::Class::Candy -autotable => v1;

primary_column article_tag_id => {
    data_type => 'int',
    is_auto_increment => 1,
};

column article_id => {
    data_type => 'int',
    is_nullable => 0,
    is_foreign_key => 1,
};

column tag_id => {
    data_type => 'int',
    is_nullable => 0,
    is_foreign_key => 1,
};

belongs_to article => 'Newsmill::Schema::Result::Article', 'article_id';
belongs_to tag => 'Newsmill::Schema::Result::Tag', 'tag_id';

1;
