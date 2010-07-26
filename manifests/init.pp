
define webapp_config ($action='install', $vhost, $base='/', $app, $version, $depends) {
        
    case $action {
        "install":  { $cmd    = "webapp-config -I -h $vhost -d $base $app $version"
                      $unless = "test -f /var/www/$vhost/htdocs/$base/.webapp-$app-$version"
                    }
        "remove" :  { $cmd    = "webapp-config -C -h $vhost -d $base $app $version"
                      $unless = "$(! test -f /var/www/$vhost/htdocs/$base/.webapp-$app-$version)"
                    }
        default:    { fail( "webapp-config: Action '$action' is invalid" ) } 
    }
       
    exec { "webapp-${action}-${app}":
        command => $cmd,
        path    => [ "/usr/bin", "/usr/sbin" ],
        unless  => $unless,
        require => $depends,
    }
}
                        
