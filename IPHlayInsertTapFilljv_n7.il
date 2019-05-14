;*********************************************************************************
;
;  PROGRAM:  IPHlayInsertTapFilljv.il
;
;  AUTHOR:   Joel D. Viray
;
;  PURPOSE:  Insert tap or fill for selected 0.16um tsmc logic cell 
;
;  ARGUEMENTS: 
;
;  FILES REFERENCED: 
;
;  METHOD: 
;
;  VARIABLE DESCRIPTION: 
;
;  EXTERNAL APPLICATIONS/SCRIPTS USED: 
;
;  MODIFICATION HISTORY
;*********************************************************************************
;
; Version: 1.0
; Date:07/21/2016       By: Joel D. Viray
; Initial Release
;
;*********************************************************************************


procedure( IPHlayInsertFILLERjv()

	command="IPHlayInsertFILLERjv"
	jvLog()
	cv=geGetEditCellView() ; get cell view id
	a=geGetSelSet() ;get id of the selected cell

	lib=ddGetObj(buildString(a~>libName)) ;get Library of the selected cell
	cells=lib~>cells~>name ;list of all cells in the library
	tap=buildString(rexMatchList("^std360_FILL1B" cells)) ;get the FILL2B cell in that library

	when( a==nil
		jvWarningMessage()
	)


	if( a nil
		printf("Please select one logic cell first....Press Esc to exit.")
	)
	else(	

	jvInsertInstance( buildString(a~>libName) tap "layout");jvInsertInstance
	)
	

);procedure
procedure( IPHlayInsertFILLERjv_left()

	command="IPHlayInsertFILLERjv_left"
	jvLog()

	logics=geGetSelSet()


	when( logics==nil
		jvWarningMessage()
	)

	

	if(rexMatchp("^tcbn16" car(logics~>libName)) then fillL=0.18 else fillL=0.28) ;get FILL info length


	foreach(a logics
		logicOrient=a~>orient
		logicOrigin=a~>xy
		logicName=a~>baseName

		lib=ddGetObj(a~>libName) ;get Library of the selected cell
		cells=lib~>cells~>name ;list of all cells in the library
		tap=buildString(rexMatchList("^std360_FILL1B" cells)) ;get the FILL2B cell in that library

		
		

		;if( a nil
		;printf("Please select one logic cell first....Press Esc to exit.")
		;  );if
		;else(	

			;jvInsertInstance( buildString(a~>libName) tap "layout");jvInsertInstance

			;jvGetPrBoundary()

			b=a~>master~>shapes

			foreach(i b
				if(i~>layerName=="prBoundary" then prbbox=i~>bBox
				print(prbbox)
				logicL=car(upperRight(prbbox))
				);if
			);foreach
	

			dbCreateParamInstByMasterName(
  				geGetEditCellView()         			;; the current cellview's dbId
  				a~>libName     					;; the library where the instance comes from
  				tap             	    			;; the name of the cell to be instantiated
  				"layout"	            			;; the viewname of the cell to be instantiated
  				strcat(logicName "_filler_L") 			;; symbolToString(gensym("I")) 	;; hopefully a unique instance name
  				car(logicOrigin)-fillL:car(cdr(logicOrigin))  	;; origin	car(car(logicOrigin))+1:car(cdr(car(logicOrigin))) 
				logicOrient                   			;; orientation
  				1                           			;; number of instances
  			);dbCreateParamInstByMasterName	
	        ;);if
		
		
	


	);foreach
	

);procedure






procedure( jvInsertFILLER_right_ver2()

	cv=geGetEditCellView() ; get cell view id
	a=geGetSelSet() ;get id of the selected cell
	
	logicOrient=buildString(a~>orient)
	logicOrigin=a~>xy
	logicName=car(a~>baseName)

	lib=ddGetObj(buildString(a~>libName)) ;get Library of the selected cell
	cells=lib~>cells~>name ;list of all cells in the library
	tap=buildString(rexMatchList("^std360_FILL1B" cells)) ;get the FILL2B cell in that library

	if( a nil
		printf("Please select one logic cell first....Press Esc to exit.")
	)
	else(	

	;jvInsertInstance( buildString(a~>libName) tap "layout");jvInsertInstance

	jvGetPrBoundary()	

	dbCreateParamInstByMasterName(
  		geGetEditCellView()         		;; the current cellview's dbId
  		buildString(a~>libName)     		;; the library where the instance comes from
  		tap             	    		;; the name of the cell to be instantiated
  		"layout"	            		;; the viewname of the cell to be instantiated
  		fillerName=symbolToString(gensym("I")) 	;; hopefully a unique instance name
  		caar(logicOrigin)+logicL:cadar(logicOrigin)  ;; origin	car(car(logicOrigin))+1:car(cdr(car(logicOrigin))) 
		logicOrient                   		;; orientation
  		1                           		;; number of instances
  		
		)	
	
	
	)
	

);procedure


