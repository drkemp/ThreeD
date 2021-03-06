include <caseutilities.scad>
include <../libraries/arduino.scad>
$fn=25;

boxwidth=100;         // width of inside of box 
boxdepth=120;         // depth of outside of box
boxheight=40;         // height of inside of box
boxradius=3;          // radius of the box and plate corners
boxthickness=1.25;    // material thickness for box and plates
ribthickness=1.25;    // thickness of the front & back ribs
paneledge=1.0;        // thickness of the inserted edge of front & back panels

riblip=2;             // width of edge around faceplates
standoff_height=7;    // PCB standoffs
standoff_screw_rad=1; // M2 x0.4 screws

postradius=3;         // top radius of mounting posts
postinset=boxdepth/6; // distance the posts are in from the ends
guidewidth=1;         // thickness of the tabs on the sides

// M3 x 0.5 case screws
screwheaddepth=3;   // depth of hole for the screw heads
screwheadradius=2.8; // radius of hole for the screw heads
screwthreadsize=1.5;  // hole size for threads of the case screws
screwclearsize=1.75;  // hole size for clearance of the case screws

arduino_backset=boxdepth/2-ribthickness-boxthickness-15;
arduino_vposition=-(boxheight/2-standoff_height-0.5);
arduino_hposition=-(boxwidth/2-2*postradius-54);

// set the main elements to render
include_keyholes=true;
include_front=false;
include_back=false;
include_top=false;
include_bottom=true;
include_arduino=false;
include_arduino_standoffs=true;


frontHoles=[["C",boxwidth/2-15,(boxheight/2-13),4.5,5],
    ["C",boxwidth/2-15,-(boxheight/2-10),3.0,5],
    ["B",boxwidth/2-27,-(boxheight/2-10),3.6,2,4.17,5,6],
    ["S",arduino_hposition-19,arduino_vposition+2,13,12,5,0],
    ["S",arduino_hposition-47,arduino_vposition+2,10,12,5,0]];
backHoles=[["S",-(boxwidth/2-20),-(boxheight-22),6,18,5,2],
    ["C",boxwidth/2-20,(boxheight/2-14),15.0/2,5],
    ["C",boxwidth/2-31,(boxheight/2-14),2.6/2,5],
    ["C",boxwidth/2-9,(boxheight/2-14),2.6/2,5],
    ];

// ---- Main layout functions

module MountingPosts(inside_size)
{
  postbaseradius = screwheadradius+boxthickness;
  zshift=-(boxheight/2-boxthickness);
  translate([-(boxdepth/2-postinset),boxwidth/2-postradius,zshift])
    TaperPost(inside_size,postbaseradius,boxheight/2+2);
  translate([boxdepth/2-postinset,boxwidth/2-postradius,zshift]) 
    TaperPost(inside_size,postbaseradius,boxheight/2+2);
  translate([-(boxdepth/2-postinset),-(boxwidth/2-postradius),zshift])
    TaperPost(inside_size,postbaseradius,boxheight/2+2);
  translate([boxdepth/2-postinset,-(boxwidth/2-postradius),zshift])
    TaperPost(inside_size,postbaseradius,boxheight/2+2);
}
module MountingPostHoles(inside_size)
{
  translate([-(boxdepth/2-postinset), boxwidth/2-postradius,-(boxheight/2+0.5)])
    cylinder(r=screwheadradius,h=screwheaddepth);
  translate([boxdepth/2-postinset,boxwidth/2-postradius,-(boxheight/2+0.5)])
    cylinder(r=screwheadradius,h=screwheaddepth);
  translate([-(boxdepth/2-postinset), -(boxwidth/2-postradius),-(boxheight/2+0.5)])
    cylinder(r=screwheadradius,h=screwheaddepth);
  translate([boxdepth/2-postinset,-(boxwidth/2-postradius),-(boxheight/2+0.5)])
    cylinder(r=screwheadradius,h=screwheaddepth);
}
module BoxRib()
{
  difference()
  {
    rotate([90,0,90] )
      RoundedBox(boxwidth+boxthickness*2, boxheight, ribthickness, boxradius);
    translate([0,0,riblip+boxthickness]) rotate([90,0,90] )
      RoundedBox(boxwidth-riblip*2, boxheight, ribthickness+1, boxradius);
  }
}
module createOuterbox()
{
  difference()
  {
    translate([0,0, -boxthickness]) rotate([90,0,90])
      RoundedBox(boxwidth+boxthickness*4,boxheight,boxdepth+2,boxradius);
    translate([0,0, 0]) rotate([90,0,90])
      RoundedBox(boxwidth+boxthickness*2, boxheight, boxdepth+4,boxradius);
  }
}

