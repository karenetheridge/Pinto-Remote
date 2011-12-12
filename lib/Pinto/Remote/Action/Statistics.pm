package Pinto::Remote::Action::Statistics;

# ABSTRACT: Report statistics about a remote repository

use Moose;
use MooseX::Types::Moose qw(Str);

use Carp;

use Pinto::Types qw(IO);

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


has format => (
    is       => 'ro',
    isa      => Str,
    default  => '',
);

#------------------------------------------------------------------------------

override execute => sub {
    my ($self) = @_;

    my @format = $self->format() ? ( format => $self->format() ) : ();

    my %ua_args = (

        Content_Type => 'form-data',

        Content => [

            format        => $self->format(),
        ],
   );

    my $response = $self->post('statistics', %ua_args);
    print { $self->out() } $response->content();

    return $response;
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__

