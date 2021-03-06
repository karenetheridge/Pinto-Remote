package Pinto::Remote::Action;

# ABSTRACT: Base class for remote Actions

use Moose;

use Carp;
use LWP::UserAgent;
use HTTP::Request;
use URI;

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

    croak 'This is an abstract method';
}

#------------------------------------------------------------------------------

sub post {
    my ($self, $name, %args) = @_;

    my $ua  = LWP::UserAgent->new(timeout => 600);
    my $url = URI->new( $self->config->root() );
    $url->path_segments('', 'action', $name);

    my $request = HTTP::Request->new(POST => $url);

    if ( $self->config->password() ) {
        $request->authorization_basic( $self->config->username(),
                                       $self->config->password() );
    }

    my $response = $ua->request($request);

    return $response;
}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
