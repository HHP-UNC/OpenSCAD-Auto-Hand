$fn=128;

skinWidth=16.6;
skinHeight=20;
length=27;
outerRadius=8;
innerRadius=3;
lengthOfElastic=18;
fingerWidth=7.2;
clearance=1;
stringPathRadius=1;
rubberClearance=3;
taper=.85;

module proximalSkin(skinWidth,skinHeight,skinLength,taper=.85){ 
    //Section to define and make the "skin"
    rotate([-90,0,0]) 
    linear_extrude(skinLength,center=true,scale=taper) 
    polygon(points = [[0.017102*skinWidth,-1.0*skinHeight],[-0.144914*skinWidth,-0.988835*skinHeight],[-0.243024*skinWidth,-0.979763*skinHeight],[-0.319532*skinWidth,-0.962317*skinHeight],[-0.377138*skinWidth,-0.936497*skinHeight],[-0.415842*skinWidth,-0.90649*skinHeight],[-0.458146*skinWidth,-0.857641*skinHeight],[-0.480648*skinWidth,-0.791347*skinHeight],[-0.49505*skinWidth,-0.71947*skinHeight],[-0.50045*skinWidth,-0.605722*skinHeight],[-0.493249*skinWidth,-0.483601*skinHeight],[-0.477948*skinWidth,-0.329379*skinHeight],[-0.448245*skinWidth,-0.199581*skinHeight],[-0.409541*skinWidth,-0.090021*skinHeight],[-0.368137*skinWidth,-0.034194*skinHeight],[-0.327633*skinWidth,0.0*skinHeight],[0.351935*skinWidth,0.0*skinHeight],[0.39964*skinWidth,-0.034194*skinHeight],[0.437444*skinWidth,-0.09351*skinHeight],[0.457246*skinWidth,-0.160502*skinHeight],[0.480648*skinWidth,-0.237264*skinHeight],[0.489649*skinWidth,-0.332868*skinHeight],[0.49685*skinWidth,-0.457083*skinHeight],[0.49955*skinWidth,-0.579204*skinHeight],[0.487849*skinWidth,-0.701326*skinHeight],[0.467147*skinWidth,-0.826936*skinHeight],[0.452745*skinWidth,-0.86462*skinHeight],[0.427543*skinWidth,-0.900907*skinHeight],[0.387939*skinWidth,-0.933008*skinHeight],[0.337534*skinWidth,-0.956734*skinHeight],[0.281728*skinWidth,-0.972784*skinHeight],[0.209721*skinWidth,-0.985345*skinHeight],[0.142214*skinWidth,-0.990928*skinHeight]], paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,0]]);
}
module proximalMiddleFingers(length,outerRadius,innerRadius,fingerWidth,taper){
    //creates middle connector
    translate([0,0,outerRadius]) rotate([0,90,0]) 
    difference(){
        union(){
            linear_extrude(fingerWidth,center=true) hull(){
              translate([0,-length/2,0]) circle(outerRadius);
              translate([(1-taper)*outerRadius,length/2,0]) circle(taper*outerRadius);};
          };
        
    }
};

module proximalSkinCutObjects(skinWidth,skinHeight,skinLength,length,outerRadius,clearance,frontPegYOffset, frontPegLength, backPegYOffset, backPegLength, backPegHeight,rubberClearance){
    //creates objects to subtract from skin
    //Cut out circles around holes
    translate([0,0,outerRadius]) rotate([0,90,0]) 
    union(){
        linear_extrude(skinWidth+1,center=true) translate([0,-length/2,0]) circle(outerRadius+clearance);
        linear_extrude(skinWidth+1,center=true) translate([0,length/2,0]) circle(outerRadius+clearance);
    };
    //Cut off front
    translate([-(skinWidth+1)/2,frontPegYOffset-frontPegLength/2-2*clearance,0]) cube([skinWidth+1,skinWidth+1,skinHeight]);
    //Cut off back lower corner
    translate([0,-length/2,outerRadius/2]) cube([skinWidth+1,2*outerRadius,outerRadius],center=true);
    //Cut around back peg
    peg(rubberClearance+1.3*backPegLength,.5*fingerWidth+rubberClearance,skinHeight,ypos=backPegYOffset,zpos=2*outerRadius+skinHeight/2,angle=-5);
    };

