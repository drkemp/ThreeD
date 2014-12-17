include  <ringlib.scad>
include  <servolib.scad>

module holeboxpattern(w,h,d,t) {
  translate([-w/2,-h/2,0]) cylinder(r=d/2,h=t);
  translate([-w/2,h/2,0]) cylinder(r=d/2,h=t);
  translate([w/2,-h/2,0]) cylinder(r=d/2,h=t);
  translate([w/2,h/2,0]) cylinder(r=d/2,h=t);
}

module servobracket(dia,thick,height) {
  $fn=30;
  platex=height/2+10;
  platey=75;
  translate([0,0,0]) {
    difference() {
      translate([-platex/2,-platey/2,0]) cube([platex,platey,thick]);
      translate([0,10,0]) servomount(thick+3);
      holeboxpattern(15,65,3,15);
    }
  }
}

module mounts_L1(dia,thick,height) {

  // motor stops
  rotate([0,0,150])translate([dia/2-thick+1,0,height-15]) support(8,8,12);
  rotate([0,0,-150])translate([dia/2-thick+1,0,height-15]) support(8,8,12);

  translate([0,dia/2-5,height/2]) rotate([90,0,0]) cube([60,height,8],center=true);
  translate([0,-(dia/2-5),height/2]) rotate([90,0,0]) cube([60,height,8],center=true);

//  translate([55,40,0]) 
servobracket(dia,thick,height);
}
module cleanbody_L1(dia,thick,height) {
  difference() {
    union() {
      sleeve(dia,dia-2*thick,height);
      mounts_L1(dia,thick,height);
    }
    translate([0,0,-2])sleeve(dia+20,dia,height+4);
  }
  // top mount
  translate([0,0,height-2])suspendedring(dia+2*thick+.2,dia+.2,6,false);
  // arm outer rings
  translate([0,-(dia/2+3),height/2]) rotate([90,0,0]) cylinder(r1=15,r2=11,h=10,center=true);
  translate([0,(dia/2+3),height/2]) rotate([90,0,0]) cylinder(r1=11,r2=15,h=10,center=true);
}

module body_L1() {
  dia=130;
  thick=2;
  height=40;
  difference() {
    cleanbody_L1(dia,thick,height);
    translate([0,dia/2-5,height/2]) rotate([90,0,0]) cylinder(r=8,h=30,center=true);
    translate([0,-(dia/2-5),height/2]) rotate([90,0,0]) cylinder(r=8,h=30,center=true);
  }

}
module accy_L1(){
  cylinder(r=7.8,h=23);
  cylinder(r=10,h=2);
}
body_L1($fa=6);
accy_L1();

