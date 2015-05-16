out=95.5;
in = 91;
step =3.5;
footthick=1;

material = (out-in)/2;
margin=4;
stripwidth=17;
stripthick = footthick+step+1;
basewidth = out+margin*2;

module front_base(){
  difference() {
   cube([stripwidth,basewidth,stripthick]);
   translate([0,margin,footthick]) cube([stripwidth+2,material+.5, stripthick]);
   translate([0,basewidth-margin-material,footthick]) cube([stripwidth+2,material+.5, stripthick]);

   translate([stripwidth-margin-material,margin,footthick]) cube([material+.5,basewidth-2*margin, stripthick]);

   translate([5,basewidth*2/3,-1]) cylinder(r1=1.5, r2=5, h=stripthick+2);
   translate([5,basewidth*1/3,-1]) cylinder(r1=1.5, r2=5, h=stripthick+2);
  }
}

module back_base(){
  difference() {
   cube([stripwidth,basewidth,stripthick]);
   translate([0,margin,footthick]) cube([stripwidth+2,material+.5, stripthick]);
   translate([0,basewidth-margin-material,footthick])
     cube([stripwidth+2,material+.5, stripthick]);

   translate([5,basewidth*2/3,-1]) cylinder(r1=1.5, r2=5, h=stripthick+2);
   translate([5,basewidth*1/3,-1]) cylinder(r1=1.5, r2=5, h=stripthick+2);
  }
  translate([stripwidth-material,margin+material+1.5,stripthick-1])
    cube([material,basewidth-2*margin-2*material-2.5, stripthick]);
}

back_base();
translate([20,0,0]) front_base();