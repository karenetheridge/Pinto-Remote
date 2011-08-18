package App::Pinto::Remote;

# ABSTRACT: Command line driver for Pinto::Remote

use strict;
use warnings;

use App::Cmd::Setup -app;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub global_opt_spec {

  return (
      [ "host|H=s"   => "URL of your Pinto server (including port)" ],
  );
}

#-------------------------------------------------------------------------------

=method pinto_remote( $options )

Returns a reference to a L<Pinto::Remote> object that has been
constructed for this application.

=cut

sub pinto_remote {
    my ($self, $command_options) = @_;

    require Pinto::Remote;
    require Pinto::Remote::Config;

    return $self->{pinto_remote} ||= do {
        my %global_options = %{ $self->global_options() };
        my $config = Pinto::Remote::Config->new(%global_options, %{$command_options});
        my $pinto_remote = Pinto::Remote->new(config => $config);
    };
}


1;

__END__
