use Mojolicious::Lite;

get '/' => {
  text => 'I ♥ Mojolicious!'
};

app->hook(after_dispatch => sub {
  my $c = shift;
  my $headers = $c->req->headers;
  my $origin = $headers->origin;
  say "Origin: $origin";
  $c->res->headers->header('Server' => 'Ubuntu');
  $c->res->headers->header('x-powered-by' => 'Mojolicious (Perl)');
  $c->res->headers->header('Access-Control-Allow-Origin' => $origin);
});

app->start;
