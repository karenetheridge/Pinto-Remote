package Pinto::Remote::Config;

# ABSTRACT: Internal configuration for Pinto::Remote

use Moose;

use Pinto::Types qw(URI);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has repos => (
    is       => 'ro',
    isa      => URI,
    coerce   => 1,
    required => 1,
);

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
