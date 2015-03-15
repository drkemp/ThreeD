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
    translate([18,7,ht/2]) rotate([90,0,0]) cylinder(r=.75,h=5, $fn=60);
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


module partialgear(teeth, gearthick,dia) {
//  difference() {
    gear(number_of_teeth=teeth,circular_pitch=200, clearance=.3,gear_thickness = gearthick,
           rim_thickness = gearthick, hub_thickness = gearthick, bore_diameter=5.1, $fn=60);
//    translate([0,-dia/2,-1]) cube([dia,dia,gearthick+2]);
//  }
}

module post(rout,rin,h) {
  difference() {
    cylinder(r=rout,h=h, $fn=60);
    translate([0,0,-1]) cylinder(r=rin,h=h+2, $fn=60); 
  }
}

module support1(rad,radin, t, clampt, xoff, yoff, shaftdia=7, shaftlen=7) {
  holedepth=21;
  difference() {
    translate([rad, yoff+3, 0]) rotate([90, 0, 0])  cylinder(r=rad, h=t, $fn=60);
    translate([rad, yoff+3, 0]) rotate([90, 0, 0])  cylinder(r=radin, h=t, $fn=60);

    translate([0, -2 , (-clampt / 2)-.25]) cube([rad*2 ,t+2, clampt+rad+2]);
    translate([0, -t/2-1.5, -.25]) cube([rad*2 ,t+2, clampt+rad+2]);
    translate([5, -6.5 , (-clampt / 2)-.25]) cube([rad*2-10 ,t+2, clampt+rad+2]);

    translate([xoff, yoff, (-clampt / 2)-(holedepth+3)]) cylinder(r=2.4, h=holedepth, $fn=60);
    translate([xoff, yoff, (-clampt / 2-4)]) cylinder(r=1, h=holedepth, $fn=60);
    translate([2 * rad - xoff, yoff, (-clampt / 2)-(holedepth+3)]) cylinder(r=2.4, h=holedepth, $fn=60);
    translate([2 * rad - xoff, yoff, (-clampt / 2-4)]) cylinder(r=1, h=holedepth, $fn=60);

  }
  difference(){
    union() {
      translate([rad, -6.5, 0]) rotate([90, 0, 0])  cylinder(r=8, h=2.5, $fn=60);
      translate([rad-4,-7,(-clampt / 2)])  linear_extrude(height=10) 
           polygon(points=[[0,0],[8,0],[4,4]]);
    }
    translate([rad, 2, 0]) rotate([90, 0, 0])  cylinder(r=radin, h=30, $fn=60);
  }


  translate([xoff, yoff, (-clampt / 2)-5]) post(2.4, 1, clampt+5.5);
  translate([2 * rad - xoff, yoff, (-clampt / 2)-5]) post(2.4, 1, clampt+5.5);

  translate([rad,-8,0]) rotate([90,0,0])
     gear(number_of_teeth=12,circular_pitch=200, clearance=.3,gear_thickness = 5, rim_thickness=5,
            hub_thickness=shaftlen+6, hub_diameter= shaftdia,bore_diameter=radin*2, $fn=60);

}

module support2(rad,radin, t, clampt, xoff, yoff) {
  holedepth=21;
  difference() {
    translate([rad, yoff+3, 0]) rotate([90, 0, 0])  cylinder(r=rad, h=t, $fn=60);
    translate([rad, yoff+3, 0]) rotate([90, 0, 0])  cylinder(r=radin, h=t, $fn=60);

    translate([0, -2 /*-t/2+5 */, (-clampt / 2)-.25]) cube([rad*2 ,t+2, clampt+rad+2]);
    translate([0, -t/2-1.5, -.25]) cube([rad*2 ,t+2, clampt+rad+2]);

    translate([xoff, yoff, (-clampt / 2)-(holedepth+3)]) cylinder(r=2.4, h=holedepth, $fn=60);
    translate([xoff, yoff, (-clampt / 2-4)]) cylinder(r=1, h=holedepth, $fn=60);
    translate([2 * rad - xoff, yoff, (-clampt / 2)-(holedepth+3)]) cylinder(r=2.4, h=holedepth, $fn=60);
    translate([2 * rad - xoff, yoff, (-clampt / 2)-3]) cylinder(r=1, h=holedepth, $fn=60);

    translate([5, -6.5 , (-clampt / 2)-.25]) cube([rad*2-10 ,t+2, clampt+rad+2]);
//    translate([rad, -1.5, 0]) rotate([90, 0, 0])  cylinder(r=rad-5, h=4.5, $fn=50);
  }
}

