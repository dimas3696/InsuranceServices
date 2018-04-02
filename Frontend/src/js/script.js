$(function() {
	var img = document.querySelector(".discounts--item__active .discounts--img");
	var imgs = document.querySelectorAll(".discounts--item .discounts--img");
	var nextBtn = $(".discounts--btn__next");
	var prevBtn = $(".discounts--btn__prev");
	var checkEl = $(".discounts--check"); // Изначальные элементы точек слайдера
	var checks = $(".discounts--checks");
	var slide = $(".discounts--item");
	var checkAmount = slide.length;
	var imgsColors = [];

	for (var i = 0; i < imgs.length; i++) {  // Цикл анализирует основные цвета картинок слайдера и записывает их в массив imgsColors
		setTimeout(imgsColors[i] = rememberCol(imgs[i]), 1);
		if (i == 0) {
			changeCol(0); // Цвета первой картинки сразу меняют цвет секции "Страховки"
		}
	};

	createChecks(checkEl, checkAmount, checks);

	var check = $(".discounts--check"); // Элементы точек слайдера после создания дополнительных 

	equalsHeight(".service--item");
	
	nextBtn.on("click", function() {
		nextSlide();
	});

	prevBtn.on("click", function() {
		prevSlide();
	});

	check.on("click", function() {
		var index = $(this).index();
		$("[data-active]").css({
			"left" : "auto", 
			"right" : "0"
		}).animate({
			right : "-100%"
		}, 1000).removeAttr("data-active");

		slide.eq(index).animate({
			right : "0"
		}, 1000).attr("data-active");

	});

	function changeCol(slideEq) { // Принимает порядковый номер картинки в массиве слайдов и меняет цвета в секции "Страховки"

	paint(".services--item", 1);
	paint(".services--header", 1);
	paint(".services--wrap", 2);
	paint(".service--header", 2);

	paint(".test1", 1);
	paint(".test2", 2);
	paint(".test3", 3);

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
	slide.css({
		"left" : "auto",
		"right" : "100%"
	}).eq(currentSlide-1).css({
		"left" : "auto", 
		"right" : "0"
	}).animate({
		right : "-100%"
	}, 1000).removeAttr("data-active");

	check.eq(currentSlide-1).removeClass("discounts--check__active");

	currentSlide++;

	if (currentSlide > slide.length) {
		currentSlide = 1;
	}

	slide.eq(currentSlide-1).animate({
		right : "0"
	}, 1000).attr("data-active");


	check.eq(currentSlide-1).addClass("discounts--check__active");

	setTimeout(changeCol(currentSlide-1), 1);
};

function prevSlide () {
	slide.css({
		"right" : "auto",
		"left" : "100%"
	}).eq(currentSlide-1).css({
		"right" : "auto", 
		"left" : "0"
	}).animate({
		left : "-100%"
	}, 1000).removeAttr("data-active");

	check.eq(currentSlide-1).removeClass("discounts--check__active");

	currentSlide--;

	if (currentSlide <= 0) {
		currentSlide = slide.length;
	}

	slide.eq(currentSlide-1).animate({
		left : "0"
	}, 1000).attr("data-active");


	check.eq(currentSlide-1).addClass("discounts--check__active");

	setTimeout(changeCol(currentSlide-1), 1);
};

});

function rememberCol(img) { // Анализирует принятую картинку и возвращает ее основные цвета
	var colorThief = new ColorThief();
	var color = colorThief.getPalette(img, 2, 1);

	return color;
};

function createChecks (checkElement, checkAmount, parentElement) { // В зависимости от количества слайдов, создает нужное количество точек для управления слайдами
	if (checkAmount !== checkElement.length) {
		for (var i = checkElement.length; i < checkAmount; i++) {
			$("<button>" + (i+1) + "-й слайд" + "</button>").addClass("discounts--check").appendTo(parentElement);
		}
	}
};


function equalsHeight (selector) { // Выравнивает ширины всех элементов, найденых по селектору
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

