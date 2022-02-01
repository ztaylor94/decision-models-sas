proc optmodel;

/* Transshipment example when more supply than total demand        */


	set <str,str> EDGES = {<"Denver","KansasCity">,<"Denver", "Louisville">,<"Atlanta","KansasCity">,<"Atlanta", "Louisville"> ,
	     <"KansasCity", "Detriot">,  <"KansasCity", "Miami">,<"KansasCity", "Dallas">,<"KansasCity", "NewOrleans">,
	     <"Louisville", "Detriot">,  <"Louisville", "Miami">,<"Louisville", "Dallas">,<"Louisville", "NewOrleans">} ; 
	     
	set <str> NODES = /Denver Atlanta KansasCity Louisville, Detriot,Miami,Dallas,NewOrleans/;
	
	set <str> SUPPLYNODES = /Denver Atlanta/; 
	  
	   /* or set <str> NODES= {"Denver","Atlanta","KansasCity", "Louisville","Detriot", "Miami", "Dallas", "NewOrleans"};     */
	
	set  TONODES{n in NODES} = slice(<n,*>,EDGES); 
	set  FROMNODES{n in NODES} = slice(<*,n>,EDGES);
	put "Edges=" EDGES ;
	put "Nodes=" NODES;
	for {n in NODES} put "Node=" n "TONODES=" TONODES[n] "FROMNODES=" FROMNODES[n];
	

    num unitcosts{EDGES} init [2 3 3 1 2 6 3 6 4 4 6 5]; 
    num SuppDemand{NODES} = [600 400 0 0 -200  -150 -350 -300]; 
    
    var Flow{EDGES} >=0; var SupplySlack{SUPPLYNODES} >=0;
    
    num capacities{EDGES} init [400 400 400 400 300 300 300 300 300 300 300 300];
    
    con EdgeCapacity{<n1, n2> in EDGES}: Flow[n1,n2] <=capacities[n1,n2]; 
    
    min TransportCosts = sum{ <n1,n2> in EDGES} unitcosts[n1,n2]* Flow[n1,n2];
    
    con FlowConservation{currentnode in NODES}:  sum{tonode in  TONODES[currentnode]} Flow[currentnode,tonode]/* Flow out*/
          - sum{fromnode in  FROMNODES[currentnode]} Flow[fromnode,currentnode] /* Flow in*/
             = SuppDemand[currentnode] 
                     + if (currentnode in SUPPLYNODES) then (-SupplySlack[currentnode]);
    
    expand FlowConservation;
    solve;
    print TransportCosts Flow SuppDemand SupplySlack; 
  
quit;
