(function() {

var Console = function(label, color, width, height) { // defining new constructor
  this.initialize(label, color, width, height); // handles all the set up work for new instances, needs to be called
}
var p = Console.prototype = new createjs.Container(); // inherit from Container

p.label;
p.background;
p.count = 0;

p.Container_initialize = p.initialize; // overrides container constructor with custom constructor
p.initialize = function(label, color, width, height) { // custom constructor
	this.Container_initialize(); // calls the parent constructor
	
	this.label = label;
	if (!color) { color = "#CCC"; }
	
	var text = new createjs.Text(label, "14px Tahoma", "#FFFFFF");
	text.textBaseline = "top";
	text.textAlign = "center";
	
	// var width = text.getMeasuredWidth()+30;
	// var height = text.getMeasuredHeight()+20;
	
	this.background = new createjs.Shape();
	this.background.graphics.beginFill(color).drawRoundRect(0,0,width,height,0);
	
	text.x = width/2;
	text.y = 10;
	// console.log("Console_ID");
	// console.log(console_id);
	// var content = new createjs.DOMElement(document.getElementById(console_id));
	// content.regX = 0;
	// content.regY = 0;

	// this.regX = width;
	//this.regY = height; // change anchor point to the bottom left
	
	this.addChild(this.background, text); 
	// this.addEventListener("click", this.handleClick);  // listen to clicks
	// this.addEventListener("mouseover", this.handleMouseover);
	// this.addEventListener("tick", this.handleTick); // makes it blink
	//p.alpha = .1;
} 

p.handleClick = function (event) {    
	var target = event.target;
	alert("You clicked on a button: "+target.label);
	$('#test').html("<p>Test Works!</p>");
} 

p.handleTick = function(event) {       
	p.alpha = Math.cos(p.count++*0.1)*0.4+0.6;
	//console.log(Math.cos(p.count++*0.1)*0.4+0.6);
}

p.handleMouseover = function(event) {
	console.log("moused over test");
	console.log(event.target.label);
	
	// alert("test");
	
	
	// do some kind of post to get more information
}

window.Console = Console; // assigns the class back into the global (window) scope, to make it available for the application
}());