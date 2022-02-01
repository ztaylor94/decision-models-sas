proc optmodel;

	set <num,num> EDGES = {
		<1,2>, <1,3>, <1,4>, 
		<2,3>, <2,5>, 
		<3,2>, <3,4>, <3,5>, <3,6>, 
		<4,6>,
		<5,6>, <5,7>,
		<6,5>, <6,7>,
		<7,1>
	}; 
	     
	set <num> NODES = union{<i,j> in EDGES} {i,j};

	set  TONODES{n in NODES} = slice(<n,*>,EDGES); 
	set  FROMNODES{n in NODES} = slice(<*,n>,EDGES);

	for {n in NODES} 
		put "Node=" n "TONODES=" TONODES[n] "FROMNODES=" FROMNODES[n];
	
    num originnode = 1;
    num destnode=7; 
   
    num capacity{EDGES} init [5 6 5 2 3 2 3 3 7 5 1 8 1 7 200] ; 
    print capacity;
   
    var Flow{<n1,n2> in EDGES} >= 0 <=capacity[n1,n2] ; 
    
    max FlowAcross = Flow[destnode,originnode];
    
    con FlowConservation{n in Nodes}:
		sum{j in  TONODES[n]} Flow[n,j]			/* Flow out */
        - sum{i in  FROMNODES[n]} Flow[i,n] 	/* Flow in */
             = 0; 								/* Net Supply */ 
    
    expand;
    solve;
    print FlowAcross Flow; 

	capacity[5, 7] = 6;
	solve;
	print FlowAcross Flow;
quit;   
