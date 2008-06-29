package YAIRCBot::Component::IRCClient;
use strict;

use POE qw(
    Sugar::Args
    Component::IRC
);
use YAIRCBot::CommandDispatcher;
use Perl6::Say;

#sub POE::Kernel::ASSERT_DEFAULT () {1}
#sub POE::Kernel::TRACE_DEFAULT ()  {0}

sub parse_input {
    my ($line) = @_;
    my @tokens = split( /\s/, $line );
    return unless @tokens >= 1;
    my $command = shift @tokens;
    return ( $command, \@tokens );
}

sub execute_command {
    my ( $command, $args ) = @_;
    my $dispatcher = YAIRCBot::CommandDispatcher->new;
    my $result = eval { $dispatcher->dispatch( $command, $args ); };
    return $result;
}

sub irc_start {
    my $poe = sweet_args;
    $poe->kernel->post( bot => register => 'all' );
    $poe->kernel->post( bot => connect  => {} );
}

sub irc_001 {
    my $poe = sweet_args;
    $poe->kernel->post( $poe->sender => join => '#techmemotest' );
}

sub irc_public {
    my $poe   = sweet_args;
    my $who   = $poe->args->[0];
    my $where = $poe->args->[1];
    my $what  = $poe->args->[2];

    my $nick         = ( split /!/, $who )[0];
    my $channel_name = $where->[0];
    my $self         = $_[0]->[OBJECT];
    if ( $what =~ /\!(.*)/ ) {
        my $command_line = $1;
        my ( $command, $tokens ) = parse_input($command_line);
        my $result = execute_command( $command, $tokens );
        $poe->kernel->post(
            $poe->sender => notice => $channel_name => $result );
    }
}

sub irc_connected {
    say 'irc_connected';
}

sub irc_error {
    my $p = sweet_args;
    my ($error) = @{ $p->args };
    say 'irc_error:' . $error;
}

sub irc_reconnect {
    say 'irc_reconnect';

}

1;
