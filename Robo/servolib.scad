include</home/david/openscad-2014.03/libraries/MCAD/involute_gears.scad>

rc_width =19.82;
rc_length=52.84;
rc_depth=26.67;
rc_drive_to_bolt1=13.47;
rc_drive_to_bolt2=33.79;
rc_bolt_spacing=10.17;
rc_drive_to_edge1=9.66;
rc_drive_to_edge2=30.22;
rc_bolt_dia=4.38;

module servomount(rc_thick) {
    translate([rc_bolt_spacing/2, rc_drive_to_bolt1, 0]) cylinder(r=rc_bolt_dia/2, h=rc_thick);
    translate([-rc_bolt_spacing/2, rc_drive_to_bolt1, 0]) cylinder(r=rc_bolt_dia/2, h=rc_thick);
    translate([rc_bolt_spacing/2, -rc_drive_to_bolt2, 0]) cylinder(r=rc_bolt_dia/2, h=rc_thick);
    translate([-rc_bolt_spacing/2, -rc_drive_to_bolt2, 0]) cylinder(r=rc_bolt_dia/2, h=rc_thick);
    translate([-rc_width/2, -rc_drive_to_edge2, 0]) 
      cube([rc_width, rc_drive_to_edge1+rc_drive_to_edge2, rc_thick]);
}

module spline(outer, inner, teeth, height, tolerance) {
  circ = outer*3.14159;
  tooth = circ/(teeth*2);
  toothangle = 360/teeth;

    union(){
      cylinder(r=inner/2-tolerance,h=height, $fn=50);
      for(i=[0:teeth]) {
        rotate([0,0,i*toothangle]) translate([-tooth/2,outer/2-tooth/2-tolerance,0])
          cylinder(r=tooth/2,h=height, $fn=20); 
      }
    }

}

module servogear() {
  assythick=4;
  splinedepth=3;
  difference() {
    gear(number_of_teeth=18,circular_pitch=200, clearance=.3,gear_thickness = assythick,
           rim_thickness = assythick, hub_thickness = assythick, bore_diameter=1, $fn=36);
    spline(5.85,5.40,25,splinedepth,-.35);
    cylinder(r=1,h=assythick+1, $fn=20);
  }
}
servogear();
//    spline(5.85,5.40,25,3,.35);