procedure( jvAlign()
	geDeselectAll()
	lxHiAlign()
	leAlignSelSetForm->alignMode->value= "Layer"
	leAlignSelSetForm->layerField_1->value= '(25171006 112 26 "prBoundary (drawing)")



);procedure

procedure( jvGetPrBoundary()
	
	;a=geGetSelSet()
	b=car(a~>master~>shapes)

	foreach(i b
		if(i~>layerName=="prBoundary" then prbbox=i~>bBox
		print(prbbox)
		logicL=car(upperRight(prbbox))
		);if
	);foreach

);procedure


procedure( IPHlayInsertFILLERjv_right()

	command="IPHlayInsertFILLERjv_right"
	jvLog()


	logics=geGetSelSet()


	when( logics==nil
		jvWarningMessage()
	)


	foreach(a logics
		logicOrient=a~>orient
		logicOrigin=a~>xy
		logicName=a~>baseName

		lib=ddGetObj(a~>libName) ;get Library of the selected cell
		cells=lib~>cells~>name ;list of all cells in the library
		tap=buildString(rexMatchList("^std360_FILL1B" cells)) ;get the FILL2B cell in that library

		
		;if( a nil
		;printf("Please select one logic cell first....Press Esc to exit.")
		;  );if
		;else(	

			;jvInsertInstance( buildString(a~>libName) tap "layout");jvInsertInstance

			;jvGetPrBoundary()

			b=a~>master~>shapes

			foreach(i b
				if(i~>layerName=="prBoundary" then prbbox=i~>bBox
				print(prbbox)
				logicL=car(upperRight(prbbox))
				);if
			);foreach
	

			dbCreateParamInstByMasterName(
  				geGetEditCellView()         			;; the current cellview's dbId
  				a~>libName     					;; the library where the instance comes from
  				tap             	    			;; the name of the cell to be instantiated
  				"layout"	            			;; the viewname of the cell to be instantiated
  				strcat(logicName "_filler_R") 			;; symbolToString(gensym("I")) 	;; hopefully a unique instance name
  				car(logicOrigin)+logicL:car(cdr(logicOrigin))  	;; origin	car(car(logicOrigin))+1:car(cdr(car(logicOrigin))) 
				logicOrient                   			;; orientation
  				1                           			;; number of instances
  			);dbCreateParamInstByMasterName	
	        ;);if
		



	);foreach
	

);procedure


procedure( IPHlayInsertTAPjv()

	command="IPHlayInsertTAPjv"
	jvLog()


	cv=geGetEditCellView() ; get cell view id
	a=geGetSelSet() ;get id of the selected cell


	when( a==nil
		jvWarningMessage()
	)
	


	lib=ddGetObj(buildString(a~>libName)) ;get Library of the selected cell
	cells=lib~>cells~>name ;list of all cells in the library
	tap=buildString(rexMatchList("^TAP" cells)) ;get the TAP cell in that library

	if( a nil
		printf("Please select one logic cell first....Press Esc to exit.")
	)
	else(	

	jvInsertInstance( buildString(a~>libName) tap "layout");jvInsertInstance
	)
	

);procedure
procedure( IPHlayInsertTAPjv_left()

	command="IPHlayInsertTAPjv_left"
	jvLog()


	logics=geGetSelSet()


	when( logics==nil
		jvWarningMessage()
	)



	if(rexMatchp("^tcbn16" car(logics~>libName)) then tapL=0.81 else tapL=0.56) ;get FILL info length


	foreach(a logics
		logicOrient=a~>orient
		logicOrigin=a~>xy
		logicName=a~>baseName

		lib=ddGetObj(a~>libName) ;get Library of the selected cell
		cells=lib~>cells~>name ;list of all cells in the library
		tap=buildString(rexMatchList("^TAP" cells)) ;get the FILL2B cell in that library

		
			

		;if( a nil
		;printf("Please select one logic cell first....Press Esc to exit.")
		;  );if
		;else(	

			;jvInsertInstance( buildString(a~>libName) tap "layout");jvInsertInstance

			;jvGetPrBoundary()

			b=a~>master~>shapes

			foreach(i b
				if(i~>layerName=="prBoundary" then prbbox=i~>bBox
				print(prbbox)
				logicL=car(upperRight(prbbox))
				);if
			);foreach
	

			dbCreateParamInstByMasterName(
  				geGetEditCellView()         			;; the current cellview's dbId
  				a~>libName     					;; the library where the instance comes from
  				tap             	    			;; the name of the cell to be instantiated
  				"layout"	            			;; the viewname of the cell to be instantiated
  				strcat(logicName "_tap_L") 			;; symbolToString(gensym("I")) 	;; hopefully a unique instance name
  				car(logicOrigin)-tapL:car(cdr(logicOrigin))  	;; origin	car(car(logicOrigin))+1:car(cdr(car(logicOrigin))) 
				logicOrient                   			;; orientation
  				1                           			;; number of instances
  			);dbCreateParamInstByMasterName	
	        ;);if
		
		
	


	);foreach
	

);procedure


