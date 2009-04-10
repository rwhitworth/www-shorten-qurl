use Test::More tests => 6;

BEGIN { use_ok WWW::Shorten::Qurl };

my $url = 'http://search.cpan.org/dist/WWW-Shorten/';
ok ( my $qurl = makeashorterlink($url), 'make it shorter');
is ( makealongerlink($qurl), $url, 'make it longer');
my ($code) = $qurl =~ /(\w+)$/;
is ( makealongerlink($code), $url, 'make it longer by Id',);

eval { &makeashorterlink() };
ok($@);
eval { &makealongerlink() };
ok($@);
