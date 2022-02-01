proc optmodel;

	set <num,num> EDGES = {
			<1,2>, <1,3>, 
			<2,3>, <2,4>, <2,6>, 
			<3,2>, <3,5>, 
			<4,2>, <4,5>, <4,6>, 
			<5,3>, <5,4>, <5,6>
	}; 
    num unitcosts{EDGES} init [
			25 20 
			3 5 14 
			3 6 
			5 4 4 
			6 4 7
	]; 
	print unitcosts;
	     
	set <num> NODES = union{<i,j> in EDGES} {i,j};
	set  TONODES{n in NODES} = slice(<n,*>,EDGES); 
	set  FROMNODES{n in NODES} = slice(<*,n>,EDGES);
	put "Edges=" EDGES;
	put "Nodes=" NODES;
	for {n in NODES} put "Node=" n "TONODES=" TONODES[n] "FROMNODES=" FROMNODES[n];
	
    num originnode = 1;
    num destnode = 6; 
   
    num SuppDemand{node in NODES} = (if node = originnode then 1) + (if node = destnode then -1);
    
    var Flow{EDGES} >= 0 <= 1; 
    
    min TransportCosts = sum{<n1,n2> in EDGES} unitcosts[n1,n2]* Flow[n1,n2];
    
    con FlowConservation{n in NODES}:  
        	sum{j in TONODES[n]} Flow[n,j]		/* Flow out */
			- sum{i in  FROMNODES[n]} Flow[i,n] /* Flow in */
            = SuppDemand[n];					/* Net Supply */ 

    solve;
    
    print TransportCosts Flow; 

/*	start of code to print the edges in the shortest 
	path in sequence  from the LP solution */
    
    num nextnodeonpath{NODES};
	for {<n1,n2> in  EDGES} 
		if (round(Flow[n1,n2]) = 1) then nextnodeonpath[n1] = n2; 
	print nextnodeonpath;

	num n init originnode;
	do while (n ne destnode);
		print n nextnodeonpath[n]; 
			n = nextnodeonpath[n];
		end;

quit;
