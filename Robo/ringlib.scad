module sleeve(od,id,h) {
  difference() {
   cylinder(r=od/2,h=h);
   cylinder(r=id/2,h=h);
  }
}

module halfdome(dia,thick) {
   difference() {
     sphere(r=dia/2);
     sphere(r=(dia-2*thick)/2);
     translate([-dia/2,-dia/2,-dia]) cube([dia,dia,dia]);
   }
}

module suspendedring(od,id,h,outside) {
  w = (od-id)/2;
  points_outside=[[0,h],[-w,h],[-w,w],[0,0]];
  points_inside=[[0,h],[-w,h],[-w,0],[0,w]];
  if(outside) {
    rotate_extrude() translate([od/2,0,0]) polygon(points_outside);
  } else {
    rotate_extrude() translate([od/2,0,0]) polygon(points_inside);
  }
}

module circleplate(r,t,w,h,wo,ho) {
  difference() {
   translate([wo,ho,0])cube([w,h,t]);
   difference() { cylinder(r=r+50,h);cylinder(r=r,h);}
  }
}

module support(width,depth,height, hashole) {
  points=[[0,height],[-depth,height],[-depth,depth],[0,0]];
  if(hashole) {
    difference() {
      rotate([90,0,0]) linear_extrude(height=width) polygon(points);
      translate([-width/2,-depth/2,3]) cylinder(r=1,h=height);
    }
  } else {
    rotate([90,0,0]) linear_extrude(height=width) polygon(points);
  }
}
module connectionring(dia,thick,height,lap){
  translate([0,0,lap-2]) {
    translate([0,0,height-4]) suspendedring(dia+2*thick,dia,lap+2,false);
    suspendedring(dia+.01,dia-2*thick,height,true);
    translate([0,0,4]) rotate([0,180,0]) suspendedring(dia+2*thick,dia,lap+2,false);
  }
}
module washer(out,in,thick) {
  difference() {
    cylinder(r=out/2,h=thick,center=true);
    cylinder(r=in/2,h=thick+.1,center=true);
  }
}

module testringlib(){
  suspendedring(124,120,5,false);
  translate([0,0,-10]) sleeve(124,120,5);
  translate([0,0,10]) halfdome(124,2.5);
  translate([0,0,-60]) connectionring(124,2,12,5, $fa=5);
  washer(10,3,1.5);
}

//testringlib();
