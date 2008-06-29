package YAIRCBot;
use Moose;

use POE::Component::IRC;
use POE::Session;
use POE::Kernel;
use YAIRCBot::Component::IRCClient;
use YAIRCBot::CommandDispatcher;

our $VERSION = '0.01';

has 'nick' => (
    isa => 'Str',
    is => 'rw',
);

has 'server' => (
    isa => 'Str',
    is => 'rw',
);

has 'port' => (
    isa => 'Int',
    is => 'rw',
);

sub run {
    my $self = shift;
    POE::Component::IRC->spawn(
        alias  => 'bot',
        nick   => $self->nick,
        server => $self->server,
        port   => $self->port,
    );

    POE::Session->create(
        inline_states => {
            _start     => \&YAIRCBot::Component::IRCClient::irc_start,
            irc_001    => \&YAIRCBot::Component::IRCClient::irc_001,
            irc_public => \&YAIRCBot::Component::IRCClient::irc_public,
            irc_error  => \&YAIRCBot::Component::IRCClient::irc_reconnect,
        },
        args => \@ARGV,
    );

    POE::Kernel->sig( INT => sub { POE::Kernel->stop } );
    POE::Kernel->run;
}

1;
__END__

=head1 NAME

YAIRCBot -

=head1 SYNOPSIS

  use YAIRCBot;

=head1 DESCRIPTION

YAIRCBot is

=head1 AUTHOR

dann E<lt>techmemo@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
