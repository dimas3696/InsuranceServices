var colorThief = new ColorThief();
var img = document.querySelector(".discounts--img");
var color = colorThief.getPalette(img, 8, 1);
var contrast1 = [];

console.log(color);


$(".services--item").css("background-color", "rgb(" + color[0][0] + "," + color[0][1] + "," + color[0][2] + ")");
$(".services--header").css("background-color", "rgb(" + color[0][0] + "," + color[0][1] + "," + color[0][2] + ")");

console.log(color[0]);
if (color[0][0] > 127) {
	contrast1[0] = 0;
}
else {
	contrast1[0] = 255
} 

if (color[0][1] > 127) {
	contrast1[1] = 0;
}
else {
	contrast1[1] = 255
} 

if (color[0][2] > 127) {
	contrast1[2] = 0;
}
else {
	contrast1[2] = 255
} 

$(".services--header").css("color", "rgb(" + contrast1[0] + "," + contrast1[1] + "," + contrast1[2] + ")");
$(".service--price").css("color", "rgb(" + contrast1[0] + "," + contrast1[1] + "," + contrast1[2] + ")");
$(".service--about").css("color", "rgba(" + contrast1[0] + "," + contrast1[1] + "," + contrast1[2] + ", 0.8)");

var contrast2 = [];
if (color[1][0] > 127) {
	contrast2[0] = 0;
}
else {
	contrast2[0] = 255
} 

if (color[1][1] > 127) {
	contrast2[1] = 0;
}
else {
	contrast2[1] = 255
} 

if (color[1][2] > 127) {
	contrast2[2] = 0;
}
else {
	contrast2[2] = 255
} 

console.log(contrast2);

$(".service--header").css("color", "rgba(" + contrast2[0] + "," + contrast2[1] + "," + contrast2[2] + ", 0.8)");
$(".services--wrap").css("background-color", "rgb(" + color[1][0] + "," + color[1][1] + "," + color[1][2] + ")");
$(".service--header").css("background-color", "rgb(" + color[1][0] + "," + color[1][1] + "," + color[1][2] + ")");


$(".test1").css("background-color", "rgb(" + color[0][0] + "," + color[0][1] + "," + color[0][2] + ")");
$(".test2").css("background-color", "rgb(" + color[1][0] + "," + color[1][1] + "," + color[1][2] + ")");
$(".test3").css("background-color", "rgb(" + color[2][0] + "," + color[2][1] + "," + color[2][2] + ")");
$(".test4").css("background-color", "rgb(" + color[3][0] + "," + color[3][1] + "," + color[3][2] + ")");
$(".test5").css("background-color", "rgb(" + color[4][0] + "," + color[4][1] + "," + color[4][2] + ")");
$(".test6").css("background-color", "rgb(" + color[5][0] + "," + color[5][1] + "," + color[5][2] + ")");
$(".test7").css("background-color", "rgb(" + color[6][0] + "," + color[6][1] + "," + color[6][2] + ")");