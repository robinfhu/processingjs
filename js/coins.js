/*  This is a simple program that calculates how many coins you should give the cashier, to optimize the amount of change you get back.
 *
 *  By Robin Hu
 *  (C) 2013
 *
 * ***/

/**  This routine figures out the optimal number of coins needed to make a certain dollar value.
 * We only care about values from 1 cent to 99 cents.
 *
 * Precond: totalCents between 1 and 99
 * Postcond: function will return object describing what coins are needed to make the dollar value.
 * */
var calcOptimalCoins = function( totalCents ) {
	var changeObj = {
		quarters: 0,
		dimes: 0,
		nickels: 0,
		pennies: 0,
		amount: 0,
		size: 0		//total # of coins in this change bunch
	};

	if (totalCents <= 0 || totalCents > 99)
		return changeObj;

	var coinMap = {
		quarters: 25,
		dimes: 10,
		nickels: 5,
		pennies: 1
	};

	var remainingCents = totalCents;
	_.each( coinMap, function(coinVal, coinType) {
		var numCoins = Math.floor( remainingCents / coinVal );
		changeObj[ coinType ] = numCoins;
		changeObj.size += numCoins;
		remainingCents -= numCoins * coinVal;
	});

	changeObj.amount = totalCents;
	return changeObj;

};

//Given a total number of cents value, produce a sorted list of optimal coins to give cashier.
var getChange = function( totalCents ) {
	var resultList = [];

	_.each( _.range(totalCents, totalCents + 100), function(centsToGive) {
		var change = centsToGive - totalCents;

		var changeCoins = calcOptimalCoins(change);

		var didExceedDollar = centsToGive >= 100;
		
		var centsWithNoDollar = centsToGive % 100;

		var givenCoins = calcOptimalCoins(centsWithNoDollar);
		givenCoins.exceedDollar = didExceedDollar;

		resultList.push({
			given: givenCoins,
			change: changeCoins,
			coinsExchanged: givenCoins.size + changeCoins.size
		});
	});

	resultList = _.sortBy(resultList, function( obj ) { 
		return (obj.change.quarters * 1 +
		       obj.change.dimes * 2 +
		       obj.change.nickels * 4 +
		       obj.change.pennies * 8) + obj.given.size + obj.given.quarters * 10;
	
	});
	return resultList;
};

//Pad zeroes in front of an integer.
var zeroPad = function(n) {
	if (n < 10)
		return "0" + n;
	else
		return n.toString();
};

//Takes a change object and creates human readable string.
var stringifyChange = function(changeObj) {
	return "<span>" + changeObj.quarters + " quarters, " + changeObj.dimes + " dimes,<br/> " + changeObj.nickels + " nickels, " + changeObj.pennies + " pennies.</span>";
};

//Called when user presses 'calculate' button.
var processUserInput = function() {
	$("#change_results").empty();
	var userItemCost = parseFloat( $("#cents_value").val() );

	if (isNaN(userItemCost)) {
		alert("Please enter valid price.");
		return;
	}

	if (userItemCost <= 0) {
		alert("Please enter valid price greater than zero.");
		return;
	}

	if (userItemCost > 100) {
		alert("Sorry! App doesn't support prices greater than $100.");
		return;
	}

	var userCentsValue = Math.floor((userItemCost * 100) % 100);
	var userDollarValue = Math.floor(userItemCost);

	var changeList = getChange(userCentsValue);

	_.each( _.range(0,10), function(index) {
		var changeObj = changeList[index];

		var rowObj = $("<div>").addClass("row hide result");
		var sectionGiven = $("<div>").addClass("span3 given");
		var sectionChange = $("<div>").addClass("span3 change");

		var dollarPart;
		if ( changeObj.given.exceedDollar ) {
			dollarPart = "$" + (userDollarValue + 1).toString() + ".";
		}
		else {
			dollarPart = "$" + userDollarValue.toString() + ".";
		}
		sectionGiven.append( $("<h2>").text("Give: " + dollarPart + zeroPad(changeObj.given.amount)))
			    .append( $(stringifyChange(changeObj.given)));
		sectionChange.append( $("<h2>").text("Change: " + "$0." + zeroPad(changeObj.change.amount)))
			     .append( $(stringifyChange(changeObj.change)));
		rowObj.append(sectionGiven).append(sectionChange);
		$("#change_results").append(rowObj);

	});

	$("#change_results .result").each(function(index) {
		$(this).delay(200*index).fadeIn(300);
	});
};

//DOM ready
$(function() {
	$("#btn_calculate").click(function() {
		processUserInput();
	});

	$("#cents_value").keydown(function(evt) {
		if (evt.which === 13) {
			processUserInput();
		}
	}).focus();


});
