module post(d,h) {
  postr=d/2;
  difference(){
    cylinder(r=postr, h=h);
    translate([0,0,+4]){
      cylinder(r=postr-4,h=h+3);
      for(i = [0:19]) {
        rotate([0,0,i*360/20]) translate([postr-.2,0,0]) cylinder(r=1,h=h);
      }
    }
  }
}

post(26.5,25);