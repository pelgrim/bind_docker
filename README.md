# ISC BIND Docker Container
A BIND dns server container, built on top of Phusion's Baseimage.

## How it works
1. A data dir, where you will store both <code>named.conf.local</code> and custom zones' configuration files, will be mounted by docker for the container on */data*, before it starts running the *BIND* daemon.

2. When it starts, after the direcory is mounted, the image will copy the <code>named.conf.local</code> file to the daemons' configuration directory, also before it starts running the *BIND* daemon.

3. Finally, the *BIND* daemon is started in the foreground.

## How to use it
1. Create a data dir, where you will store your custom configurations.

2. Write a custom <code>named.conf.local</code> inside this data dir. An example:

        // data/named.conf.local

        zone "lan.example.com" {
          type master;
          file "/data/db.lan.example.com";
        };

        zone "200.168.192.in-addr.arpa" {
          type master;
          notify no;
          file "/data/db.192.168.200";
        };

3. Write the zone files inside your data dir, such as:

        ; data/db.lan.example.com
        ; Zone file for lan.example.com
        ;
        $TTL    86400
        @       IN      SOA     lan.example.com. root.lan.example.com. (
                                      1         ; Serial
                                 604800         ; Refresh
                                  86400         ; Retry
                                2419200         ; Expire
                                  86400 )       ; Negative Cache TTL
        ;
        @       IN      NS      ns1.lan.example.com.
        ns1     IN      A       192.168.200.1

  and

        ; data/db.192.168.200
        ; Zone file for 192.168.200
        ;
        $TTL    86400
        @       IN      SOA     lan.example.com. root.lan.example.com. (
                                      1         ; Serial
                                 604800         ; Refresh
                                  86400         ; Retry
                                2419200         ; Expire
                                  86400 )       ; Negative Cache TTL
        ;
        @               IN      NS      ns1.lan.example.com.
        1               IN      PTR     ns1.lan.example.com.

4. Now, run your container with a command such as:

        docker run -d --name dns -v data:/data -p 53:53/tcp -p 53:53/udp plgr/bind

## What else?

Maintained by [Lucas Vieira Souza da Silva](lucas@vieira.io), July 2016.

Licensed under Apache 2.0 License. Check the LICENSE file.

If you noticed a problem whatsoever, please, let me know.
