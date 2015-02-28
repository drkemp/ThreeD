include</home/david/openscad-2014.03/libraries/MCAD/involute_gears.scad>
// grabber claw

module clamp1(ht) {
  difference() {
    union() {
      linear_extrude(height=ht) import("claw3.dxf","Layer 1");
      translate([9.5,4,0]) rotate([0,0,12]) partialgear(15,ht,25);
    }
    translate([13,-6,ht/4]) cube([20,20,ht/2]);
  }
  difference() {
    translate([12,3,ht/4]) cube([8,2,ht/2]);
    translate([18,7,ht/2]) rotate([90,0,0]) cylinder(r=.75,h=5, $fn=20);
  }
  translate([13,0,ht/4])  linear_extrude(height=ht/2) 
           polygon(points=[[0,0],[4,4],[0,8]]);
}

module clamp2(ht) {
  difference() {
    union() {
      linear_extrude(height=ht) import("claw3.dxf","Layer 1");
      translate([9.5,4,0])  partialgear(15,ht,25);
    }
    translate([13,-6,ht/4-.25]) cube([20,20,(ht/2+.5)]);
  }
}

module driver(rad, t, clampt, stickh) {
  difference() {
    union() {
      translate([0,2*t/3,0]) rotate([90,0,0])  cylinder(r1=rad-1, r2=rad,h=t/3,$fn=30);
      translate([0,t/3,0]) rotate([90,0,0])  cylinder(r1=rad, r2=rad,h=t/3,$fn=30);
      translate([0,0,0]) rotate([90,0,0])  cylinder(r1=rad, r2=rad-1,h=t/3,$fn=30);
      translate([0,1,0]) rotate([90,0,0])  cylinder(r=1.5,h=stickh,$fn=20);
      translate([-1.5, -(stickh-1),-(1.414*5)/2]) rotate([45,0,0]) cube([3,5,5]);
    }
    translate([-4,-(stickh+0),0]) rotate([0,90,0])  cylinder(r=.75,h=8,$fn=20);
  }
}

module partialgear(teeth, gearthick,dia) {
//  difference() {
    gear(number_of_teeth=teeth,circular_pitch=200, clearance=.3,gear_thickness = gearthick,
           rim_thickness = gearthick, hub_thickness = gearthick, $fn=36);
//    translate([0,-dia/2,-1]) cube([dia,dia,gearthick+2]);
//  }
}

module post(rout,rin,h) {
  difference() {
    cylinder(r=rout,h=h, $fn=30);
    translate([0,0,-1]) cylinder(r=rin,h=h+2, $fn=30); 
  }
}

module support1(rad,radin, t, clampt, xoff, yoff) {
  difference() {
    translate([rad, yoff+3, 0]) rotate([90, 0, 0])  cylinder(r=rad, h=t, $fn=30);
    translate([rad, yoff+3, 0]) rotate([90, 0, 0])  cylinder(r=radin, h=t, $fn=30);

    translate([0, -2 , (-clampt / 2)-.25]) cube([rad*2 ,t+2, clampt+rad+2]);
    translate([0, -t/2-1.5, -.25]) cube([rad*2 ,t+2, clampt+rad+2]);

    translate([xoff, yoff, (-clampt / 2)-7]) cylinder(r=2.4, h=5, $fn=30);
    translate([xoff, yoff, (-clampt / 2-4)]) cylinder(r=1, h=5, $fn=30);
    translate([2 * rad - xoff, yoff, (-clampt / 2)-7]) cylinder(r=2.4, h=5, $fn=30);
    translate([2 * rad - xoff, yoff, (-clampt / 2-4)]) cylinder(r=1, h=5, $fn=30);

    translate([rad, -1.5, 0]) rotate([90, 0, 0])  cylinder(r=rad-1.5, h=2.5, $fn=50);
    translate([rad, -3, 0]) rotate([90, 0, 0])  cylinder(r=rad-3.25, h=3.5, $fn=50);

  }
  translate([xoff, yoff, (-clampt / 2)-5]) post(2.4, 1, clampt+5.5);
  translate([2 * rad - xoff, yoff, (-clampt / 2)-5]) post(2.4, 1, clampt+5.5);
}

