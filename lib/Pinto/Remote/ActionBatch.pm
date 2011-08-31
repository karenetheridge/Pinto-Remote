package Pinto::Remote::ActionBatch;

# ABSTRACT: Runs a series of remote actions

use Moose;

use Try::Tiny;
use Path::Class;

use Pinto::Remote::BatchResult;

use Pinto::Types 0.017 qw(Dir);
use MooseX::Types::Moose qw(Str Bool);

#-----------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------
# Moose attributes

has config    => (
    is        => 'ro',
    isa       => 'Pinto::Remote::Config',
    required  => 1,
);


has _actions => (
    is       => 'ro',
    isa      => 'ArrayRef[Pinto::Remote::Action]',
    traits   => [ 'Array' ],
    default  => sub { [] },
    handles  => {enqueue => 'push', dequeue => 'shift'},
);


has _result => (
    is       => 'ro',
    isa      => 'Pinto::Remote::BatchResult',
    builder  => '_build__result',
    init_arg => undef,
);

#-----------------------------------------------------------------------------
# TODO: I don't like having the result as an attribute.  I would prefer
# to keep it transient, so that it doesn't survive beyond each run().

sub _build__result {
    my ($self) = @_;

    return Pinto::Remote::BatchResult->new();
}

#------------------------------------------------------------------------------

sub run {
    my ($self) = @_;

    #try {
        $self->_run_actions();
    #}
    #catch {
        # $self->logger->whine($_);
    #    $self->_result->add_exception($_);
    #};

    return  $self->_result();
}

#-----------------------------------------------------------------------------

sub _run_actions {
    my ($self) = @_;

    while ( my $action = $self->dequeue() ) {
        $self->_run_one_action($action);
    }

    return $self;
}

#-----------------------------------------------------------------------------

sub _run_one_action {
    my ($self, $action) = @_;

    #try   {
        my $response = $action->execute();
        # $self->_result->made_changes() if $changes;
    #}
    #catch {
        # Collect unhandled exceptions
        # $self->logger->whine($_);
    #    $self->_result->add_exception($_);
    #}
    #finally {
        # Collect handled exceptions
        # $self->_result->add_exception($_) for $action->exceptions();
    #};

    #for my $msg ( $action->messages() ) {
    #    $self->append_message("\n\n") if length $self->message();
    #    $self->append_message($msg);
    #}

    return $self;
}


#-----------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#-----------------------------------------------------------------------------
1;

__END__
