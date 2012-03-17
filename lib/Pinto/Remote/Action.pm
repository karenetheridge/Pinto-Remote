package Pinto::Remote::Action;

# ABSTRACT: Base class for remote Actions

use Moose;

use Carp;
use LWP::UserAgent;

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has config    => (
    is        => 'ro',
    isa       => 'Pinto::Remote::Config',
    required  => 1,
);

#------------------------------------------------------------------------------

sub execute {
    my ($self) = @_;

    croak 'This is an absract method';
}

#------------------------------------------------------------------------------

sub post {
    my ($self, $name, %args) = @_;

    my $ua       = LWP::UserAgent->new(timeout => 600);
    my $url      = $self->config->root() . "/action/$name";
    my $response = $ua->post($url, %args);

    return $response;
}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
