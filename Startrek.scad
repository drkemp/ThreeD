$fa=5;

module curve_cut()
{
  difference()
  {
    cylinder(r=215,h=200);
    translate([0,0,-1]) cylinder(r=200,h=215);
  }
}
module badge()
{
  linear_extrude(height=10)
  {
    import("Startrek.dxf","Layer 1");
  }
  translate([42,48,2]) rotate_extrude()
  {
    translate([34,0,0]) circle(r=2);
  }
  translate([38,53,0]) cube([11,36,15]);
  translate([32,40,0]) cube([22,36,15]);
}

difference()
{
  badge();
  translate([0,45,-190]) rotate([0,90,0]) curve_cut();
}

