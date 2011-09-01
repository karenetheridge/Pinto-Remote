package Pinto::Remote::Action::List::All;

# ABSTRACT: List all the contents of a remote Pinto repository

use Moose;

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

extends qw(Pinto::Remote::Action::List);

#------------------------------------------------------------------------------

has '+type' => (
    default => 'All',
);

#------------------------------------------------------------------------------
1;

__END__

