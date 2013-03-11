<?php

$YIELD = <<< HTML
<script src="js/mandelbrot.js"></script>
<h1>Mandelbrot iPhone Wallpapers</h1>

<div class='program_canvas row'>
	<div class='span5'>
		<canvas id='main_canvas' data-processing-sources='mandelbrot.pde'></canvas>
		<canvas id='highres_canvas' data-processing-sources='mandelbrot.pde' class='hide'></canvas>
	</div>
	<div class='span6'>
		<button id="btn_reset" class='btn'>Reset</button>
		<br/>
		Iterations: <input type='number' min='200' max='10000' step='100' value='200' id='txt_iterations' style="height:auto;"><button id='btn_apply' class='btn'>Apply</button>
		<p/><br/>
		<button id="btn_download" class='btn btn-primary'>Download Image</button>

		<div id='overview'>
			<h3>Overview</h3>
			Fractals have always fascinated me, with the Mandelbrot Set being my favorite!  It's unfortunate that I am limited by floating point precision for this app; you can't zoom very far.
			<br/>Here is how you use this app:
			<ul>
				<li>Click the region you want to zoom to. The app will automatically zoom a fixed amount.</li>
				<li><strong>Right click</strong> to center the fractal to that location.</li>
				<li>If you like what you see, click <strong>Download Image</strong>, and a 640x960 resolution image will open in a new window. You can use it on your iPhone!</li>
			</ul>

			<h3>Technologies Used</h3>
			<ul>
				<li>jQuery, Processing.js</li>
				<li>Total project time: 10 hours</li>
			</ul>
		</div>
	</div>
</div>
HTML;
include "template.php";
?>
