

// DODAT SPODNJI PRECNI KONEKTOR


// Motor radius
motorRadius = 8.7; 

// Motor holder width
motorHolderWidth = 10.0; 

// Motor holder  thickness
motorHolderThickness = 4.0; 

// Motor hole tolerance
motorTolerance = 0.05;      // Toleranca
         

// Screw holder length
screwHolderLength = 5.5; 

// Screw holder thickness
screwHolderThickness = 8.0;

// Space between holders
spaceBetweenHolders = 6.0;

// Screw position
screwTranslate = 0.0;   // Zamik vijakov

// Fischertechnik Bottom holes
fischertechnikBottom = false;

// Fischertechnik Bottom cross hole
fischertechnikBottomCross = false;

// Fischertechnik Bottom cross center hole
fischertechnikBottomCrossCenter = false;

// Fischertechnik side holes
fischertechnikSide = false;

// Fischertechnik holes tolerance
fischertechnikTolerance = 0.05;


// Circle segments
segments = 100;      




// ZACETEK PROGRAMA
Main();



// Glavna Methoda
module Main() {
    
    difference( ){
        
        if(fischertechnikSide || fischertechnikBottomCross || fischertechnikBottom){
            nosilecFischertechnik();
        }
        else{
            nosilec();
        }
        
        motor(); // Naredi lukno za motor

        
        popravekX = motorRadius + motorHolderThickness + screwTranslate;

        // vijak levo
        translate([-popravekX, 0, 0]) {
            vijak();
        }

        // vijak desno
        translate([popravekX, 0, 0]) {
            vijak();
        }
        
    }

    
}// Main()



// MOTOR (izrez)
module motor() {

    sirinaPrav = 2 * motorRadius + 2 * motorHolderThickness + 2 * screwHolderLength + 10;

    union(){
        cube([ sirinaPrav, spaceBetweenHolders / 2, motorHolderWidth + 10], center = true);
        cylinder(r = motorRadius + (motorTolerance / 2), h = motorHolderWidth + 1, center = true, $fn = segments);
    }
    
    

}// motor()


// NOSILEC
module nosilec() {

    xPrav = ( 2 * (motorRadius + motorHolderThickness))  + 2 * screwHolderLength;
    yPrav = motorRadius + motorHolderThickness + (spaceBetweenHolders / 2) + screwHolderThickness;

    popravekY = (yPrav - (2 * motorRadius + 2 * motorHolderThickness)) / 2 ;

    debelinaPrav = 2 * screwHolderThickness + 2;

    union(){
        translate([0, popravekY, 0]) {
            cube([ xPrav, yPrav, motorHolderWidth], center = true);
        }
        cylinder(r = motorRadius + motorHolderThickness, h = motorHolderWidth, center = true, $fn = segments);
    }
    
}// nosilec()




// FISCHERTECHNIKS NOSILEC
module nosilecFischertechnik() {

    popravekY = - motorRadius - motorHolderThickness + 2 + fischertechnikTolerance / 2;

    difference(){

        nosilec();

        if(fischertechnikBottom){

            // sredinski
            translate([0, popravekY, 0]) {
                fischertechnikLuknja();
            }

            // levo 1
            if(motorRadius + screwHolderLength + motorHolderThickness / 2 > 15){
                translate([-15, popravekY, 0]) {
                    fischertechnikLuknja();
                }
            }

            // levo 2
            if(motorRadius + screwHolderLength + motorHolderThickness / 2 > 30){
                translate([-30, popravekY, 0]) {
                    fischertechnikLuknja();
                }
            }
            
            // desno 1
            if(motorRadius + screwHolderLength + motorHolderThickness / 2 > 15){
                translate([15, popravekY, 0]) {
                    fischertechnikLuknja();
                }
            }
                
            // desno 2
            if(motorRadius + screwHolderLength + motorHolderThickness / 2 > 30){
                translate([30, popravekY, 0]) {
                    fischertechnikLuknja();
                }
            }
        }
        

        if(fischertechnikBottomCross){

            if(fischertechnikBottomCrossCenter){

                translate([0, popravekY, 0]) {
                    fischertechniksLuknjaPrecna();
                }

            }
            else{

                popZ = motorHolderWidth / 2 - 7.5;

                translate([0, popravekY, popZ]) {
                    fischertechniksLuknjaPrecna();
                }

                if(motorHolderWidth >= 26){
                    translate([0, popravekY, popZ - 15]) {
                        fischertechniksLuknjaPrecna();
                    }
                }

                if(motorHolderWidth >= 41){
                    translate([0, popravekY, popZ - 30]) {
                        fischertechniksLuknjaPrecna();
                    }
                }

            }
            
            
        }
        

        if(fischertechnikSide){


            // LEVI
            rotate([90, 0, 0]) {
                scale([1, 1, 1]) {

                    popravekX = motorRadius + motorHolderThickness + screwHolderLength - 2  - fischertechnikTolerance / 2;

                    translate([-popravekX, 0, 0]) {
                        fischertechnikLuknjaStranskaLevi();
                    }
                }
            }
            
            // DESNI
            rotate([90, 0, 0]) {
                scale([1, 1, 1]) {

                    popravekX = motorRadius + motorHolderThickness + screwHolderLength - 2  - fischertechnikTolerance / 2;

                    translate([popravekX, 0, 0]) {
                        fischertechnikLuknjaStranskaDesni();
                    }
                }
            }

        }
            

    }
    
}// nosilecFischertechnik()



