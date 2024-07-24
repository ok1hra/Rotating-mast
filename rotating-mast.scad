//-------------------------------------------------------------------
// title: Rotating mast
// author: OK1HRA
// license: Creative Commons BY-SA
// URL: https://remoteqth.com/w/doku.php?id=rotating_mast_concept
// revision: 0.1 (2024-07-24)
// format: OpenSCAD
//-------------------------------------------------------------------
//    HowTo:
//    After open change inputs parameters and press F5
//    .STL export press F6 and menu /Design/Export as STL...
//-------------------------------------------------------------------
//
/*  Vypocet pruhybu https://e-konstrukter.cz/technicke-vypocty/18-vypocet-pruhybu-nosniku/36-vypocet-pruhybu-staticky-urcite-nosniky/39-vypocet-pruhybu-staticky-urciteho-nosniku https://e-konstrukter.cz/technicke-vypocty/14-kvadraticky-moment-a-modul-prurezu-v-ohybu/94-kvadraticky-moment-prurezu-modul-prurezu-v-ohybu-obdelniku
*/


difference(){
    union(){
       metal();
        
// rotating-mast-08.stl
//        rotate([180,0,0])
        color([1,1,1]) translate([0,0,230+130])  TopCover();
        
// rotating-mast-07.stl
//     color([0,1,0]) LRmsountpoint();
        
// rotating-mast-06.stl
//        rotate([0,180,0])
        color([1,0,1]) translate([0,0,153+15+130]) 
        TopRainShield();
        
// rotating-mast-05.stl
        color([1,1,0]) translate([0,0,153+3+130])  OutTop();

// rotating-mast-04.stl
        color([1,0,0]) translate([0,0,153+130]) mirror([0,0,1]) OutDown(9);

// rotating-mast-03.stl
        color([0,1,0]) translate([0,0,128.5+130]) InTop();

// rotating-mast-10.stl
        translate([0,0,155]) rotate([0,180,0]) 
        insulator();

// rotating-mast-01.stl
//        rotate([0,180,0])
        color([1,1,0]) OutDown(0);

// rotating-mast-02.stl
//        rotate([0,180,0])
        color([0,1,0]) translate([0,0,3]) InDown();

// rotating-mast-11.stl
        translate([0,0,20+230]) mirror([0,0,1]) axis();
        translate([0,0,20]) axis();

// rotating-mast-09.stl
    translate([0,0,-50]) RotatorTerminal();


    }
    translate([0,-150+0.2,0])cube([400,300,800], center=true);
}

InnerDiameterHole    = 20.5;
InnerDiameter    = 52;
InnerDiameterOnEnd = 51.5;
OuterDiameter    = 60.5;
NumberOfCylinder =  3;

////////////////////////
$fn = 200;



module insulator(){
    difference(){
        union(){
//            translate([0,0,-InnerDiameter/2]) cylinder(d=InnerDiameter,h= 4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+InnerDiameter);
            translate([0,0,3*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)-0.1]) cylinder(d2=InnerDiameterOnEnd, d1=InnerDiameter, h= InnerDiameter/2+0.1);            
            translate([0,0,-InnerDiameter/15]) cylinder(d=OuterDiameter,h= 4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1));
                // + KEY
                KeyX=15;
                KeyZ=5;
                difference(){
                    translate([0,0,-InnerDiameter/15-KeyZ]) cylinder(d=OuterDiameter,h= 4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+KeyZ*2);
                    translate([-OuterDiameter,KeyX/2,-InnerDiameter/15-KeyZ-1]) cube([OuterDiameter*2,OuterDiameter*2,4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+KeyZ*2+2]);
                    rotate([0,0,180]) translate([-OuterDiameter,KeyX/2,-InnerDiameter/15-KeyZ-1]) cube([OuterDiameter*2,OuterDiameter*2,4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+KeyZ*2+2]);
                }
                rotate([0,0,90]) difference(){
                    translate([0,0,-InnerDiameter/15-KeyZ]) cylinder(d=OuterDiameter,h= 4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+KeyZ*2);
                    translate([-OuterDiameter,KeyX/2,-InnerDiameter/15-KeyZ-1]) cube([OuterDiameter*2,OuterDiameter*2,4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+KeyZ*2+2]);
                    rotate([0,0,180]) translate([-OuterDiameter,KeyX/2,-InnerDiameter/15-KeyZ-1]) cube([OuterDiameter*2,OuterDiameter*2,4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+KeyZ*2+2]);
                }


