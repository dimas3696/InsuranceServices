var img = document.querySelector(".discounts--item__active .discounts--img");
var imgs = document.querySelectorAll(".discounts--item .discounts--img");
var nextBtn = $(".discounts--btn__next");
var prevBtn = $(".discounts--btn__prev");
	var checkEl = $(".discounts--check"); // Изначальные элементы точек слайдера
	var checks = $(".discounts--checks");
	var slide = $(".discounts--item");
	var slideList = $(".discounts--list");
	var checkAmount = slide.length;
	var imgsColors = new Array;
	var elToChangeTag = $("[data-changeTag]");
	var searchInput = $(".main-header--input");
	var searchIcon = $(".main-header--show");
	var logo = $(".main-header--logo");
	var headerWrap = $(".main-header--wrap");
	var contacts = $(".contacts--list");

	var break_md = 980;
	var break_sm = 780;
	var break_xs = 560;


	$(function() {

	for (var i = 0; i < imgs.length; i++) {  // Цикл анализирует основные цвета картинок слайдера и записывает их в массив imgsColors
		setTimeout(imgsColors[i] = rememberCol(imgs[i]), 1);
		if (i == 0) {
			changeCol(0); // Цвета первой картинки сразу меняют цвет секции "Страховки"
		}
	};


	createChecks(checkEl, checkAmount, checks);


	var check = $(".discounts--check"); // Элементы точек слайдера после создания дополнительных 


	equalsHeight(".service--item");


	$(slide).hammer().on("swipeleft", function(){
		nextSlide();
	});

	$(slide).hammer().on("swiperight", function(){
		prevSlide();
	});

	nextBtn.on("click", function(event) {
		event.preventDefault();
		nextSlide();
	});


	prevBtn.on("click", function(event) {
		event.preventDefault();
		prevSlide();
	});


	check.on("click", function() {
		var index = $(this).index();

		if (index + 1 != currentSlide) {
			translateWidth = -slide.eq(currentSlide-1).width() * (index);
			slideList.css({
				"transform": "translate(" + translateWidth + "px, 0)"
			});
			check.eq(currentSlide-1).removeClass("discounts--check__active");

			currentSlide = index + 1;
			
			setTimeout(function () {
				check.eq(currentSlide-1).addClass("discounts--check__active");
			}, 800);
			setTimeout(changeCol(currentSlide-1), 1);
		};
	});

	
	searchIcon.on("click", function(event) {
		event.preventDefault();

		search();
		
	});

	replaceElementTag(elToChangeTag, "<span></span>", break_md);


	cancelequalsHeight(".service--item", break_md);


	function changeCol(slideEq) { // Принимает порядковый номер картинки в массиве слайдов и меняет цвета в секции "Страховки"

	paint(".services--item", 1);
	paint(".services--header", 1);
	paint(".services--wrap", 2);

/*	paint(".test1", 1);
	paint(".test2", 2);
	paint(".test3", 3);*/

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
			"transform": "translate(" + translateWidth + "px, 0)"
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
			"transform": "translate(" + translateWidth + "px, 0)"
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


function replaceElementTag(selector, newTagString, windowWidth) {
	if ($(window).outerWidth() >= windowWidth){
		$(selector).each(function(){
			var newElem = $(newTagString, {html: $(this).html()});
			$.each(this.attributes, function() {
				newElem.attr(this.name, this.value);
			});
			$(this).replaceWith(newElem);
		});
	}
}


function cancelequalsHeight(selector, windowWidth) {
	if ($(window).outerWidth() <= windowWidth) {
		$(selector).css("min-height", "auto");
	}
};


function search() {

	if($(window).outerWidth() <= break_md && $(window).outerWidth() > break_sm) { // Экран от break_sm до break_md
		searchInput.toggleClass("main-header--input__moved");
		var breakToResizeLogo = 875;
		if ($(window).outerWidth() <= breakToResizeLogo) {
			logo.toggleClass("main-header--logo__moved");
		}
	}

	else if($(window).outerWidth() <= break_sm && $(window).outerWidth() > break_xs) {
		headerWrap.toggleClass("main-header--wrap__moved");
		
		if(headerWrap.hasClass("main-header--wrap__moved")){
			searchInput.css({
				"display" : "block"
			}).animate({
				opacity: 1 
			}, 1000);
		}
		else if( !(headerWrap.hasClass("main-header--wrap__moved"))){
			searchInput.animate({
				opacity: 0 
			}, 500);

		}
		
	}

	else if($(window).outerWidth() < break_sm) {
		searchInput.css({
			"top" : logo.outerHeight()
		});

		contacts.toggleClass("contacts--list__moved");

		if(contacts.hasClass("contacts--list__moved")){
			searchInput.css({
				"display" : "block"
			}).animate({
				opacity: 1 
			}, 1000);
		}
		else if( !(contacts.hasClass("contacts--list__moved"))){
			searchInput.animate({
				opacity: 0 
			}, 500);

		}
	}

	
}