
gap =12.4;
guide=4;
flange=16;

depth=17;

module wedge(w,t)
{
  inside=w/2 - 1.414*t/2;
  points=[[-w/2,-t/2],[-inside,t/2],[inside,t/2],[w/2,-t/2]];
  rotate([-90,0,0])
  linear_extrude(height=depth, center=true) polygon(points);
}

difference(){
  union() {
    cube([gap,depth,2], center=true);
    translate([0,0,-2]) cube([flange,depth,2], center=true);
    translate([0,0,2]) wedge(15.25,2);
  }
  translate([0,0,-2]) cube([guide,depth,2], center=true);
  translate([flange/2,0,-3]) cube([2,depth,.5], center=true);
  translate([-flange/2,0,-3]) cube([2,depth,.5], center=true);

  // 3.5mm pin hole 15mm from back
  translate([0,depth/2-15,-3]) cylinder(r=3.5/2, h=6, center=true, $fn=30);

}