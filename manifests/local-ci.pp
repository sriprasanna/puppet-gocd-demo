node goserver{
  class{ 'goserver': }
}

node goagent{
  class{ 'goagent':
    goserver_ip => "192.168.10.100"
  }
}