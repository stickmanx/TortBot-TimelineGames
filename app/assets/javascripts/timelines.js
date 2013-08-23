// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {

	// sticky console header when the user scrolls further down
	var stickyHeaderTop = $('#canvas_console').offset().top;

	$(window).scroll(function() {
		if( $(window).scrollTop() > stickyHeaderTop ) {
			$('#canvas_console').css({position: 'fixed', top:'0px'});
			$('.main_content').css({padding:'30px 0px 0px 0px'});
			$('#add_timeline_event').css({margin:'40px -200px 0px 0px'});
		} else {
			$('#canvas_console').css({position: 'static', top:'0px'});
			$('#canvas_console').css('z-index', '2');
			$('.main_content').css({padding:'0px 0px 0px 0px'});
			$('#add_timeline_event').css({margin:'70px -200px 0px 0px'});
		}
	})
});


$(document).ready(function() {
	$('#display_user_canvas').submit(function() {
		$.post(
			$(this).attr('action'),
			$(this).serialize(),
			function(data) {
				console.log(data);
				console.log(data.timeline)
				console.log("Systems: "+data.timeline.systems)
				
				for(i in data.events) {
					console.log("Game ID: "+data.events[i].game_id)
					console.log("Name: "+data.events[i].name);
					console.log("Start Date: "+data.events[i].start_date);
					console.log("End Date: "+data.events[i].end_date);
					console.log("Image: "+data.events[i].image);
					console.log("System: "+data.events[i].system);
					console.log("Height: "+data.events[i].height);		
					console.log("Y Position: "+data.events[i].y_position);
					console.log("X Position: "+data.events[i].x_position);	
					console.log("Content: "+data.events[i].content);
					console.log("Event ID: "+data.events[i].event_id);
					// console.log(data.events[i].color);		
					
					$('#canvas_container').prepend(data.events[i].content);
				}
			
			
			$('#canvas_console').html("<canvas id='systems' width='1100' height='40' style='background-color:#2D2D2D;'></canvas>");
			console_init(data.timeline.system_count, data.timeline.systems)
			
			$('#canvas_intervals').html("<canvas id='intervals' width='100' height='"+((data.timeline.interval*400)+100)+"'></canvas>");
			interval_init(data.timeline.interval, data.timeline.max);	

			$('#canvas_area').html("<canvas id='myCanvas' width='1100' height='"+((data.timeline.interval*400)+100)+"'></canvas>");
			// $('#canvas_area').html("<canvas id='myCanvas' width='"+((data.timeline.system_count*200)+300)+"' height='"+((data.timeline.interval*400)+100)+"'></canvas>");
			


			$('#canvas_area').hide();
			
			// preprend div, comes from backend
			// details also need to be in th events so that it can be called from the javascript side
			
			// $('#canvas_container').prepend("<div id='drink' style='z-index: 1; position: absolute; background-color: #FF0000; width:180px; height:260px; padding: 5px; visibility: hidden;'><b>Hello! I'm an HTML div.</b><br/><br/>I am not rendered to the canvas, but I can be included in the display list for positioning and transformations.<br/><br/>This means I can contain any HTML content (rich text, forms, video, etc), but I'm not a full part of the EaselJS display list.<br/><br/><a href='http://easeljs.com/'>This is a link</a><img src='http://content.mycutegraphics.com/graphics/cats/yellow-cat-face.png'></div>")
			
			init(data.timeline.interval, data.timeline.system_count, data.timeline.systems, data.timeline.max, data.events);
			
			$('#canvas_area').fadeIn();

				// $( document ).tooltip({
				// 	items: ".test_game",
				// 	content: function() {
				// 		var element = $( this );
				// 		if (element.is( ".test_game" ) ) {
				// 			return "<div>TEST!!!</div>";
				// 		}
				// 	}
				// });
		

			$( ".test_game").qtip({
				content: 'asdfasdfasdftest!!!',
				position: {
					target: 'mouse',
					adjust: {x:5,y:5},
					viewport: $(window)
				}

			});


			},
			'json'
		)
		return false;
	});
	
	$('#display_user_canvas').submit();

	$( ".test_game").qtip({
		content: 'test!!!',
		position: {
			target: 'mouse',
			adjust: {x:5,y:5},
			viewport: $(window)
		}
		// items: ".test_game",
		// content: function() {
		// 	var element = $( this );
		// 	if (element.is( ".test_game" ) ) {
		// 		return "<div style='z-index:2000'>TEST!!!</div>";
		// 	}
		// }
	});



});

