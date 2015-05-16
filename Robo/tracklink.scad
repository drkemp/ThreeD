$fn=30;


module slab(tol) {
  cube([3,5+tol,2.5+tol]);
  translate([3,0,1.25+tol/2])rotate([-90,0,0]) cylinder(r=1.25+tol/2,h=5+tol);
}
module riser() {
  rotate([90,0,0]) linear_extrude(height=2,convexity = 10)
  polygon([[0,0],[6,0],[4,2],[2,2]]);
}
module plug(w,l,h) {
  rotate([90,0,0]) linear_extrude(height=w,convexity = 10)
  polygon([[0,0],[l,0],[l-h,-h],[h,-h]]);
}
module link() {
 tol=0.25;
 pinhole=.6;
  difference() {
    union() {
      cube([3.5,45,5]);
      translate([0,0,2.5]) cube([13,45,2.5]);
      translate([13,0,3.75]) rotate([-90,0,0]) cylinder(r=1.25,h=45);
      translate([3,15,4.5]) riser();//cube([4,3,4]);
      translate([3,32,4.5]) riser();//cube([4,3,4]);
    }

//thin side insets
    translate([10.5,-1,0]) cube([6,6,10]);
    translate([10.5,10,0]) cube([6,5,10]);
    translate([10.5,20,0]) cube([6,5,10]);
    translate([10.5,30,0]) cube([6,5,10]);
    translate([10.5,40,0]) cube([6,6,10]);

// step side insets
    translate([-1,5-tol/2,2.5]) slab(tol); // cube([3,5.1,2.5]);
    translate([-1,15-tol/2,2.5]) slab(tol); //cube([3,5.1,10]);
    translate([-1,25-tol/2,2.5]) slab(tol); //cube([3,5.1,10]);
    translate([-1,35-tol/2,2.5]) slab(tol); //cube([3,5.1,10]);

// track relief
    translate([4,43,5.1]) plug(7,5,2);//cube([4,7,3]);
    translate([4,29,5.1]) plug(13,5,2);//cube([4,13,3]);
    translate([4,9,5.1]) plug(7,5,2);//cube([4,7,3]);

// track holes/guides
    translate([4,10,0]) cube([4,3,6]);
    translate([4,32,0]) cube([4,3,6]);

// drill holes for pins
    translate([13,0,3.75]) rotate([-90,0,0]) cylinder(r=pinhole/2,h=50);
    translate([2,0,3.75]) rotate([-90,0,0]) cylinder(r=pinhole/2,h=50);

// track grip
    for(i=[0:5]) {
      translate([3.5,i*9+2.5,-.1]) rotate([180,0,90])plug(4,3,1);
    }
  }
}
module tooth() {
linear_extrude(height=5,convexity = 10,center=true)
  polygon([[0,-4],[0,4],[2,5],[2,-5]]);
}
module drivegear() {
  difference() {
    cylinder(r=22,h=2);
    for(i=[0:12]) {
      rotate([0,0,i*30]) translate([20,0,0])tooth();
    }
  }
  cylinder(r=5,h=11.5);
}
module test() {
  link();
  translate([11,0,0]) link();

  translate([12,34,25]) rotate([90,0,0]) drivegear();
  translate([12,11,25]) rotate([90,0,180]) drivegear();
}

module print(){
  link();
  translate([0,0,8]) link();
}

scale([1.5,1.5,1.5]) print();