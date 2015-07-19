$fn=60;

module triangle(v,h){
 linear_extrude(height=h) polygon(points=[[0,0],[v,0],[v,v]]);
}

module shape(h,s){
 linear_extrude(height=h) polygon(points=s);
}

module roundshape(h,s,r) {

 hull() for (i=s) { translate([i[0],i[1],0]) cylinder(r=r,h=h); }
}

module ring(d,w,h) {
 rotate_extrude(convexity = 10) translate([d/2,0,0]) polygon(points=[[0,0],[h,w/2],[0,w]]);
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
  rotate([-90,0,0]) shape(36,[[-14,0],[14,0],[24,30],[40,50],[-40,50],[-24,30],[-14,0]]);
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
  translate([-3,0,0]) rotate([-90,0,-90]) shape(6, [[0,0],[0,6],[3,6],[3,10],[6,10],[6,6],[0,0]]);
}

module buttonclip() {
  rotate([-90,0,-90]) shape(6, [[0,0],[0,10],[2.5,10],[2.5,6],[5.5,6],[5.5,10],[8,10],[8,6],[0,0]]);
}

module buttonbump() {
  rotate([-90,0,-90]) shape(6, [[0,0],[0,6],[3.5,6]]);
}

module strapsupport() {
  translate([-67,20,-33]) rotate([90,0,0]) shape(40, [[0,0],[8,8],[8,0]]);
}


module base() {
  thick=4;
  halfthick=thick/2;
  difference(){
    union() {
     //sides
     translate([-59-halfthick,-37,-35]) cube([thick,74,67]);
     translate([59-halfthick,-37,-35]) cube([thick,74,67]);

     //phone face
     translate([0,0,28]) roundshape(4,[[-61,-37],[61,-37],[61,37],[-61,37]],3);

     //top and bottom
     translate([-58,-37,-35]) cube([116,4,67]);
     translate([-58, 33,-35]) cube([116,4,67]);

     //screw rails
     translate([-64-5,-12.5,-13]) cube([10,5,45]);//screwrail2();
     translate([64-5,-12.5,-13]) cube([10,5,45]);// screwrail1();

     translate([0,-25,-91]) faceband();
     translate([0,45,-91]) faceband();

     // strap mounts
     translate([53,-37,-36])  rotate([0,45,0]) cube([14,74,8]);
     translate([-53,37,-36]) rotate([0,45,180]) cube([14,74,8]);

     // the elastic band clips
     translate([36,-37,18]) clip();
     translate([-36,-37,18]) clip();
     translate([36,37,18]) rotate([0,0,180]) clip();
     translate([-36,37,18]) rotate([0,0,180]) clip();

      // button retainers
      translate([2,-33,1]) rotate([0,0,180]) buttonclip();
      translate([-17,-33,-4]) rotate([0,0,180]) buttonbump();

      // strap support
      translate([-69,20,-33]) rotate([90,0,0]) shape(40, [[0,0],[8,8],[8,0]]);
      translate([69,-20,-33]) rotate([90,0,180]) shape(40, [[0,0],[8,8],[8,0]]);
    }

    // slots for the lens holder
    translate([-61+6,0,33]) rotate([-90,0,90]) shape(12,[[-7.5,0],[7.5,0],[7.5,52],[.5,58],[-.5,58],[-7.5,52]]);
    translate([61+6,0,33]) rotate([-90,0,90]) shape(12,[[-7.5,0],[7.5,0],[7.5,52],[.5,58],[-.5,58],[-7.5,52]]);

    //phone face cutout
    translate([-57,-33,27]) cube([114,66,6]);

    translate([0,50,-93]) rotate([90,0,0]) cylinder(r=80,h=100);

    // clean off the back
    translate([-80,-40,-47]) cube([160,100,6]);

    // nose cutout
    translate([0,14,17]) nosecut(); 

    // button hole
    translate([-52.5,-68, -2.25]) cube([11,50,13]);
    translate([-60,-29,-7]) rotate([0,90,0]) cylinder(r=1.75,h=8);

    // STRAP HOLES
    translate([63-2,-20,-42]) cube([4,40,9]);
    translate([-63-2,-20,-42]) cube([4,40,9]);

    // clean sides of STRAP HOLES
    translate([-68-2,-40,-34]) cube([4,80,16]);
    translate([-69-2,-40,-42]) cube([4,80,4]);
    translate([68-2,-40,-34]) cube([4,80,16]);
    translate([69-2,-40,-42]) cube([4,80,4]);

    // screw slots
    translate([65-3.75/2,-14,-10]) cube([3.75,8,34]);
    translate([-65-3.75/2,-14,-10]) cube([3.75,8,34]);
  }

