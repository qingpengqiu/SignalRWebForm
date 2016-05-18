jQuery(document).ready(function() {
	
	
	jQuery('body').removeClass('navigation');
	
	
	
	//menu mobile
	jQuery('.menu-button').click(function() {
		
		if (! jQuery('.menu-button').hasClass('menu-active') ) {
			
			jQuery('.navigation-mob').animate({
				left:0
			},400);
			
			jQuery('.bottom-nav').animate({
				left:0
			},400);
			
			jQuery('.menu-button').animate({
				left:160
			},400, function() {
				jQuery('.menu-button').addClass('menu-active');
			});
			
			
		
		} else {
			
			
			jQuery('.navigation-mob').animate({
				left:-160
			},400);
			
			jQuery('.menu-button').animate({
				left:0
			},400, function() {
				jQuery('.menu-button').removeClass('menu-active');
			});
			
			jQuery('.bottom-nav').animate({
				left:-160
			},400, function() {
			});
		
		};
		
	});
	
	if (! jQuery('.menu-button').hasClass('menu-active') ) {
			
		jQuery('.navigation-mob').animate({
			left:-160
		},0);
		
		jQuery('.menu-button').animate({
			left:0
		},0, function() {
			jQuery('.menu-button').addClass('menu-active');
		});
		
		jQuery('.bottom-nav').animate({
			left:0
		},0, function() {
		});
	
	} else {
		
		
		jQuery('.navigation-mob').animate({
			left:-160
		},0);
		
		jQuery('.menu-button').animate({
			left:0
		},0, function() {
			jQuery('.menu-button').removeClass('menu-active');
		});
		
	};
	
	

	
	jQuery('.container').click(function() {
		
		if (! jQuery('.menu-button').hasClass('menu-active') ) {
			
		
	
	} else {
		
		
		jQuery('.navigation-mob').animate({
			left:-160
		},0);
		
		jQuery('.menu-button').animate({
			left:0
		},0, function() {
			jQuery('.menu-button').removeClass('menu-active');
		});
		
		jQuery('.bottom-nav').animate({
			left:-160
		},0, function() {
		});
		
	};
		
	})
	
	
	jQuery('.back-to-top').click(function() {
		
		jQuery("html, body").animate({ scrollTop: 0 }, "slow");
		return false;
		
	})
	
	
	homeOverlay();
	
	//homepage slideshow
	jQuery('.slideshow').bxSlider({
		pager:false,
		auto:true,
		infiniteLoop: true,
		useCSS: false
	});
	
	//homepage slideshow
	jQuery('.brands-slider').bxSlider({
		pager:false,
		auto:true,
		infiniteLoop: true,
		useCSS: false
	});
	
	//homepage slideshow
	jQuery('.brands-slider-mob').bxSlider({
		pager:false,
		auto:true,
		infiniteLoop: true,
		useCSS: false
	});
	
	var scrolled = jQuery(document).scrollTop();
	
	if (scrolled > 255) {
		jQuery('.slide-overlay').css("position","fixed");
		jQuery('.slide-overlay').css("top",-255);
		//alert();
	} else {
		jQuery('.slide-overlay').css("position","absolute");
		jQuery('.slide-overlay').css("top",0);
	}
	
	//footer push
	var winHeight = jQuery(window).height();
	var contentHeight = jQuery('.container').height();
	if (jQuery('body').height() < 2000) {
		jQuery('.footer-push').height((winHeight - contentHeight) - 102);
	}
	
	//jQuery(".countdown-clock").kkcountdown({
    //	dayText		: '天 ',
    //	daysText 	: '天 ',
    //    hoursText	: '小时 ',
    //    minutesText	: '分钟 ',
    //    secondsText	: '',
    //    displayZeroDays : false,
    //    callback	: on,
    //    oneDayClass	: 'one-day'
    //});
    
    function on() {
	    console.log('Event is on!');
    }
	
})

function link(link) {
	window.location = link;
}

function openMenu() {
	jQuery('.sub-nav-2').slideToggle();
}

jQuery(document).ready(function() {
	
}) 

function scrollToLink(link) {
	
        jQuery('html, body').animate({
            scrollTop: jQuery("#"+link).offset().top - 20
        }, 800);
        var Offset = jQuery('#offers').offset();
        console.log(Offset);
	
}

function homeOverlay() {
	
	//shadows on homepage
	var easyHeight = jQuery('#run-easy').height();
	var easyWidth = jQuery('#run-easy').width();
	jQuery('.easy-overlay').height(easyHeight);
	jQuery('.easy-overlay').width(easyWidth + 30);
	
	var inspiredHeight = jQuery('#run-inspired').height();
	var inspiredWidth = jQuery('#run-inspired').width();
	jQuery('.inspired-overlay').height(inspiredHeight);
	jQuery('.inspired-overlay').width(inspiredWidth + 30);
	
	var internationalHeight = jQuery('#international').height();
	var internationalWidth = jQuery('#international').width();
	jQuery('.international-overlay').height(internationalHeight);
	jQuery('.international-overlay').width(internationalWidth + 30);
	
	jQuery('.easy-overlay').hover(function() {
		jQuery('.easy-overlay').animate({
		    opacity: 0.01,
		  }, 5000)
	});
	
	jQuery('.inspired-overlay').hover(function() {
		jQuery('.inspired-overlay').animate({
		    opacity: 0.01,
		  }, 5000)
	})
	
	jQuery('.international-overlay').hover(function() {
		jQuery('.international-overlay').animate({
		    opacity: 0.01,
		  }, 5000)
	})
	
	

	
}




var winHeight = jQuery(window).height();
var navHeight = jQuery('.navigation').height()
	
var maxScroll = navHeight - winHeight;

jQuery(window).scroll(function() {
	
	var scrolled = jQuery(document).scrollTop();
	
	
	
	var scrolled = jQuery(document).scrollTop();
	
	if ( navHeight > winHeight ) {
		
		if (maxScroll > scrolled) {
			//if(scrolled > 0) {
				jQuery('.navigation').css("top", -scrolled);
			//}
		}
	}
	
	
	
	if (scrolled > 170) {
		jQuery('.slide-overlay').css("position","fixed");
		jQuery('.slide-overlay').css("top",-170);
		jQuery('.back-to-top').show();
		//alert();
	} else {
		jQuery('.slide-overlay').css("position","absolute");
		jQuery('.slide-overlay').css("top",0);
		jQuery('.back-to-top').hide();
	}
		
})

jQuery(window).resize(function() {
	
	homeOverlay();
		
	//footer push
	var winHeight = jQuery(window).height();
	var contentHeight = jQuery('.container').height();
	if (jQuery('body').height() < 2000) {
		jQuery('.footer-push').height((winHeight - contentHeight) - 102);
	}
	
})

jQuery(window).load(function() {

  
  
  //MERCHANDISE PAGE //homepage slideshow
	jQuery('.merch-item .merch-pic').bxSlider({
		pager:false,
		infiniteLoop: true,
		useCSS: false,
		controls: true
	});
	
	jQuery('.male.merchandise-items').hide();
  
})

jQuery('a.gender-button').click(function() {
    
  if(!jQuery(this).hasClass('active')) {
  
    jQuery('.gender-button').removeClass('active');
    jQuery(this).addClass('active');
  
    var gender = jQuery(this).attr('rel');
    //alert(gender);
    jQuery('.merchandise-items').animate({
      opacity:0
    }, 500, function() {
      jQuery('.merchandise-items').hide();
      jQuery('.merchandise-items.'+gender).show();
      jQuery('.merchandise-items').animate({
        opacity:1
      })
    });
  
  }
  
})


