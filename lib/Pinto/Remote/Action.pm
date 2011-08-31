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

  my $ua       = LWP::UserAgent->new();
  #my $name     = $self->_name();
  my $url      = $self->config->repos() . "/action/$name";
  my $response = $ua->post($url, %args);

  return $response;

  #return Pinto::Remote::Response->new( status  => $response->is_success(),
  #                                     content => $response->content() );
}

#------------------------------------------------------------------------------

sub _name {
    my ($self) = @_;
    my $class = ref $self;
    my $name = ($class =~ m{:: (.*) $}gmx);
    return $name;
}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
