# Class: goserver
#
#
class goserver {
  package { 'java-1.7.0-openjdk.x86_64':
    ensure => installed
  }
  
  exec { 'download-goserver':
    command => "/usr/bin/wget http://download01.thoughtworks.com/go/14.1.0/ga/go-server-14.1.0-18882.noarch.rpm -O /tmp/goserver.rpm",
    creates => "/tmp/goserver.rpm"
  }
  
  exec { 'install-goserver':
    command => "/bin/rpm -i /tmp/goserver.rpm",
    creates => "/var/lib/go-server",
    require => [Package['java-1.7.0-openjdk.x86_64'], Exec['download-goserver']]
  }
  
  firewall { '000 allow 8153 and 8154':
    port   => [8153, 8154],
    proto  => tcp,
    action => accept,
  }
  
  service { "go-server":
    ensure     => running,
    enable     => true,
    require    => Exec['install-goserver']
  }
}