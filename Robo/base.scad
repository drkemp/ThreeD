// track base
blength=178;
bwidth=214; //overall width
bheight=90;
bwheel=38;
twidth=41; //track width
tthick=2.5; // track thick

module wheel(rot) {
  ww = twidth-10;
  translate([0,0,twidth/2]) rotate(rot) translate([0,0,-15]){
    difference() {
      cylinder(r=bwheel/2,h=ww);
      translate([0,0,2])cylinder(r=bwheel/2,h=ww-4);
    }
    translate([0,0,5])cylinder(r=2,h=twidth);
  }
}
module drivewheel(rot) {
  ww = twidth-12;
  translate([0,0,twidth/2]) rotate(rot) translate([0,0,-15]){
    difference() {
      cylinder(r=bwheel/2,h=ww);
      translate([0,0,2])cylinder(r=bwheel/2,h=ww-4);
    }
    translate([0,0,5])cylinder(r=2,h=twidth);
  }
}
module track() {
  difference() {
    hull() {
      cylinder(r=bwheel/2+tthick,h=twidth);
      translate([blength-bwheel,0,0]) cylinder(r=bwheel/2+tthick,h=twidth);
      translate([blength-2*bwheel,bwheel*1.25,0]) cylinder(r=bwheel/2+tthick,h=twidth);
    }
    hull() {
      cylinder(r=bwheel/2,h=twidth);
      translate([blength-bwheel,0,0]) cylinder(r=bwheel/2,h=twidth);
      translate([blength-2*bwheel,bwheel*1.25,0]) cylinder(r=bwheel/2,h=twidth);
    }
  }
}
module trackassy(rot) {
//  rot =[0,0,0];
  translate([-(blength-2*bwheel),twidth/2,0])
  rotate([90,0,0]) {
   track();
//    hull() {
      wheel(rot);
      translate([blength-bwheel,0,0]) wheel(rot);
      translate([blength/2-bwheel/2,0,0]) wheel(rot);
      translate([blength-2*bwheel,bwheel*1.25,0])  drivewheel(rot);
//    }
  }
}
module drive() {
  translate([0,0,0])
  rotate([90,0,0]) {
    cylinder(r=17,h=45);
    translate([0,8,-20]) cylinder(r=2,h=45);
//    translate([-15,-10,0]) cube([30,40,3]);
  }
}

module mountbar() {
  translate([0,-2.5,-12]) {
    cube([blength,5,8]);
    translate([30,0,2]) cube([20,5,10]);
    translate([75,0,2]) cube([90,5,10]);
    translate([blength-20,0,2]) cube([20,5,10]);
  }
}
module sideframe() {
 rotate([90,0,0]) linear_extrude(height=2,convexity = 10)
  polygon([[0,0],[160,0],[160,12],[85,38],[85,41],
         [128,69],[135,69],[135,61],[135,61],[160,61],
         [160,82],[28,82],[17,49],[22,41],[22,35],[0,12]]);
}

module mountbase() {
  bedwidth=(bwidth-2*twidth)-20;
//  translate([-blength+bwheel,-bedwidth/2,bheight]) mountbar();
//  translate([-blength+bwheel,bedwidth/2,bheight]) mountbar();
  translate([0,bedwidth/2+5,bwheel]) drive();
  translate([0,-bedwidth/2-5,bwheel]) rotate([0,0,180]) drive();

  translate([-112,-bedwidth/2-4,bheight-20]) cube([blength-46,bedwidth+8,2]);
//  translate([-65,-bedwidth/2,bheight-14]) cube([30,bedwidth,2]);

  translate([0,-(bwidth-twidth)/2,-1.5]) trackassy([0,180,0]);
  translate([0,(bwidth-twidth)/2,-1.5]) trackassy([0,0,0]);

}
// 4 of 18650 battery
module battassy() {
  translate([-38,-65/2,0])
  rotate([-90,0,0]) {
   translate([0,0,0]) cylinder(r=9.1,h=66);
   translate([20,0,0]) cylinder(r=9.1,h=66);
   translate([40,0,0]) cylinder(r=9.1,h=66);
    translate([60,0,0]) cylinder(r=9.1,h=66);
  }
}
module battpack() {
  rotate([0,0,90]) {
    translate([0,0,22]) battassy();
    battassy();
  }
}
module battbox(w,l,t) {
  translate([-w/2,-l/2,-t]) {
    cube([w,l,t]);
  }
}

module tub(h) {
  tubwidth=140;
  tublength=225;
  translate([-tublength/2-40,-tubwidth/2+10,0]) {
    minkowski() {
      cube([tublength,tubwidth-20,h-2]);
      cylinder(r=10,h=2);
    }
  }
}
module frontsupport() {
  bedwidth=(bwidth-2*twidth)-20;
  translate([-120,-bedwidth/2-4,bheight-48]) cube([60,bedwidth+8,2]);
}

module botbase() {
//  translate([0,0,bheight]) tub(35);
  mountbase();
  translate([-70,0,bheight-48]) battbox(85,84,43);
//  translate([0,0,bheight+36]) cylinder(r=70,h=20);
  translate([48,-62,-10]) rotate([0,0,180]) sideframe();
  translate([48,60,-10]) rotate([0,0,180]) sideframe();
}
//translate([0,0,-1]) cylinder(r=1,h=90);

botbase();
translate([-70,9,10 ]) battpack();

frontsupport();

module link() {
  difference() {
    union() {
      cube([3.5,42,5]);
      translate([0,0,2.5]) cube([13,42,2.5]);
    }
    translate([10,4,0]) cube([3,4,10]);
    translate([10,14,0]) cube([3,4,10]);
    translate([10,24,0]) cube([3,4,10]);
    translate([10,34,0]) cube([3,4,10]);

    translate([0,0,0]) cube([3,4,10]);
    translate([0,10,0]) cube([3,4,10]);
    translate([0,20,0]) cube([3,4,10]);
    translate([0,30,0]) cube([3,4,10]);
    translate([0,40,0]) cube([3,4,10]);
  }
}
//link();
