$fn=16;
//function feasy(x,y) = -(0.5*(x/10)^10 + 0.5*(y/10)^10 + 0.05*(x*y/10)^(2))+10;
//function fhard(x,y) = -(0.15*(x/10)^12 + 0.75*(y/10)^12 + 0.03*(x*y/10)^(2))-(x*y)/70+x/10-((x^2*y^6)/30000000)+10;

//Input Values
//outline = [[50,-40],[13.75,8.8],[12.5,13.8],[6.8,15],[-3.5,14],[-12.5,14],[-16.7,11.9],[-16.3,6.9],[-13.5,-1],[-11,-5.84]];
outline = [[-41.13, -39.88], [-43.31, -28.35], [-45.49, -16.51], [-45.49, -4.36], [-43.62, 6.85], [-40.82, 23.68], [-35.52, 27.73], [-28.04, 28.98], [-21.19, 32.09], [-9.35, 33.34], [-1.87, 38.64], [6.23, 38.95], [13.4, 38.95], [20.88, 36.45], [25.24, 33.34], [29.6, 25.55], [33.03, 15.89], [35.83, 6.85], [36.45, -6.85], [35.21, -19.32], [33.96, -28.98], [33.15, -39.88]];

//Function to give top curve
function f(x,y) = .5*(-(x/10)^2-(y/10)^2)+50;

//Render values
limit=60;
step=.05;
thickness=5;
outlineResolution=1;


//Interpolation
function length(x,y) = ((x[0]-y[0])^2+(x[1]-y[1])^2)^.5;

function halfPoint(x,y) = [(x[0]+y[0])/2,(x[1]+y[1])/2];

function interLine(x,y,res) = ((length(x,y)<res) ? [y] : concat(interLine(x,halfPoint(x,y),res),interLine(halfPoint(x,y),y,res)));

function flatten(l)=[for(a=l) for(b=a) b];


module shellOutline(outline,outRes){
    shellList = concat([outline[0]],flatten([for(i=[0:1:len(outline)-2]) interLine(outline[i],outline[i+1],outRes)]));
    difference(){ 
       for(i=[0:1:len(shellList)-2]){
            hull(){
                translate([shellList[i][0],shellList[i][1],f(shellList[i][0],shellList[i][1])]) sphere(d=thickness);
                translate([shellList[i][0],shellList[i][1]]) sphere(d=thickness);
                translate([shellList[i+1][0],shellList[i+1][1],f(shellList[i+1][0],shellList[i+1][1])]) sphere(d=thickness);
                translate([shellList[i+1][0],shellList[i+1][1]]) sphere(d=thickness);
               };
        };
        translate([0,0,-20]) cube([200,200,40],center=true);
        //cut off open side
        lastPoint = outline[len(outline)-1];
        leftPoint = outline[0][0]<lastPoint[0]? outline[0]:lastPoint;
        rightPoint = outline[0][0]<lastPoint[0]? lastPoint:outline[0];
        leng = length(leftPoint,rightPoint);
        ang = atan((rightPoint[1]-leftPoint[1])/(rightPoint[0]-leftPoint[0]));
        sideInner=rightPoint[1]>leftPoint[1]? 1:-1;
        translate([leftPoint[0],leftPoint[1],0]) rotate([0,0,ang]) translate([leng/2,sideInner*thickness/2,f(0,0)/2]) cube([leng+8*thickness,thickness,f(0,0)],center=true);
    };
};







module smoothSkin(){
    intersection(){
        union(){
        for(a=[-1:step:1-step],b=[-1:step:1-step]){
            //echo(a);
            x=a*limit;
            y=b*limit;
            x2=(a+step)*limit;
            y2=(b+step)*limit;
            
            hull(){
                translate([x,y,f(x,y)]) sphere(d=thickness);
                translate([x,y2,f(x,y2)]) sphere(d=thickness);
                translate([x2,y,f(x2,y)]) sphere(d=thickness);
            };
            hull(){
                translate([x2,y2,f(x2,y2)]) sphere(d=thickness);
                translate([x,y2,f(x,y2)]) sphere(d=thickness);
                translate([x2,y,f(x2,y)]) sphere(d=thickness);
            };
        };
        };
        //linear_extrude(100) polygon(outline);
    };
};

module cubeSkin(){
    intersection(){
        union(){
        for(a=[-1:step:1-step],b=[-1:step:1-step]){
            //echo(a);
            x=a*limit;
            y=b*limit;
            x2=(a+step)*limit;
            y2=(b+step)*limit;
            
            hull(){
                translate([x,y,f(x,y)]) cube([.1,.1,thickness],center=true);
                translate([x,y2,f(x,y2)]) cube([.1,.1,thickness],center=true);
                translate([x2,y,f(x2,y)]) cube([.1,.1,thickness],center=true);
            };
            hull(){
                translate([x2,y2,f(x2,y2)]) cube([.1,.1,thickness],center=true);
                translate([x,y2,f(x,y2)]) cube([.1,.1,thickness],center=true);
                translate([x2,y,f(x2,y)]) cube([.1,.1,thickness],center=true);
            };
        };
        };
        //linear_extrude(100) polygon(outline);
    };
};

//smoothSkin();

cubeSkin();

//shellOutline(outline,outlineResolution);