            translate([0,0,-InnerDiameter/2]) cylinder(d1=InnerDiameterOnEnd, d2=InnerDiameter, h= InnerDiameter/2);
        }
        translate([0,0,-InnerDiameter/2-1]) cylinder(d=InnerDiameterHole,h= 4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+InnerDiameter);
        for(z=[0:120:360]){
//            rotate([0,0,z]) translate([0,10.5+8,3*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+InnerDiameter/2-7]) rotate([90,0,0]) screw(11,9);
        }
        for(z=[0:120:360]){
//            rotate([0,0,z]) translate([0,10.5+8,-InnerDiameter/2+10]) rotate([90,0,0]) screw(11,9);
        }
    }
    for(z=[0:1:NumberOfCylinder-1]){
        translate([0,0,z*InnerDiameter/2]) ring(InnerDiameter);
    }
}


module support(){ 
    difference(){
        translate([0,0,-InnerDiameter/15]) cylinder(d=OuterDiameter,h= 4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1));
        translate([0,0,-InnerDiameter/2]) cylinder(d=InnerDiameter,h= 4*(InnerDiameter/15)+InnerDiameter/2*(NumberOfCylinder-1)+InnerDiameter);
    }
}

module ring(dia){
    rotate_extrude(convexity = 1) {
        translate([dia/2, 0, 0])
        hull(){
            circle(r = dia/15, $fn=30);
            translate([dia/2,dia/2,0]) circle(r = dia/20, $fn=30);
        }
    }
}

module screw(HEAD, LONG){
    translate([0,0,0]) cylinder(d1=3.2, d2=2.7, h=LONG);
    translate([0,0,-HEAD]) cylinder(d=6.5, h=HEAD);
}




module RotatorTerminal(){
    difference(){
        union(){
            difference(){
                cylinder(h=15, d=50+5, center=false, $fn=260);
                translate([0,0,-0.1]) cylinder(h=21, d2=50.5, d1=50, center=false, $fn=260);
            }
            cylinder(h=30, d2=41, d1=42, center=false, $fn=260);
            translate([0,0,-5]) cylinder(h=5, d2=50+5, d1=47, center=false, $fn=260);
        }
        for (r=[0:90:360]) {
                rotate([0,0,r]) translate([0,36/2,-6]) cylinder(h = 38, d2=6.2, d1=7, center=false, $fn=30);
        }
        translate([0,0,15]) rotate([90,0,-45]) translate([0,0,24]) cylinder(h = 10, d=3, center=false, $fn=60);
        translate([0,0,15]) rotate([90,0,-45+180]) translate([0,0,24]) cylinder(h = 10, d=3, center=false, $fn=60);

        translate([0,0,15]) rotate([90,0,45]) cylinder(h = 70, d=10.2, center=true, $fn=60);
            translate([0,0,15]) rotate([90,0,45]) translate([0,0,23]) cylinder(h = 10, d=20, center=false, $fn=60);
            translate([0,0,15]) rotate([90,0,45+180]) translate([0,0,21]) cylinder(h = 10, d=28, center=false, $fn=60);
    } 
}

module TopCover(){
    translate([0,0,20.1]) cylinder(h=5, d1=60+5, d2=57, center=false, $fn=260);
    difference(){
            cylinder(h=20.1, d1=60+5, d2=60+5, center=false, $fn=260);
            translate([0,0,-1]) cylinder(h=21, d1=60.5, d2=60, center=false, $fn=260);
    }
    translate([0,0,10]) cylinder(h=11, d1=51, d2=52, center=false, $fn=260);
}

module LRmountpoint(){
    translate([-141.5,-60,-5.5]) 
    difference(){
        rotate([0,90,0]) cube([20,120,20]);
        translate([10,60,-10]) cylinder(h=35, d=6, center=true, $fn=60);
        translate([10,60-50,-10]) cylinder(h=35, d=6, center=true, $fn=60);
        translate([10,60+50,-10]) cylinder(h=35, d=6, center=true, $fn=60);

        translate([10,60+10,-10]) rotate([0,90,0]) cylinder(h=35, d=6, center=true, $fn=60);
        translate([10,60-10,-10]) rotate([0,90,0]) cylinder(h=35, d=6, center=true, $fn=60);
        translate([10,60+40,-10]) rotate([0,90,0]) cylinder(h=35, d=6, center=true, $fn=60);
        translate([10,60-40,-10]) rotate([0,90,0]) cylinder(h=35, d=6, center=true, $fn=60);
        }
}

