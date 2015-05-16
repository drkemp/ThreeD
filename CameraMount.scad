$fn=30;
tolerance=.3;
clearance=1.5;

module tube(o,i,h) {
  difference() {
    cylinder(r=o/2,h=h);
    translate([0,0,-1]) cylinder(r=i/2,h=h+2);
  }    
}
module hingeout(i,w,t,f) {
  o=i+t*2;
  difference() {
    union() {
      tube(o,i,w);
      translate([o/2-t,0,0]) cube([t,f,w]);
    }
    translate([0,0,w/3-tolerance]) cylinder(r=o/2+clearance,h=w/3+tolerance*2);
    translate([o/2-t+tolerance,o/2-t,w/3-tolerance]) cube([t,t,w/3+tolerance*2]);
  }
}
module hingein(i,w,t,f) {
  o=i+t*2;
  translate([0,0,w/3]) tube(o,i,w/3);
  translate([o/2-t,-f,w/3]) cube([t,f,w/3]);
}

module cameraplate(width,depth) {
  platethick=3;
  hingepin=6;
  difference() {
    union() {
      hingeout(hingepin,20,3,10);
      translate([0,0,width-20]) hingeout(hingepin,20,platethick,10);
      translate([hingepin-platethick,hingepin,0,]) cube([platethick,depth,width]);
    }
    translate([0,30,width-60]) rotate([0,90,0]) cylinder(r=3.75,h=10);
  }
  translate([-12,32,width]) cube([18,14,3]);
}

module mountplate(width,depth) {
  platethick=3;
  hingepin=6;
  hingein(hingepin,20,platethick,10);
  translate([0,0,width-20]) hingein(hingepin,20,platethick,10);
  translate([hingepin-platethick,-depth-hingepin,0,]) cube([platethick,depth,width]);
}

module pin(h,t) {
  hingepin=6-tolerance;
  difference() {
    union() {
      cylinder(r=hingepin/2,h=h+t);
      translate([0,0,-t]) cylinder(r=hingepin/2+t,h=t);
    }
    translate([0,hingepin/2+1,h+tolerance]) rotate([90,0,0]) cylinder(r=.5,h=hingepin+2);
  }
}

module print() {
  cameraplate(100,40);
  translate([0,-15,0]) mountplate();
  translate([3,0,-10]) rotate([0,-90,0]) pin(21,3);
  translate([3,20,-10]) rotate([0,-90,0]) pin(21,3);

}

module test() {
  cameraplate(100,40);
  translate([0,0,0]) rotate([0,0,-90]) mountplate(100,50);
  translate([0,0,-tolerance]) pin(21,3);
  translate([0,0,100-20-tolerance]) pin(21,3);
}

test();
//print();