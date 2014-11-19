ringwidth=9;
ringinner=28;
ringouter=32;

support_len=16;
slotwidth=4;

pinlength=11;
pindia=4;
pinhead=1;
pinlock=1.5;
pincase=pinlength-pinhead-pinlock;
pinbump=.45;


$fn=50;
module splitring()
{
  difference()
  {
    union()
    {
      cylinder(r=ringouter/2,h=ringwidth, center=true);
      translate([ringouter/2+support_len-ringwidth/2-1,pincase/2,0])
        rotate([90,0,0]) cylinder(r=ringwidth/2,h=pincase);
      translate([ringouter/2,0,0])
        cube([ringwidth+support_len-ringwidth/2,pincase,ringwidth], center=true);
    }
    translate(0,0,-1) cylinder(r=ringinner/2,h=ringwidth+2, center=true);
    // slice it
    translate([ringouter/2-1,0,-1])
      cube([(ringwidth+support_len)*2,slotwidth,ringwidth+2],center=true);
    // drill the pin hole
    translate([ringouter/2+support_len-ringwidth/2-1,pinlength/2+1,0])
      rotate([90,0,0]) cylinder(r=pindia/2+pinbump,h=pinlength+2);
  }
}

module pin()
{
  translate([0,0,-ringwidth/2])cylinder(r=pindia/2,h=pinlength);
  translate([0,0,-ringwidth/2]) cylinder(r=pindia,h=pinhead);
  translate([0,0,pinlength-ringwidth/2])
    cylinder(r1=pindia/2+pinbump,r2=pindia/2,h=pinlock/2);
  translate([0,0,pinlength-ringwidth/2-pinlock/2])
    cylinder(r2=pindia/2+pinbump,r1=pindia/2,h=pinlock/2);
}

splitring();
pin();