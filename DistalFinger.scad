$fn=128;
//Parameters
//vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
//vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

//- Inside finger width
innerWidth=7.8;
//-Outside width
outerWidth=14.6;
//- Radius of pin hole
innerRadius=5.4/2;
//- Height of base of finger
outerRadius=8;
//- Length of part
distalLength=49;
//- How tall the pad of finger is from the print bed
distalTipHeight=19.5;
//- Clearance around joint width
jointWidthClearance=.3;
//- Clearance around radius of joint
jointRadiusClearance=1;
//- Rubber width
rubberClearance=3;
//- Rubber Length
lengthOfElastic=18;
//- Angle of fingertip (degrees)
fingertipAngle=35; //degrees
//- Width of pin head (long side)
pinHeadLength=6.5;
//- Width of pin
pinWidth=4.5;
//- Depth of pin head 
pinHeadDepth=1.6;
//- Depth of clip hole
pinClipDepth=2;
//- Diameter of clip
pinClipDiam=6;
//- Diameter of pin
pinDiam=5;
//-Clearance around pin
pinClear=.25;
//- Vertcal scale factor for base of skin to attach to fingertip
skinScale = .9;

module skinExtrude(outerWidth,outerRadius,distalLength,linscale=1){
    skinWidth=outerWidth;
    skinHeight=2*outerRadius;
    rotate([-90,0,0])
    linear_extrude(distalLength,scale=linscale)
    polygon(points = [[0.36789*skinWidth,-1.0*skinHeight],[-0.368807*skinWidth,-1.0*skinHeight],[-0.394495*skinWidth,-0.976013*skinHeight],[-0.422018*skinWidth,-0.923077*skinHeight],[-0.444037*skinWidth,-0.867659*skinHeight],[-0.466055*skinWidth,-0.797353*skinHeight],[-0.478899*skinWidth,-0.712986*skinHeight],[-0.490826*skinWidth,-0.590571*skinHeight],[-0.494495*skinWidth,-0.477254*skinHeight],[-0.5*skinWidth,-0.331679*skinHeight],[-0.499083*skinWidth,-0.229115*skinHeight],[-0.495413*skinWidth,-0.144748*skinHeight],[-0.488991*skinWidth,-0.093466*skinHeight],[-0.480734*skinWidth,-0.055418*skinHeight],[-0.468807*skinWidth,-0.01737*skinHeight],[-0.457798*skinWidth,0.0*skinHeight],[0.453211*skinWidth,0.0*skinHeight],[0.470642*skinWidth,-0.023987*skinHeight],[0.481651*skinWidth,-0.045492*skinHeight],[0.489908*skinWidth,-0.086849*skinHeight],[0.494495*skinWidth,-0.138958*skinHeight],[0.498165*skinWidth,-0.198511*skinHeight],[0.499083*skinWidth,-0.26799*skinHeight],[0.499083*skinWidth,-0.3689*skinHeight],[0.5*skinWidth,-0.457403*skinHeight],[0.498165*skinWidth,-0.519438*skinHeight],[0.494495*skinWidth,-0.597188*skinHeight],[0.488073*skinWidth,-0.677419*skinHeight],[0.474312*skinWidth,-0.761787*skinHeight],[0.465138*skinWidth,-0.82134*skinHeight],[0.455963*skinWidth,-0.859388*skinHeight],[0.443119*skinWidth,-0.892473*skinHeight],[0.424771*skinWidth,-0.927213*skinHeight],[0.407339*skinWidth,-0.961125*skinHeight],[0.4*skinWidth,-0.975186*skinHeight],[0.392661*skinWidth,-0.985939*skinHeight],[0.380734*skinWidth,-0.993383*skinHeight]], paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,0]]);
};


module distalPositive(outerWidth,outerRadius,distalTipHeight,fingertipAngle,distalLength,skinScale){
    
    xScaleFront = .9;
    yScaleFront = .9;
    zScaleFront = .65;
    xScaleMiddle = .8;
    yScaleMiddle = 1.1;
    zScaleMiddle = .45;
    yScaleBack = 1.5;
    
