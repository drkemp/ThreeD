
module PostTop()
{
  difference()
  {
    cylinder(r=10,h=8);
    cylinder(r=6,h=6);
  }
}

module TrianglePost(face,height)
{
  difference()
  {
    cube([face,face,h]);
    rotate([0,0,-45]) cube([face,face*1.414,h]);
  }
}
module Beam(size, posn="center")
{
  cube(size);
  if(posn=="center") translate([-size[0],0,0]) cube([3*size[0],size[1]-3,size[0]]);
  if(posn=="left")  translate([-size[0],0,0]) cube([2*size[0],size[1]-2,size[0]]);
  if(posn=="right")  translate([0,0,0]) cube([2*size[0],size[1]-2,size[0]]);
}
module Mount(base, height,width,post,strut)
{
  sideheight=height+10;
  face=20;

  web=1.25;
  brace=sqrt(width*width+post*post)-2;
  angle=atan(post/width);
  difference()
  {
    union()
    {
      //center fill
      cylinder(r=4,h=height);

      // post mount (not adjustable)
      translate([post,0,0]) cylinder(r=9,h=25);
      translate([-post,0,0]) cylinder(r=9,h=25);
      translate([-post,-web/2,0])cube([2*post,web,height]);
      // side webs
      translate([post-web/2,0,0])Beam([web,width-strut,sideheight],"left");
      translate([-post-web/2,0,0])Beam([web,width-strut,sideheight],"right");
      translate([post-web/2,-(width-strut),0])Beam([web,width-strut,sideheight],"left");
      translate([-post-web/2,-(width-strut),0])Beam([web,width-strut,sideheight],"right");

      // ends
      translate([-(post-strut),-width,0])cube([2*(post-strut),web,height]);
      translate([-(post-strut),width,0])cube([2*(post-strut),web,height]);

      // angle braces
      translate([-web/2,0,0]) rotate([0,0,angle]) Beam([web,brace,height]);
      translate([-web/2,0,0]) rotate([0,0,-angle]) Beam([web,brace,height]);
      translate([web,web,0]) rotate([0,0,180-angle]) Beam([web,brace,height]);
      translate([web/2,web,0]) rotate([0,0,-(180-angle)]) Beam([web,brace,height]);

      translate([post+web/2,width-face+web-strut,0]) rotate([0,-90,0]) 
        TrianglePost(face=face,h=web);
      translate([-(post-web/2),width-face+web-strut,0]) rotate([0,-90,0])
        TrianglePost(face=face,h=web);
      translate([post-web/2,-(width-face-strut),0]) rotate([180,-90,0])
        TrianglePost(face=face,h=web);
      translate([-(post+web/2),-(width-face)+strut,0]) rotate([180,-90,0])
        TrianglePost(face=face,h=web);

      translate([-(post+web/2)+face+strut,-(width-web),0]) rotate([180,-90,-90])
        TrianglePost(face=face,h=web);
      translate([-(post+web/2)+face+strut,(width+web),0]) rotate([180,-90,-90])
        TrianglePost(face=face,h=web);
      translate([post+web/2-face-strut,(width),0]) rotate([0,-90,-90])
        TrianglePost(face=face,h=web);
      translate([post+web/2-face-strut,-(width),0]) rotate([0,-90,-90])
        TrianglePost(face=face,h=web);

      translate([-(post-strut/2-web*3/2),-(width-strut),0]) rotate([0,0,90])
        cylinder(r=strut,h=base);
      translate([(post-strut/2-web*3/2),-(width-strut),0]) rotate([0,0,90])
        cylinder(r=strut,h=base);
      translate([(post-strut/2-web*3/2),(width-strut)+web,0]) rotate([0,0,90])
        cylinder(r=strut,h=base);
      translate([-(post-strut/2-web*3/2),(width-strut)+web,0]) rotate([0,0,90])
        cylinder(r=strut,h=base);
    }
    // drill the holes for the posts
    translate([post,0,0]) cylinder(r=6.5,h=17);
    translate([post,0,17]) cylinder(r1=6.5,r2=2,h=8);
    translate([-post,0,0]) cylinder(r=6.5,h=17);
    translate([-post,0,17]) cylinder(r1=6.5,r2=2,h=8);
// tiny slot for tolerance
    translate([-post-.15,0,0]) cylinder(r=6.5,h=17);
    translate([-post-.15,0,17]) cylinder(r1=6.5,r2=2,h=8);

      translate([-(post-strut/2-web*3/2),-(width-strut),0]) rotate([0,0,90])
        cylinder(r=strut/2,h=base);
      translate([(post-strut/2-web*3/2),-(width-strut),0]) rotate([0,0,90])
        cylinder(r=strut/2,h=base);
      translate([(post-strut/2-web*3/2),(width-strut)+web,0]) rotate([0,0,90])
        cylinder(r=strut/2,h=base);
      translate([-(post-strut/2-web*3/2),(width-strut)+web,0]) rotate([0,0,90])
        cylinder(r=strut/2,h=base);
  }
}
module elbow(dia, rad, start,end)
{
  for(i=[start:3:end])
  {
     translate([rad*(1-cos(i)),0,rad*sin(i)])
     rotate([0,i,0]) cylinder(r=dia/2, h=4);
  }
}
module Ring(radius, diam)
{
  rotate_extrude(convexity = 10)
    translate([diam/2, 0, 0])
      circle(r = radius, $fn = 20);
}
module SupportArm(height,strut, post, pipe)
{
  rad=30;
  strut2=strut/2;
  angle=atan((post-strut)/(height-strut-pipe/2));
  zshift=rad*sin(angle);

  rotate([0,0,90])
  {
    elbow(strut*2,rad,0,angle);
    translate([rad*(1-cos(angle)),0,zshift]) rotate([0,angle,0])
        cylinder(r1=strut, r2=strut2,h=height-pipe/2-zshift-strut2);
    translate([post-strut,0,height-pipe/2-zshift+strut2/2])
      rotate([0,-90,180]) elbow(strut2*2,pipe/2+strut2,0,90);
  }
}
module ReelSupport(width,post,strut, height)
{
  face=20;
  web=1.25;
  pipewidth=22.5;
  // a base cylinder to start
  translate([-(post-strut/2-web*3/2),-(width-strut),0]) rotate([0,0,-90])
    SupportArm(height,strut,post,pipewidth);
  translate([(post-strut/2-web*3/2),-(width-strut),0]) rotate([0,0,90])
    SupportArm(height,strut,post,pipewidth);
  translate([(post-strut/2-web*3/2),(width-strut)+web,0]) rotate([0,0,90])
    SupportArm(height,strut,post,pipewidth);
  translate([-(post-strut/2-web*3/2),(width-strut)+web,0]) rotate([0,0,-90])
    SupportArm(height,strut,post,pipewidth);
}

baseheight=22;
strut=5;
postwidth = 82-12;
reelwidth=(95+4*strut)/2;
reelheight=112;
Mount(baseheight,4, reelwidth, postwidth/2, strut);
translate([0,0,baseheight]) ReelSupport(reelwidth, postwidth/2, strut, reelheight);
