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

=method pinto_remote()

Returns a reference to a L<Pinto::Remote> object that has been
constructed for this application.

=cut

sub pinto_remote {
    my ($self) = @_;

    return $self->{pinto_remote} ||= do {
        my %global_options = %{ $self->global_options() };

        $global_options{host}
            or $self->usage_error('Must specify a host');

        require Pinto::Remote;
        my $pinto_remote = Pinto::Remote->new(%global_options);
    };
}


1;

__END__
