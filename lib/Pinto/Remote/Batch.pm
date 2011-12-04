package Pinto::Remote::Batch;

# ABSTRACT: Runs a series of remote actions

use Moose;

use Pinto::Remote::Result;

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


#------------------------------------------------------------------------------

sub run {
    my ($self) = @_;

    my $result = Pinto::Remote::Result->new();

    while ( my $action = $self->dequeue() ) {
        my $response = $action->execute();
        $result->add_exception( $response->content() )
          if not $response->is_success();
    }

    return $result;
}

#-----------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#-----------------------------------------------------------------------------
1;

__END__
