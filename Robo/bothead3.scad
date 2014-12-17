include</home/david/openscad-2014.03/libraries/MCAD/involute_gears.scad>
include</home/david/openscad-2014.03/libraries/MCAD/motors.scad>

basedia=130;
basethick=3;
gearthick=3.5;
idlershaftdia=6;
idlercircledia=79.5;

hubinside=28;
huboutside=35;

tolerance=.35;

module motormount() {
  h=10;
  cylinder(r=11.25,h=h, center=true);
  translate([13,13,0]) cylinder(r=1.5,h=h, center=true);
  translate([13,-13,0]) cylinder(r=1.5,h=h, center=true);
  translate([-13,13,0]) cylinder(r=1.5,h=h, center=true);
  translate([-13,-13,0]) cylinder(r=1.5,h=h, center=true);
}

module outergear() {
  difference() {
    cylinder(r=basedia/2-2-tolerance,h=10,$fn=72);
    gear(number_of_teeth=106,circular_pitch=200, clearance=.3,gear_thickness = gearthick,
           rim_thickness = gearthick, hub_thickness = gearthick, $fn=36);
    cylinder(r=6 ,h=17,$fn=36); // blots the center hole of the gear
    translate([0,0,gearthick]) cylinder(r=basedia/2-5,h=10,$fn=72);
  }
}

module innergear() {
  difference() {
    gear(number_of_teeth=39,circular_pitch=200, clearance=.3, backlash=.1,hub_diameter=huboutside+4,
         gear_thickness = gearthick, rim_thickness = gearthick, hub_thickness = gearthick+2, $fn=25);
    cylinder(r=huboutside/2+tolerance,h=10, $fn=72);
  }
}

module idlergear() {
  gear(number_of_teeth=32,circular_pitch=200, clearance=.3, backlash=.1,bore_diameter=6+2*tolerance,
        gear_thickness = gearthick, rim_thickness =gearthick, hub_thickness = gearthick+2, $fn=36);
}

module idlershaft() {
  cylinder(r=10,h=basethick,$fn=72);
  cylinder(r=idlershaftdia/2-.1,h=10,$fn=72);
}

module driveshaft(isD) {
// 5mm outside, 4.5mm at step
  if(isD) {
    difference() {
      cylinder(r=2.5,h=8, $fn=36);
      translate([3.2,0,4]) cube([2,10,10],center=true);
    }
  } else {
    cylinder(r=2.5,h=8, $fn=36);
  }
}

module drivegear() {
  difference() {
    gear(number_of_teeth=32,circular_pitch=200,bore_diameter=4,clearance=.3, backlash=.1,
       gear_thickness = gearthick, rim_thickness = gearthick, hub_thickness = gearthick+2, $fn=36);
    driveshaft(false);
  }
}
module base() {

  difference() {
    union() {
      difference() {
        cylinder(r=basedia/2,h=10,$fn=72);
        translate([0,0,basethick+2]) cylinder(r=basedia/2-2,h=12,$fn=72);
        translate([0,0,basethick-1]) cylinder(r=basedia/2-5,h=12,$fn=72);
      }
      cylinder(r=20,h=basethick,$fn=72);
      cylinder(r=huboutside/2,h=12,$fn=72);
      translate([idlercircledia/2,0,0]) cylinder(r=23,h=basethick,$fn=72);
    }
    cylinder(r=hubinside/2,h=15,$fn=36);
    translate([idlercircledia/2,0,0])   motormount($fn=72);
  }
  rotate([0,0,45]) translate([idlercircledia/2,0,0]) idlershaft();
  rotate([0,0,165]) translate([idlercircledia/2,0,0]) idlershaft();
  rotate([0,0,-75]) translate([idlercircledia/2,0,0]) idlershaft();
}

module rendering() {
  base();
  translate([0,0,basethick]) {
    translate([idlercircledia/2,0,0]) drivegear();
    rotate([0,0,120]) translate([idlercircledia/2,0,0]) idlergear();
    rotate([0,0,-120]) translate([idlercircledia/2,0,0]) idlergear();
    translate([0,0,2]) outergear();
    innergear();
  }
}

module printgears() {
    translate([34,0,0]) drivegear();
    rotate([0,0,70]) translate([34,0,0]) idlergear();
    rotate([0,0,-70]) translate([34,0,0]) idlergear();
    outergear();
    translate([-20,0,0]) innergear();
}
// outergear();
//rendering();
 base();
// printgears();
