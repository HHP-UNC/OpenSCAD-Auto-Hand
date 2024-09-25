x_center = 73;      
x_length = 6.8;     
y_length = 35.58;   
z_length = 20.51;   

y_center = y_length / 2;


union() {
cube([76.42, 92.82, 2.5]);
cube([6.8,92.82, 36.67]);
translate([x_center - x_length / 2, 0, 0])
    cube([6.8,92.82, 36.67]);
}

difference() {
    union(){
    translate([x_center - x_length / 2, -y_center/2, 0])
    cube([x_length, 3*(y_length/4) , z_length]);

    translate([0, -y_center/2, 0])
    cube([x_length, 3*(y_length/4) , z_length]);
    
    translate([0,-y_length/4, z_length/2])
    rotate([0,90,0])
        cylinder(h=x_length ,d=z_length);
        
    translate([69.62,-y_length/4, z_length/2])
    rotate([0,90,0])
        cylinder(h=x_length ,d=z_length);
    }


translate([-1,-10,10])
    rotate([0,90,0])
    cylinder(r = 3.4, h = 80);
}


x_hole = 20;
y_hole = 4.55;
z_hole = 7.23;
space = 14.425;


union(){
difference() {
    
    translate([0,92.82,0])
        cube([5.06,7.3,14.6]);
    
    translate([-x_hole/2,-y_hole/2+92.82+7.3,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);

}    

difference(){

    translate([0,92.82+7.3,7.3])
    rotate([0,90,0])
        cylinder(r=7.3, h=5.06);

    translate([-x_hole/2,-y_hole/2+92.82+7.3,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);
}
}


union(){
difference() {
    
    translate([space,92.82,0])
        cube([5.06,7.3,14.6]);
    
    translate([-x_hole/2+space,-y_hole/2+92.82+7.3,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);

}    

difference(){

    translate([space,92.82+7.3,7.3])
    rotate([0,90,0])
        cylinder(r=7.3, h=5.06);

    translate([-x_hole/2+space,-y_hole/2+92.82+7.3,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);
}
}

union(){
difference() {
    
    translate([space+y_hole,92.82,0])
        cube([5.06,7.3,14.6]);
    
    translate([-x_hole/2+space+y_hole,-y_hole/2+92.82+7.3,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);

}    

difference(){

    translate([space+y_hole,92.82+7.3,7.3])
    rotate([0,90,0])
        cylinder(r=7.3, h=5.06);

    translate([-x_hole/2+space+y_hole,-y_hole/2+92.82+7.3,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);
}
}

union(){
difference() {
    
    translate([2*space+y_hole,92.82,0])
        cube([5.06,7.3,14.6]);
    
    translate([-x_hole/2+2*space+y_hole,-y_hole/2+92.82+7.3,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);

}    

difference(){

    translate([2*space+y_hole,92.82+7.3,7.3])
    rotate([0,90,0])
        cylinder(r=7.3, h=5.06);

    translate([-x_hole/2+2*space+y_hole,-y_hole/2+92.82+7.3,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);
}
}

union(){
difference() {
    
    translate([2*space+2*y_hole,92.82-5,0])
        cube([5.06,7.3,14.6]);
    
    translate([-x_hole/2+2*space+2*y_hole,-y_hole/2+92.82+7.3-5,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);

}    

difference(){

    translate([2*space+2*y_hole,92.82+7.3-5,7.3])
    rotate([0,90,0])
        cylinder(r=7.3, h=5.06);

    translate([-x_hole/2+2*space+2*y_hole,-y_hole/2+92.82+7.3-5,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);
}
}

union(){
difference() {
    
    translate([3*space+2*y_hole,92.82-5,0])
        cube([5.06,7.3,14.6]);
    
    translate([-x_hole/2+3*space+2*y_hole,-y_hole/2+92.82+7.3-5,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);

}    

difference(){

    translate([3*space+2*y_hole,92.82+7.3-5,7.3])
    rotate([0,90,0])
        cylinder(r=7.3, h=5.06);

    translate([-x_hole/2+3*space+2*y_hole,-y_hole/2+92.82+7.3-5,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);
}
}

union(){
difference() {
    
    translate([3*space+3*y_hole,92.82-10,0])
        cube([5.06,7.3,14.6]);
    
    translate([-x_hole/2+3*space+3*y_hole,-y_hole/2+92.82+7.3-10,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);

}    

difference(){

    translate([3*space+3*y_hole,92.82+7.3-10,7.3])
    rotate([0,90,0])
        cylinder(r=7.3, h=5.06);

    translate([-x_hole/2+3*space+3*y_hole,-y_hole/2+92.82+7.3-10,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);
}
}

union(){
difference() {
    
    translate([4*space+3*y_hole,92.82-10,0])
        cube([5.06,7.3,14.6]);
    
    translate([-x_hole/2+4*space+3*y_hole,-y_hole/2+92.82+7.3-10,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);

}    

difference(){

    translate([4*space+3*y_hole,92.82+7.3-10,7.3])
    rotate([0,90,0])
        cylinder(r=7.3, h=5.06);

    translate([-x_hole/2+4*space+3*y_hole,-y_hole/2+92.82+7.3-10,-z_hole/2+7.3])
        cube([x_hole,y_hole,z_hole]);
}
}
