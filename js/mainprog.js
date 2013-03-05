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
	
	$("#btn_clear").click(function() {
		getProcessingInstance().clearWorld();
	});

	$("#txt_rule").keydown(function(evt) {
		if (evt.which === 13) {
			getProcessingInstance().parseRule(evt.target.value);
		}
	});

	var customRules = [
			{name: "Star Wars", rule: "345/2/4"},
			{name: "Brian's Brain", rule: "/2/3"},
			{name: "Conway's Life", rule: "23/3/2"},
			{name: "Rake", rule: "3467/2678/6"},
			{name: "SediMental", rule: "45678/25678/4"}
		];
	$.each( customRules, function(index, value) {
		$("<option>", {
			text: value.name,
		}).data('rule',value.rule).appendTo($("#rule_selection"));
	});

	$("#rule_selection").change(function() {
		$("#txt_rule").val( $(this.options[this.selectedIndex]).data('rule') );

		var keyEvent = jQuery.Event("keydown");
		keyEvent.which = 13;
		$("#txt_rule").trigger(keyEvent);
	});
};

//DOM Ready Function
$(function() {
	initEventHandlers();
});
