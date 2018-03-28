var colorThief = new ColorThief();
var img = document.querySelector(".discounts--img");
var color = colorThief.getPalette(img, 8, 1);
var contrast1 = [];

console.log(color);


$(".services--item").css("background-color", "rgb(" + color[0][0] + "," + color[0][1] + "," + color[0][2] + ")");
$(".services--header").css("background-color", "rgb(" + color[0][0] + "," + color[0][1] + "," + color[0][2] + ")");


$(".services--header").css("color", "rgb(" + ((color[0][0]+128)%256) + "," + ((color[0][1]+128)%256) + "," + ((color[0][2]+128)%256) + ")");
$(".service--price").css("color", "rgb(" + ((color[0][0]+128)%256) + "," + ((color[0][1]+128)%256) + "," + ((color[0][2]+128)%256) + ")");
$(".service--about").css("color", "rgb(" + ((color[0][0]+128)%256) + "," + ((color[0][1]+128)%256) + "," + ((color[0][2]+128)%256) + ")");

$(".service--header").css("background-color", "rgb(" + color[1][0] + "," + color[1][1] + "," + color[1][2] + ")");
$(".services--wrap").css("background-color", "rgb(" + color[1][0] + "," + color[1][1] + "," + color[1][2] + ")");



