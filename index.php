<?php 
$YIELD = <<< HTML
<script src="js/cellular_main.js"></script>
<h1>Cellular automata in Processing.js</h1>

		<div class='program_canvas'>
			<div class='btn-group'>
				<button id='btn_start' class='btn btn-primary'>Start</button>
				<button id='btn_stop' class='btn btn-primary'>Stop</button>
				<button id='btn_clear' class='btn btn-primary'>Clear World</button>
				<button id='btn_random' class='btn btn-primary'>Randomize</button>
			</div>

			<label for='rule_selection'>Enter Rule</label>
			<select name='rule_selection' id='rule_selection'>
			</select>
			<input type='text' placeholder='Enter rule(i.e."345/2/4")...' id='txt_rule'>


			<p/>
			<canvas id='main_canvas' data-processing-sources="cellular.pde"></canvas>	
		</div>

		<h3>How to use</h3>
		<ul>
			<li>Press <strong>Start</strong> to begin simulation. Press <strong>Stop</strong> to pause it.</li>
			<li><strong>Clear World</strong> sets all cells to zero state. <strong>Randomize</strong> randomly adds pixels to about 50% of the world.</li>
			<li>Drag your mouse over the canvas to add more pixels. Left click to add pixels, right click to erase.</li>
			<li>To change the simulation rules, enter rule in the input box and press <strong>enter</strong>. Rule must in S/B/G notation.</li>
			<li>Requires HTML5 compatible browser.</li>
			<li>Source code is available for viewing: <a href="https://github.com/robinfhu/processingjs">https://github.com/robinfhu/processingjs</a></li>
		</ul>

		<h3>Overview</h3>
		This program was inspired by <a href="http://psoup.math.wisc.edu/mcell/index.html">Mirek's Cellebration</a> website, which talks in detail about <strong>cellular automata</strong>.
		These are mathematical simulations which involve iterating a collection of cells in a grid, based on a series of rules. 
		<p/>
		For instance, the well known automaton, <strong>Conway's Game of Life</strong>, has the following rules:
		<ul>
			<li>Cells in the grid can either be ON or OFF.</li>
			<li>If a cell is OFF, and exactly 3 of its neighbors are ON, the cell turns ON in the next generation.</li>
			<li>If a cell is ON, and 2 or 3 of its neighbors are ON, it continues to survive. Otherwise, it dies in the next generation.</li>
		</ul>
		To see this in action, enter the rule <strong>23/3/2</strong> in the rule box.
		<p/>
		I created this program using <a href="http://processingjs.org/">Processing.js</a>.  This is a powerful JavaScript visualization engine that uses canvas in HTML 5. Warning though, this simulation can be very CPU intensive!

		<h3>Rules notation</h3>
		Each rule has three parts: Survival rule, Birth rule and # of generations (S/B/G). 
		<ul>
			<li>The survival rule is a list of numbers 0-8 which specify how many neighboring cells must be alive in order for a given cell to survive. 
			Represented by "23" in The Game of Life.</li>
			<li>The birth rule is also a list of numbers 0-8, which specify how many neighboring cells must be alive in order for a dead cell to come alive.
			Represented by "3" in The Game of Life.</li>
			<li>The # of generations is a special rule used to create complex automata. For The Game of Life, this number is "2", because a cell can only be alive or dead.</li>
		</ul>

		<h3>'Generations' Automata</h3>
		Good examples include Brian's Brain ("/2/3") and Star Wars ("345/2/4").  More rules can be found here: <a href="http://psoup.math.wisc.edu/mcell/rullex_gene.html">MCell Rules Lexicon</a>

		<p/>
		Lets examine how the Star Wars rule works: <strong>345/2/4</strong>.
		<ul>
			<li>If a cell is OFF, and two neighbors are ON, the current cell is turned ON.</li>
			<li>If a cell is ON and 3,4 or 5 neighbors are ON, the current cell remains ON.</li>
			<li>If a cell is ON, but has 1,2,6,7 or 8 neighbors that are ON, the current cell becomes <strong>AGED</strong></li>
			<li>Aged cells are not dead, but they do not contribute to birthing new cells.  They also do not contribute towards keeping cells in the ON state alive.</li>
			<li>The "4" in the notation represents the total number of states a cell can have: OFF, ON, Aged level 1 and Aged level 2.</li>
			<li>After a cell has reached Aged level 2, it dies and turns OFF.</li>
		</ul>

		<h3>Technologies Learned from this Project</h3>
		<ul>
			<li>Git source control. This is my first exposure to Git and GitHub.</li>
			<li>jQuery was used to make the application form respond to user events.</li>
			<li>Twitter Bootstrap was used for the UI.</li>
			<li>Processing.js was used for the visualization.</li>
			<li>Hours spent: 10.</li>
		</ul>
HTML;
include("template.php"); 

?>
