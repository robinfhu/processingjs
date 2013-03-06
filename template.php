<html>
	<head>
		<title>RobinForest.net</title>
		<script src="js/processing-1.4.1.js"></script>
		<script src="js/jquery-1.9.1.min.js" type='text/javascript'></script>
		<script src="js/underscore-min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<!--- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
		<style>
			body {
				padding-top: 60px;
			}
		</style>
	</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<span class='brand'>Cool Programs by Robin Hu</span>

				<div class='nav-collapse collapse'>
					<ul class='nav'>
						<li><a href='index.php'>Cellular Automata</a></li>
						<li><a href='coins.php'>Change Calculator</a></li>
						<li><a href='mandelbrot.php'>Mandelbrot</a></li>

					</ul>
				</div>
			</div>
		</div>
	</div>		
	<div class='container'>
		<?php echo $YIELD; ?>
	</div>
	<div class='footnote text-center'>
		<small>&copy; Robin Hu. All Rights Reserved.</small>
	</div>
</body>
</html>
