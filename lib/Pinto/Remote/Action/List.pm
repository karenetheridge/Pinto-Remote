package Pinto::Remote::Action::List;

# ABSTRACT: List the contents of a remote repository

use Moose;

use Carp;
use MooseX::Types::Moose qw(Str);
use Pinto::Types 0.017 qw(IO);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

extends qw(Pinto::Remote::Action);

#------------------------------------------------------------------------------

has out => (
    is      => 'ro',
    isa     => IO,
    coerce  => 1,
    default => sub { [fileno(STDOUT), '>'] },
);


has type => (
    is       => 'ro',
    isa      => Str,
    init_arg => undef,
    default  => sub { croak 'Abstract attribute' },
    lazy     => 1,
);

#------------------------------------------------------------------------------

override execute => sub {
    my ($self) = @_;

    my %ua_args = ( Content => [ type => $self->type() ] );
    my $response = $self->post('list', %ua_args);
    print { $self->out() } $response->content();

    return $response;
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__