module bearingmount(id,od,len, flange, shaft, offset) {
  difference(){
    translate([0,0,0]) cylinder(r=flange/2,h=len+4, $fn=60);
    translate([0,0,-3]) cylinder(r=od/2,h=len+1, $fn=60);
    translate([0,0,0]) cylinder(r=id/2+2,h=len+6, $fn=60);
    translate([-offset,0,0]) cylinder(r=shaft/2,h=len+6, $fn=60);
    translate([-offset,0,len-4]) cylinder(r=5,h=len+6, $fn=60);
  }
  difference() {
    translate([0,0,-5]) cylinder(r=flange/2+2,h=7, $fn=60);
    translate([0,0,0 -6]) cylinder(r=flange/2,h=9, $fn=60);
  }
}
module bearing(id,od,len) {
  difference(){
    translate([0,0,0]) cylinder(r=od/2,h=len);
    translate([0,0,-1]) cylinder(r=id/2,h=len+2);
  }
}
module armend(clampthick, bore,centeroffset, shaft, shaftoffset) {
  bid=8;
  bod=22;
  bthick=7;
  translate([centeroffset,-14,clampthick/2]) rotate([90,0,0]) bearingmount(bid,bod,bthick, 44.5,shaft,shaftoffset);

}
module bearings(clampthick, bore,centeroffset, shaft, shaftoffset) {
  bid=8;
  bod=22;
  bthick=6;
  translate([centeroffset,-14,clampthick/2]) rotate([90,0,0]) bearing(bid,bod,bthick);
  translate([centeroffset-shaftoffset,-22,clampthick/2]) rotate([90,15,0]) bearing(5,10,4);
}
module drivegear(clampthick, shaft, centeroffset,shaftoffsetx, shaftoffsety, shaftlen) {
  translate([centeroffset-shaftoffsetx,shaftoffsety,clampthick/2]) rotate([90,15,0])
     gear(number_of_teeth=12,circular_pitch=200, clearance=.3,gear_thickness = 3,
           rim_thickness = 3, hub_thickness = 3.75, hub_diameter= 10,bore_diameter=1, $fn=60);
    translate([centeroffset-shaftoffsetx,shaftoffsety,clampthick/2]) rotate([90,0,0]) cylinder(r=shaft/2,h=shaftlen, $fn=60);
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

//  translate([-outoffset,0,clampthick/2]) support1(outdia/2,bore/2,supportthick,clampthick,13.5,4,8,16);
  translate([outdia-outoffset,0,clampthick/2])  rotate([0,180, 0]) support2(outdia/2,9,supportthick,clampthick,13.5,4);

  armend(clampthick,bore,18,5.2,13.5);
//  bearings(clampthick,bore,18,5.2,13.5);
  drivegear(clampthick,4.8,18,13.5,-9.5,25);

//  cylinder(r=1,h=20);

}


module print() {
  clampthick=8;
  supportthick=16;
  armlen=10;
  bore=3;
  outdia=44;
  clampwidth=18;

  clamp1(clampthick);
  translate([clampwidth+4,0,0]) clamp2(clampthick);
  translate([clampwidth*2+6,12,7]) rotate([-90,0,0]) support1(outdia/2,bore/2,supportthick,clampthick,13.5,4,7,16);
  translate([clampwidth*2+6+0,18,7+2]) rotate([90,00,0]) support2(outdia/2,9,supportthick,clampthick,13.5,4);

  translate([4,-18,-9.5]) rotate([-90,0,0])  drivegear(clampthick,4.8,18,13.5,-9.5,25);
  translate([18,-30,25]) rotate([90,0,0])   armend(clampthick,bore,18,5.2,13.5);


//cylinder(r=1,h=20);
}

module printsupports() {
  clampthick=8;
  supportthick=16;
  armlen=10;
  bore=3;
  outdia=44;
  clampwidth=18;

  translate([clampwidth*2+2,12,7]) rotate([-90,0,0]) support1(outdia/2,bore/2,supportthick,clampthick,13.5,4,7,16);
  translate([70,-18,9]) rotate([-90,180,90]) support2(outdia/2,9,supportthick,clampthick,13.5,4);
  translate([20,-35,25]) rotate([90,0,0])   armend(clampthick,bore,18,5.2,13.5);


}

module printdrive() {
  clampthick=8;
  supportthick=16;
  armlen=10;
  bore=3;
  outdia=44;
  clampwidth=18;
  translate([5,-0,4]) rotate([0,0,0])  drivegear(clampthick,4.8,18,13.5,-9.5,25);
}

module printclamps() {
  clampthick=8;
  supportthick=16;
  armlen=10;
  bore=3;
  outdia=44;
  clampwidth=18;

  clamp1(clampthick);
  translate([clampwidth+5,0,0]) clamp2(clampthick);

}

//test();
print();
//printsupports();
//printclamps();
//printdrive();

