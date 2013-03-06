<?php

$YIELD = <<< HTML
<script src="js/mandelbrot.js"></script>
<h1>Mandelbrot iPhone Wallpapers</h1>

<div class='program_canvas row'>
	<div class='span8'>
	        <canvas id='main_canvas' data-processing-sources='mandelbrot.pde'></canvas>
	</div>
	<div class='span4'>
		<button id="btn_download" class='btn btn-primary'>Download Image</button>
	</div>
</div>
HTML;
include "template.php";
?>
