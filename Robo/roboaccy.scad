include  <ringlib.scad>
translate([-6,0,1]) washer(10,3,2,$fn=35);
translate([6,0,1]) washer(10,3,2,$fn=35);

$fn=35;
difference() {
  union() {
   cylinder(r=20,h=4);
   cylinder(r=40,h=2);
  }
  translate([0,0,-1]) cylinder(r=17.5,h=6);
  translate([25,-50,-1]) cube([20,100,4]);
}

