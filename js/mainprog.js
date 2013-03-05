/** Program code for the Cellular Automata simulation.
 * By Robin Hu
 *
 */

var getProcessingInstance = function() {
	return Processing.getInstanceById("main_canvas");


};

//Initialize Event Handlers
var initEventHandlers = function() {
	$("#btn_start").click(function() {
		getProcessingInstance().loop();
	});

	$("#btn_stop").click(function() {
		getProcessingInstance().noLoop();
	});

	$("#txt_rule").keydown(function(evt) {
		if (evt.which === 13) {
			getProcessingInstance().parseRule(evt.target.value);
		}
	});
};

//DOM Ready Function
$(function() {
	initEventHandlers();
});
