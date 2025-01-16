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

// Forearm Height (main) = 2.52 mm
heightMain = heightSmall*1.04;

 
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


difference() {
difference() {
difference() {
difference() {
    // Main shape
    linear_extrude(height=heightMain) {
        hull() { 
            translate([origin, origin]) circle(d=diameter);
            translate([width1, origin]) circle(d=diameter);
            translate([(width1 - width2) / 2 + width2, length1]) circle(d=diameter);
            translate([(width1 - width2) / 2, length1]) circle(d=diameter);
            polygon(points=[
                [origin, origin],
                [width1, origin],
                [(width1 - width2) / 2 + width2, length1],
                [(width1 - width2) / 2, length1]
            ]); 
        }

    }
    
    

    // Arrays for cube positions and rotations
    rotations = [5.5, -5.5, 5.5, -5.5];
    x_positions = [
        0.92915214866 * width1,
        0.07742934572 * width1,
        0.92915214866 * width1,
        0.07742934572 * width1
    ];
    y_positions = [
        0.59241706161 * length1,
        0.67704807041 * length1,
        0.0846310088  * length1,
        0.1692620176  * length1
    ];

    // Subtracting cubes using a loop
    for (i = [0 : len(rotations) - 1]) {
        rotate(rotations[i]) {
            translate([x_positions[i], y_positions[i]]) {
                cube([5.35, 27.03, 3 * circExtrude], center = true);
            }
        }
    }

    // Base positions for cylinders
    x_base = 0.07742934572 * width1;
    y_base = 0.1692620176 * length1;

    // Arrays for cylinder offsets
    x_offsets = [3.13, 107.21, 109.8, 0.61, 6.31, 8.9, 104.05, 101.4];
    y_offsets = [12.1, 14.7, -12, -14.1, 45.1, 72.1, 47.6, 74.92];

    // Subtracting cylinders using a loop
    for (i = [0 : len(x_offsets) - 1]) {
        translate([x_base + x_offsets[i], y_base + y_offsets[i]]) {
            cylinder(h = 3 * circExtrude, r = 5.35 / 2);
        }
    }

    // Subtracting the scaled sphere to create a cutout

    translate([width1 / 2 +.05, -12 + length1]) {

        scale([1.95, .5, 1]) { // Scaling in x, y, z directions
            sphere(r = 19.8, center = true);
        }
    }
}
// Port Hole Correction 
linear_extrude(height=circExtrude)   
translate([(width1-width2)/3.5+width2,length1]) 
circle(radius); 
translate([(width1-width2)/3.5+width2,length1]){
cube([squareRad,squareRad,3*circExtrude],true);
}
// Port Hole Correction 
linear_extrude(height=circExtrude)  
translate([(width1-width2)/1.4,length1])
circle(radius);
translate([(width1-width2)/1.4,length1]){
cube([squareRad,squareRad,3*circExtrude],true);
    }
}
// Rectangle segment cutout
linear_extrude(height=circExtrude)  
translate([width1-63,length1-2])
cube([50,20,3*circExtrude],true);
translate([width1-64.5,length1-2]){
cube([(length1/1.53),20,3*circExtrude],true);
    }
}
}
 ; 
//Need to still figure out exact location of these circle ports in relation to rest of body

//Right port
difference()
 {
linear_extrude(height=circExtrude)   
translate([(width1-width2)/3.5+width2,length1]) 
circle(radius); 
translate([(width1-width2)/3.5+width2,length1]){
cube([squareRad,squareRad,3*circExtrude],true);
    }
 }
 //Left Port
 difference()
 {
linear_extrude(height=circExtrude)  
translate([(width1-width2)/1.4,length1])
circle(radius);
translate([(width1-width2)/1.4,length1]){
cube([squareRad,squareRad,3*circExtrude],true);
    }
    
}
;

topPortWidth = 13.54;
topPortLength = 36.43;
topPortHeight = 5.02;

topPortX = (width1-topPortWidth)/2;
topPortY = (length1-topPortLength)/2;

translate([topPortX,topPortY,heightSmall]){
cube([topPortWidth,topPortLength,topPortHeight]);

translate([topPortX/8-.5,topPortY-7,0]){
cylinder(topPortHeight,topPortWidth/2+.3,topPortWidth/2+.3);
}

}

b = 10;
h = 10;
w = 4;

//Start with an extruded triangle

translate([topPortX+topPortWidth/2,topPortY,heightSmall]){
rotate(a=[180,-90,0])
linear_extrude(height = topPortWidth, center = true, convexity = 10, twist = 0)
polygon(points=[[0,0],[topPortHeight,0],[0,b]], paths=[[0,1,2]]);

}

// Adding slight raised parts over oval cutouts
rotations_2 = [-5.5, 5.5];
x_positions_2 = [0, width1 - 17]; 
y_positions_2 = [0, -12]; 

for (i = [0 : len(rotations_2) - 1]) {
    rotate(rotations_2[i]) { 
        translate([x_positions_2[i], y_positions_2[i]]) {
            cube([15.55, 84.64, heightMain + 1.28], center = false); 
        }
    }
    
    
}



// outline code for the ports

module gauntletPegHole() {
    difference() {
        union() {
            linear_extrude(height=3, center=false, scale=0.75) {
                circle(d=18.65);
            }
            translate([0, 0, 0]) {
                cube([10, 10, 10], center=true);
            }
            translate([0, 0, 0]) {
                cylinder(h=10, r=5);
            }
        }
        cube([20, 20, 20]);
    }
}

translate([0, 0, 0]) gauntletPegHole();
translate([30, 0, 0]) gauntletPegHole();