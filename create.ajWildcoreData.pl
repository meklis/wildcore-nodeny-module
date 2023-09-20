#<ACTION> file=>'web/ajWildcoreData.pl',hook=>'new'
# ---------------------------------------------
#  WildcoreDMS (https://wildcore.tools)
# ---------------------------------------------
use strict;
use LWP::UserAgent;

my $timeout = 3;

sub go
{
    my $res = _proc_wildcore_data(@_);

#<HOOK>ajax_start
    push @$ses::cmd, {
        id   => ses::input('domid'),
        data => $res,
    };
}

sub _proc_wildcore_data
{
    if ($cfg::wildcore_url eq "") {
      return "<h3>Module wildcore not configured in billing</h3>";
    }
    my $uid = ses::input_int('uid');

    my $url = $cfg::wildcore_url . '/api/v1/component/nodeny_plus/billing/render-diag-card?id='.$uid.'&from='.$cfg::wildcore_diag_from;
    my $ua = LWP::UserAgent->new(
        agent   => 'WebNoDeny',
        timeout => 60,
    );
    my $url_obj = URI->new( $url );
    my $response = $ua->get( $url_obj, 'X-Auth-Key' => $cfg::wildcore_auth_key );
    my $content = $response->content;
    return $content;
}
1;