$fn=50;

module lensstop() {
  difference() {
    cylinder(r=13.5,h=1.5);
    translate([0,0,-1]) cylinder(r=12,h=3);
  }
}

module dovetail() {
  rotate([90,0,0]) 
  difference() {
    rotate([0,0,45]) cube([11.5,11.5,55]);
    translate([0,0,-1])cube([17,17,57]);
  }
}

module sliderhole() {
 cube([10,15,52]);
 translate([0,7.5,-7.5]) rotate([45,0,0]) cube([10,10.5,10.5]);
}

module screwrail1() {
  difference() {
    cube([10,5,45]);
    translate([3.75,-1,3]) cube([3.75,8,34]);
  }
}
module screwrail2() {
  difference() {
    cube([10,5,45]);
    translate([3,-1,3]) cube([3.75,8,34]);
  }
}

module nosecut() {
  rotate([-90,0,0]) 
 linear_extrude(height=36) 
     polygon(points=[[-14,0],[14,0],[30,50],[-30,50],[-14,0]]);
//cube([30,16,30]);
}

module faceband() {
  difference() {
     union() {
       rotate([90,0,0]) rotate_extrude(convexity = 10) translate([-85, 0, 0])
         polygon(points=[[0,10],[10,20],[10,0]]);
     }
     translate([-100,-30,-100]) cube([200,35,150]);
  }
}
module side() {
  rotate([0,45,0]) cube([14,74,8]);
}

module clip() {
// cube([10,10,10]);
  rotate([-90,0,-90]) linear_extrude(height=6) 
     polygon(points=[[0,0],[0,6],[3,6],[3,10],[6,10],[6,6],[0,0]]);
}

module base() {
  difference(){
    union() {
     //sides
     translate([-59,-37,-35]) cube([4,74,67]);
     translate([59,-37,-35]) cube([4,74,67]);

     //phone face
     translate([-61,-39,28]) cube([126,78,4]);

     //top and bottom
     translate([-57,-37,-35]) cube([116,4,67]);
     translate([-57,33,-35]) cube([116,4,67]);

     //screw rails
     translate([-69,-12.5,-13]) screwrail2();
     translate([62,-12.5,-13])  screwrail1();

     translate([2,-25,-91]) faceband();
     translate([2,45,-91]) faceband();

     translate([56,-37,-36]) side();
     translate([-52,37,-36]) rotate([0,0,180]) side();

     translate([38,-37,18]) clip();
     translate([-40,-37,18]) clip();
     translate([44,37,18]) rotate([0,0,180]) clip();
     translate([-34,37,18]) rotate([0,0,180]) clip();

     // button retainer
     translate([-58.5,22,14.5]) cube([9,10,7]);
     translate([-50,34,18]) rotate([90,0,0]) cylinder(r=3.5,h=12);
     translate([-48.5,22,21]) rotate([90,0,180])  linear_extrude(height=11) 
         polygon(points=[[0,0],[8,0],[8,8]]);
    }
    translate([-63,-7.5,-19]) sliderhole();
    translate([57,-7.5,-19]) sliderhole();
    //phone face cutout
    translate([-55,-33,27]) cube([114,66,6]);

    translate([2,50,-93]) rotate([90,0,0]) cylinder(r=80,h=100);

    translate([-80,-40,-47]) cube([156,100,6]);

    // nose cutout
    translate([0,14,17]) nosecut(); 

    // button hole
//    translate([52,28,18]) rotate([90,0,0]) cylinder(r=2,h=100);
//    translate([52,-28,18]) rotate([90,0,0]) cylinder(r=4,h=50);
    translate([-52.5,-68,16]) cube([4,100,4]);//rotate([90,0,0]) cylinder(r=2,h=100);
    translate([-52.5,-68,14.5]) cube([7,50,7]);//rotate([90,0,0]) cylinder(r=4,h=50);
    translate([-60,-22,18]) rotate([90,0,90]) cylinder(r=9.5,h=3);

    // STRAP HOLES
    translate([64,-20,-42]) cube([4,40,16]);
    translate([-64,-20,-42]) cube([4,40,16]);
  }

  //cross support tapered to avoid nose
  translate([0.25,-35,17]) {
    difference() {
      cube([2.5,70,15]);
      translate([-1,3,-15]) rotate([10,0]) cube([4.5,70,15]);
    }
  }
}
module screwblock() {
  difference() {
    cube([9,5,10]);
    translate([4.5,10,5]) rotate([90,0,0]) cylinder(r=1.5,h=20);
  }
}

module lensholder() {
  difference() {
   union() {
     translate([-53.5,-17.5,0]) cube([107,34,5]);
     translate([52.5,-6.5,0]) cube([17.5,14,10]);
     translate([-51.5-19.5,-6.5,0]) cube([17.5,14,10]);

     translate([-71,-6.5,10]) screwblock();
     translate([61,-6.5,10]) screwblock();
   }
   translate([0,-5,-1]) rotate([0,0,45]) cube([45,45,7]);
  
   translate([-30.50,0,1]) cylinder(r=12.75,h=5);
   translate([30.50,0,1]) cylinder(r=12.75,h=5);
   translate([-30.50,0,-1]) cylinder(r=11.5,h=7);
   translate([30.50,0,-1]) cylinder(r=11.5,h=7);
  }
}

module button() {
/*
   rotate([90,0,0]) cylinder(r=1.5,h=60);
   translate([0,-45,0]) rotate([90,0,0]) cylinder(r=3.3,h=25);
   translate([1.1,-45,0]) rotate([0,90,0]) cylinder(r=9.5,h=2.2);
*/
   translate([0,-60,-1.5]) cube([3,60,3]);
   translate([0,-70,-3]) cube([6,25,6]);
   translate([0,-45,0]) rotate([0,90,0]) cylinder(r=9.5,h=3);
}
module triangle(v,h){
 linear_extrude(height=h) polygon(points=[[0,0],[v,0],[v,v]]);
}

module lensring() {
  difference() {
    union() {
      cylinder(r=13.5,h=1.5);
      translate([0,0,1]) cylinder(r=12.5,h=2.0);
    }
    translate([0,0,-1]) cylinder(r=11.5,h=5);
  }

}
module supportfoot() {
  translate([-10,-4,26]) cube([15,10,6]);
  translate([0,-2,-30]) cube([5,5,58]);
  translate([3,-15,-37]) cube([2,30,2]);
  translate([3,-1,-20]) rotate([0,90,0]) triangle(16,2);
  translate([5,1,-20]) rotate([0,90,180]) triangle(16,2);
}

module test() {
  base();
  translate([2,0,0]) lensholder();
  translate([-28.5,0,9]) rotate([180,0,0]) lensring();
  translate([32.5,0,9]) rotate([180,0,0]) lensring();
  translate([-52,21,18]) button();
}

module print() {
  translate([2,65,32]) rotate([180,0,0])lensholder();
//  translate([30,0,32]) rotate([180,0,0]) lensring();
//  translate([-30,0,32]) rotate([180,0,0]) lensring();
//  translate([-39,50,32]) rotate([0,90,90])button();
  translate([-32,-15,32]) rotate([180,0,0]) lensring();
  translate([-15,15,32]) rotate([180,0,0]) lensring();
  translate([6,25,32]) rotate([0,90,40])button();
  base();
 translate([64,0,0]) supportfoot();
 translate([-60,0,0]) rotate([0,0,180]) supportfoot();
}
print();
//test();