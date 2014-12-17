include  <ringlib.scad>
include <../caseutilities.scad>

module body_L2() {
  dia=130;
  thick=2;
  height=40;

  pcb_height=18;
  sleeve(dia,dia-2*thick,height);

  // baseplate and Arduino pcb mount
  translate([-10,15,2]) ArdunioStandoffs(5, 1, 2.75);
  circleplate(dia/2,2,dia-30,dia,-25,-dia/2);

  //PCB mounts
  rotate([0,0,0])translate([dia/2-thick,0,pcb_height]) support(8,8,12,true);
  rotate([0,0,90])translate([dia/2-thick,0,pcb_height]) support(8,8,12,true);
  rotate([0,0,-90])translate([dia/2-thick,0,pcb_height]) support(8,8,12,true);
  rotate([0,0,45])translate([dia/2-thick,0,pcb_height]) support(8,8,12,true);
  rotate([0,0,-45])translate([dia/2-thick,0,pcb_height]) support(8,8,12,true);
  rotate([0,0,135])translate([dia/2-thick,0,pcb_height]) support(8,8,12,true);
  rotate([0,0,-135])translate([dia/2-thick,0,pcb_height]) support(8,8,12,true);
  rotate([0,0,180])translate([dia/2-thick,0,pcb_height]) support(8,8,12,true);
}

body_L2($fa=6);

