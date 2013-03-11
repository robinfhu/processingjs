/* Utility functions for the MandelBrot program.
 *
 *
 * */

//DOM ready function
$(function() {
	$("#btn_download").click(function() {
		var instance = Processing.getInstanceById("highres_canvas");
		var smallInstance = Processing.getInstanceById("main_canvas");
		instance.renderFullImage(640, smallInstance.getPlotData());
		var dataURL = document.getElementById("highres_canvas").toDataURL();

		window.open(dataURL, "Mandelbrot Image", "width=640, height=960");
	});

	$("#btn_apply").click(function() {
		var smallInstance = Processing.getInstanceById("main_canvas");
		smallInstance.setMaxIters($("#txt_iterations").val());
	});
	
	$("#btn_reset").click(function() {
		var smallInstance = Processing.getInstanceById("main_canvas");
		smallInstance.reset();
	});


});
