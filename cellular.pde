/* Brian's Brain. A Cellular AUtomata project in processing.js
 * By Robin Hu
 * (C) 2013
 * */
//Globals
int CANVAS_WIDTH = 800;	
int CANVAS_HEIGHT = 600;
int PIXEL_WIDTH = 4;	//specify how big you want each pixel.
int PWIDTH = ceil(CANVAS_WIDTH/PIXEL_WIDTH);
int PHEIGHT = ceil(CANVAS_HEIGHT/PIXEL_WIDTH);

int WORLD_A[][];
int WORLD_B[][];

int RULE_SURVIVE[];
int RULE_BIRTH[];
int RULE_GENS;
int MAX_GENS = 20;

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
	for(int x=0; x<PWIDTH; x++) {
		for(int y=0; y<PHEIGHT; y++) {
			if ( random(0,100) > 50)
			    WORLD_B[x][y]=1;
		}
	}

	STATE_COLORS = { color(255), color(240,200,40) };
	for(int i=0; i < 20; i++) {
		append(STATE_COLORS, color( random(0,250), random(0,250), random(0,250)));
	}

	parseRule("345/2/4");
	noLoop();
}

//Main draw loop. Is called continuously.
void draw() {
	background(0);
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

		if ( currentState == 0) {
			int neighborsOn = calcNeighbors(x,y);
			if ( ruleContains(neighborsOn, RULE_BIRTH))
				WORLD_B[x][y] = 1;
		}
		else if ( currentState > 0 && (currentState < (RULE_GENS - 1) || RULE_GENS == 2) ) {
			
			int neighborsOn = (RULE_SURVIVE.length == 0) ? 0 : calcNeighbors(x,y);
			bool shouldSurvive = ruleContains(neighborsOn, RULE_SURVIVE);
			if (currentState == 1 && shouldSurvive) 
			{
				WORLD_B[x][y] = currentState;
			}
			else if (!shouldSurvive) {
				    WORLD_B[x][y] = (currentState + 1) % RULE_GENS;
			}

			if ( currentState > 1)
				WORLD_B[x][y] = currentState + 1;
		}
		else if (currentState >= (RULE_GENS - 1)) {
			WORLD_B[x][y] = 0;
		}
		



	    }
	}
	
}

//Given a cell, how many neighbors are in the "on" state?
int calcNeighbors(int x,int y) {
	int totalSum = 0;
	int xLeft = (x + PWIDTH - 1) % PWIDTH;
	int xRight = (x + 1) % PWIDTH;
	int yTop = (y + PHEIGHT -1) % PHEIGHT;
	int yBottom = (y + 1) % PHEIGHT;
	
	if (WORLD_A[xLeft][yTop] == 1) totalSum++;
	if (WORLD_A[x][yTop] ==1 ) totalSum++;
	if (WORLD_A[xRight][yTop] ==1 ) totalSum++;
	if (WORLD_A[xLeft][y] ==1 ) totalSum++;
	if (WORLD_A[xRight][y] ==1 ) totalSum++;
	if (WORLD_A[xLeft][yBottom] ==1 ) totalSum++;
	if (WORLD_A[x][yBottom] ==1 ) totalSum++;
	if (WORLD_A[xRight][yBottom] ==1 ) totalSum++;

	return totalSum;
}

//Sets all cells to zero state.
void clearWorld() {
	for(int x=0; x < PWIDTH; x++) {
		for(int y=0; y < PHEIGHT; y++) {
			WORLD_B[x][y] = 0;
		}
	}
}

//Randomly add pixels to the world
void randomizeWorld() {
	for(int x=0; x < PWIDTH; x++) {
		for(int y=0; y < PHEIGHT; y++) {
			WORLD_B[x][y] = (random(0,100) > 50) ? 1 : 0;
		}
	}

}

/* This places a square point somewhere on the canvas, at location X,Y.
 * */
void drawPoint(int x, int y, color c) {
	fill(c);
	rect(x*PIXEL_WIDTH,y*PIXEL_WIDTH,PIXEL_WIDTH,PIXEL_WIDTH);
}


//Parse rule. Rule format is S/B/G, (Survival rule/Birth Rule/# of generations)
//Example rules: /2/3 Brian's Brain
//  345/2/4  Star Wars
//  23/3/2   Conway's Life
void parseRule( String rule ) {
	String[] parts = split(rule, "/");

	if (parts.length != 3) {
		println("Rule: " + rule + " is not in correct format.");
		return;
	}

	int[] surviveList = split(parts[0], "");
	int[] birthList = split(parts[1], "");
	int generations = int(parts[2]);
	if (generations < 2) {
		println("Cannot have rule where the number of generations is less than 2.");
		return;
	}
	RULE_GENS = min(MAX_GENS, int(parts[2]));

	RULE_SURVIVE = {};
	RULE_BIRTH = {};
	//Apply rules to global variables.
	for(int i=0; i < surviveList.length; i++) {
		append(RULE_SURVIVE, surviveList[i]);
	}

	for(int i=0; i < birthList.length; i++) {
		append(RULE_BIRTH, birthList[i]);
	}

	//Special case where if the # of generations is 2.
	//There will be cells left that are in state, 2,3,4, etc.
	//Remove those cells as they are not needed.
	if (RULE_GENS == 2) {
		for(int x=0; x < PWIDTH; x++) {
			for(int y=0; y < PHEIGHT; y++) {
				if (WORLD_B[x][y] > 1) {
					WORLD_B[x][y] = 0;
				}
			}
		}
	}

}

//Returns true if the array contains the value 'n'.
bool ruleContains(int n, Array rule) {
	for(int i=0; i < rule.length; i++) {
		if ( rule[i] == n )
			return true;
	}
	return false;
}

//Called when user drags mouse over canvas. This will let you draw pixels.
void mouseDragged() {
	int xPos = ceil(mouseX / PIXEL_WIDTH);
	int yPos = ceil(mouseY / PIXEL_WIDTH);
	int xPosPrev = ceil(pmouseX / PIXEL_WIDTH);
	int yPosPrev = ceil(pmouseY / PIXEL_WIDTH);

	int pixelType = (mouseButton == LEFT) ? 1 : 0;
	WORLD_B[xPos][yPos] = pixelType;
	WORLD_B[xPos+1][yPos] = pixelType;
	WORLD_B[xPos][yPos+1] = pixelType;
	WORLD_B[xPosPrev][yPosPrev] = pixelType;
}
