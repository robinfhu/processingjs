<?php
$YIELD = <<< HTML
<script src="js/coins.js"></script>
<style>
.result .given {
	background-color: #FFFF88;
}

.result .change {
	background-color: #CCDDFF;
}

.result div{
	border-bottom: solid 1px #AAAAAA;
}

</style>
<h1>Change calculator</h1>

<label for="cents_value">Cost of Item: </label>
<input type='text' name='cents_value' id='cents_value' placeholder="e.g.: 5.78" pattern="[0-9\.]*"/>
<button class='btn btn-primary' id='btn_calculate'>Calculate</button>

	<div class='row'>
		<div id='change_results' class='span6'>
		</div>
		<div class='span5'>
			<h3>Overview</h3>
			My motivation for creating this app came to me when I was standing in line at McDonald's, ready to pay for my meal with cash.
			I hate getting coins in my change, so I always try to give the cashier some amount of coins so that I get only bills back, or a quarter.<p/>
			However, sometimes my brain freezes while trying to calculate the right amount of coins to get, so I hold up the line.<p/>

			To use this, simply input the final cost of your item. You will be presented with a list of amounts to give to the cashier, along with the proper change you will receive.

			<h3>Technical Skills Learned</h3>
			<ul>
				<li>jQuery, Underscore.js, Twitter Bootstrap.</li>
				<li>Total project time: 5 hours.</li>
			</ul>
		</div>
	</div>

HTML;
include "template.php";
?>
