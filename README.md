3D models for printing in plastic
=======

##ArduinoCase

###Description
This is a complete, parameterized 3D printable case for an Arduino Project. 
The case is made from a 4 parts:

* Identical top and bottom (except optional holes and standoffs)
* front panel (with holes)
* back panel (with holes)

By default it places standoffs and holes for a Arduino Uno. The board is placed to the right side of the case regardless of what size you make the case. The front and back panels are printed separately. The top of the file includes a simple list of holes for each panel. 

Uses the Arduino model by jestin ( http://www.thingiverse.com/thing:18139 ).
The file can be used stand-alone, but by default uses the Arduino library so you can place the board for clearance checks.

If you don't want to use the Arduino library, comment out the library and don't include the Arduino.

###Usage
By default will produce one half of a case 100mmx120mmx40mm with Arduino standoffs. You can just print two of these for a second half. If you want to see the whole thing together, you can turn on all the parts at once (but you wont want to print that).

For a complete case, select render and export to stl each of:

* the bottom (with or without standoffs and keyholes)
* another bottom or a top (they are the same, you will have to flip the top over in your slicer to print it)
* a front panel with appropriate holes (you will have to re-orient this in your slicer)
* a back panel with appropriate holes (you will have to re-orient this in your slicer)

The case works best if you set the slicer to use thick outer layers, and try to avoid most infill. For most cases it is faster and stronger, with almost no difference in plastic cost.
The default case thickness of 1.25mm is quite strong in PLA.

The settings near the top of the file allow adjustment of all the basics:

* case overall size, corner radius
* material thickness, panel retaining rib thickness
* board standoff height
* screw sizes
* hole list for front and back panels

Holes are specified in 2D from the center of the panel. Currently round and square holes are supported, with round holes dimensioned to center and square holes to the top left corner.
Hole definitions are a list of vectors with each vector as:

* type "C" for circle, "S" for square
* X position
* Y position
* Circle radius or square X
* Circle depth or Square Y
* square depth (not used for Circle)

Example: [["C",10,20,30,2]] will make a 30mm round hole 2mm deep at 10,20




