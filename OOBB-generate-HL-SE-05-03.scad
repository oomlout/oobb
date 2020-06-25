
baseCapHeight = 5;        
spacerHeight = 12;
extraCapHeight = baseCapHeight+7;  //this is the amount to stretch the cap
bearingHeight = 4;  //default to 6704
totalHeight = spacerHeight + bearingHeight;
capHeight = bearingHeight + 2 + baseCapHeight;
holderBaseHeight = 2; //used to be 12 6 too small may need to be 9


heightTop = capHeight;
heightCapB = heightTop - capHeight;
bearingInsertionHeight = 0;


//todo
//add a second M3 hole to hold servo on each side
//remove slot for single hole
//make screws come up from bottom
//add block to lock m3 nuts on servo
module OOBB_HL_SE_05_03(){
    //mode = "3DPR";
    mode = "NONE";
    
    if(mode == "3DPR"){

        //######  HOLDER PART
        if( extra == "NONE" || extra=="HOLDER"  || extra=="HOLDERA" || extra=="NOHORN"){
            translate([OOBBSpacing * 1,OOBBSpacing * 2,0]){
                translate([OOBBSpacing*2,OOBBSpacing*2.25,capHeight]){
                    rotate([0,180,0]){
                        translate([-OOBBSpacing*2,-OOBBSpacing*4,0]){
                            OOBB_HL_SE_05_03_HOLDER_A();    
                        }
                    }
                }
            }
        }
        //######  HOLDER PART
        if( extra == "NONE" || extra=="HOLDER"  || extra=="HOLDERB" || extra=="NOHORN"){
            translate([OOBBSpacing * 1,OOBBSpacing * 2,0]){
                translate([OOBBSpacing*2,OOBBSpacing*2.25,capHeight]){
                    translate([0,50,0]){  //for printing
                        translate([-OOBBSpacing*2,-OOBBSpacing*2,0]){
                            OOBB_HL_SE_05_03_HOLDER_B();    
                        }
                    }
                }
            }
        }
        
        //######  SERVO BRACKET
        if( extra == "NONE" || extra=="BRACKET" || extra=="NOHORN"){
            translate([OOBBSpacing * 3,OOBBSpacing * 8.5,0]){
            //translate([0,0,0]){ 
                OOBB_HL_SE_05_03_BRACKET();
            }
        }
        
        //###### Servo Horn
        if( extra == "NONE" || extra=="HORN"){    
            translate([OOBBSpacing * 6,OOBBSpacing * 4,0]){    
            //translate([0,0,0]){    
                OOBB_HL_SE_05_03_SERVOHORN();
            }
        }
        //######  Base
        if( extra == "NONE" || extra=="BASE" || extra=="NOHORN"){    
            translate([OOBBSpacing * 3 + 5,OOBBSpacing * 6,0]){ 
            //translate([0,0,0]){    
                
                   // OOBB_HL_SM_03_03_BASE();
                
            } 
        }
    }
    else{
    
                OOBB_HL_SE_05_03_HOLDER_A();
                //OOBB_HL_SE_05_03_HOLDER_B();    
                //OOBB_HL_SE_05_03_BRACKET();
                //OOBB_HL_SE_05_03_SERVOHORN();
    }
}




//////////////////////////////////////////////////// SE-05-03
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////



///########
///########
///########  HOLDER
///########
        
module OOBB_HL_SE_05_03_HOLDER_A(){
    difference(){
            OOBB_HL_SE_05_03_HOLDER_CAP();
            OOBB_HL_SE_05_03_HOLDER_MAINHOLES();
            OOBB_HL_SE_05_03_HOLDER_MAINHOLES_CAPONLY();
            OOBB_HL_SE_05_03_HOLDER_BEARINGHOLE();
            //OOBB_HL_SE_05_03_HOLDER_CAPTIVENUTS(capHeight);
    }
}


module OOBB_HL_SE_05_03_HOLDER_B(){ 
    difference(){
        OOBB_HL_SE_05_03_HOLDER_BASE(holderBaseHeight, extraCapHeight);
        OOBB_HL_SE_05_03_HOLDER_MAINHOLES(holderBaseHeight);
        OOBB_HL_SE_05_03_HOLDER_MAINHOLES_CAPONLY(holderBaseHeight);
    }
}
       

