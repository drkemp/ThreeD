include <../libraries/threads.scad>;
module hollow_sphere(d_outer, d_inner)
{
  difference()
  {
    sphere(r=d_outer/2);
    sphere(r=d_inner/2);
  }
}

module arm(rot)
{
  translate([0,0,0]) rotate([0,0,rot])
  {
    translate([0,-12,4])cube([2,24,6]);
    difference()
    {
      translate([-2,-12,10])cube([4,24,2]);
      translate([-2,-17,10])rotate([0,0,30]) cube([4,24,2]);
      translate([-6,10,10])rotate([0,0,-30]) cube([4,24,2]);
    }
  }
}
module base()
{
  base_curve=38;
  difference()
  {
    translate([-17.5,-22.5,0])cube([35,45,4]);
    translate([0,0,-(base_curve*.65)]) hollow_sphere(base_curve*3,base_curve*2);
  }
  translate([-1.5,-17,4])cube([3,34,2]);
  translate([15,0,0]) arm(0);
  translate([-15,0,0]) arm(180);
}

difference()
{
  union()
  {
    base();
    translate([-17.5,-22.5,-6])cube([35,45,6]);
  }
  translate([0,0,-6]) english_thread(diameter=0.25, threads_per_inch=20, length=.25,
                      internal=true, n_starts=1);
}