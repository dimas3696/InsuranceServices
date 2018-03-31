$(function() {

	var img = document.querySelector(".discounts--item__active .discounts--img");
	var imgs = document.querySelectorAll(".discounts--item .discounts--img");
	var check = $(".discounts--check");

	var imgsColors = [];
	for (var i = 0; i < imgs.length; i++) {
		setTimeout(imgsColors[i] = rememberCol(imgs[i]), 1);
		if (i == 0) {
			changeCol(imgs[0], 0);
		}
	}

	function changeCol(img, slideEq) {

		paint(".services--item", 1);
		paint(".services--header", 1);
		paint(".services--wrap", 2);
		paint(".service--header", 2);

		textColor(".services--header", 1);
		textColor(".service--price", 1);
		textColor(".service--about", 1);
		textColor(".service--header", 2);

		function paint(selector, colorNumber) {
			$(selector).css("background-color", "rgb(" + imgsColors[slideEq][colorNumber-1][0] + "," + imgsColors[slideEq][colorNumber-1][1] + "," + imgsColors[slideEq][colorNumber-1][2] + ")");
		}

		function textColor(selector, colorNumber) {
			if(((imgsColors[slideEq][colorNumber-1][0]*0.3)+(imgsColors[slideEq][colorNumber-1][1]*0.59)+(imgsColors[slideEq][colorNumber-1][2]*0.11)+1.0) < 128.0) {
				$(selector).css("color", "rgba(255, 255, 255, 0.7)");
			}
			else {
				$(selector).css("color", "rgba(0, 0, 0, 0.85)" );
			}
		}

	};

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
		}, 1000).removeAttr("data-active");

		check.eq(currentSlide-1).removeClass('discounts--check__active');

		currentSlide++;

		if (currentSlide > slide.length) {
			currentSlide = 1;
		}

		slide.eq(currentSlide-1).animate({
			right : '0'
		}, 1000).attr("data-active");


		check.eq(currentSlide-1).addClass('discounts--check__active');

		var img = document.querySelector("[data-active] .discounts--img");

		setTimeout(changeCol(img, currentSlide-1), 1);
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