module BoxHalf(addkeyholes, istop)
{
  postgap = postinset-postradius-guidewidth*2 -boxthickness - 2*ribthickness;
  tabstart = guidewidth+boxthickness+2*ribthickness;
  difference()
  {
    union()
    {
      difference()
      {
        rotate([90,0,90])
          RoundedBox(boxwidth+boxthickness*2,boxheight,boxdepth,boxradius);
        translate([0,0, boxthickness]) rotate([90,0,90])
          RoundedBox(boxwidth, boxheight, boxdepth+2,boxradius);
      }
      translate([boxdepth/2,0,0]) BoxRib();
      translate([boxdepth/2-boxthickness-ribthickness,0,0]) BoxRib();
      translate([-(boxdepth/2-boxthickness-ribthickness),0,0]) BoxRib();
      translate([-(boxdepth/2),0,0]) BoxRib();
      MountingPosts(istop ? screwclearsize : screwthreadsize);
    }
    // clean off the mating surface
    translate([0,0,boxheight/4+boxthickness])
      cube([boxdepth+10, boxwidth+10, boxheight/2],true);
    // clean off the outside - remove any leaking bits
    createOuterbox();
    // add mounting screw holes for top
    if(istop) MountingPostHoles();
    if(addkeyholes)
    {
      translate([-(boxdepth/2-postinset),boxwidth/2-postradius*5,-(boxheight/2)])
        Keyhole(4,8,boxthickness*2);
      translate([boxdepth/2-postinset,-(boxwidth/2-postradius*5),-(boxheight/2)])
        Keyhole(4,8,boxthickness*2);
    }
  }
  translate([-(boxdepth-2*(postinset+postradius+guidewidth))/2,-(boxwidth/2),0])
    cube([(boxdepth-2*(postinset+postradius+guidewidth)),guidewidth,3]);
  translate([boxdepth/2-tabstart-postgap,boxwidth/2-guidewidth,0])
    cube([postgap,guidewidth,3]);
  translate([-(boxdepth/2-tabstart),boxwidth/2-guidewidth,0])
    cube([postgap,guidewidth,3]);
}

// Top level objects to render
if(include_arduino)
{
  translate([-arduino_backset,arduino_hposition,arduino_vposition]) Arduino(0,0,0);
}
if(include_arduino_standoffs)
{
  translate([-arduino_backset,arduino_hposition,-(boxheight/2 -0.5)])
    ArdunioStandoffs(standoff_height, standoff_screw_rad, 2.75);
}
if(include_bottom)
{
  BoxHalf(include_keyholes,false);
}
if(include_top)
{
  translate([0,0,boxthickness*2]) rotate([0,180,180]) BoxHalf(false,true);
}
if(include_front)
{
  translate([-(boxdepth/2-ribthickness),0,0])
    BoxPanel(boxwidth-0.25,boxheight-1.5,boxthickness,riblip+1,paneledge,boxradius, frontHoles);
}
if(include_back)
{
  translate([boxdepth/2-ribthickness,0,0])
    BoxPanel(boxwidth-0.25,boxheight-1.5,boxthickness,riblip+1,paneledge,boxradius, backHoles);
}
