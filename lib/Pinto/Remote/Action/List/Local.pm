package Pinto::Remote::Action::List::Local;

# ABSTRACT: List the local contents of a remote Pinto repository

use Moose;

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

extends qw(Pinto::Remote::Action::List);

#------------------------------------------------------------------------------

has '+type' => (
    default => 'Local',
);

#------------------------------------------------------------------------------
1;

__END__

