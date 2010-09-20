$(document).ready(function() {
  
  
  //github-voice
  $('a.voice').githubVoice('scottkf', 'tb', {
    limit : 3,
    text  : {
      loading      : "Loading ideas...",
      description  : "Below are the top three ideas.",
      callToAction : "View feedback forum."
    }
  });
  
  
  //analytics
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-6824117-5']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

  //if it exists, remove the flash[]
  jQuery.each(['.message', '.alert', '.notice'], function(index, value) {
    if ($(value)) $(value).delay(3000).hide(300);
  });
});
