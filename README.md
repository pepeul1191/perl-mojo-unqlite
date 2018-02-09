# Mojo Perl UnQLite

### Mojo Micro Web Framework

    $ sudo apt install cpanminus
    $ curl -L https://cpanmin.us | perl - -M https://cpan.metacpan.org -n Mojolicious
    $ sudo cpanm Mojolicious::Plugin::SecureCORS
    $ sudo apt install libmojolicious-perl

### Instalar dependencias de Perl

    $ sudo cpanm JSON JSON::XS Crypt::MCrypt Try::Tiny UnQLite

### Arrancar el microservicio

    $ morbo app.pl -l http://127.0.0.1:5000

Para imprimir variables:

    #print("\nA\n");print($url);print("\nB\n");
    #print("\n");print Dumper(%temp);print("\n");

---

Fuentes:

+ http://mojolicious.org/
+ https://metacpan.org/pod/UnQLite
+ https://groups.google.com/forum/#!msg/mojolicious/_HLsJeheavE/CjHnMtQaAgAJ
+ https://perlmaven.com/subroutines-and-functions-in-perl
