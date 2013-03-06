<?php

$YIELD = <<< HTML
<h1>Mandelbrot iPhone Wallpapers</h1>

<div class='program_canvas'>
	<canvas id='main_canvas' data-processing-sources='mandelbrot.pde'></canvas>
</div>
HTML;
include "template.php";
?>
