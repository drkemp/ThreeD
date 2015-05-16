
$fn=30;

module hexnut(size, depth) {
  cs=size*2;
  bias=size*1.5;
  difference() 
  {
    cube([size*2,size*2,depth],center=true);
    rotate([0,0, 60]) translate([bias,0,-1]) cube([cs,cs,depth*2],center=true);
    rotate([0,0,120]) translate([bias,0,-1]) cube([cs,cs,depth*2],center=true);
    rotate([0,0,180]) translate([bias,0,-1]) cube([cs,cs,depth*2],center=true);
    rotate([0,0,240]) translate([bias,0,-1]) cube([cs,cs,depth*2],center=true);
    rotate([0,0,300]) translate([bias,0,-1]) cube([cs,cs,depth*2],center=true);
    rotate([0,0,  0]) translate([bias,0,-1]) cube([cs,cs,depth*2],center=true);
  }
}

module plate(l,t) {
  difference() {
    union() {
      hull() {
        translate([-25,0,0]) cube([50,l-25,t]);
        cylinder(r=25,h=t);
      }
    }
    translate([0,50,-1]) cylinder(r=3.75,h=10);
    translate([0,0,-1]) cylinder(r=3.75,h=10);
translate([0,0,2]) hexnut(12,5);
  }
}


plate(100,7);
