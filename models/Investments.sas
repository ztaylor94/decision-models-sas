data returns;
infile cards truncover;
input investment $ 1-8  percentReturn 10-14;
cards;
AtlOil   7.3
PacOil   10.3
MidSteel 6.4
HubSteel 7.5
GovBonds 4.5
;
run;

proc optmodel;

	set<str> INV;
	num percentReturn{INV};
	read data returns into INV=[investment] percentReturn;

	num avail = 100000;

	var Amount{INV} >= 0;

/*	Neither industry (oil or steel) should receive more than $50,000. */
	con Amount['AtlOil'] + Amount['PacOil'] <= 50000;
	con Amount['MidSteel'] + Amount['HubSteel'] <= 50000;

/*	Government bonds should be at least 25% of the steel industry investments. */
	con Amount['GovBonds'] >= 0.25 * (Amount['MidSteel'] + Amount['HubSteel']);

/*	The investment in Pacific Oil, the high-return but high-risk investment, */
/*	cannot be more than 60% of the total oil industry investment. */
	con Amount['PacOil'] <= 0.6 * (Amount['AtlOil'] + Amount['PacOil']);

	max totReturn = sum{i in INV} percentReturn[i] * Amount[i];
	con sum{i in INV} Amount[i] <= avail;
	
	expand;
	solve;
	print Amount;

quit;
