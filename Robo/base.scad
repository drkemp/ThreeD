// track base
blength=210;
bwidth=225;
bheight=90;
bwheel=55;
twidth=50;

module track() {
  translate([-(blength-1.75*bwheel),twidth/2,bwheel/2])
  rotate([90,0,0]) {
    hull() {
      cylinder(r=bwheel/2,h=twidth);
      translate([blength-bwheel,0,0]) cylinder(r=bwheel/2,h=twidth);
      translate([blength-1.75*bwheel,bwheel/2,0]) cylinder(r=bwheel/2,h=twidth);
    }
  }
}
module drive() {
  translate([0,0,0])
  rotate([90,0,0]) {
    cylinder(r=10,h=45);
    translate([0,0,-20]) cylinder(r=2,h=45);
    translate([-15,-10,0]) cube([30,40,3]);
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
module mountbase() {
  bedwidth=(bwidth-2*twidth)-20;
  translate([-blength+bwheel,-bedwidth/2,bheight]) mountbar();
  translate([-blength+bwheel,bedwidth/2,bheight]) mountbar();
  translate([0,bedwidth/2+5,bwheel]) drive();
  translate([0,-bedwidth/2-5,bwheel]) rotate([0,0,180]) drive();
  translate([-145,-bedwidth/2,bheight-14]) cube([20,bedwidth,2]);
  translate([-65,-bedwidth/2,bheight-14]) cube([30,bedwidth,2]);

  translate([0,-(bwidth-twidth)/2,0]) track();
  translate([0,(bwidth-twidth)/2,0]) track();

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

module botbase() {
  translate([0,0,bheight]) tub(35);
  mountbase();
  translate([-80,0,bheight-14]) battbox(125,110,45);
  translate([0,0,bheight+36]) cylinder(r=70,h=20);

}
//translate([0,0,-1]) cylinder(r=1,h=90);

botbase();
translate([-120,9,42 ]) battpack();

