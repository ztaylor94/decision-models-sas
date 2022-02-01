proc optmodel;
	var XA >= 0, XH >= 0, 
		YA >= 0, YH >= 0; 

	max PROFIT = 350*XA + 300*XH;

	impvar  TotA = XA + YA,
			TotH = XH + YH;

	con PumpAvailability:    1*(TotA) +  1*(TotH) <= 200;
	con LaborAvailability:   9*(TotA) +  6*(TotH) <= 1566;
	con TubingAvailability: 12*(TotA) + 16*(TotH) <= 2880;

	solve;
	print XA YA XH YH;
	print TotA TotH Profit;  




	var IFYA binary, IFYH binary;
	max PROFIT2 = Profit + 385*YA + 330*YH; /* what about 430? for YH - change sol */

 	con YALink: YA <= 400*IFYA;
 	con YHLink: YH <= 400*IFYH;

	con changepointA: XA <= 150;
	con changepointH: XH <= 100;

	con linkXAYA: XA >= 150*IFYA; /* float vs trap */
	con linkXHYH: XH >= 100*IFYH; 

	solve;

	print XA YA XH YH;
	print TotA TotH Profit2;  
quit;
