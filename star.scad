$fn=30;
module point() {
  translate([-2.5,0,-5])
  difference() {
    rotate([45,15,0]) cube([22,8,8]);
    translate([0,0,-5]) cube([50,40,20],center=true);
  }
}
module star() {
  cylinder(r=.5,h=6);
  rotate([0,0,0]) point();
  rotate([0,0,60]) point();
  rotate([0,0,120]) point();
  rotate([0,0,180]) point();
  rotate([0,0,240]) point();
  rotate([0,0,300]) point();
}

module assy() {
  translate([2,0,0.5]) rotate([0,90,0])  cylinder(r=2,h=22);
  rotate([0,180,0]) star();
  star();
}
difference() {
 assy();
 translate([-25,-25,-12]) cube([50,50,10]);
}
translate([18,-.25,-2]) cube([6,.5,2]);

