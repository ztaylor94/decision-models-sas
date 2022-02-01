proc optmodel;

	set <num> TIMES = 9.. 18;
	num requirement{TIMES} = [6 4 8 10 9 6 4 7 6 6]; 
	print Requirement;
	
	/* Not much point getting full time employees to start after 11 but let us allow that */

	num fullavailchart{start in TIMES, t in TIMES} = if (t<start OR t=start+4 OR t >= start+8) then 0 else 1;
	num partavailchart{start in TIMES, t in TIMES} = if (t<start OR t >= start+4) then 0 else 1;
	
		print fullavailchart;
		print partavailchart;

	num fulltimecost = 70;
	num parttimecost = 32;

	/*the variables count the number of full time and part time staff that **start** at a given time*/
	var FullStart{TIMES} >= 0 integer,  PartStart{TIMES} integer >= 0;

	min StaffingCost = sum{start in TIMES} (fulltimecost*FullStart[start] + parttimecost*PartStart[start]);

	/*minimum staff requirement constraint */

	con MinReq{t in TIMES}: 
		sum{start in TIMES} ( fullavailchart[start,t]*FullStart[start] 
							+ partavailchart[start,t]*PartStart[start] ) 
		>= requirement[t];  

	expand MinReq;

	/* Customer servise policy requires at least as many full time as part time during the busy periods  */

	con CustomerService{t in 11..13}: 
		sum{start in TIMES} (fullavailchart[start,t]*FullStart[start]) 
		>= sum{start in TIMES}(partavailchart[start,t]*PartStart[start]); 
		
	expand CustomerService;
	
	solve;
	print FullStart PartStart;

	num employeesOnDuty{t in TIMES} 
		= sum{start in TIMES} ( fullavailchart[start,t]*FullStart[start].sol 
								+ partavailchart[start,t]*PartStart[start].sol );

	create data staffing from [time] requirement employeesOnDuty FullStart PartStart;

quit;

proc print data=staffing;
run;

axis1 minor=none order=(0 to 11 by 1);
axis2 minor=none;
legend1 position=bottom FRAME;

proc gbarline data=staffing;
	bar time / sumvar=employeesOnDuty DISCRETE axis=axis1;
	plot / sumvar=requirement axis=axis1;
run;
