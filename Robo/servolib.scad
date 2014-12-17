
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

