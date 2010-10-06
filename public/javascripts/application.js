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
  
  

  //if it exists, remove the flash[]
  jQuery.each(['.message', '.alert', '.notice'], function(index, value) {
    if ($(value)) $(value).delay(5000).slideUp(300);
  });

  jQuery("a[rel='markdown']").colorbox({transition:"elastic", width:"55%", rel:"nofollow"});

});
