$(function() {

	var img = document.querySelector(".discounts--item__active .discounts--img");
	var imgs = document.querySelectorAll(".discounts--item .discounts--img");

	if(img.complete) {  //Script starts working only, when necessary image is loaded
		changeCol(img);
	};

	var imgsColors = []; 
	for (var i = 0; i < imgs.length; i++) {
		 setTimeout(imgsColors[i] = rememberCol(imgs[i]), 1);
	}






	function changeCol(img) {
	imgsColors

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

	var nextBtn = $(".discounts--btn__next");
	nextBtn.on("click", function() {
		nextSlide();


	});
	

	equalsHeight(".service--item");

});

function rememberCol(img) {
	var colorThief = new ColorThief();
	var color = colorThief.getPalette(img, 2, 1);

	return color;
}


var currentSlide = 1;
function nextSlide () {
	var slide = $(".discounts--item");
	

	slide.css({
		'left' : 'auto',
		'right' : '100%'
	}).eq(currentSlide-1).css({
		'left' : 'auto', 
		'right' : '0'
	}).animate({
		right : '-100%'
	}, 1000).removeClass("ie");

	currentSlide++;

	if (currentSlide > slide.length) {
		currentSlide = 1;
	}

	slide.eq(currentSlide-1).animate({
		right : '0'
	}, 1000).addClass("ie");

	var img = document.querySelector(".ie .discounts--img");

	setTimeout(changeCol(img), 1);

};

function equalsHeight (selector) {
	var selector = $(selector);
	var max = 0;
	selector.each(function () {
		var h = $(this).outerHeight();
		
		if(h > max) {
			max = h;
		}
	});

	$(selector).css("min-height", max);
};









