package YAIRCBot::CommandDispatcher;
use Moose;
use Module::Find;
use YAIRCBot::Utils;

has 'dispatch_table' => (
    is       => 'ro',
    isa      => 'HashRef',
    required => 1,
    default  => sub {
        my @commands = usesub YAIRCBot::Command;
        my %table
            = map { YAIRCBot::Utils->classsuffix($_) => $_->new }
            @commands;
        \%table;
    }
);

sub dispatch {
    my ( $self, $command, $args ) = @_;
    my $result;
    if ( exists $self->dispatch_table->{$command} ) {
        $result = $self->dispatch_table->{$command}->do_execute($args);
    }
    else {
        $result = 'Unknown command:' . $command;
    }
    $result;
}

__PACKAGE__->meta->make_immutable;

1;
