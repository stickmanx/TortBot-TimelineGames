// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var stage, interval_stage, system_stage

createjs.Bitmap.prototype.setWidth = function(w) {
	if(this.image.width == 0) return;

	this.scaleX = w / this.image.width;
}

createjs.Bitmap.prototype.setHeight = function(h) {
	if(this.image.width == 0) return;

	this.scaleY = h / this.image.height;
}

function interval_init(intervals, year_end) {
	interval_stage = new createjs.Stage("intervals");

	for(var i=0; i <= intervals; i++) {
		var year_text = interval_stage.addChild(new createjs.Text(year_end-i, "20px Tahoma", "#474747"));
		year_text.x = 0;
		year_text.y = 30+(400 * i);
	}

	interval_stage.update();
}

function console_init(system_count,systems) {
	system_stage = new createjs.Stage("systems");

	for (var i in systems) {
		console.log(systems[i]);
		var btn1 = system_stage.addChild(new Interval(systems[i], "000000", 200, 40));
		btn1.x = (200*i);
		btn1.y = 0;		
	}

	system_stage.update();
}

function init (intervals, system_count,systems, year_end, events) {
	

	stage = new createjs.Stage("myCanvas");
	
	stage.enableMouseOver();
	
	for(var i=0; i <= intervals; i++) {
		console.log("inside intervals");
		var bar = stage.addChild(new Interval("","#5298C9",1100,1));
		bar.x = 0;
		bar.y = 40+(400 * i);
		
		// var year_text = stage.addChild(new createjs.Text(year_end-i, "20px Arial", "#ff7700"));
		// year_text.x = 0;
		// year_text.y = 30+(400 * i);
	}
	
	for(var i in events) {
		console.log(events[i].name);
		
		var timeline_event = stage.addChild(new Timeline_event(events[i].name, events[i].color, 188, events[i].height, events[i].image, events[i].event_id));
		timeline_event.x = 6+(200*events[i].x_position);
		timeline_event.y = 40+(events[i].y_position);
		
		// var image = new createjs.Bitmap("http://content.mycutegraphics.com/graphics/cats/yellow-cat-face.png");
		// var test = btn1.addChild(image);
		// test.x =0;
		// test.y =0;
	}
	
	// for (var i in systems) {
	// 	console.log(systems[i]);
	// 	var btn1 = stage.addChild(new Interval(systems[i], "000000", 200, 40));
	// 	btn1.x = (200*i);
	// 	btn1.y = 0;		
	// }
	
	
	
	// content = new createjs.DOMElement("foo")
	// var container = new createjs.Container();
	// stage.addChild(container);
	// 
	// var frame = new createjs.Shape();
	// frame.graphics.beginFill("#00F").drawRect(0,0,250,280);
	// 
	// 
	// // var content = new createjs.DOMElement(document.getElementById("drink"));
	// 
	// 
	// //content.visible = false;
	// 
	// //var o = content.clone();
	// //stage.addChild(content);
	// 
	// container.addChild(frame,content);
	// 
	// container.x = 0;
	// container.y = 0;
	
	
	
	stage.update();
}

function closeAddTimelineEvent() {
	$('#add_timeline_event').fadeOut();
}


$(document).ready(function() {
	$('#display_canvas').submit(function() {
		$.post(
			$(this).attr('action'),
			$(this).serialize(),
			function(data) {
				console.log(data);
				console.log(data.timeline)
				console.log(data.timeline.systems)
				
				for(i in data.events) {
					console.log(data.events[i].game_id)
					console.log(data.events[i].name);
					console.log(data.events[i].start_date);
					console.log(data.events[i].end_date);
					console.log(data.events[i].image);
					console.log(data.events[i].system);
					console.log(data.events[i].height);		
					console.log(data.events[i].y_position);
					console.log(data.events[i].x_position);	
					console.log(data.events[i].content);
					console.log(data.events[i].event_id);
					// console.log(data.events[i].color);		
					
					$('#canvas_container').prepend(data.events[i].content);
				}
			$('#canvas_console').html("<canvas id='systems' width='1100' height='40'></canvas>");
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
			},
			'json'
		)
		return false;
	});
	
	// update the canvas
	$('#display_canvas').submit();
	


	$('body').on('mouseover', '.timeline_event', function() {
		console.log("display test");
		console.log($(this).attr('id'));
		console.log($(this).attr('data-gameid'));
		
	});
	
	
	// Add Timeline Event
	$('#add_timeline_event').hide();
	
	$('#button_add_event').click(function() {
		$('#add_timeline_event').fadeIn();
	});

	// Close Add Timeline Event
	// up top

	// Add Timeline Ajax
	$('#new_timeline_event_form').submit(function() {
		console.log("Test");
		$.post(
			$(this).attr('action'),
			$(this).serialize(),
			function(data) {
				console.log(data);
			},
			'json'
		);
		return false;
	});

	// Add Timeline Event Ajax (needs ajax in the back)
	$('#new_timeline_event_form').submit(function() {
		
		$('#display_canvas').submit();
		return false;
	})

	
	
	
	
	// autosearch with ID
  $(".game_search").autocomplete({
		source:"/game_search/games",
		select: function(event, ui) {
			console.log(ui.item.id)
			$('#game_id').html("<input type='hidden' name='timeline_event[game_id]' value="+ui.item.id+" >")
			// console.log( ui.item ? 
			// 	"Selected" + ui.item.id :
			// 	"Nothing was selected" + this.value );

		}
	});


  	// Game preview submission
  	$("#game_preview").submit(function() {

  	});




	
});