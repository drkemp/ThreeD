$fn=50;

module ARCA_Plate(length)
{
  width=40;
  thickness=6;

  translate([-length/2,-width/2,-thickness])
  {
    difference()
    {
      cube([length,width,thickness]);
      translate([0,0,0]) rotate([45,0,0])
        cube([length,thickness*2,thickness*3]);
      translate([0,width-thickness,thickness]) rotate([-45,0,0])
        cube([length,thickness*2,thickness*3]);
      translate([length/2,width/2-8.9,0]) cylinder(r=2.1,h=4);
      translate([length/2,width/2-9.3,0]) cylinder(r=2.1,h=4);
      translate([length/2,width/2,0]) cylinder(r=6.2,h=1);
    }
  }
}
module cutbox(width,depth)
{
  difference()
  {
    cube([width+10,width+10,depth], center=true);
    cube([width,width,depth], center=true);
  }
}
module hex(width, face)
{
  difference()
  {
    cube([face,face,width], center=true);
    rotate([0,0,45]) cutbox(face,width);
  }
}

GP_width=15;
GP_Post=3.3;
GP_Dia=15.5;
GP_Slot=3.0;
GP_Hole=5.2;
GP_Boss=3;

length=50;
width=22;
thickness=1;

module GPMount()
{
  translate([-GP_width/2,0,GP_Post+GP_Dia/2])
  difference()
  {
    union()
    {
      rotate([0,90,0]) cylinder(r=GP_Dia/2,h=GP_width);
      translate([0,-GP_Dia/2, -(GP_Post+GP_Dia/2)])
        cube([GP_width,GP_Dia,GP_Dia/2+GP_Post]);
      translate([-GP_Boss,0,0]) rotate([0,90,0]) cylinder(r=13/2,h=GP_Boss);
    }
    translate([GP_width/2+GP_Slot/2,-GP_Dia/2,-GP_Dia/2])
      cube([GP_Slot,24,GP_Dia]);
    translate([GP_width/2-GP_Slot*3/2,-GP_Dia/2,-GP_Dia/2])
      cube([GP_Slot,24,GP_Dia]);
    translate([-GP_Boss,0,0])  rotate([0,90,0])
      cylinder(r=GP_Hole/2,h=GP_width+GP_Boss+1);
    translate([-(GP_Boss+0.01),0,0]) rotate([0,90,0]) hex(4,8);
  }
}

module GoPro()
{
  ARCA_Plate(length);
  rotate(90,0,0) GPMount();
  translate([0,0,-6]) cylinder(r=1.25,h=1);
}

module generic()
{
  difference()
  {
    union()
    {
      ARCA_Plate(length);
      cube([50,28,5.5], center=true);
    }
    translate([0,0,-5]) cylinder(r=25.4/8,h=15);
    translate([0,0,-6]) cylinder(r=6.5,h=5);
  }
  translate([0,0,-6]) cylinder(r=2.5,h=4.9);
}

GoPro();
translate([-length-5,0,0]) generic();