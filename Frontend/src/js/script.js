$(function() {

	
	var img = document.querySelector(".discounts--item__active .discounts--img");

	if(img.complete) {  //Script starts working only, when necessary image is loaded
		changeCol(img);
	};

});



function changeCol(img) {

/*	var defaults = {
		Paint1Col : [".services--item", ".services--header"], // Elements, wich will be painted with 1st color 
		Paint1ColText : [".services--header",".service--price",".service--about"], // For texts inside elements with 1st color
		Paint2Col : [".services--item",".services--header"], // Elements, wich will be painted with 2nd color 
		Paint2ColText : [".services--header",".service--price",".service--about"], // For texts inside elements with 2nd color
	};*/

	var colorThief = new ColorThief();
	var color = colorThief.getPalette(img, 2, 1);
	var contrast1 = [];

	paint(".services--item", 1);
	paint(".services--header", 1);
	paint(".services--wrap", 2);
	paint(".service--header", 2);

	textColor(".services--header", 1);
	textColor(".service--price", 1);
	textColor(".service--about", 1);
	textColor(".service--header", 2);


	function paint(selector, colorNumber) {
		$(selector).css("background-color", "rgb(" + color[colorNumber-1][0] + "," + color[colorNumber-1][1] + "," + color[colorNumber-1][2] + ")");
	}

	function textColor(selector, colorNumber) {
		if(((color[colorNumber-1][0]*0.3)+(color[colorNumber-1][1]*0.59)+(color[colorNumber-1][2]*0.11)+1.0) < 128.0) {
			$(selector).css("color", "rgba(255, 255, 255, 0.7)");
		}
		else {
			$(selector).css("color", "rgba(0, 0, 0, 0.85)" );
		}
	}
};




