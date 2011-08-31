package Pinto::Remote::Action::List::All;

# ABSTRACT: List the contents of a remote repository

use Moose;

extends qw(Pinto::Remote::Action::List);

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

override execute => sub {
    my ($self) = @_;

    my %ua_args = ( Content => [ type => 'All' ] );
    my $response = $self->post('list', %ua_args);
    print { $self->out() } $response->content();

    return 0;
};

#------------------------------------------------------------------------------
1;

__END__