module TopRainShield(){
    difference(){
        union(){
            difference(){
                translate([0,0,-5]) cylinder(h=35, d1=110+2, d2=90, center=false, $fn=360);
                translate([0,0,20]) cylinder(h=12, d=60.2, center=false, $fn=300);
                translate([0,0,-9]) cylinder(h=30.2, d1=110, d2=90, center=false, $fn=300);

                translate([50/2,0,25.5]) rotate([0,90,0]) cylinder(h=18+2, d=3, center=false, $fn=60);
                translate([0,-150+0.2,0])cube([400,300,800], center=true);
            }
            translate([-60/2,0,25.5]) rotate([0,-90,0]) cylinder(h=12.5+2, d=2, center=false, $fn=60);
        }
        translate([-38,0,25.5]) rotate([90,0,0]) cylinder(h=80, d=3.2, center=true, $fn=60);
            translate([-38,10,25.5]) rotate([-90,0,0]) cylinder(h=80, d=6, center=false, $fn=60);
        translate([38,0,25.5]) rotate([-90,0,0]) cylinder(h=5, d1=3, d2=2.7, center=false, $fn=30);
            translate([38,4.99,25.5]) rotate([-90,0,0]) cylinder(h=50, d=2.7, center=false, $fn=30);
    }
}

module OutTop(){
    difference(){
        union(){
            translate([0,0,0]) cylinder(h=3, d1=140, d2=135, center=false, $fn=60);
            translate([0,0,0]) cylinder(h=30, d1=100, d2=80, center=false, $fn=60);
        }
        translate([0,0,-0.1]) cylinder(h=30.2, d1=65, d2=75, center=false, $fn=300);
        for (i = [10:40:180]) {
            rotate([0,0,i]) translate([63,0,3]) cylinder(h=20, d=6, center=false, $fn=30);
            rotate([0,0,i]) translate([63,0,-1]) cylinder(h=20, d=3.2, center=false, $fn=30);
        }
        for (i = [190:40:360]) {
            rotate([0,0,i]) translate([63,0,3]) cylinder(h=20, d=6, center=false, $fn=30);
            rotate([0,0,i]) translate([63,0,-1]) cylinder(h=20, d=3.2, center=false, $fn=30);
        }
    }
}

module InTop(){
    difference(){
        union(){
            translate([0,0,-2]) cylinder(h=25, d=60-0.2, center=false, $fn=300);
            translate([0,0,-2]) cylinder(h=2.5, d=60-0.4+20, center=false, $fn=60);
        }
            translate([0,0,-3]) cylinder(h=30, d=50.8, center=false, $fn=300);
    }
}

module InDown(){
    difference(){
        translate([0,0,0]) cylinder(h=21+3, d1=110+2*15+20, d2=110+4+25, center=false, $fn=360);
        translate([0,0,-3]) cylinder(h=21+3, d1=110+2*15+20-3, d2=110+4+20-3, center=false, $fn=60);
        translate([0,0,-1]) cylinder(h=26, d=50.8, center=false, $fn=300);
    }
    difference(){
        translate([0,0,-2]) cylinder(h=21+3, d2=60-0.2, d1=60-0.4, center=false, $fn=360);
        translate([0,0,-3]) cylinder(h=26, d=50.8, center=false, $fn=300);
    }
}

module OutDown(ZZ){
    difference(){
        translate([0,0,0]) cylinder(h=21+ZZ, d1=110+2*15, d2=110+4, center=false, $fn=360);
        translate([0,0,-1]) cylinder(h=18+2, d=110.4, center=false, $fn=300);
        translate([0,0,0]) cylinder(h=25+ZZ, d=110-8, center=false, $fn=160);
        for (i = [10:40:180]) {
            rotate([0,0,i]) translate([63,0,3]) cylinder(h=20, d=5.55/sin(60), center=false, $fn=6);
            rotate([0,0,i]) translate([63,0,-1]) cylinder(h=20, d=3.2, center=false, $fn=30);
        }
        for (i = [190:40:360]) {
            rotate([0,0,i]) translate([63,0,3]) cylinder(h=20, d=5.55/sin(60), center=false, $fn=6);
            rotate([0,0,i]) translate([63,0,-1]) cylinder(h=20, d=3.2, center=false, $fn=30);
        }
    }
}

