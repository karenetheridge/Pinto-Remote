package Pinto::Remote::BatchResult;

# ABSTRACT: Accumulates exceptions and status from a batch of actions

use Moose;

use MooseX::Types::Moose qw(Bool ArrayRef);

use overload ('""' => 'to_string');

#-----------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------
# Moose attributes

has exceptions => (
    is         => 'ro',
    isa        => ArrayRef,
    traits     => [ 'Array' ],
    default    => sub { [] },
    handles    => {add_exception => 'push'},
    init_arg   => undef,
    auto_deref => 1,
);

#-----------------------------------------------------------------------------
# TODO: Should we have an "ActionResult" to go with our "BatchResult" too?

sub is_success {
    my ($self) = @_;

    return @{ $self->exceptions } == 0;
}

#-----------------------------------------------------------------------------

sub to_string {
    my ($self) = @_;

    my $string = join "\n", map { "$_" } $self->exceptions();
    $string .= "\n" unless $string =~ m/\n $/x;

    return $string;
}

#-----------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#-----------------------------------------------------------------------------
1;

__END__