// Fischertechnik luknja
module fischertechnikLuknja() {

    color( "Coral", 0.3 ) {
        union(){
            cylinder(r=2 + fischertechnikTolerance / 2, h=motorHolderWidth + 2, center=true,$fn = segments);
            translate([0, -2, 0]) {
                cube(size=[3 + fischertechnikTolerance / 2, 3 + fischertechnikTolerance / 2, motorHolderWidth + 2], center=true);
            }
        }
    }
    
    
}// fischertechnik()


module fischertechniksLuknjaPrecna() {

    dolzinaLuknja = ( 2 * (motorRadius + motorHolderThickness))  + 2 * screwHolderLength + 2;
    
    color( "Coral", 0.3 ) {
        rotate([0, 90, 0]) {
            union(){
                cylinder(r=2 + fischertechnikTolerance / 2, h=dolzinaLuknja, center=true,$fn = segments);
                translate([0, -2, 0]) {
                    cube(size=[3 + fischertechnikTolerance / 2, 3 + fischertechnikTolerance / 2, dolzinaLuknja], center=true);
                }
            }
        }
        
    }

}// fischertechniksLuknjaPrecna()




module fischertechnikLuknjaStranskaLevi() {

    yPrav = motorRadius + motorHolderThickness + (spaceBetweenHolders / 2) + screwHolderThickness + 100;

    color( "Coral", 0.3 ) {
        union(){
            cylinder(r=2 + fischertechnikTolerance / 2, h=yPrav, center=true,$fn = segments);
            translate([-2, 0, 0]) {
                cube(size=[3 + fischertechnikTolerance / 2, 3 + fischertechnikTolerance / 2, yPrav], center=true);
            }
        }
    }
    
}// fischertechnikLuknjaStranskaLevi()


module fischertechnikLuknjaStranskaDesni() {

    yPrav = motorRadius + motorHolderThickness + (spaceBetweenHolders / 2) + screwHolderThickness + 100;

    color( "Coral", 0.3 ) {
        union(){
            cylinder(r=2 + fischertechnikTolerance / 2, h=yPrav, center=true,$fn = segments);
            translate([2, 0, 0]) {
                cube(size=[3 + fischertechnikTolerance / 2, 3 + fischertechnikTolerance / 2, yPrav], center=true);
            }
        }
    }
    
}// fischertechnikLuknjaStranskaDesni()



// VIJAK
module vijak() {

    dolzinaSredine = screwHolderThickness * 2 + spaceBetweenHolders - 6;
    polmerKapice = 4;
    visinaKapice = 50;

    color("RoyalBlue", 0.3) {

        union(){
            
            // sredina
            rotate([90, 0, 0]) {
                cylinder(r=1.55, h=dolzinaSredine, center=true,$fn = segments);
            }

            // zgoraj
            rotate([90, 0, 0]){
                translate([0, 0, - dolzinaSredine/2 - visinaKapice/2 + 0.2]) {
                    cylinder(r=polmerKapice, h=visinaKapice, center=true,$fn = segments);
                }
            }

            // spodaj
            rotate([90, 0, 0]){
                translate([0, 0, dolzinaSredine/2 + visinaKapice/2 - 0.2]) {
                    cylinder(r=polmerKapice, h=visinaKapice, center=true,$fn = segments);
                }
            }

        }
        
    }
    
    
    
}// vijak
