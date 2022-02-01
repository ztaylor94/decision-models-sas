proc optmodel;

/*	Market Research Problme Explicit form 
	DC = the number of daytime interviews of households with children,
	EC = the number of evening interviews of households with children,
	DNC = the number of daytime interviews of households without children
	ENC = the number of evening interviews of households without children
*/
	var  DC >=0,EC >=0,DNC >=0, ENC >=0 ; 

	min TotalCost = 20*DC + 25*EC + 18*DNC + 20*ENC;

/*	At least 1000 Interviews */
	con TotalInterviews: DC + EC + DNC + ENC = 1000;

/*	At least 400 Interviews for Households with children */
	con MinWithChild: DC + EC >= 400; 

/*	At least 400 Interviews for Households without children */
	con MinWithoutChild: DNC + ENC >= 400;

/*	At least as many evening interviews as day interviews */
	con EveGreaterDay:  EC + ENC >= DC + DNC ;  

/*	At least 40% of interviews of households with children must be during the evening */
	con MinEveToDayWithC:  EC >= 0.4*(DC + EC);   

/*	At least 60% of interviews of households without children must be during the evening */
	con MinEveToDayNoC:  ENC >= 0.6*(DNC + ENC); 

	solve;
	print   DC EC DNC ENC TotalCost;

quit;
