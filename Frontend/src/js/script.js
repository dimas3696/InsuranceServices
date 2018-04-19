$(function() {
	var img = document.querySelector(".discounts--item__active .discounts--img");
	var imgs = document.querySelectorAll(".discounts--item .discounts--img");
	var nextBtn = $(".discounts--btn__next");
	var prevBtn = $(".discounts--btn__prev");
	var checkEl = $(".discounts--check"); // Изначальные элементы точек слайдера
	var checks = $(".discounts--checks");
	var slide = $(".discounts--item");
	var slideList = $(".discounts--list");

	var checkAmount = slide.length;
	var imgsColors = [];
	var break_md = 980;


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

		if (index + 1 != currentSlide) {
			translateWidth = -slide.eq(currentSlide-1).width() * (index);
			slideList.css({
				'transform': 'translate(' + translateWidth + 'px, 0)'
			});
			check.eq(currentSlide-1).removeClass("discounts--check__active");

			currentSlide = index + 1;
			
			setTimeout(function () {
				check.eq(currentSlide-1).addClass("discounts--check__active");
			}, 800);
			setTimeout(changeCol(currentSlide-1), 1);
		};
	});


	cancelDrag($("a"));


	cancelequalsHeight(".service--item", break_md);


	function changeCol(slideEq) { // Принимает порядковый номер картинки в массиве слайдов и меняет цвета в секции "Страховки"

	paint(".services--item", 1);
	paint(".services--header", 1);
	paint(".services--wrap", 2);

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
var slideCount = slide.length;
var translateWidth = 0;

function nextSlide() {

	if (currentSlide == slideCount || currentSlide <= 0 || currentSlide > slideCount) {
		slideList.css("transform", "translate(0, 0)");
		check.eq(currentSlide-1).removeClass("discounts--check__active");

		currentSlide = 1;
		setTimeout(function () {
			check.eq(currentSlide-1).addClass("discounts--check__active");
		}, 800);
		setTimeout(changeCol(currentSlide-1), 1);
	} 
	else {
		translateWidth = -slide.eq(currentSlide-1).width() * (currentSlide);
		slideList.css({
			"transform": "translate(" + translateWidth + "px, 0)"
		});
		
		check.eq(currentSlide-1).removeClass("discounts--check__active");


		currentSlide++;
		setTimeout(function () {
			check.eq(currentSlide-1).addClass("discounts--check__active");
		}, 800);
		setTimeout(changeCol(currentSlide-1), 1);
	}
}

function prevSlide() {
	if (currentSlide == 1 || currentSlide <= 0 || currentSlide > slideCount) {
		translateWidth = -slide.eq(currentSlide-1).width() * (slideCount - 1);
		slideList.css({
			'transform': 'translate(' + translateWidth + 'px, 0)'
		});
		check.eq(currentSlide-1).removeClass("discounts--check__active");

		currentSlide = slideCount;
		setTimeout(function () {
			check.eq(currentSlide-1).addClass("discounts--check__active");
		}, 800);
		setTimeout(changeCol(currentSlide-1), 1);
	} 
	else {
		translateWidth = -slide.eq(currentSlide-1).width() * (currentSlide - 2);
		slideList.css({
			'transform': 'translate(' + translateWidth + 'px, 0)'
		});
		check.eq(currentSlide-1).removeClass("discounts--check__active");

		currentSlide--
		setTimeout(function () {
			check.eq(currentSlide-1).addClass("discounts--check__active");
		}, 800);
		setTimeout(changeCol(currentSlide-1), 1);

	}
}

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


function cancelDrag (selector) {
	$(selector).on("dragstart", function(e) {
		e.preventDefault();
	});
};


function cancelequalsHeight (selector, windowWidth) {
	if ($(window).width() <= windowWidth) {
		$(selector).css("min-height", "auto");
	}



};