module spline(outer, inner, teeth, height, tolerance) {
  circ = outer*3.14159;
  tooth = circ/(teeth*2);
  toothangle = 360/teeth;

  difference() {
    union(){
      cylinder(r=inner/2,h=height, $fn=50);
      for(i=[0:teeth]) {
        rotate([0,0,i*toothangle]) translate([-tooth/2,1,0]) cube([tooth,outer/2,height]);
      }
    }
    difference() {
      cylinder(r=outer,h=height, $fn=50);
      cylinder(r=outer/2,h=height, $fn=50);
    }
  }
}

spline(5.85,5.45,25,6,0);