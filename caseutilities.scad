//

module RoundedBox(width,height,thickness,radius)
{
   cube([width-2*radius,height,thickness],true);  
   cube([width,height-2*radius,thickness],true);  
   translate([radius-width/2,radius-height/2,0])
     cylinder(r=radius, h=thickness, center=true);
   translate([radius-width/2,height/2-radius,0])
     cylinder(r=radius, h=thickness, center=true);
   translate([width/2-radius,height/2-radius,0])
     cylinder(r=radius, h=thickness, center=true);
   translate([width/2-radius,radius-height/2,0])
     cylinder(r=radius, h=thickness, center=true);
}

module Standoff(length, inside, outside)
{
  difference()
  {
    cylinder(r1=outside+1, r2=outside, h=length);
    cylinder(r=inside, h=length);
  }
}
module DrillHoles(holelist){
  for(i=holelist){
    if(i[0]=="C") translate([i[1],i[2],0]) cylinder(r=i[3],h=i[4]);
    if(i[0]=="S") translate([i[1],i[2],0]) cube([i[3],i[4],i[5]]);
  }
}
module BoxPanel(width, height, thickness, edge, edgethickness, radius, holelist)
{
  shim=(thickness-edgethickness)/2;
  difference()
  {
    union()
    {
      translate([0,0,0]) rotate([90,0,90])
        RoundedBox(width-edge*2,height-edge*2,thickness,radius);
      translate([-shim,0,0]) rotate([90,0,90])
        RoundedBox(width,height,edgethickness,radius);
    }
    translate([-2,0,0]) rotate([90,0,90]) DrillHoles(holelist);
  }
}

module TaperPost(inside, outside, height)
{
  difference()
  {
    union()
    {
      cylinder(r=outside-0.75, h=height);
      translate([0,0,outside]) cylinder(r1=outside, r2=outside-0.75, h=height/2-outside);
      cylinder(r=outside, h=outside);
    }
    cylinder(r=inside, h=height);
  }
}
module Keyhole(holesize, headsize, material)
{
  translate([0,0,0.25]) RoundedBox(headsize,holesize,material,holesize/2);
  translate([headsize/2,0,-0.25]) cylinder(r=headsize/2, h=material);
}
module ArdunioStandoffs(length, inside, outside)
{
  Standoff(length, inside, outside);
  translate([-1.1, -48.40, 0]) Standoff(length, inside, outside);
  translate([51, -15.25, 0]) Standoff(length, inside, outside);
  translate([51, -43.25, 0]) Standoff(length, inside, outside);
}


