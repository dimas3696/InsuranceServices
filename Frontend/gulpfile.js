const gulp = require('gulp');
const autoprefixer = require('gulp-autoprefixer');
const server = require('browser-sync').create();
const sourcemaps = require('gulp-sourcemaps');
const gcmq = require('gulp-group-css-media-queries');
const	preproc = require('gulp-less');
const cleanCSS = require('gulp-clean-css');
const rename = require("gulp-rename");
const config = {
	src: './src',
	css: {
		watch: '/precss/**/*.less',
		src: '/precss/style.less',
		dest: '/css'
	},
	html: '/*.html',
	js: {
		src: '/js/*.js'
	}
};

gulp.task('style', function() {
	gulp.src(config.src + config.css.src)
	.pipe(sourcemaps.init())
	.pipe(preproc())
	.pipe(gcmq())
	.pipe(autoprefixer({
		browsers: ['> 0.1%'],
		cascade: false
	}))
	.pipe(cleanCSS({
		level: 2,
		format: 'beautify' 
	}))
	.pipe(sourcemaps.write('.'))
	.pipe(gulp.dest(config.src + config.css.dest))
	.pipe(cleanCSS({
		level: 2
	}))
	.pipe(sourcemaps.write('.'))
	.pipe(rename("style.min.css"))
	.pipe(gulp.dest(config.src + config.css.dest))
	.pipe(server.stream());
});


gulp.task('serve', function() {
	server.init({
	  server: config.src,
	  notify: false,
	  open: true,
	  cors: true,
	  ui: false
	});

	gulp.watch(config.src + config.css.watch, ["style"]);
	gulp.watch(config.src + config.html, server.reload);
	gulp.watch(config.src + config.js.src, server.reload);
});


