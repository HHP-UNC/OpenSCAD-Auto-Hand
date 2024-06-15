$fn=64;

pinLength=17;
pinDiam=4.8;

pinTipDiam=5.7;
pinTipDepth=4;

pinHeadWidth=7;
pinHeadHeight=4;
pinHeadDepth=3;

pinGapLength=.5*pinLength;
pinGapWidth=.35*pinDiam;
chamferSize=.7;


module pin(pinLength,pinDiam,pinTipDiam,pinTipDepth,pinHeadWidth,pinHeadHeight,pinHeadDepth,pinGapLength,pinGapWidth){
    difference(){
        union(){
            translate([0,0,pinHeadHeight/2]) rotate([0,90,0]) cylinder(pinLength,d=pinDiam);
            translate([pinHeadDepth/2,0,pinHeadHeight/2]) cube([pinHeadDepth,pinHeadWidth,pinHeadHeight],center=true);
            minkowski(){
                sphere(d=chamferSize);
                translate([pinLength-pinTipDepth,0,pinHeadHeight/2]) rotate([0,90,0]) cylinder(pinTipDepth-.5*chamferSize,d=pinTipDiam-chamferSize);
                
            };
        };
        translate([pinLength/2,0,-pinHeadHeight/2]) cube([pinLength,pinHeadWidth,pinHeadHeight],center=true);
        translate([pinLength/2,0,+3*pinHeadHeight/2]) cube([pinLength,pinHeadWidth,pinHeadHeight],center=true);
        translate([pinLength-pinGapLength/2,0,pinHeadHeight/2]) cube([pinGapLength,pinGapWidth,pinHeadHeight],center=true);
    };
    
};


pin(pinLength,pinDiam,pinTipDiam,pinTipDepth,pinHeadWidth,pinHeadHeight,pinHeadDepth,pinGapLength,pinGapWidth);