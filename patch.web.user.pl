#<ACTION> file=>'web/user.pl',hook=>'additional_info'


Require_web_mod('ajWildcoreData');
my $domid = v::get_uniq_id();
my $wildcoreLoadingCatch = '
  <script>
      document.querySelector(\'[data-domid="'.$domid.'"]\').addEventListener("click", function () {
        document.getElementById("'.$domid.'").innerHTML = "<h4>Loading...</h4>"
      });
  </script>
';
$reload_url = url->new(a=>'ajWildcoreData', uid=>$Fuid, '-data-domid'=>$domid, -ajax=>1);
push @left, WideBox( msg=>"<div id='".$domid."'><h4>Click to button 'Diagnostic' for get information from equipment</h4><br>or go to <a href='".$cfg::wildcore_url."'>Wildcore</a></div>".$wildcoreLoadingCatch, title=> $reload_url->a('Diagnostic'  ) );