module proximalAllCutObjects(skinWidth,skinHeight,skinLength,length,outerRadius,clearance,frontPegYOffset, frontPegLength, backPegYOffset, backPegLength, backPegHeight,rubberClearance){
    //Circles through fingers
    translate([0,0,outerRadius]) rotate([0,90,0]) union(){
    linear_extrude(fingerWidth+1,center=true) translate([0,-length/2,0]) circle(innerRadius);
    linear_extrude(fingerWidth+1,center=true) translate([0,length/2,0]) circle(innerRadius);
    };
    //Fishing line run
    translate([0,0,2*stringPathRadius]) rotate([90,0,0]) cylinder(length+2*outerRadius,r=stringPathRadius,center=true);
    difference(){
        translate([0,0,stringPathRadius]) cube([2*stringPathRadius,length+2*outerRadius,2*stringPathRadius],center=true);
        translate([0,0,stringPathRadius]) cube([2*stringPathRadius,.5*length,2*stringPathRadius],center=true);
    }; 
    translate([0,-length/2-outerRadius,2*stringPathRadius]) cube([2*stringPathRadius,outerRadius,length],center=true);
};

module peg(length,width,height,xpos=0,ypos=0,zpos=0,angle=0,lipheight=.1,lipwidth=.5,radius=.5){
    translate([xpos,ypos,zpos])
    rotate([angle,0,0])
    union(){
    minkowski() {
        cube([width-2*radius+2*lipwidth,length-2*radius+2*lipwidth,lipheight],center=true);
        sphere(radius);};
    translate([0,0,-height/2])
    linear_extrude(height,center=true)
    minkowski(){
        square([width-2*radius,length-2*radius],center=true);
        circle(radius);
    }
    };
}



module drawProximal(skinWidth,skinHeight,length,outerRadius,
    innerRadius,fingerWidth,clearance,rubberClearance,lengthOfElastic,taper=.85) {
        //Creates proximal finger joint at origin from paramaters listed
    frontPegYOffset=length/2;
    frontPegLength=lengthOfElastic/2;
    backPegYOffset=-.7*(length/2);
    backPegZOffset=2*outerRadius+(2/3)*outerRadius;
    backPegLength=.8*lengthOfElastic/2;
    backPegHeight=(2/3)*outerRadius;
    skinLength=length*.75;
    difference(){
        union() {
            difference(){
            proximalSkin(skinWidth,skinHeight,skinLength,taper=taper);
            proximalSkinCutObjects(skinWidth,skinHeight,skinLength,length,outerRadius,clearance,frontPegYOffset,frontPegLength,backPegYOffset, backPegLength, backPegHeight, rubberClearance);
        };
            //Front peg:
            peg(frontPegLength,.5*fingerWidth,(2/3)*outerRadius,ypos=frontPegYOffset,zpos=1.7*outerRadius+(2/3)*outerRadius-2,angle=-15);
            //Back peg
            peg(backPegLength,.5*fingerWidth,backPegHeight,ypos=backPegYOffset,zpos=2*outerRadius+.65*backPegHeight,angle=-5);
            //MiddleFingers
            proximalMiddleFingers(length,outerRadius,innerRadius,fingerWidth,taper);
        };
        proximalAllCutObjects(skinWidth,skinHeight,skinLength,length,outerRadius,clearance,frontPegYOffset,frontPegLength,backPegYOffset, backPegLength, backPegHeight, rubberClearance);
        
};
};




drawProximal(skinWidth,skinHeight,length,outerRadius,innerRadius,fingerWidth,clearance,rubberClearance,lengthOfElastic,taper);