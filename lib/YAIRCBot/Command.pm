package YAIRCBot::Command;
use Moose;

# template method
sub do_execute {
    my ( $self,             $tokens )  = @_;
    my ( $is_check_success, $message ) = $self->check_pre_condition;
    return $message unless $is_check_success;

    my ( $is_validation_success, $validation_status_message )
        = $self->validate_tokens($tokens);
    return $validation_status_message unless $is_validation_success;

    my $args = $self->parse_tokens($tokens);
    return $self->execute($args);
}

sub check_pre_condition {
    my ( $self, $tokens ) = @_;
    return ( 1, "" );
}

sub validate_tokens {
    my ( $self, $tokens ) = @_;
    return ( 1, "" );
}

sub parse_tokens {
    my ( $self, $tokens ) = @_;
    die 'virtual method';
}

__PACKAGE__->meta->make_immutable;

1;
