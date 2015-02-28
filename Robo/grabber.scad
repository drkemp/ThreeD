// grabber claw

module clamp1() {
  difference() {
    linear_extrude(height=7) import("claw.dxf","Layer 1");
    translate([10,10,1.95]) cube([20,30,3.1]);
    translate([22,28,0]) cylinder(r=1.5,h=20,$fn=20);
    translate([4,4,0]) cylinder(r=1,h=20,$fn=20);
  }
}

module clamp2() {
  difference() {
    linear_extrude(height=7) import("claw.dxf","Layer 1");
    translate([10,10,-.10]) cube([20,30,2.1]);
    translate([10,10,4.9]) cube([20,30,2.2]);
    translate([22,28,0]) cylinder(r=1.5,h=20,$fn=20);
    translate([4,4,0]) cylinder(r=1,h=20,$fn=20);
  }
}

module driver() {
  cylinder(r=5,h=6);
}

module test() {
  clamp1();
  translate([44,0,7]) rotate([0,180,0]) clamp2();
  translate([22,0,0]) driver();

  cylinder(r=1,h=20);
  translate([5,-40,-5]) arm();
  translate([5,-40,9.5]) arm();
}
module arm() {
  cube([35,75,2.5]);
}

module print() {
  clamp1();
  translate([0,0,10]) clamp2();
}

test();
//print();

