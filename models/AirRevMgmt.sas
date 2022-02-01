proc optmodel;
	var PCQ >=0, PMQ >=0,POQ>=0,PCY >=0,PMY >=0,POY >=0, NCQ>=0, NMQ>=0,  
	   NOQ>=0,  NCY>=0,  NMY>=0,  NOY>=0,  CMQ >=0, CMY>=0,  COQ >=0,  COY >= 0;
	Max Revenue = 178*PCQ + 268*PMQ + 228*POQ + 380*PCY + 456*PMY + 560*POY + 199*NCQ + 249*NMQ + 349*NOQ + 385*NCY + 444*NMY
	+ 580*NOY + 179*CMQ + 380*CMY + 224*COQ + 582*COY;

	con CapNewarkCharlotte: NCY + NMY + NOY + NCQ + NMQ + NOQ <= 50;
	con CapPittsburghCharlotte: PCY + PMY + POY + PCQ + PMQ + POQ <= 67;
	con CapCharlotteOrlando: NOY+ POY +COY + NOQ+ POQ +COQ <= 65; 
	con CapCharlotteMyrtle:  CMY + PMY + NMY + CMQ + PMQ + NMQ <=55; 

	con DemPCQ: PCQ <= 33;
	con DemPMQ: PMQ <= 44;
	con DemPOQ: POQ <=45;
	con DemPCY: PCY <= 16;
	con DemPMY: PMY <=6;
	con DemPOY: POY <= 11;
	con DemNCQ: NCQ <= 26;
	con DemNMQ: NMQ <= 56;
	con DemNOQ: NOQ <= 39;
	con DemNCY: NCY <= 15;
	con DemNMY: NMY <= 7;
	con DemNOY: NOY <=9;
	con DemCMQ: CMQ <=64;
	con DemCMY: CMY<= 8;
	con DemCOQ: COQ <=46;
	con DemCOY: COY <=10;

	solve;
	print DemPCQ.body DemPCQ.dual; 
	print DemPMQ.body DemPMQ.dual;
	print DemPOQ.body DemPOQ.dual;
	print DemPCY.body DemPCY.dual;
	print DemPMY.body DemPMY.dual;
	print DemPOY.body DemPOY.dual;
	print DemNCQ.body DemNCQ.dual;
	print DemNMQ.body DemNMQ.dual;
	print DemNOQ.body DemNOQ.dual;
	print DemNCY.body DemNCY.dual;
	print DemNMY.body DemNMY.dual;
	print DemNOY.body  DemNOY.dual;
	print DemCMQ.body DemCMQ.dual;
	print DemCMY.body DemCMY.dual;
	print DemCOQ.body DemCOQ.dual;
	print DemCOY.body DemCOY.dual;
	/* Duals of capacity constraints*/
	print CapNewarkCharlotte.body CapNewarkCharlotte.dual;
	print CapPittsburghCharlotte.body CapPittsburghCharlotte.dual;
	print CapCharlotteOrlando.body CapCharlotteOrlando.dual;
	print CapCharlotteMyrtle.body CapCharlotteMyrtle.dual;

quit;

