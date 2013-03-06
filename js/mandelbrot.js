/* Utility functions for the MandelBrot program.
 *
 *
 * */

//DOM ready function
$(function() {
	$("#btn_download").click(function() {
		var dataURL = document.getElementById("main_canvas").toDataURL();

		window.open(dataURL, "Mandelbrot Image", "width=640, height=960");
	});


});
