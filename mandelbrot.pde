/* Mandelbrot Set generator
 * in Processing.js
 * By Robin Hu
 * (C) 2013
 *
 * */
float XMIN = -2.5;
float XMAX = 1.0;
float YMIN = 0;
float YMAX = 0;
float XLEN = XMAX - XMIN;
float YLEN = 0;
int MAX_ITERS = 200;
void setup() {
	size(640,960);

	YLEN = (height/width) * XLEN;
	YMAX = YLEN / 2;
	YMIN = -YMAX;
	background(50);
	mandel();
}

void draw() {

}

//Draw an iteration of the mandelbrot set.
void mandel() {
	loadPixels();
	float xFactor = (XLEN / width);
	float yFactor = -(YLEN / height);
	for(int x=0; x < width; x++) {
            for(int y=0; y < height; y++) {
		float cReal = xFactor * x + XMIN;
		float cImg = yFactor * y + YMAX;

		float zReal = cReal;
		float zImg = cImg;
		int iterations = 0;
		float zModulus = 0;
		while (iterations < MAX_ITERS) {
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
		if ( iterations == MAX_ITERS) {
			pixels[ pixelIndex ] = 0;
		}
		else {
			//pixels[ pixelIndex] = color(iterations % 255);

			int smoothColor =  (iterations + 1 - log(log(zModulus)) / log(2));
			if (smoothColor > 255) {
				smoothColor = abs(255 - (smoothColor - 255)) % 255;
			}
			//int smoothColor = iterations % 255;
			pixels[pixelIndex] = color(0,smoothColor /2, smoothColor);
		}


	    }
	}
	updatePixels();
}

void mouseClicked() {
	float xFactor = (XLEN / width);
	float yFactor = -(YLEN / height);

	float xPos = xFactor * mouseX + XMIN;
	float yPos = yFactor * mouseY + YMAX;

	float zoomFactor = 0.3125;
	MAX_ITERS = int(MAX_ITERS * 1.1);
	YLEN = YLEN * zoomFactor;
	XLEN = XLEN * zoomFactor;

	XMIN = xPos - XLEN / 2;
	XMAX = xPos + XLEN / 2;
	YMIN = yPos - YLEN / 2;
	YMAX = yPos + YLEN / 2;

	mandel();
}