    yTransFront = distalLength-(yScaleFront*outerWidth)/1.85;
    zTransMiddle = distalTipHeight-(zScaleMiddle*outerWidth)/2;
    zTransFront = zTransMiddle-(zScaleFront*outerWidth)/5;
    yTransMiddle = distalLength-(yScaleMiddle*outerWidth)/2-(yScaleMiddle*outerWidth)/10;
    yTransBack = distalLength-(yScaleBack*outerWidth)/2-zTransFront/tan(fingertipAngle)-((yScaleBack-yScaleFront)*outerWidth)/2;
    //Fingertip creation
    difference(){
        //positive
        hull(){
            //front
            translate([0,yTransFront,zTransFront])
            scale([xScaleFront,yScaleFront,zScaleFront]) 
            sphere(d=outerWidth);
            //middle
            translate([0,yTransMiddle,zTransMiddle])
            scale([xScaleMiddle,yScaleMiddle,zScaleMiddle])
            sphere(d=outerWidth);
            //back
            translate([0,yTransBack,0])
            scale([1,yScaleBack,1])
            sphere(d=outerWidth);
        };
        //cut off bottom
        translate([0,yTransBack,-outerWidth/2]) 
        cube([outerWidth,5*yScaleBack*outerWidth,outerWidth],center=true);
        //round off bottom
        difference(){
            scale([1.5,1,1.5]) skinExtrude(outerWidth,outerRadius,distalLength);
            scale([1,1.1,1]) skinExtrude(outerWidth,outerRadius,distalLength);
            translate([0,distalLength/2,distalTipHeight]) cube([outerWidth,distalLength,distalTipHeight],center=true);
        };
        //cut off back if it goes too far
        translate([0,-distalLength/2,outerRadius]) cube([outerWidth,distalLength,outerRadius*2],center=true);
    };
    
    //Skin attach
    difference(){
        skinExtrude(outerWidth,outerRadius,distalLength,[1,skinScale]);
        translate([0,yTransBack,0]) rotate([fingertipAngle-90,0,0]) translate([-outerWidth/2,0,0]) cube([outerWidth,10*outerWidth,10*zTransMiddle/sin(fingertipAngle)]);
    };
};


module peg(length,width,height,xpos=0,ypos=0,zpos=0,angle=0,lipheight=.1,lipwidth=.5,radius=.5){
    translate([xpos,ypos,zpos])
    rotate([angle,0,0])
    union(){
    minkowski() {
        cube([width-2*radius+2*lipwidth,length-2*radius+2*lipwidth,lipheight],center=true);
        sphere(radius,$fn=20);};
    translate([0,0,-height/2])
    linear_extrude(height,center=true)
    minkowski(){
        square([width-2*radius,length-2*radius],center=true);
        circle(radius,$fn=20);
    }
    };
}

module distalAddObjects(innerWidth,outerWidth,innerRadius,outerRadius,distalLength,distalTipHeight,jointWidthClearance,jointRadiusClearance,rubberClearance,lengthOfElastic,fingertipAngle,pinHeadLength,pinHeadDepth,pinClipDepth,pinDiam,skinScale,pegLipHeight=.55){
    
    difference(){
        translate([0,2*outerRadius+lengthOfElastic/4,pegLipHeight]) rotate([180,0,0]) peg(length=lengthOfElastic/2,width=innerWidth/2,height=(2/3)*outerRadius);
        translate([0,outerRadius,outerRadius]) rotate([0,90,0]) cylinder(h=innerWidth+jointWidthClearance,r=outerRadius+jointRadiusClearance,center=true);
    };
    
    //String tie point
    radiusTiePoint=1.5;
    distanceTiePoint=2*outerRadius+lengthOfElastic/4;
    fractionLengthTie=(distanceTiePoint/distalLength);
    heightTiePoint=(1-fractionLengthTie+fractionLengthTie*skinScale)*2*outerRadius-.75*radiusTiePoint;
    translate([0,distanceTiePoint,heightTiePoint]) scale([1,1,.75]) rotate([0,90,0]) cylinder(r=radiusTiePoint,h=innerWidth+2*jointWidthClearance,center=true);
};

module distalCutObjects(innerWidth,outerWidth,innerRadius,outerRadius,distalLength,distalTipHeight,jointWidthClearance,jointRadiusClearance,rubberClearance,lengthOfElastic,fingertipAngle,pinHeadLength,pinWidth,pinHeadDepth,pinClipDepth,pinDiam,pinClear,pegLipHeight=.55){
    
