$(document).ready(function() {
	$('a').on('click', function(e){  
	    e.preventDefault();
	    $("ul.metismenu li a").removeClass('mm-active');
	    var pageRef = $(this).attr('href'),
	    	title = $(this).data('title'),
	    	subtitle = $(this).data('subtitle');
	  	$(this).addClass('mm-active');
	    callPage(pageRef,title,subtitle)
	});

	function callPage(pageRefInput,title,subtitle) {
		$.ajax({
			url: pageRefInput,
			type: "GET",
			beforeSend:function(ht) {
			  $('.content').html('');
			  jQuery('.overlay-loader').fadeIn('slow');
			  $('body').addClass('.overlay-loader');
			},
			success: function( response ) {
			  console.log('the page was loaded', response);
			  setTimeout(function() {
			  	
				  $("#titleHalaman").html(title);
				  $("#subTitleHalaman").html(subtitle);
				  $('.content').html(response);
				  // $('body').removeClass('.overlay-loader');
				  jQuery('.overlay-loader').fadeOut('slow');
			  },2000);
			},
			error: function( error ) {
			  console.log('the page was NOT loaded', error);
			},
			complete: function( xhr, status ) {
			  console.log("the request is complete!", xhr);
			}
		});	
	}
});
jQuery(window).load(function () {
	jQuery('.overlay-loader').fadeOut('slow');
});