module support2(rad,radin, t, clampt, xoff, yoff) {
  difference() {
    translate([rad, yoff+3, 0]) rotate([90, 0, 0])  cylinder(r=rad, h=t, $fn=30);
    translate([rad, yoff+3, 0]) rotate([90, 0, 0])  cylinder(r=radin, h=t, $fn=30);

    translate([0, -2 /*-t/2+5 */, (-clampt / 2)-.25]) cube([rad*2 ,t+2, clampt+rad+2]);
    translate([0, -t/2-1.5, -.25]) cube([rad*2 ,t+2, clampt+rad+2]);

    translate([xoff, yoff, (-clampt / 2)-7]) cylinder(r=2.4, h=5, $fn=30);
    translate([xoff, yoff, (-clampt / 2-4)]) cylinder(r=1, h=5, $fn=30);
    translate([2 * rad - xoff, yoff, (-clampt / 2)-7]) cylinder(r=2.4, h=5, $fn=30);
    translate([2 * rad - xoff, yoff, (-clampt / 2-4)]) cylinder(r=1, h=5, $fn=30);

//    translate([rad, t+1, -rad+3]) rotate([90, 0, 0])  cylinder(r=1.3, h=t+2, $fn=30);

    translate([rad, -1.5, 0]) rotate([90, 0, 0])  cylinder(r=rad-5, h=4.5, $fn=50);
//    translate([rad, -3, 0]) rotate([90, 0, 0])  cylinder(r=rad-3.25, h=3.5, $fn=50);

  }
}

module arm(dia,len, thick) {
  difference() {
   union() {
    difference() {
      translate([0,len/2,0]) rotate([90,0,0]) cylinder(r=dia/2, h=len, $fn=30);
      translate([-dia - thick/2,-len/2-3,-dia/2]) cube([dia, len, dia]);
      translate([ thick/2,-len/2-3,-dia/2]) cube([dia, len, dia]);
    }
    translate([0,len/2,0]) rotate([90,0,0]) cylinder(r=dia/5, h=len, $fn=30);
   }
//   translate([-dia/4,len/2,0]) rotate([0,90,0]) cylinder(r=dia/4, h=dia/2, $fn=30);
   translate([0,len/2,0]) rotate([90,0,0]) cylinder(r=2.5, h=len, $fn=30);
   translate([-(thick-4),-len/2-1,-3.5]) cube([4, len+2, 7]);
  }
  difference() {
    union() {
      translate([0,len/2+4,0]) rotate([90,0,0]) cylinder(r=dia/2-2, h=2, $fn=50);
      translate([0,len/2+2,0]) rotate([90,0,0]) cylinder(r=dia/2-4, h=2, $fn=50);
    }
    translate([0,len/2+4,0]) rotate([90,0,0]) cylinder(r=dia/4, h=4, $fn=30);
  }    
}
module bearingmount(id,od,len, flange, shaft, offset) {
  difference(){
    translate([0,0,0]) cylinder(r=(od+flange)/2,h=len+4);
    translate([0,0,-3]) cylinder(r=od/2,h=len+1);
    translate([0,0,0]) cylinder(r=id/2+2,h=len+6);
    translate([-offset,0,0]) cylinder(r=shaft/2,h=len+6, $fn=30);
    translate([-offset,0,len-4]) cylinder(r=5,h=len+6, $fn=30);
  }
}
module bearing(id,od,len) {
  difference(){
    translate([0,0,0]) cylinder(r=od/2,h=len);
    translate([0,0,-1]) cylinder(r=id/2,h=len+2);
  }
}
module armend(clampthick, bore,centeroffset, shaft, shaftoffset) {
  bid=7;
  bod=19;
  bthick=7;
  translate([centeroffset,-14,clampthick/2]) rotate([90,0,0]) bearingmount(bid,bod,bthick, 25,shaft,shaftoffset);
  translate([centeroffset,-9,clampthick/2]) rotate([90,0,0])
     gear(number_of_teeth=12,circular_pitch=200, clearance=.3,gear_thickness = 4,
           rim_thickness = 4, hub_thickness = bthick+5, hub_diameter= bid,bore_diameter=bore, $fn=36);
}
module bearings(clampthick, bore,centeroffset, shaft, shaftoffset) {
  bid=7;
  bod=19;
  bthick=7;
  translate([centeroffset,-14,clampthick/2]) rotate([90,0,0]) bearing(bid,bod,bthick);
  translate([centeroffset-shaftoffset,-22,clampthick/2]) rotate([90,15,0]) bearing(5,10,4);
}
module drivegear(clampthick, shaft, centeroffset,shaftoffsetx, shaftoffsety, shaftlen) {
  translate([centeroffset-shaftoffsetx,shaftoffsety,clampthick/2]) rotate([90,15,0])
     gear(number_of_teeth=12,circular_pitch=200, clearance=.3,gear_thickness = 3,
           rim_thickness = 3, hub_thickness = 3.75, hub_diameter= 10,bore_diameter=1, $fn=36);
    translate([centeroffset-shaftoffsetx,shaftoffsety,clampthick/2]) rotate([90,0,0]) cylinder(r=shaft/2,h=shaftlen, $fn=30);
}

