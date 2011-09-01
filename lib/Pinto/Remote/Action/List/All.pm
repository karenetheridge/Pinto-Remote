package Pinto::Remote::Action::List::All;

# ABSTRACT: List all the contents of a remote Pinto repository

use Moose;

extends qw(Pinto::Remote::Action::List);

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has '+type' => (
    default => 'All',
);

#------------------------------------------------------------------------------
1;

__END__

