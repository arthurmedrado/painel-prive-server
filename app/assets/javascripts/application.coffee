# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file. JavaScript code in this file should be added after the last require_* statement.
#
# Read Sprockets README (https:#github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap/dist/js/bootstrap
#= require ladda-bootstrap/dist/spin
#= require ladda-bootstrap/dist/ladda
#= require sweetalert2/dist/sweetalert2
#= require highcharts/highcharts.src
#= require jsrender/jsrender
#= require magnific-popup/dist/jquery.magnific-popup
#= require blueimp-file-upload/js/vendor/jquery.ui.widget
#= require blueimp-file-upload/js/jquery.iframe-transport
#= require blueimp-file-upload/js/jquery.fileupload
#= require_tree .

String::isEmpty = ->
  @length == 0 or !@trim()
