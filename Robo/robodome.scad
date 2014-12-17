include  <ringlib.scad>

module cameramount(rad, angle) {
  r =rad-7;
  offset_y = -r*sin(angle);
  offset_z = r*cos(angle);
  outside=58;
  inside=33;
  height=60;
  screwoffset=(outside-inside)/2-3;
  translate([0,offset_y,offset_z] ) rotate([angle,0,0])
  translate([-outside/2,-height/2,0] )
  difference() {
    cube([outside,height,7]);
    translate([(outside-inside)/2,0,0]) cube([inside,height,4]);
    translate([screwoffset,height/2,0]) cylinder(r=1,h=4);
    translate([outside-screwoffset,height/2,0]) cylinder(r=1,h=4);
  }
}

module micmount(rad, angle1,angle2) {
  padthick=6;
  r =rad-padthick/2;
  offset_x = r*sin(angle1);
  offset_z = r*cos(angle1);
  pad=60;
  mount=8;
  translate([offset_x,0,offset_z] ) rotate([angle1,0,angle2])
  translate([0,0,padthick/2])
  difference() {
    cube([pad,pad,padthick],center=true);
    cylinder(r=mount/2,h=padthick,center=true);
  }
}

module dome(dia,thick) {
  $fa=6;
  camera_angle=60;
  mic_angle=45;
  difference() {
    union() {
      halfdome(dia,thick);
      translate([0,0,4]) sleeve(126,122,4);
      cameramount(dia/2-thick,camera_angle);
      micmount(dia/2-thick,mic_angle,90);
    }
    // lens hole
    rotate([camera_angle,0,0]) cylinder(r=22/2,h=dia);
    // mic hole
    rotate([mic_angle,0,90]) cylinder(r=1,h=dia);
  }
}

module head() {
  difference() {
    dome(130,2);
    halfdome(130+30,15);
  }
}

head();
//cube([1,1,1],center=true);

