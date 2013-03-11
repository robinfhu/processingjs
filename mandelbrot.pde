/* Mandelbrot Set generator
 * in Processing.js
 * By Robin Hu
 * (C) 2013
 *
 * */

MandelCoordinates PLOT;
bool SHOULD_RENDER = true;
void setup() {
	size(300, 960 * (300/640))
	PLOT = new MandelCoordinates();
	background(50);
}

void draw() {
	mandel();
}

void renderFullImage(int new_width, MandelCoordinates plotData) {
	size(new_width, 960 * (new_width / 640));
	PLOT = plotData;
	startRender();
	mandel();
}

void startRender() {
	SHOULD_RENDER = true;
}

MandelCoordinates getPlotData() {
	return PLOT;
}

void setMaxIters(int n) {
	PLOT.setMaxIters(n);
	startRender();
}

void reset() {
	PLOT = new MandelCoordinates();
	startRender();
}

//Draw an iteration of the mandelbrot set.
void mandel() {
	if (SHOULD_RENDER) {
		SHOULD_RENDER = false;
	}
	else {
		return;
	}
	loadPixels();
	float xFactor = PLOT.xfactor(width);
	float yFactor = PLOT.yfactor(height);
	for(int x=0; x < width; x++) {
            for(int y=0; y < height; y++) {
		float cReal = xFactor * x + PLOT.xmin;
		float cImg = yFactor * y + PLOT.ymax;

		float zReal = cReal;
		float zImg = cImg;
		int iterations = 0;
		float zModulus = 0;
		while (iterations < PLOT.maxIters) {
			float zRealSq = zReal * zReal;
			float zImgSq = zImg * zImg;
			
			if ( zRealSq + zImgSq > 4.0f) {
				zModulus = zRealSq + zImgSq;
				break;
			}
			float twoAB = 2.0 * zReal * zImg;
			zReal = zRealSq - zImgSq + cReal;
			zImg = twoAB + cImg;
			iterations++;
		}
		
		int pixelIndex = x + y * width;
		if ( iterations >= PLOT.maxIters) {
			pixels[ pixelIndex ] = color(0);
		}
		else {
			//pixels[ pixelIndex] = color(iterations % 255);

			int smoothColor =  (iterations + 1 - log(log(zModulus)) / log(2));
			if (smoothColor > 255) {
				smoothColor = abs(255 - (smoothColor - 255)) % 255;
			}
			//int smoothColor = iterations % 255;
			pixels[pixelIndex] = color(smoothColor / 6,smoothColor /1.3, smoothColor / 10);
		}


	    }
	}
	updatePixels();
}

void mouseClicked() {
	PLOT.zoom(0.3125);
	$("#txt_iterations").val(PLOT.maxIters);
	startRender();
}

//Class that handles the coordinate system
class MandelCoordinates {
	float xmin, xmax, ymin, ymax;
	float xlen, ylen;
	int maxIters;

	MandelCoordinates() {
		xmin = -2.5;
		xmax = 1.0;
		xlen = xmax - xmin;
		
		ylen = (height/width) * xlen;
		ymax = ylen / 2;
		ymin = -ymax;
		maxIters = 200;
	}

	float xfactor(int canvasWidth) {
		return xlen / canvasWidth;
	}

	float yfactor(int canvasHeight) {
		return -ylen / canvasHeight;
	}

	void setMaxIters( int n ) {
		maxIters = n;
	}

	void zoom( zoomFactor ) {
		maxIters = int(maxIters *1.1);
		float xPos = xfactor(width) * mouseX + xmin;
		float yPos = yfactor(height) * mouseY + ymax;
		ylen = ylen * zoomFactor;
		xlen = xlen * zoomFactor;

		xmin = xPos - xlen / 2;
		xmax = xPos + xlen / 2;
		ymin = yPos - ylen / 2;
		ymax = yPos + ylen / 2;
	}
}
