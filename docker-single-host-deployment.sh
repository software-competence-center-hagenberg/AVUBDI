 # mounted volumes need r/w permissions for these directories. please use with caution and only in secured development environment.
 # this enables various users on the same system to tinker with the live infrastructure configuration.
 chmod -R a+rwX cogniplant/
 
 docker-compose up -d --build