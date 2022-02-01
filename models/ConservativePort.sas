proc optmodel;

	var M;
	var FS >= 0, IB >= 0, LG >= 0, LV >= 0, SG >= 0, SV >= 0;

	con FS + IB + LG + LV + SG + SV = 1;

	con	ScenarioA: 10.06*FS + 17.64*IB + 32.41*LG + 32.36*LV + 33.44*SG + 24.56*SV >= M;
	con ScenarioB: 13.12*FS + 3.25*IB + 18.71*LG + 20.61*LV + 19.40*SG + 25.32*SV >= M;
	con ScenarioC: 13.47*FS + 7.51*IB + 33.28*LG + 12.93*LV + 3.85*SG - 6.70*SV >= M;
	con ScenarioD: 45.42*FS - 1.33*IB + 41.46*LG + 7.06*LV + 58.68*SG + 5.43*SV >= M;
	con ScenarioE: -21.93*FS + 7.36*IB - 23.26*LG - 5.37*LV - 9.02*SG + 17.31*SV >= M;
	
	max obj = M;

	solve;	      

	print FS IB LG LV SG SV;

	print "Scenario A return: " ((ScenarioA.body-M)/100) percent6.2;
	print "Scenario B return: " ((ScenarioB.body-M)/100) percent6.2;
	print "Scenario C return: " ((ScenarioC.body-M)/100) percent6.2;
	print "Scenario D return: " ((ScenarioD.body-M)/100) percent6.2;
	print "Scenario E return: " ((ScenarioE.body-M)/100) percent6.2;

quit;