module OOBB_HL_SE_05_03_HOLDER_CAP(){
    translate([OS * -2,OS *-2,-capHeight+heightTop]){
        difference(){
            union(){
                OOBBPLOutline3D(3,3,capHeight);
                OOBBPLOutline3D(5,3,capHeight-4);
            }
            TOP = 3;
            RIGHT = 3;
            BOTTOM = 1;
            LEFT = 1;
            OOBBInsertItemCoordRotate("M6BoltClearanceCorner",LEFT,TOP,capHeight,height=4,rot=270);
            OOBBInsertItemMMRotate("M6BoltClearanceCorner",LEFT*OOBBSpacing-1,TOP*OOBBSpacing,capHeight,height=4,rot=270);
            OOBBInsertItemCoordRotate("M6BoltClearanceMiddle",LEFT,BOTTOM,capHeight,height=4,rot=0);
            OOBBInsertItemMMRotate("M6BoltClearanceMiddle",LEFT*OOBBSpacing-1,BOTTOM*OOBBSpacing,capHeight,height=4,rot=0);
        
            }
    }
}

module OOBB_HL_SE_05_03_HOLDER_BASE(holderBaseHeight,extraCapHeight){
    difference(){
        union(){
            OOBBPLOutline3D(5,3,holderBaseHeight+extraCapHeight-baseCapHeight);
            /*
            //extra end bits to keep servo bracket from sticking out the end.
            translate([-1,0,0]){
                OOBBPLOutline3D(5,3,holderBaseHeight);
            }
            translate([1,0,0]){
                OOBBPLOutline3D(3,3,holderBaseHeight);
            }
            */
            //bearing push up piece
            translate([OOBBSpacing*2,OOBBSpacing*2,holderBaseHeight+extraCapHeight-baseCapHeight]){
                cylinder(baseCapHeight, OOBBBearing6803OutsideHold+1-.2, OOBBBearing6803OutsideHold+1-.2); //.2 extra clearance guess Bearing push up piece
            }
        }
            OOBBInsertItemCoord("Bearing6704Little",2,2,holderBaseHeight);    
        
           
		//Servo Low
        
    OOBBInsertItemMM("M3NutCaptive",2*OOBBSpacing,3*OOBBSpacing+2,ooZ=OOBBNutM3Height,height=20);      
    //Servo High
    OOBBInsertItemMM("M3NutCaptive",2*OOBBSpacing,1*OOBBSpacing-2,ooZ=OOBBNutM3Height,height=20);      
   
    
    extraNutHeight =     holderBaseHeight+extraCapHeight-baseCapHeight-3;
    OOBBInsertItemMM("M3NutCaptive",3*OOBBSpacing+2,2*OOBBSpacing,ooZ=extraNutHeight,height=20);      
    
    OOBBInsertItemMM("M3NutCaptive",1*OOBBSpacing-2,2*OOBBSpacing,ooZ=extraNutHeight,height=20);      
    
    
    
    OOBBInsertItemCoord("ServoHole",2,2,height=holderBaseHeight+extraCapHeight-baseCapHeight-5);
    //OOBB_HL_SM_03_03_BASE_HOLES();
    
    nutHeight = 4;
    //OOBBInsertItemMMRotate("M3NutCaptiveSideInsert",2*OOBBSpacing-OOBBbaseBoltOffset,3*OOBBSpacing,ooZ=nutHeight+3,height=nutHeight,rot=0);
    //OOBBInsertItemMMRotate("M3NutCaptiveSideInsert",2*OOBBSpacing-OOBBbaseBoltOffset,1*OOBBSpacing,ooZ=nutHeight+3,height=nutHeight,rot=180);
               
    	
    }
}


module OOBB_HL_SE_05_03_HOLDER_MAINHOLES_CAPONLY(totalHeight){
    OOBBInsertItemMM("M3Hole",3*OOBBSpacing+2,2*OOBBSpacing);      
    OOBBInsertItemMM("M3Hole",1*OOBBSpacing-2,2*OOBBSpacing);      
 //Servo Low
    OOBBInsertItemMM("M3Hole",2*OOBBSpacing,3*OOBBSpacing+2);      
    //Servo High
    OOBBInsertItemMM("M3Hole",2*OOBBSpacing,1*OOBBSpacing-2);
}

