# $Id$

=head1 NAME

WWW::Shorten::Qurl - Perl interface to qurl.com

=head1 SYNOPSIS

  use WWW::Shorten::Qurl;

  # or

  use WWW::Shorten 'Qurl';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site Qurl.com.  Qurl simply maintains
a database of long URLs, each of which has a unique identifier.

=cut

package WWW::Shorten::Qurl;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
our $VERSION = '2.00';

use Carp;

=head1 Functions

=head2 makeashorterlink

The function C<makeashorterlink> will call the Qurl web site passing
it your long URL and will return the shorter Qurl version.

=cut

sub makeashorterlink ($)
{
    my $url = shift or croak 'No URL passed to makeashorterlink';
    my $ua = __PACKAGE__->ua();
    my $qurl = 'http://qurl.com/automate.php';
    my $resp = $ua->post($qurl, [
	url => $url,
	]);
    return undef unless $resp->is_success;
    my $content = $resp->content;
    return if $content eq $url;
    return $content;
}

=head2 makealongerlink

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full Qurl URL or just the
Qurl identifier.

If anything goes wrong, then either function will return C<undef>.

=cut

sub makealongerlink ($)
{
    my $qurl = shift 
	or croak 'No Qurl key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $qurl = "http://qurl.com/$qurl"
    unless $qurl =~ m!^http://!i;

    if ($qurl =~ m|^http://www\.|) {
      $qurl =~ s/www\.//;
    }

    my $resp = $ua->get($qurl);

    return unless $resp->is_redirect;
    my $url = $resp->header('Location');
    return $url;
}

1;

__END__

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 SUPPORT, LICENCE, THANKS and SUCH

See the main L<WWW::Shorten> docs.

=head1 AUTHOR

Dave Cross <dave@mag-sol.com>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://qurl.com/>

=cut
