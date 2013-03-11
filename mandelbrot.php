<?php

$YIELD = <<< HTML
<script src="js/mandelbrot.js"></script>
<h1>Mandelbrot iPhone Wallpapers</h1>

<div class='program_canvas row'>
	<div class='span5'>
		<canvas id='main_canvas' data-processing-sources='mandelbrot.pde'></canvas>
		<canvas id='highres_canvas' data-processing-sources='mandelbrot.pde' class='hide'></canvas>
	</div>
	<div class='span4'>
		<button id="btn_reset" class='btn'>Reset</button>
		<br/>
		Iterations: <input type='number' min='200' max='10000' step='100' value='200' id='txt_iterations' style="height:auto;"><button id='btn_apply' class='btn'>Apply</button>
		<p/><br/>
		<button id="btn_download" class='btn btn-primary'>Download Image</button>
	</div>
</div>
HTML;
include "template.php";
?>
