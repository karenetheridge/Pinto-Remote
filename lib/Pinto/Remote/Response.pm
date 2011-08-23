package Pinto::Remote::Response;

# ABSTRACT: Represents the response received from a Pinto::Server

use Moose;

use MooseX::Types::Moose qw(Bool Str);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------
# Moose attributes

has status => (
    is       => 'ro',
    isa      => Bool,
    required => 1,
);

has content => (
    is      => 'ro',
    isa     => Str,
);

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
