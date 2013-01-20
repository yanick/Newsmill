package Newsmill::WebApp;

use strict;
use warnings;

use Dancer 2;
use Dancer::Plugin::DBIC;
use Newsmill::View::Issue;

get qr{/issue/(\d+)} => sub {
    my( $nbr ) = splat;
    my $issue = rset('Edition')->find( $nbr )
        or return send_error "Issue '$nbr' not found", 404;

    return Newsmill::View::Issue->new(
        issue => $issue
    )->render('page');
};

1;
