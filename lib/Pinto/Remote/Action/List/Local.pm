package Pinto::Remote::Action::List::Local;

# ABSTRACT: List the local contents of a remote Pinto repository

use Moose;

extends qw(Pinto::Remote::Action::List);

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has '+type' => (
    default => 'Local',
);

#------------------------------------------------------------------------------
1;

__END__

