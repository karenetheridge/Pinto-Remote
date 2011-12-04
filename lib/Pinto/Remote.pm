package Pinto::Remote;

# ABSTRACT:  Interact with a remote Pinto repository

use Moose;

use Carp;
use Class::Load;

use Pinto::Remote::Config;
use Pinto::Remote::Batch;

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


has _batch => (
    is         => 'ro',
    isa        => 'Pinto::Remote::Batch',
    writer     => '_set_batch',
    init_arg   => undef,
);

#------------------------------------------------------------------------------

sub BUILDARGS {
    my ($class, %args) = @_;

    $args{config} ||= Pinto::Remote::Config->new( %args );

    return \%args;
}

#------------------------------------------------------------------------------

sub new_batch {
    my ($self, %args) = @_;

    my $batch = Pinto::Remote::Batch->new( config => $self->config(),
                                           %args );
    $self->_set_batch( $batch );

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

    $self->_batch->enqueue($action);

    return $self;
}

#------------------------------------------------------------------------------

sub run_actions {
    my ($self) = @_;

    $self->_batch() or croak 'You must create a batch first';

    return $self->_batch->run();
}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#-------------------------------------------------------------------------------

1;

__END__