module OOBB_HL_SE_05_03_HOLDER_MAINHOLES(){
//holes
    translate([OS * -2,OS *-2,0]){
        
        OOBBHole3D(1,1);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-1,1*OOBBSpacing-1);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-2,1*OOBBSpacing-2);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-3,1*OOBBSpacing-3);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-4,1*OOBBSpacing-4);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-5,1*OOBBSpacing-5);
        
        
        OOBBHole3D(1,3);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-1,3*OOBBSpacing+1);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-2,3*OOBBSpacing+2);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-3,3*OOBBSpacing+3);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-4,3*OOBBSpacing+4);
        OOBBInsertItemMM("OOBBHole",1*OOBBSpacing-5,3*OOBBSpacing+5);
        
        
        OOBBInsertItemCoord("OOBBHole",4,1);
        OOBBInsertItemCoord("OOBBHole",4,3);
        
        
        //OOBBInsertItemCoord("OOBBHole",2,3);
        OOBBInsertItemCoord("OOBBHole",5,3);
        //OOBBInsertItemCoord("OOBBHole",4,3);
        
        //OOBBInsertItemCoord("OOBBHole",2,1);
        OOBBInsertItemCoord("OOBBHole",5,1);
        //OOBBInsertItemCoord("OOBBHole",4,1);
        
        
        OOBBInsertItemCoord("OOBBHole",5,2);
        
    }
    
}




module OOBB_HL_SE_05_03_HOLDER_BEARINGHOLE(){
        OOBBInsertItemCoord("Bearing6704Hold",0,0,heightTop-2);    
}


module OOBB_HL_SE_05_03_HOLDER_CAPTIVENUTS(capHeight){
    nutHeight = OOBBNutM3Height;
    nutGap = nutHeight;
    //Servo Low
   
    //OOBBInsertItemMM("M3SocketHead",2*OOBBSpacing,3*OOBBSpacing+2,height=capHeight-2);
    OOBBInsertItemMM("M3SocketHead",2*OOBBSpacing,3*OOBBSpacing+2,height=capHeight); //to allow for using 30mm bolts      
    //Servo High
    //OOBBInsertItemMM("M3SocketHead",2*OOBBSpacing,1*OOBBSpacing-2,height=capHeight);
    //to allow for using 30mm bolts
    //OOBBInsertItemMM("M3SocketHead",2*OOBBSpacing,1*OOBBSpacing-2,height=capHeight-2); 
    OOBBInsertItemMM("M3SocketHead",2*OOBBSpacing,1*OOBBSpacing-2,height=capHeight); //Retaining Screws
    OOBBInsertItemMM("M3SocketHead",3*OOBBSpacing+2,2*OOBBSpacing,height=capHeight);      
    OOBBInsertItemMM("M3SocketHead",1*OOBBSpacing-2,2*OOBBSpacing,height=capHeight);      
    
    

    
}

///########
///########
///########  BRACKET
///########
module OOBB_HL_SE_05_03_BRACKET(){
	difference(){
        translate([-4*OOBBSpacing,-2*OOBBSpacing,0]){
            difference(){
                OOBBPLOutline3D(5,3,servoBracketThicknessFull);
                translate([6*OOBBSpacing,0,0]){
                    mirror([1,0,0]){
                    
                        OOBB_HL_SE_05_03_HOLDER_MAINHOLES(30);
                    }
                }
            }          
        }
            OOBBInsertItemCoord("ServoFullMountTop",0  ,0,height=12);
            OOBBInsertItemMM("M3Slot",0*OOBBSpacing,1*OOBBSpacing+2);
            OOBBInsertItemMM("M3Slot",0*OOBBSpacing,-1*OOBBSpacing-2);
        
            
	}
}


///########
///########
///########  SERVOHORN
///########

	
botTubeHeightFull=7;
topTubeHeightFull = 4;
	
module OOBB_HL_SE_05_03_SERVOHORN(){

