$fa=2;

include_symbol="TSTAR"; // CIRCLE,TSTAR, LEAF

module curve_cut(r)
{
  difference()
  {
    cylinder(r=r,h=200);
    translate([0,0,-1]) cylinder(r=r-15,h=202);
  }
}

module symbol_circle()
{
  cylinder(r=7, h=20);
}
module symbol_tstar()
{
  scale([.7,.7,.7])
  {
    translate([-43.5,-58,0]) linear_extrude(height=10)
    {
      import("Startrek.dxf","Layer 2");
    }
  }
}
module symbol_leaf()
{
  scale([.7,.7,.7])
  {
    translate([-43.5,-58,0]) linear_extrude(height=10)
    {
      import("Startrek.dxf","Layer 3");
    }
  }
}
module badge()
{
  scale([.7,.7,.7])
  {
    linear_extrude(height=10)
    {
      import("Startrek.dxf","Layer 1");
    }
    translate([42,48,2]) rotate_extrude()
    {
      translate([30,0,0]) circle(r=2);
    }
  }
}
module symbol()
{
  if(include_symbol=="CIRCLE") symbol_circle();
  if(include_symbol=="TSTAR") symbol_tstar();
  if(include_symbol=="LEAF") symbol_leaf();
}
scale([1, 1, 1])
{
  difference()
  {
    badge();
    translate([0,40,-(230-21)]) rotate([0,90,0]) curve_cut(230);
    translate([30.5,40,4]) symbol();
    translate([30,32,0]) cube([26,6,3],center=true);
  }
  translate([22,32,0]) cylinder(r=1,h=3.1);
  translate([28,32,0]) cylinder(r=1,h=3.1);
  translate([34,32,0]) cylinder(r=1,h=3.1);

}

