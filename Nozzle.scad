include <../libraries/threads.scad>

$fn=25;

module hexblock(width, length)
{
  difference()
  {
    cube([width,width,length],true);
    rotate([0,0,45]) translate([width,0,0]) cube([width,width,length],true);
    rotate([0,0,45]) translate([-width,0,0]) cube([width,width,length],true);
    rotate([0,0,-45]) translate([width,0,0]) cube([width,width,length],true);
    rotate([0,0,-45]) translate([-width,0,0]) cube([width,width,length],true);
  }
}

// 1/8NPT = 27tpi, 10 threads, 0.405"OD
module NPT_fitting(flength)
{
  mlength=flength*25.4;
//  translate([0,0,-mlength/2])
  difference()
  {
    hexblock(7/16*25.4,mlength);
    translate([0,0,-mlength/2-1])cylinder(r=.125*25.4,h=mlength+3);
    english_thread(diameter=.405,threads_per_inch=27,length=flength,internal=true);
  }
}
module pipe(inside,outside,length)
{
  difference()
  {
    cylinder(r=outside/2,h=length);
    cylinder(r=inside/2,h=length+2);
  }
}
module base(depth,height,width)
{
  nozrad=1.5;
  nozinsiderad=0.75;
  nozlen=10;
  fitposn=width/2-depth/2;
  nozposn=-(width/2-nozrad);
  translate([0,0,height/2])
  difference()
  {
    union()
    {
       cube([depth,width,height],true);
       translate([0,fitposn,height/2+4]) NPT_fitting(3/8);
       translate([0,nozposn,height/2]) cylinder(r=nozrad,h=10);
       translate([0,0,-4]) cube([depth,width,4],true);
    }
    union()
    {
       translate([0,fitposn,-(height/2)]) cylinder(r=3,h=height+2);
       translate([0,nozposn,-(height/2)]) cylinder(r=nozinsiderad,h=height+nozlen+2);
       translate([0,fitposn,-height/2]) rotate([90,0,0]) cylinder(r1=nozrad, r2=nozinsiderad,h=fitposn-nozposn);
    }
  }
}
base(7/16*25.4,4,35);
