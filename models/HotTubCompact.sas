proc optmodel;

/*	Set and Parameter declarations */
	set <str> PRODUCTS = /Aqua HydroLux/; 
	set <str> RESOURCES = /Pumps Labor Tubing/; 
	num unitprof{PRODUCTS} init [350 300];
	num capacity{RESOURCES} init [200 1566 2880];
	num unituse{RESOURCES, PRODUCTS} = [1 1 9 6 12 16]; /*can't modify these*/

/*	The decision model declaration */
	var NumProd{PRODUCTS} >= 0; 

	max Profit = sum{p in PRODUCTS} unitprof[p]*NumProd[p];

	con ResourceCapacity{r in RESOURCES}: 
		sum{p in PRODUCTS} unituse[r,p]*NumProd[p] <= capacity[r];

/*	The expand statement
	allows you to see the explicit model */
	expand; 

	solve;
	Print Profit NumProd;

/*	OPTMODEL has programming capability, here is one example */
	for {newpumpcap in 180..220 by 5} do;
	/*	dummy parameter (newpumpcap) can only be used in for loop */
		capacity["Pumps"]= newpumpcap;
		solve;
		Print newpumpcap Profit;
	end;
	  
quit;
