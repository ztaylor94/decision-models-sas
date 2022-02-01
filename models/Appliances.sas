proc optmodel;

	set PRODUCTS = /TVDVR TVS PROJTVS DVR DVD VGames Desktops/;
	num initinvest{PRODUCTS} = [6 12 20 14 15 2 32];
	num sqftuse{PRODUCTS} = [125 150 200 40 40 20 100];
	num returnrate{PRODUCTS} = [8.1 9.0 11.0 10.2 10.5 14.1 13.2];
	num totalinvestamt = 450;
	num totalarea = 420;

	var IfInvest{PRODUCTS} binary;
	max Return = sum{p in PRODUCTS} returnrate[p]*IfInvest[p];

	con StoreCapacity: sum{p in PRODUCTS} sqftuse[p]*IfInvest[p] <= totalarea;
	con TotalInvestment: sum{p in PRODUCTS} initinvest[p]<= totalinvestamt;

	/* Introduce at least 3 new product lines */
	con ThreeNew: sum{i in PRODUCTS} IfInvest[i] >= 3;

	/* Do not stock both DVRs and DVD players */
	con DVRorDVD: IfInvest['DVD'] + IfInvest['DVR'] <= 1;

	/* Stock video games only if they also stock TV's */
	con VidGaIforTVs: IfInvest['VGames'] <= IfInvest['TVS'];

	/* Stock projection TVs only if stock TVDVRs or TVs */
	con ProjTV: IfInvest['PROJTVS'] <= IfInvest['TVS'] + IfInvest['TVDVR'];


	solve;
	print IfInvest;



quit; 
