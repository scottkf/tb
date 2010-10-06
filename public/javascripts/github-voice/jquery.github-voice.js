"use strict";jQuery.base64=(function($){var _PADCHAR="=",_ALPHA="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",_VERSION="1.0";function _getbyte64(s,i){var idx=_ALPHA.indexOf(s.charAt(i));if(idx===-1){throw"Cannot decode base64"}return idx}function _decode(s){var pads=0,i,b10,imax=s.length,x=[];s=String(s);if(imax===0){return s}if(imax%4!==0){throw"Cannot decode base64"}if(s.charAt(imax-1)===_PADCHAR){pads=1;if(s.charAt(imax-2)===_PADCHAR){pads=2}imax-=4}for(i=0;i<imax;i+=4){b10=(_getbyte64(s,i)<<18)|(_getbyte64(s,i+1)<<12)|(_getbyte64(s,i+2)<<6)|_getbyte64(s,i+3);x.push(String.fromCharCode(b10>>16,(b10>>8)&255,b10&255))}switch(pads){case 1:b10=(_getbyte64(s,i)<<18)|(_getbyte64(s,i+1)<<12)|(_getbyte64(s,i+2)<<6);x.push(String.fromCharCode(b10>>16,(b10>>8)&255));break;case 2:b10=(_getbyte64(s,i)<<18)|(_getbyte64(s,i+1)<<12);x.push(String.fromCharCode(b10>>16));break}return x.join("")}function _getbyte(s,i){var x=s.charCodeAt(i);if(x>255){throw"INVALID_CHARACTER_ERR: DOM Exception 5"}return x}function _encode(s){if(arguments.length!==1){throw"SyntaxError: exactly one argument required"}s=String(s);var i,b10,x=[],imax=s.length-s.length%3;if(s.length===0){return s}for(i=0;i<imax;i+=3){b10=(_getbyte(s,i)<<16)|(_getbyte(s,i+1)<<8)|_getbyte(s,i+2);x.push(_ALPHA.charAt(b10>>18));x.push(_ALPHA.charAt((b10>>12)&63));x.push(_ALPHA.charAt((b10>>6)&63));x.push(_ALPHA.charAt(b10&63))}switch(s.length-imax){case 1:b10=_getbyte(s,i)<<16;x.push(_ALPHA.charAt(b10>>18)+_ALPHA.charAt((b10>>12)&63)+_PADCHAR+_PADCHAR);break;case 2:b10=(_getbyte(s,i)<<16)|(_getbyte(s,i+1)<<8);x.push(_ALPHA.charAt(b10>>18)+_ALPHA.charAt((b10>>12)&63)+_ALPHA.charAt((b10>>6)&63)+_PADCHAR);break}return x.join("")}return{decode:_decode,encode:_encode,VERSION:_VERSION}}(jQuery));
(function($) {
  $.fn.githubVoice = function(url, user, repository, options) {
    options      = $.extend(true, {}, $.fn.githubVoice.defaults, options || {});
		options.user = user
		options.pass = repository
    options.url  = url;

    this.setupExtras(options.setup || $.fn.githubVoice.base, options);
    this.each(function() {
      $(this).trigger('github-voice-initialize');
    });

    return this;
  };

  $.fn.githubVoice.base = {
    initialize: [function(options) {
      this.bind('github-voice-initialize', function() {
        $(this).trigger('github-voice-bindEventListeners');
      });
    }],

    bindEventListeners: [function(options) {
      this.bind('github-voice-bindEventListeners', function() {
        var element = $(this)

        element.click(function() {
          var cache = element.data('cache');

          if (options.overlay) {
            element.trigger('github-voice-createOverlay');
          }

          element.trigger('github-voice-createElement')
                 .trigger('github-voice-updatePosition');

          if (cache) {
            element.trigger('github-voice-update', [cache]);
          } else {
						var url = options.url;
						
						$.ajax({
							url: 'http://projects.tesoriere.com/api/1/projects/478teabagscom/task_lists',
							dataType: 'json',
					   	beforeSend: function(xhr) {
					     xhr.setRequestHeader("Authorization", "Basic " + $.base64.encode(options.user + ":" + options.pass));
					   	},
							success: function(data) {
							              element.trigger('github-voice-update', [data]);
							              element.data('cache', data);
							},
						});
          }

          return false;
        });
      });
    }],

    createElement: [function(options) {
      this.bind('github-voice-createElement', function() {
        $('body').append(options.html);

        $('#github-voice')
          .find('p.description').html(options.text.description).end()
          .find('li.loading').html(options.text.loading).end()
          .find('p.call-to-action a')
            .html(options.text.callToAction)
            .attr('href', 'http://github.com/' + options.path + '/issues');

        $('#github-voice-wrapper .close').click(function() {
          $('#github-voice-overlay, #github-voice-wrapper').remove();
        });
      });
    }],

    createOverlay: [function(options) {
      this.bind('github-voice-createOverlay', function() {
        $('body')
          .append('<div id="github-voice-overlay"></div>')
          .find('#github-voice-overlay')
            .css({
              width   : $(window).width(),
              height  : $(document).height(),
              opacity : 0.75
            })
            .click(function() {
              $('#github-voice-overlay, #github-voice-wrapper').remove();
            });
      });
    }],

    update: [function(options) {
      this.bind('github-voice-update', function(event, data) {
        var sort  = options.sort,
            list  = $('#github-voice ol').empty(),
            count = 0,
            valid;

        data.sort($.isFunction(sort)
                         ? sort
                         : function(a, b) {
                             return ((a[sort] < b[sort]) ?
                                     1 : ((a[sort] > b[sort]) ? -1 : 0));
                           }
                        );

        $.each(data, function(index, issue) {
          if (options.filter) {
            valid = true;

            $.each(options.filter, function(key, value) {
              if (!issue[key].match(value)) {
                valid = false;

                return false;
              }
            });

            if (!valid) {
              return;
            }
          }

          list.append('<li>' +
            '<p class="votes">' +
              '<em>' + issue.position + '</em> votes' +
            '</p>' +
            '<h3><a href="http://github.com/' + options.path + '/issues#issue/' + issue.number + '">' + issue.name + '</a></h3>' +
          '</li>');

          if (++count == options.limit) {
            return false;
          }
        });

        $('#github-voice p.call-to-action a').append('<span> (' + data.issues.length + ' ideas)</span>')

        $(this).trigger('github-voice-updatePosition');
      });
    }],

    updatePosition: [function(options) {
      this.bind('github-voice-updatePosition', function() {
        var
        element = $('#github-voice-wrapper');
        element.css('margin-top', -1 * (element.height() / 2));
      });
    }]
  };

  $.fn.githubVoice.defaults = {
    sort    : 'votes',
    limit   : 5,
    overlay : true,
    filter  : null,
    text    : {
      loading     : "Loading...",
      description : "We've setup a feedback forum so you can tell us what's on your mind. Please go there and be heard!",
      callToAction: "&raquo; Go to our Feedback Forum"
    },
    html : '\
    <div id="github-voice-wrapper"> \
      <div class="close" /> \
      <h1>Feedback</h1> \
      <div id="github-voice"> \
        <p class="description"></p> \
        <ol> \
          <li class="loading"></li> \
        </ol> \
        <p class="call-to-action"><a href="#"></a></p> \
      </div> \
    </div>'
  };

  // From:
  // http://yehudakatz.com/2009/04/20/evented-programming-with-jquery/
  jQuery.fn.setupExtras = function(setup, options) {
    for (property in setup) {
      var self = this;

      if (setup[property] instanceof Array) {
        for (var i = 0; i < setup[property].length; i++) {
          setup[property][i].call(self, options);
        }
      } else {
        setup[property].call(self, options);
      }
    }
  };
})(jQuery);
