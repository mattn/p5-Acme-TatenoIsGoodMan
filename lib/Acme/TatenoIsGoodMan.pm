package Acme::TatenoIsGoodMan;

use strict;
use vars qw($VERSION);
use utf8;
use constant {
    CONSUMER_KEY    => 'vtPrw2UJdQYqm1dmmgehuA',
    CONSUMER_SECRET => 'DI6V19d59lMGt2k8vgtKFGOqOuv9Iw92KKKAOLrm0s',
};
use Config::Pit;
use Net::Twitter::Lite;
$VERSION = '0.01';

our $nt;

sub announce {
    my $config = pit_get('tateno_is_good_man');
    unless ( $config->{access_token_secret} ) {
        $config = +{
            consumer_key    => CONSUMER_KEY,
            consumer_secret => CONSUMER_SECRET,
        };
        $nt = Net::Twitter::Lite->new( %{$config} );
        $| = 1;
        print "Authorize this app at:\n ", $nt->get_authorization_url,
          "\nAnd enter the PIN: ";
        my $pin = <STDIN>;
        chomp $pin;
        my ( $access_token, $access_token_secret, $user_id, $screen_name ) =
          $nt->request_access_token( verifier => $pin );
        $config->{access_token}        = $access_token;
        $config->{access_token_secret} = $access_token_secret;
        pit_set( 'tateno_is_good_man', data => $config );
    } else {
        $nt = Net::Twitter::Lite->new( %{$config} );
        $nt->access_token( $config->{access_token} );
        $nt->access_token_secret( $config->{access_token_secret} );
    }

    $nt->update({status => '舘野さんみたいな素晴しい方と一緒に仕事ができて、とても嬉しいです！'});
}

1;
__END__

=head1 NAME

Acme::TatenoIsGoodMan -

=head1 SYNOPSIS

  use Acme::TatenoIsGoodMan;

=head1 DESCRIPTION

Acme::TatenoIsGoodMan is

=head1 AUTHOR

Author E<lt>author@galaxyE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<>

=cut
