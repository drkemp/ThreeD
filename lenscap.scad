
module lenscap (id, thick, ridge, depth)
{
  $fn=50;
  difference() {
    cylinder(r=id/2+thick,h=depth);
    translate([0,0,-thick]) cylinder(r=id/2-1,h=depth);
    translate([0,0,-thick-ridge]) cylinder(r=id/2,h=depth);
  }
  translate([id/2,0,0]) cylinder(r=.25,h=depth);
  translate([-id/2,0,0]) cylinder(r=.25,h=depth);
  translate([0,id/2,0]) cylinder(r=.25,h=depth);
  translate([0,-id/2,0]) cylinder(r=.25,h=depth);
}


lenscap(19, 1.5, 2, 9);
