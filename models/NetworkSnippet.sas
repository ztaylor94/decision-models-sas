proc optmodel;

	set <num,num> EDGES 
		= /<1,2>, <1,3>, <2,3>, <2,4>, <3,4>, <4,1>, <4,2>/; 
		/* the nodes can be strings as well */

	/* OR:
	set <num,num> EDGES = {<1,2>,<1,3>,<2,3>,<2,4>,<3,4>,<4,1>,<4,2>}; 
	*/

	put "Edges=" EDGES;

	/* You cannot PRINT sets in OPTMODEL to the output (because they are not 
	fixed size). GETS PRINTED TO THE LOG, NOT THE RESULTS. */

	set <num> NODES = /1,2,3,4/;
	put "Nodes=" NODES;
	set <num> NODES2 = setof{<i,j> in EDGES} i;
	put "Nodes2=" NODES2;

	/* Note that OPTMODEL keeps the set in the order in which it was constructed */

	set  TONODES{n in NODES} = slice(<n,*>,EDGES); 
	set  FROMNODES{n in NODES} = slice(<*,n>,EDGES);

	for {n in NODES} 
		put "Node=" n "TONODES=" TONODES[n] "FROMNODES=" FROMNODES[n];

quit;   
