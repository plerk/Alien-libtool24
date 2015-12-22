package My::ModuleBuild;

use strict;
use warnings;
use base qw( Alien::Base::ModuleBuild );
use File::chdir;
use Capture::Tiny qw( capture );

sub new
{
  my($class, %args) = @_;
  
  #$args{alien_build_commands}   = [ '%c --prefix=%s', 'make' ];
  #$args{alien_install_commands} = [ 'make install' ];
  
  $args{alien_repository} = {
    protocol => 'http',
    host     => 'ftp.gnu.org',
    location => "/gnu/libtool/",
    pattern  => qr{^libtool-2\.4\..*\.tar\.gz$},
  };

  my $self = $class->SUPER::new(%args);
  
  $self;
}

sub alien_check_installed_version
{
  my($out, $err) = capture { system 'libtool', '--version' };
  $out =~ /libtool \(GNU libtool\) (2.4.[0-9\.]+)/ ? $1 : ();
}

sub alien_check_built_version
{
  $CWD[-1] =~ /^libtool-(.*)$/ ? $1 : 'unknown';
}

1;
