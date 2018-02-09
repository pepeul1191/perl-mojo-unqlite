use strict;
use warnings;
use Mojolicious::Lite -signatures;
use Mojo::Log;
use UnQLite;
use utf8;
use Encode;
use JSON;
use JSON::XS;
binmode STDOUT, ':utf8';

sub conn {
  return UnQLite->open('db/demo.db', UnQLite::UNQLITE_OPEN_READWRITE|UnQLite::UNQLITE_OPEN_CREATE);
}

my $log = Mojo::Log->new;

app->hook(after_dispatch => sub {
  my $c = shift;
  my $headers = $c->req->headers;
  my $origin = $headers->origin;
  #say "Origin: $origin";
  $c->res->headers->header('Server' => 'Ubuntu');
  $c->res->headers->header('x-powered-by' => 'Mojolicious (Perl)');
  #$c->res->headers->header('Access-Control-Allow-Origin' => $origin);
});

get '/' => sub {
  my $c = shift;
  $c->render(text => 'Error: URL Vacía');
};

post '/grabar' => sub {
  my $c = shift;
  my $key = $c->param('key');
  my $value = $c->param('value');
  my $db = conn();
  my $_id = $db->kv_store($key, $value);
  undef $db;
  $c->render(text => $_id);
};

post '/agregar' => sub {
  my $c = shift;
  my $key = $c->param('key');
  my $db = conn();
  my $value = $db->kv_fetch($key);
  if ($value eq ''){
    $db->kv_store($key, $value);
    undef $db;
    $c->render(text => 'Creado');
  }else{
    my @names = ($value);
    push @names, $c->param('value');
    $db->kv_store($key, Encode::decode('utf8', JSON::to_json \@names));
    undef $db;
    $c->render(text => 'Editado');
  }
};

get '/obtener' => sub {
  my $c = shift;
  my $key = $c->param('key');
  my $db = conn();
  my $value = $db->kv_fetch($key);
  undef $db;
  if ($value eq ''){
    $c->render(text => 'No existe dato asociado a la llave "' . $key . '"');
  }else{
    $c->render(text => Encode::decode('utf8', $value));
  }
};

app->start;
