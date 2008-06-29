package YAIRCBot::Command::echo;
use Moose;

extends 'YAIRCBot::Command';

override 'validate_tokens', sub {
    my ( $self, $tokens ) = @_;

    if ( @{$tokens} != 1 ) {
        return ( 0, "error: echo <message>" );
    }
    return ( 1, "" );
};

override 'parse_tokens', sub {
    my ( $self, $token ) = @_;
    my $args = {};
    $args->{message} = $token->[0];
    return $args;
};

sub execute {
    my ( $self, $args ) = @_;
    return $args->{message};
}

1;
