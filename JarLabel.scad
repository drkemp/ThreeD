outerlength=140;
outerwidth=85;

length=120;
width=65;
thick=.7;
scallop=10;
radius=width/3;

module ex(points)
{
  linear_extrude(height=thick, convexity=10)
    polygon(points);
}
module corner(thickness)
{
  translate([0,width/2-15,0])
  linear_extrude(height=thickness, convexity=10)
  import("profile.dxf",layer="Layer_1");
}

module profile()
{
  corner(thick);
  mirror([1,0,0]) corner(thick);
}
module base()
{
  translate([-(length/2-radius),-radius,0]) cube([length-2*radius,radius*2,thick]);
  translate([length/2-radius,0,0]) cylinder(r=radius,h=thick);
  translate([-(length/2-radius),0,0]) cylinder(r=radius,h=thick);

  profile();
  mirror([0,1,0]) profile();
}
module labelshape()
{
  difference()
  {
    base();
    translate([length/4,width,0]) cylinder(r=scallop,h=thick);
  }
}

difference()
{
  translate([-(outerlength/2),-outerwidth/2,0]) cube([outerlength,outerwidth,thick]);
  labelshape();
}
