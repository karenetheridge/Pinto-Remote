package Pinto::Remote::Config;

# ABSTRACT: Configuration for Pinto::Remote

use Moose;

use Pinto::Types qw(URI);

extends qw(Pinto::Config);

use namespace::autoclean;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

has 'host'  => (
    is        => 'ro',
    isa       => URI,
    key       => 'host',
    #section  => 'Pinto::Remote', ??
    required  => 1,
    coerce    => 1,
);

#-------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#-------------------------------------------------------------------------------
1;

__END__

