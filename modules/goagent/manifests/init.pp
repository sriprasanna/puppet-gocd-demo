# Class: goagent
#
#
class goagent($goserver_ip) {
  package { 'java-1.7.0-openjdk.x86_64':
    ensure => installed
  }
  
  exec { 'download-goagent':
    command => "/usr/bin/wget http://download01.thoughtworks.com/go/14.1.0/ga/go-agent-14.1.0-18882.noarch.rpm -O /tmp/goagent.rpm",
    creates => "/tmp/goagent.rpm"
  }
  
  exec { 'install-goagent':
    command => "/bin/rpm -i /tmp/goagent.rpm",
    creates => "/var/lib/go-agent",
    require => [Package['java-1.7.0-openjdk.x86_64'], Exec['download-goagent']]
  }
  
  service { "go-agent":
    ensure     => running,
    enable     => true,
    require    => Exec['install-goagent']
  }
  
  file { '/etc/default/go-agent':
    ensure  => file,
    content => template("goagent/config.erb"),
    require => Exec['install-goagent'],
    notify  => Service["go-agent"]
  }
}