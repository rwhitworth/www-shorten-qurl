use Test::More tests => 2;

BEGIN { use_ok WWW::Shorten::Qurl };

my $url = 'https://github.com/rwhitworth/www-shorten-qurl';
#my $url = '';
my $qurl = makeashorterlink($url, 'lithron@gmail.com');
print "# qurl: $qurl\n";
ok($qurl != undef, 'make it shorter');
#ok ( my $qurl = makeashorterlink($url), 'make it shorter');

#is ( makealongerlink($qurl), $url, 'make it longer');
#my ($code) = $qurl =~ /(\w+)$/;
#is ( makealongerlink($code), $url, 'make it longer by Id',);

#eval { makeashorterlink() };
#ok($@);
#eval { makealongerlink() };
#ok($@);
