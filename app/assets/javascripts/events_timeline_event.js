(function() {

var Timeline_event = function(label, color, width, hieght, image, event_id) { // defining new constructor
  this.initialize(label, color, width, hieght, image, event_id); // handles all the set up work for new instances, needs to be called
}
var p = Timeline_event.prototype = new createjs.Container(); // inherit from Container

p.label;
p.background;
p.count = 0;

p.Container_initialize = p.initialize; // overrides container constructor with custom constructor
p.initialize = function(label, color, width, height, image, event_id) { // custom constructor
	this.Container_initialize(); // calls the parent constructor
	
	this.label = label;
	if (!color) { color = "#CCC"; }
	
	var text = new createjs.Text(label, "16px Arial Narrow", "#FFFFFF");
	text.textBaseline = "top";
	text.textAlign = "center";
		
	this.background = new createjs.Shape();
	this.background.graphics.beginFill(color).drawRoundRect(0,0,width,height,2);
	this.background.regX = 0;
	this.background.regY = 0;

	text.x = width/2;
	text.y = 10;
	console.log("inside the events timeline event");
	console.log(event_id);

	var content = new createjs.DOMElement(document.getElementById(event_id));
	content.regX = 0;
	content.regY = 0;
	
	this.addChild(this.background, content, text);
	// this.addChild(this.background, text);
	// this.addEventListener("click", this.handleClick);  // listen to clicks
} 

p.handleClick = function (event) {    
	var target = event.target;
	alert("You clicked on a button: "+target.label);
} 

p.handleMouseover = function(event) {
	console.log("moused over test");
	console.log(event.target.label);

}

window.Timeline_event = Timeline_event; // assigns the class back into the global (window) scope, to make it available for the application
}());