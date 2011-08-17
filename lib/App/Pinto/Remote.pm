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


sub pinto_remote {
    my ($self, $command_options) = @_;

    require Pinto::Remote;

    return $self->{pinto} ||= do {
        my %global_options = %{ $self->global_options() };
        my $pinto  = Pinto::Remote->new(%global_options);
    };
}


1;

__END__
