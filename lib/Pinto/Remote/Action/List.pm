package Pinto::Remote::Action::List;

# ABSTRACT: List the contents of a remote repository

use Moose;
use Pinto::Types 0.017 qw(IO);

extends 'Pinto::Remote::Action';

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has out => (
    is      => 'ro',
    isa     => IO,
    coerce  => 1,
    default => sub { [fileno(STDOUT), '>'] },
);

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__

