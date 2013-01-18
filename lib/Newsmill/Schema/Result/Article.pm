package Newsmill::Schema::Result::Article;

use strict;
use warnings;

use DBIx::Class::Candy -autotable => v1;

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

primary_column article_id => {
    data_type => 'int',
    is_auto_increment => 1,
};

column title => {
    data_type => 'varchar',
    size => 200,
    is_nullable => 0,
};

column url => {
    data_type => 'varchar',
    size => 200,
    is_nullable => 0,
};

column creation_date => {
    data_type => 'date',
    is_nullable => 1,
};

column description => {
    data_type => 'text',
    is_nullable => 1,
};

column bitly_url => {
    data_type => 'varchar',
    size => 200,
    is_nullable => 1,
};

has_many article_tag => 'Newsmill::Schema::Result::ArticleTag', 'article_id';
many_to_many( tags => 'article_tag', 'tag' );

1;