module metal(){
        // laser cut
        translate([0,0,125+29.3+130]) rotate([0,0,0]) linear_extrude(height = 2, center = true, convexity = 10, $fn = 100)
           import (file = "rotating-mast.dxf", layer = "TopMountpoint");

        translate([0,0,125+130]) rotate([0,0,0]) linear_extrude(height = 2, center = true, convexity = 10, $fn = 100)
           import (file = "rotating-mast.dxf", layer = "RingTop");
    
        translate([0,0,28.2]) rotate([0,0,0]) linear_extrude(height = 2, center = true, convexity = 10, $fn = 100)
           import (file = "rotating-mast.dxf", layer = "RingBottom");

//        translate([0,0,60.2]) rotate([0,0,0]) linear_extrude(height = 2, center = true, convexity = 10, $fn = 100)
//           import (file = "rotating-mast.dxf", layer = "MiddleMount");
//        translate([0,0,62.2]) mirror([0,1,0]) linear_extrude(height = 2, center = true, convexity = 10, $fn = 100)
//           import (file = "rotating-mast.dxf", layer = "MiddleMount");

        translate([0,0,-2.5]) rotate([0,0,0]) linear_extrude(height = 6, center = true, convexity = 10, $fn = 100)
           import (file = "rotating-mast.dxf", layer = "T");

        translate([0,0,-25]) rotate([0,0,0]) linear_extrude(height = 2, center = true, convexity = 10, $fn = 100)
           import (file = "rotating-mast.dxf", layer = "FIX");

        translate([-2.5-142,0,155]) rotate([0,-90,0]) linear_extrude(height = 6, center = true, convexity = 10, $fn = 100)
           import (file = "rotating-mast.dxf", layer = "L");
        translate([2.5+142,0,155]) rotate([0,-90,0]) linear_extrude(height = 6, center = true, convexity = 10, $fn = 100)
           import (file = "rotating-mast.dxf", layer = "L");
        // bearing 110 x 60 x 24,5mm

        // https://www.dimensor.cz/produkty/prumyslova-loziska/loziska-kuzelikova/jednorada/30212-a-000-027370.html
        translate([0,0,153+130]) rotate([0,90,0]) import("SKF_30212.stl", convexity=3);
        translate([0,0,0]) rotate([0,-90,0]) import("SKF_30212.stl", convexity=3);
        // tube
        translate([0,0,152+130]) tube(52, 60, 94.3);
            translate([0,0,90+130]) tube(42, 50, 140);
        translate([0,0,165]) tube(52, 60, 88);
        translate([0,0,29.5]) tube(52, 60, 60);
            translate([0,0,-30]) tube(42, 50, 90);
}
        
module tube(IN, OUT, ZZ){
    difference(){
        translate([0,0,0]) cylinder(h=ZZ, d=OUT, center=false, $fn=60);
        translate([0,0,-1]) cylinder(h=ZZ+2, d=IN, center=false, $fn=60);
    }
}



module axis(){
    difference(){
        hull(){
            translate([0,0,25]) cylinder(d=20, h= 5, $fn=50, center=false);
            // -3 mm
            scale([1, 0.928, 1]) translate([0,0,15]) cylinder(d=41.5, h= 22, $fn=200, center=true);
        }
        translate([0,0,28]) rotate([0,-50,45]) cylinder(d=5, h= 100, $fn=20, center=true);
            rotate([0,0,45]) translate([21,0,0]) cylinder(d=6, h= 100, $fn=20, center=true);
        translate([0,0,28]) rotate([0,50,45]) cylinder(d=5, h= 100, $fn=20, center=true);
            rotate([0,0,45]) translate([-21,0,0]) cylinder(d=6, h= 100, $fn=20, center=true);
        translate([0,0,30-9]) cylinder(d1=20, d2=21, h= 20, $fn=50, center=false);
        translate([0,0,13]) rotate([90,0,0]) cylinder(d=10.5, h= 70, $fn=30, center=true);
//        translate([55.5/2-2.5,0,0]) cube([5,10,65], center=true);
//            translate([51.75/2,0,0]) rotate([0,-90,0]) cylinder(h=5, r=6.5/sin(60)/2, $fn=6, center=false);
//            translate([51.75/2,0,0]) rotate([0,-90,0]) cylinder(h=15, d=5.5, $fn=30, center=false);
     }
 }