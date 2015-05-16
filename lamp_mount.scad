$fn=50;

module lampmount(width, thick) {
  hole=13;
  baset=2.5;
  clear=3;
//  thick=baset+clear;
  difference(){
    union(){
      translate([0,0,0]) cylinder(r=width/2,h=thick);
      translate([-width/2,0,0]) cube([width,width/2,thick]);
      translate([0,0,baset+clear]) cylinder(r=hole/2+2,h=2);
    }
    translate([0,0,-1]) cylinder(r=hole/2,h=thick+2);
    translate([0,0,-clear]) cylinder(r=hole/2+1,h=thick);
    translate([0,0,baset+clear]) cylinder(r=hole/2+1,h=thick);
  }
}

module mount(d,screw, width, thick) {

  difference(){
    cube([d+screw*3,width,thick]);
    translate([screw*1.5,width/2,-1])cylinder(r=screw/2,h=thick+2);
    translate([d+screw*1.5,width/2,-1])cylinder(r=screw/2,h=thick+2);
  }
}
spacing = 1.25*25.4;
screw=0.2*25.4;
mount(spacing, screw, 10, 5.5);
translate([(spacing+screw*3)/2,-9,0]) lampmount(18,5.5);