package Pinto::Remote;

# ABSTRACT:  Interact with a remote Pinto repository

use Moose;

use Carp;
use Class::Load;

use Pinto::Remote::Config;
use Pinto::Remote::ActionBatch;

use namespace::autoclean;

#-------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------
# Moose attributes

has config    => (
    is        => 'ro',
    isa       => 'Pinto::Remote::Config',
    required  => 1,
);


has _action_batch => (
    is         => 'ro',
    isa        => 'Pinto::Remote::ActionBatch',
    writer     => '_set_action_batch',
    init_arg   => undef,
);

#------------------------------------------------------------------------------

sub BUILDARGS {
    my ($class, %args) = @_;

    $args{config} ||= Pinto::Remote::Config->new( %args );

    return \%args;
}

#------------------------------------------------------------------------------

sub new_action_batch {
    my ($self, %args) = @_;

    my $batch = Pinto::Remote::ActionBatch->new( config => $self->config(),
                                                 %args );
    $self->_set_action_batch( $batch );

    return $self;
}

#------------------------------------------------------------------------------

sub add_action {
    my ($self, $action_name, %args) = @_;

    my $action_class = "Pinto::Remote::Action::$action_name";

    eval { Class::Load::load_class($action_class); 1 }
        or croak "Unable to load action class $action_class: $@";

    my $action = $action_class->new( config => $self->config(),
                                     %args );

    $self->_action_batch->enqueue($action);

    return $self;
}

#------------------------------------------------------------------------------

sub run_actions {
    my ($self) = @_;

    my $action_batch = $self->_action_batch()
      or croak 'You must create an action batch first';

    return $self->_action_batch->run();
}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#-------------------------------------------------------------------------------

1;

__END__
