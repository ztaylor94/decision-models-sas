proc optmodel;

	set <str,str> EDGES = {<"Denver","KansasCity">,<"Denver", "Louisville">, <"Atlanta","KansasCity">, <"Atlanta", "Louisville"> ,
	     <"KansasCity", "Detriot">, <"KansasCity", "Miami">, <"KansasCity", "Dallas">, <"KansasCity", "NewOrleans">,
	     <"Louisville", "Detriot">, <"Louisville", "Miami">, <"Louisville", "Dallas">, <"Louisville", "NewOrleans">} ; 
    num unitcosts{EDGES} init [2 3 3 1 2 6 3 6 4 4 6 5];
	print unitcosts;
	     
	set NODES = union{<i,j> in EDGES} {i,j};
    num suppDemand{NODES} = [600 0 0 400 -200  -150 -350 -300];
	print suppDemand;
	  
	set  TONODES{n in NODES} = slice(<n,*>,EDGES); 
	set  FROMNODES{n in NODES} = slice(<*,n>,EDGES);
	for {n in NODES} put "Node=" n "TONODES=" TONODES[n] "FROMNODES=" FROMNODES[n];
    
    var Flow{EDGES} >= 0; 
    
    min TransportCosts = sum{<n1,n2> in EDGES} unitcosts[n1,n2] * Flow[n1,n2];
    
    con FlowConservation{n in NODES}:  
        	sum{j in TONODES[n]} Flow[n,j]		/* Flow out */
			- sum{i in  FROMNODES[n]} Flow[i,n] /* Flow in */
            = SuppDemand[n];					/* Net Supply */ 

    expand FlowConservation;
    solve;
    print TransportCosts Flow; 
    
    /* sometimes you have capacity on edges*/ 
    
    num capacities{EDGES} init [400 400 400 400 300 300 300 300 300 300 300 300];
    
    con EdgeCapacity{<n1, n2> in EDGES}: Flow[n1,n2] <=capacities[n1,n2]; 
    solve;
    print TransportCosts Flow; 
      
quit;   