module test() {
  clampthick=8;
  supportthick=16;
  armlen=10;
  bore=3;
  outdia=44;
  clampwidth=18;
  outoffset = (outdia-2*clampwidth)/2;

  clamp1(clampthick);
    translate([clampwidth*2,0,clampthick]) rotate([0,180,0]) clamp2(clampthick);

  translate([-outoffset,0,clampthick/2]) support1(outdia/2,bore/2,supportthick,clampthick,13.5,4);
  translate([outdia-outoffset,0,clampthick/2])  rotate([0,180, 0]) support2(outdia/2,bore/2,supportthick,clampthick,13.5,4);

  armend(clampthick,bore,18,5.2,13.5);
//  bearings(clampthick,bore,18,5.2,13.5);
  drivegear(clampthick,4.8,18,13.5,-9.5,25);
/*
  translate([18,-14,clampthick/2]) rotate([90,0,0]) bearing(bid,bod,bthick);
  translate([18,-14,clampthick/2]) rotate([90,0,0]) bearingmount(bid,bod,bthick, 20,5,13.5);
  translate([18,-9,clampthick/2]) rotate([90,0,0])
     gear(number_of_teeth=12,circular_pitch=200, clearance=.3,gear_thickness = 4,
           rim_thickness = 4, hub_thickness = bthick+5, hub_diameter= bid,bore_diameter=bore, $fn=36);
  translate([4.5,-9.5,clampthick/2]) rotate([90,15,0])
     gear(number_of_teeth=12,circular_pitch=200, clearance=.3,gear_thickness = 3,
           rim_thickness = 3, hub_thickness = 3, $fn=36);
*/
//  translate([12,-armlen/2 -5.75 ,clampthick/2]) arm(24,armlen,6);

//  cylinder(r=1,h=20);

}


module print() {
  clampthick=8;
  supportthick=12;
  armlen=10;

  clamp1(clampthick);
  translate([12,0,0]) clamp2(clampthick);
  translate([25,12,7]) rotate([-90,0,0]) support1(12,7,supportthick,clampthick,3.5,4);
  translate([49,18,7]) rotate([90,180,0]) support2(12,7,supportthick,clampthick,3.5,4);

  translate([37,15,2.25]) rotate([-90,0,0])  driver(4.75,3.5,clampthick,11);
  translate([-17,15,9]) rotate([-90,0,0])  arm(24,armlen,6);


//cylinder(r=1,h=20);
}

module printsupport() {
  clampthick=6;
  supportthick=12;
  armlen=10;

  translate([25,12,7]) rotate([-90,0,0]) support1(12,7,supportthick,clampthick,3.5,4);
  translate([49,18,7]) rotate([90,180,0]) support2(12,7,supportthick,clampthick,3.5,4);
  translate([8,15,9]) rotate([-90,0,0])  arm(24,armlen,6);

}

module printdrive() {
  clampthick=6;
  supportthick=12;
  armlen=10;

  translate([37,15,2.25]) rotate([-90,0,0])  driver(4.75,3.5,clampthick,11);

}



test();
//print();
//printsupport();
//printdrive();