	bearingTubeHeight = 4; //default to 6704
	//bearingTubeHeight = 4; //default to 6704
	bearingInside = OOBBBearing6704Inside; //default to 6704
	bearingLittle = OOBBBearing6704Little;
    totalHeight = botTubeHeightFull+bearingTubeHeight+topTubeHeight+9; //2+5+3+9=19
	
    topHeight = topTubeHeightFull + 9; //9 is wheel width
    bottomHeight = botTubeHeightFull + bearingTubeHeight;
        
    
    
        //TOP PIECE
    //translate([0,0,0]){
    translate([0,0,topHeight/2]){  //move to zero height
        rotate([0,180,0]){ //rotate 180 to print upside down
            translate([0,0,-bottomHeight - topHeight/2]){ //shift so centred for flip
                difference(){
                    union(){
                        //bottomTube
                        
                        
                        //topTube
                        translate([0,0,botTubeHeightFull+bearingTubeHeight+topTubeHeightFull/2  ]){
                            //cylinder(topTubeHeight,bearingLittle-0.5,bearingLittle-0.5,true);
                            cylinder(topTubeHeightFull,bearingInside+1,bearingInside+1,true);
                        }
                        //wheel
                        translate([0,0,totalHeight]){
                            rotate([0,180,0]){
                                OOBB_WH_SOLID(3);
                            }
                        }
                               //bearing tube
                        translate([0,0,botTubeHeightFull+bearingTubeHeight/2  ]){
                            cylinder(bearingTubeHeight,bearingInside,bearingInside,true);
                            } 
                    }
                    OOBB_HL_SE_05_03_SERVOHORN_HOLES();
                }
            }
        }

    }
    
        // BOTTOM PIECE
    //translate([0,0,0]){
    translate([0,-OOBBSpacing*2-3,7]){
        rotate([0,180,0]){//rotate 180 to print upside down
            difference(){
                union(){
                    
                    translate([0,0,0]){
                        //OOBBcylinder(botTubeHeightFull,bearingLittle-0.5,bearingLittle-0.5);
                        OOBBcylinder(botTubeHeightFull,bearingInside+1,bearingInside+1);
                    }
                    //bearingTube    
                    
                    
                    
                    
                    
                }
                OOBB_HL_SE_05_03_SERVOHORN_HOLES();
            }
        }
    }    
	
}

module OOBB_HL_SE_05_03_SERVOHORN_HOLES(){
    OOBB_screwClamp1X = 0; 
    OOBB_screwClamp2X = 0;
    OOBB_screwClamp1Y = 8.125;
    OOBB_screwClamp2Y = -8.125;
	
    
    
	bearingTubeHeight = 4; //default to 6704
	//bearingTubeHeight = 4; //default to 6704
	bearingInside = OOBBBearing6704Inside; //default to 6704
	bearingLittle = OOBBBearing6704Little;
    totalHeight = botTubeHeightFull+bearingTubeHeight+topTubeHeight+9; //2+5+3+9=19

		OOBBInsertItemCoord("ServoMicroHornHole",0,0,height=4);
		OOBBInsertItemCoord("OOBBHole",0,0,height=4);
		
		
	//for tg90
	//OOBBInsertItemCoord("ServoMicroHornCatchSingleBottomInsertion",0,0,4); //allows for 1.5mm thick arm and 2.5mm thick adapter tube
	//for continuousRotation
    OOBBInsertItemCoord("ServoFullHornCatchBottomInsertion",0,0,5.75); 
    
    
        //clamping screws
        OOBBInsertItemMM("M3SocketHead",OOBB_screwClamp1X,OOBB_screwClamp1Y,totalHeight);
        OOBBInsertItemMM("M3Hole",OOBB_screwClamp1X,OOBB_screwClamp1Y);
        OOBBInsertItemMM("M3NutCaptiveSingle",OOBB_screwClamp1X,OOBB_screwClamp1Y,OOBBNutM3Height);
        
        
        OOBBInsertItemMM("M3SocketHead",OOBB_screwClamp2X,OOBB_screwClamp2Y,totalHeight);
        OOBBInsertItemMM("M3Hole",OOBB_screwClamp2X,OOBB_screwClamp2Y);
        OOBBInsertItemMM("M3NutCaptiveSingle",OOBB_screwClamp2X,OOBB_screwClamp2Y,OOBBNutM3Height);
}