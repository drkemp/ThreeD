pipedia=23; //mm ~ 3/4 copper
holespace=1.25*25.4;
margin=4;
thickness=3;
supportlen=20;

module hanger() {
  difference() {
    union() {
      hull(){
        translate([5,0,0]) cylinder(r=holespace/2+margin, h=thickness);
        translate([-5,0,0]) cylinder(r=holespace/2+margin, h=thickness);
      }
      translate([3,0,0]) cylinder(r=pipedia/2+2, h=supportlen);
    }
    translate([5,0,thickness]) cylinder(r=pipedia/2, h=supportlen);
    translate([3,-pipedia/2,thickness]) cube([pipedia,pipedia,supportlen]);

    translate([holespace/2,0,0]) cylinder(r1=3, r2=5, h=thickness);
    translate([-holespace/2,0,0]) cylinder(r1=3, r2=5, h=thickness);
  }
  //  translate([0,-pipedia/2,thickness]) cube([pipedia,pipedia,supportlen]);
}


hanger();
