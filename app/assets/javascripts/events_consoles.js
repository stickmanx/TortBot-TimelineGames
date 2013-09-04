(function() {

var Console = function(label, color, width, height) { // defining new constructor
  this.initialize(label, color, width, height); // handles all the set up work for new instances, needs to be called
}
var p = Console.prototype = new createjs.Container(); // inherit from Container

p.label;
p.background;

p.Container_initialize = p.initialize; // overrides container constructor with custom constructor
p.initialize = function(label, color, width, height) { // custom constructor
	this.Container_initialize(); // calls the parent constructor
	
	this.label = label;
	if (!color) { color = "#CCC"; }
	
	var text = new createjs.Text(label, "14px Tahoma", "#FFFFFF");
	text.textBaseline = "top";
	text.textAlign = "center";
	
	this.background = new createjs.Shape();
	this.background.graphics.beginFill(color).drawRoundRect(0,0,width,height,0);
	
	text.x = width/2;
	text.y = 10;
	
	this.addChild(this.background, text); 
}

window.Console = Console; // assigns the class back into the global (window) scope, to make it available for the application
}());