  //cross support tapered to avoid nose
  translate([-1.25,-35,17]) {
    difference() {
      cube([2.5,70,15]);
      translate([-1,3,-15]) rotate([10,0,0]) cube([4.5,70,15]);
      translate([0,6,9]) rotate([0,90,0]) cylinder(r=2.35,h=5);
      translate([3,6,15.5]) rotate([-90,0,90]) shape(4,[[0,0],[5,5],[16,5],[21,0]]);
    }
  }

}

module screentouch() {
  difference() {
    union() {
      translate([-2,-11,31]) rotate([180,90,0])
        shape(3,[[1,3],[1,18],[4,21],[6.5,22],[20,22],[20,19],[14,19],
                 [14,16],[20,16],[20,8],[16,8],[17,13],[10,13],[3,3]]);
      translate([-2,-29,25]) rotate([0,90,0]) cylinder(r=3.5,h=.5); // spacer
      translate([-2,-29,25]) rotate([0,90,0]) cylinder(r=2,h=4.0); // axis
      translate([-2,-32.5,17])  cube([.5,7,8]); // spacer
      translate([-2,-23,28]) cube([7,9,2]);
    }
    translate([-2,-29,25]) rotate([0,90,0]) cylinder(r=1.1,h=4.5); // screw hole
  }
}

module lensholder() {
  difference() {
   union() {
     roundshape(5,[[-52,-15],[52,-15],[52,15],[-52,15]],2);
     translate([53,-7,0]) rotate([-90,-90,0]) shape(14,[[0,0],[0,16],[10,16],[10,6],[5,0]]);
     translate([-53,7,0]) rotate([90,-90,0]) shape(14,[[0,0],[0,16],[10,16],[10,6],[5,0]]);

     translate([-69,-7,10]) cube([8,5,10]);
     translate([61,-7,10]) cube([8,5,10]);
   }
   translate([0,-5,-1]) rotate([0,0,45]) cube([45,45,7]);
   translate([-72,-3,-1]) rotate([0,0,45]) cube([15,25,20]);
   translate([72,-3,-1]) rotate([0,0,45]) cube([15,25,20]);

   translate([-30.50,0,1]) cylinder(r=12.75,h=5);
   translate([30.50,0,1]) cylinder(r=12.75,h=5);
   translate([-30.50,0,-1]) cylinder(r=11.5,h=7);
   translate([30.50,0,-1]) cylinder(r=11.5,h=7);

   //holes for the screws
   translate([65,10,15]) rotate([90,0,0]) cylinder(r=1.5,h=20);
   translate([-65,10,15]) rotate([90,0,0]) cylinder(r=1.5,h=20);
  }
}
module bent_button(r,w1,w2) {
  intersection() {
      rotate([0,90,0])cylinder(r=12.5,h=20);
      translate([-1,-r,-r]) cube([w1+2,r,2*r]);
      translate([0,0,-r-w1/2]) rotate([0,90,0])
         rotate_extrude(convexity = 10) translate([r, 0, 0]) square([w1,w2]);
  }
}
module buttonwiring(w2) {
    translate([1.5,4,1]) rotate([107,0,0])cylinder(r=1,h=20);
    translate([w2-1.5,4,1]) rotate([107,0,0])cylinder(r=1,h=20);
    translate([-5,-12,-4]) rotate([0,90,0])cylinder(r=1,h=20);

    translate([40,4,1]) rotate([90,0,0])cylinder(r=1,h=20);
}

module button() {
  difference() {
    union() {
      translate([-2,-51.25,-1]) rotate([-90,0,0]) 
        shape(2.5,[[0,5],[0,25],[5,25],[5,15],[20,15],[20,25],[30,25],
              [30,15],[40,15],[40,25],[49,25],[49,0],[42,0],[42,5]]);
      translate([0.5,-51,-12]) bent_button(13,9,9);
      translate([-7,-50,-25]) rotate([0,90,0]) cylinder(r=1.25,h=58);
      translate([42.5,-50,-3]) rotate([0,90,0]) cylinder(r=1.25,h=9);
    }
    translate([0.5,-51,-12]) buttonwiring(9);
  }
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

module test() {
  base();
  translate([0,0,0]) lensholder();
  translate([-30.5,0,9]) rotate([180,0,0]) lensring();
  translate([30.5,0,9]) rotate([180,0,0]) lensring();
  translate([-52,21,18]) button();
  translate([0,0,0]) screentouch();
}

module print() {
  rotate([180,0,0]) {
    translate([0,62,32]) rotate([180,0,0])lensholder();
    translate([-34,-15,32]) rotate([180,0,0]) lensring();
    translate([-20,15,32]) rotate([180,0,0]) lensring();
    translate([31,-28,80.75]) rotate([90,0,60])button();
    translate([23,5,27]) rotate([0,90,0]) screentouch();
    base();
  }
}
print();
//test();