    //Middle cut out for proximal fingers to fit inside
    difference(){
        translate([0,outerRadius/2,outerRadius]) cube([outerWidth,outerRadius,2*outerRadius],center=true);
        translate([0,outerRadius,outerRadius]) rotate([0,90,0]) cylinder(h=outerWidth,r=outerRadius,center=true);
        translate([0,outerRadius/1.4,outerRadius/2]) cube([outerWidth,outerRadius,outerRadius],center=true);
    };
    translate([0,outerRadius,outerRadius]) rotate([0,90,0]) cylinder(h=innerWidth+jointWidthClearance,r=outerRadius+jointRadiusClearance,center=true);
    cube([innerWidth+jointWidthClearance,outerRadius+jointRadiusClearance,outerRadius+jointRadiusClearance],center=true);
    
    
    //Hole for rubber band
    filletSize=2.5;
    minkowski(){
        rotate([0,0,90]) cube([2*(2*outerRadius+lengthOfElastic/2+rubberClearance-filletSize),innerWidth+jointWidthClearance-2*filletSize,(2/3)*outerRadius-2*filletSize],center=true);
        sphere(r=filletSize);
       };
       
       
    //Hole for string
    filletSizeString=2;
    minkowski(){
        translate([0,0,2*outerRadius]) rotate([0,0,90]) cube([2*(2*outerRadius+lengthOfElastic/2-filletSizeString),innerWidth+jointWidthClearance-2*filletSizeString,1.25*outerRadius-2*filletSizeString],center=true);
        sphere(r=filletSizeString);
       };
       
    //Peg hole
    intersection(){
        translate([0,outerRadius,outerRadius]) rotate([0,90,0]) cylinder(h=outerWidth,d=pinDiam+2*pinClear,center=true);
        translate([0,outerRadius,outerRadius]) cube([outerWidth,pinDiam+2*pinClear,pinWidth+2*pinClear],center=true);
    };
    translate([(outerWidth-pinHeadDepth)/2,outerRadius,outerRadius]) cube([pinHeadDepth+2*pinClear,pinHeadLength+2*pinClear,pinWidth+2*pinClear],center=true);
    translate([-(outerWidth-pinClipDepth)/2,outerRadius,outerRadius]) rotate([0,90,0]) cylinder(h=pinClipDepth,d=pinClipDiam+2*pinClear,center=true);
};

    


module renderDistal(innerWidth,outerWidth,innerRadius,outerRadius,distalLength,distalTipHeight,jointWidthClearance,jointRadiusClearance,rubberClearance,lengthOfElastic,fingertipAngle,pinHeadLength,pinWidth,pinHeadDepth,pinClipDepth,pinDiam,pinClear,skinScale,pegLipHeight=.55){
    
    difference(){
    distalPositive(outerWidth,outerRadius,distalTipHeight,fingertipAngle,distalLength,skinScale);
    distalCutObjects(innerWidth,outerWidth,innerRadius,outerRadius,distalLength,distalTipHeight,jointWidthClearance,jointRadiusClearance,rubberClearance,lengthOfElastic,fingertipAngle,pinHeadLength,pinWidth,pinHeadDepth,pinClipDepth,pinDiam,pinClear);
    };
    distalAddObjects(innerWidth,outerWidth,innerRadius,outerRadius,distalLength,distalTipHeight,jointWidthClearance,jointRadiusClearance,rubberClearance,lengthOfElastic,fingertipAngle,pinHeadLength,pinHeadDepth,pinClipDepth,pinDiam,skinScale,pegLipHeight=.55);
};

renderDistal(innerWidth,outerWidth,innerRadius,outerRadius,distalLength,distalTipHeight,jointWidthClearance,jointRadiusClearance,rubberClearance,lengthOfElastic,fingertipAngle,pinHeadLength,pinWidth,pinHeadDepth,pinClipDepth,pinDiam,pinClear,skinScale,pegLipHeight=.55);

//distalCutObjects(innerWidth,outerWidth,innerRadius,outerRadius,distalLength,distalTipHeight,jointWidthClearance,jointRadiusClearance,rubberClearance,lengthOfElastic,fingertipAngle,pinHeadLength,pinHeadDepth,pinClipDepth);