procedure( IPHlayInsertTAPjv_right()

	command="IPHlayInsertTAPjv_right"
	jvLog()


	logics=geGetSelSet()


	when( logics==nil
		jvWarningMessage()
	)



	foreach(a logics
		logicOrient=a~>orient
		logicOrigin=a~>xy
		logicName=a~>baseName

		lib=ddGetObj(a~>libName) ;get Library of the selected cell
		cells=lib~>cells~>name ;list of all cells in the library
		tap=buildString(rexMatchList("^TAP" cells)) ;get the FILL2B cell in that library

		
		;if( a nil
		;printf("Please select one logic cell first....Press Esc to exit.")
		;  );if
		;else(	

			;jvInsertInstance( buildString(a~>libName) tap "layout");jvInsertInstance

			;jvGetPrBoundary()

			b=a~>master~>shapes

			foreach(i b
				if(i~>layerName=="prBoundary" then prbbox=i~>bBox
				print(prbbox)
				logicL=car(upperRight(prbbox))
				);if
			);foreach
	

			dbCreateParamInstByMasterName(
  				geGetEditCellView()         			;; the current cellview's dbId
  				a~>libName     					;; the library where the instance comes from
  				tap             	    			;; the name of the cell to be instantiated
  				"layout"	            			;; the viewname of the cell to be instantiated
  				strcat(logicName "_tap_R") 			;; symbolToString(gensym("I")) 	;; hopefully a unique instance name
  				car(logicOrigin)+logicL:car(cdr(logicOrigin))  	;; origin	car(car(logicOrigin))+1:car(cdr(car(logicOrigin))) 
				logicOrient                   			;; orientation
  				1                           			;; number of instances
  			);dbCreateParamInstByMasterName	
	        ;);if
		



	);foreach
	

);procedure


procedure( jvLog()

x=geGetEditCellView()
;command="test"
time=getCurrentTime()
;pwd
library=x~>libName
cell=x~>cellName
view=x~>viewName

procedure( jvWhoAmI()
system("whoami > myName")
      let(( inPort nextLine)
        inPort = infile( "./myName")
        when( inPort
          while( gets( nextLine inPort)
         printf("%s" nextLine)

	 myName=nextLine	

          )
      close( inPort)
          )
         )
     )

procedure( jvPwd()
system("pwd > myPath")
      let(( inPort nextLine)
        inPort = infile( "./myPath")
        when( inPort
          while( gets( nextLine inPort)
         printf("%s" nextLine)

	 myPath=nextLine	

          )
      close( inPort)
          )
         )
     )
jvWhoAmI()
jvPwd()


newChar=pcreCompile("\n")
colon=pcreCompile(":")
space=pcreCompile(" ")
myName=pcreReplace(newChar myName "" 0) ;remove the newChar
myPath=pcreReplace(newChar myPath "" 0) ;remove the newChar
myTime=pcreReplace(colon time "" 0) ;remove the colon in time
myTime2=pcreReplace(space myTime "" 0) ;remove the spaces in time

myFile = strcat(command "_" myTime2 "_" myName)
myPort = outfile(strcat("/home/jviray/tmp/" myFile))
fprintf(myPort "************************************************************\n\n")
fprintf(myPort strcat(myName "\n"))
fprintf(myPort strcat(myPath "\n"))
fprintf(myPort strcat(time "\n"))
fprintf(myPort strcat(command "\n"))
fprintf(myPort strcat(library "\n"))
fprintf(myPort strcat(cell "\n"))
fprintf(myPort strcat(view "\n"))
fprintf(myPort strcat(" " "\n"))
close(myPort)

)


procedure(jvWarningMessage()
        hiDisplayAppDBox(
                ?name `test
                ?dialogType hicMessageDialog
                ?dboxBanner "Reminder"
                ?dboxText strcat("Warning! No cell has been selected.")
                ?buttonLayout `Close
        );hiDisplayAppDBox
);procedure
