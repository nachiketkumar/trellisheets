gulp = require 'gulp'
path = require 'path'
gutil = require 'gulp-util'
sass = require 'gulp-sass'
minifyCSS = require 'gulp-minify-css'
rename = require 'gulp-rename'
AutoPrefix = require 'gulp-autoprefixer'

stylesSrc = './src/entries/*'

autoprefix = new AutoPrefix
  browsers: [
    'chrome >= 35'
    'ie >= 10'
    'iOS >= 6'
    'ff >= 24'
    'safari >= 5.1'
  ]

gulp.task 'styles', ->

  gulp
    .src stylesSrc
    .pipe sass
      paths: [path.join(__dirname, './src')]
      plugins: [autoprefix]
    .on 'error', (err) ->
      gutil.log(err)
      this.emit('end')
    .pipe gulp.dest('./public/styles')
    .pipe minifyCSS()
    .pipe rename
      suffix: ".min"
    .pipe gulp.dest('./public/styles')

gulp.task 'watch', ->
  gulp.watch './src/**/*', ['styles']

gulp.task 'default', ['styles']
