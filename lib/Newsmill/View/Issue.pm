package Newsmill::View::Issue;

use strict;
use warnings;

use Moose;
use Template::Caribou;

use Template::Caribou::Tags::Bootstrap 
    row => { -as => 'body_row', fluid => 1 },
    span => { -as => 'body_span', offset => 2, span => 8 };

with 'Template::Caribou';
with 'Template::Caribou::Files' => {
    dirs => [ 'views/issue' ],
    auto_reload => 1,
};

has issue => (
    is => 'ro',
);

1;
