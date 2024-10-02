// Parameters
// Forearm Width 1 (mm)
$fn = 64;

width1 = 129.15; //[45:175]

// Forearm Width 2 (mm)
width2 = 103.89; //[25:155]

// Forearm Length 1 (mm)
length1 = 118.16; //[35:165]

// Forearm Origin (mm)
origin = 0;

// Forearm Height (smallest) (mm)
heightSmall = 1.04; //[.75:1.25]
 
// Diameter fillet (mm)
diameter = 5; //[3:7]



//Add the circle ports 
radius = 8.32; //[3:12]
yShift = 7; //[4:13]

//square cutout for circle ports
squareRad = 6.86; //[3:10]

//linear extrude of circle ports (mm)
//trying to put the variable in terms of height of the base of the trapezoid
circExtrude = heightSmall*5.07692307692;




// Fillet edges
difference()
difference()
difference()
difference()
difference()
difference()
difference()
difference()
difference()
difference()
difference()
difference()
{
{
{
{
{
{
{
{
{
{
{
{
difference(){
linear_extrude(height=heightSmall)
hull() { 
    translate([origin,origin]) circle(d=diameter);
    translate([width1,origin]) circle(d=diameter);
    translate([(width1-width2)/2+width2,length1]) circle(d=diameter);
    translate([(width1-width2)/2,length1]) circle(d=diameter);
    
    
    polygon(points=[[origin,origin],[width1,origin],[(width1-width2)/2+width2,length1],[(width1-width2)/2,length1]]); 
    
    cylinder(d=diameter, h=heightSmall); 
 }
 }
 // Instead of putting coordinates, I used the coordinates already in place and divided the coordinate value by the respective dimension (width1 for x values, length1 for y values), and multiplied this ratio by the respective dimension so the location of the rectangle will scale properly. (the only problem is that the locations only scale w/ respect to width1 and not width2)
 
 // Right now, the rectangular ports are slightly offset with one higher than the other. We're trying to make it symmetrical but can't figure it out. That is the next step. 

  rotate(5.5)
 translate([0.92915214866*width1,0.59241706161*length1]){
cube([5.35,27.03,3*circExtrude],true);}
 }
  rotate(-5.5)
  translate([0.07742934572*width1,0.67704807041*length1]){
cube([5.35,27.03,3*circExtrude],true);}
 }
   rotate(5.5)
   translate([0.92915214866*width1,0.0846310088*length1]){
cube([5.35,27.03,3*circExtrude],true);}
 }
 rotate(-5.5)
   translate([0.07742934572*width1,0.1692620176*length1]){
cube([5.35,27.03,3*circExtrude],true);}

translate([0.07742934572*width1+3.13,0.1692620176*length1+12.1])
cylinder(circExtrude*3,5.35/2,5.35/2);}

translate([0.07742934572*width1+107.21,0.1692620176*length1+14.7])
cylinder(circExtrude*3,5.35/2,5.35/2);}

translate([0.07742934572*width1+109.8,0.1692620176*length1-12])
cylinder(circExtrude*3,5.35/2,5.35/2);}  

translate([0.07742934572*width1+.61,0.1692620176*length1-14.1])
cylinder(circExtrude*3,5.35/2,5.35/2);}  

translate([0.07742934572*width1+6.31,0.1692620176*length1+45.1])
cylinder(circExtrude*3,5.35/2,5.35/2);}  

translate([0.07742934572*width1+8.9,0.1692620176*length1+72.1])
cylinder(circExtrude*3,5.35/2,5.35/2);} 

translate([0.07742934572*width1+104.05,0.1692620176*length1+47.6])
cylinder(circExtrude*3,5.35/2,5.35/2);}  

translate([0.07742934572*width1+101.4,0.1692620176*length1+74.92])
cylinder(circExtrude*3,5.35/2,5.35/2);} 
// Not correct, needs to be corrected
 
// Above is the code for the circular arcs for the four side ports - need to make this scalable
 
 //cutout for the groove 
    translate([width1/2,7+length1])
    scale([1,.5]) sphere(30.58, center = true);

 }
 ; 
//Need to still figure out exact location of these circle ports in relation to rest of body

//Right port
difference()
 {
linear_extrude(height=circExtrude)   
translate([(width1-width2)/2.5+width2,8+length1]) 
circle(radius); 
translate([(width1-width2)/2.5+width2,8+length1]){
cube([squareRad,squareRad,3*circExtrude],true);
    }
 }
 //Left Port
 difference()
 {
linear_extrude(height=circExtrude)  
translate([(width1-width2)/1.5,8+length1])
circle(radius);

translate([(width1-width2)/1.5,8+length1]){
cube([squareRad,squareRad,3*circExtrude],true);
    }
    
}
;