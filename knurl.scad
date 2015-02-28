include <../libraries/threads.scad>;

module cutter(dia, depth, height,twist) {
  function x1(a)= dia/2*cos(a);
  function y1(a)= dia/2*sin(a);
  function x2(a)= (depth+dia/2)*cos(a);
  function y2(a)= (depth+dia/2)*sin(a);
  kpoints = [[x1(0),y1(0)],[x2(15),y2(15)],[x1(30),y1(30)],[x2(45),y2(45)],[x1(60),y1(60)],[x2(75),y2(75)],
            [x1(90),y1(90)],[x2(105),y2(105)],[x1(120),y1(120)],[x2(135),y2(135)],[x1(150),y1(150)],[x2(165),y2(165)],
            [x1(180),y1(180)],[x2(195),y2(195)],[x1(210),y1(210)],[x2(225),y2(225)],[x1(240),y1(240)],[x2(255),y2(255)],
            [x1(270),y1(270)],[x2(285),y2(285)],[x1(300),y1(300)],[x2(315),y2(315)],[x1(330),y1(330)],[x2(345),y2(345)]];

  ratio = (PI*dia/24)/depth;
  echo(ratio);
  ktwist = twist * 45 * ratio;

  linear_extrude(height = height, center = true, convexity = 10, twist = ktwist) polygon(points=kpoints );
}

module knurl(inside, outside, depth, height) {
 difference(){
   cutter(outside-depth,depth, height, 1);
   difference() {
     cylinder(r=outside+1,h=height+1, center = true);
     cutter(outside-depth,depth, height,-1);
   }
   translate([0,0,-1]) cylinder(r=inside/2,h=height+2, center = true);
 }
}

module cone(d1,d2,thick,len) {
  difference(){
    cylinder(r1=d1/2,r2=d2/2, h=len, center=true);
    translate([0,0,-1]) cylinder(r1=(d1-thick)/2,r2=(d2-thick)/2, h=len+2, center=true);
  }
}

module sleeve(dia,h, id, hc) {
  pitch=2.5;
  difference(){
    cylinder(r=dia/2+pitch,h=h, center = true);
    translate([0,0,-h/2-1]) metric_thread(diameter=dia, pitch=pitch, length=h+2, internal=true, n_starts=1);
  }
  knurl(dia+pitch+2,dia+pitch+4,1.25,h);
  translate([0,0,(h+hc)/2]) cone(dia+pitch+4,id,5,hc);
}
module cross(h){
  translate([-.5,-h/2,-h/2]) cube([1,h,h]);
  translate([-h/2,-.5,-h/2]) cube([h,1,h]);
}
module post(dia,h,india,hc) {
  pitch=2.5;
  tol=.8;
  rdia=dia-tol*2;
  difference() {
    union() {
      translate([0,0,-h/2]) metric_thread(diameter=rdia, pitch=pitch, length=h, internal=false, n_starts=1);
      translate([0,0,(h+hc)/2]) cone(dia-2*pitch,india+1.5,7,hc);
      translate([0,0,(h+hc)/2+5]) cone(dia-2*pitch-2,india+1.5,4,hc+1);
    }
    translate([0,0,h+hc-7])cross(25);
    translate([0,0,15]) cylinder(r=india/2,h=h+hc+5, center=true);
  }
  translate([0,0,-h/2-9]) cylinder(r=(dia+6)/2,h=10);
// translate([0,0,15]) cylinder(r=india/2,h=h+hc+5, center=true);
}
//sleeve(18,18,9.5,18);

  translate([-20,-15,9]) post(18,18,5.8,15);

