/* Brian's Brain. A Cellular AUtomata project in processing.js
 * By Robin Hu
 * (C) 2013
 * */
//Globals
int CANVAS_WIDTH = 800;	
int CANVAS_HEIGHT = 600;
int PIXEL_WIDTH = 3;	//specify how big you want each pixel.
int PWIDTH = ceil(CANVAS_WIDTH/PIXEL_WIDTH);
int PHEIGHT = ceil(CANVAS_HEIGHT/PIXEL_WIDTH);

int WORLD_A[][];
int WORLD_B[][];

color STATE_COLORS[];

//Setup the canvas.
void setup() {
	size(CANVAS_WIDTH, CANVAS_HEIGHT);
	noStroke();
	frameRate(30);

	//Initialize memory array where we will store the grid data.
	WORLD_A = new int[PWIDTH][PHEIGHT];
	WORLD_B = new int[PWIDTH][PHEIGHT];

	//Randomize the grid in the beginning.
	/*for(int x=0; x<PWIDTH; x++) {
		for(int y=0; y<PHEIGHT; y++) {
			if ( random(0,100) > 50)
			    WORLD_B[x][y]=1;
		}
	}*/
	WORLD_B[40][40] = 1;
	WORLD_B[40][41] = 1;
	WORLD_B[39][40] = 1;
	WORLD_B[39][41] = 1;

	STATE_COLORS = { color(0), color(0), color(130,130,250), color(250,100,100), color(250,250,30)};
}

//Main draw loop. Is called continuously.
void draw() {
	background(230,230,255);
	//This loop renders the pixels on the canvas.
	////Depending on the state of a cell, a different colored pixel is generated.
	for(int x=0; x < PWIDTH; x++) {
	   for(int y=0; y < PHEIGHT; y++) {
		int currentState = WORLD_B[x][y];
		if ( currentState > 0) {

		     drawPoint(x,y, STATE_COLORS[currentState]);
		     WORLD_A[x][y] = currentState;
		}
		else if (currentState <= 0) {
		     WORLD_A[x][y] = currentState;
		}
		WORLD_B[x][y] = 0;
	   }
	}

	//This loop calculates the next generation of cells.
	//Cellular Automata rules should be specified here.
	for(int x=0; x < PWIDTH; x++) {
            for(int y=0; y < PHEIGHT; y++) {
		int currentState = WORLD_A[x][y];
		/*
		if ( currentState == 0 && neighborsOn == 2) {
			WORLD_B[x][y] = 1; 
		}
		else if (currentState == 1) {
			WORLD_B[x][y] = 2;
		}
		else if (currentState == 2) {
			WORLD_B[x][y] = 0;
		}*/

		if ( currentState == 0) {
			int neighborsOn = calcNeighbors(x,y,false);
			if (neighborsOn == 2)
				WORLD_B[x][y] = 1;
		}
		else if ( (currentState == 1 || currentState == 2)) {
			int neighborsOn = calcNeighbors(x,y,false);
			if (currentState == 1 && neighborsOn >= 3 && neighborsOn <= 5) 
			{
				WORLD_B[x][y] = currentState;
			}

			if (neighborsOn < 3 || neighborsOn > 5)
				WORLD_B[x][y] = currentState + 1;

			if ( currentState == 2)
				WORLD_B[x][y] = 3;
		}
		else if (currentState == 3) {
			WORLD_B[x][y] = 0;
		}
		



	    }
	}
	
}

//Given a cell, how many neighbors are in the "on" state?
int calcNeighbors(int x,int y, bool getAged) {
	int totalSum = 0;
	int xLeft = (x + PWIDTH - 1) % PWIDTH;
	int xRight = (x + 1) % PWIDTH;
	int yTop = (y + PHEIGHT -1) % PHEIGHT;
	int yBottom = (y + 1) % PHEIGHT;
	
	if (getAged) {
		if (WORLD_A[xLeft][yTop] >= 1) totalSum++;
		if (WORLD_A[x][yTop] >=1 ) totalSum++;
		if (WORLD_A[xRight][yTop] >=1 ) totalSum++;
		if (WORLD_A[xLeft][y] >=1 ) totalSum++;
		if (WORLD_A[xRight][y] >=1 ) totalSum++;
		if (WORLD_A[xLeft][yBottom] >=1 ) totalSum++;
		if (WORLD_A[x][yBottom] >=1 ) totalSum++;
		if (WORLD_A[xRight][yBottom] >=1 ) totalSum++;

	}
	else {
		if (WORLD_A[xLeft][yTop] == 1) totalSum++;
		if (WORLD_A[x][yTop] ==1 ) totalSum++;
		if (WORLD_A[xRight][yTop] ==1 ) totalSum++;
		if (WORLD_A[xLeft][y] ==1 ) totalSum++;
		if (WORLD_A[xRight][y] ==1 ) totalSum++;
		if (WORLD_A[xLeft][yBottom] ==1 ) totalSum++;
		if (WORLD_A[x][yBottom] ==1 ) totalSum++;
		if (WORLD_A[xRight][yBottom] ==1 ) totalSum++;

	}
	return totalSum;
}

/* This places a square point somewhere on the canvas, at location X,Y.
 * */
void drawPoint(int x, int y, color c) {
	fill(c);
	rect(x*PIXEL_WIDTH,y*PIXEL_WIDTH,PIXEL_WIDTH,PIXEL_WIDTH);
}
