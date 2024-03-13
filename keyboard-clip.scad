$fn= $preview ? 32 : 128;  // render more accurately than preview
thickness = 7.0;       // thickness in mm
toothDepth = .15;      // thickness of tooth at front of slot
toothWidth = 1;        // thickness of front teeth
stringHoleRadius = 2;  // radius of hole for string
slotDepth = 1.7;       // depth of slot; PCB is 1.6mm
slotLength = 14;       // length of slot
slotGap = 0.5;         // gap between slot and string hole
tipAngle = 9;          // angle of opening of slot
tipLength = 3.5;       // length of (angled) tip
ridgeHeight = 0.5;     // height of ridge above and below

width = stringHoleRadius * 4;           // width of clip
length = slotLength + width + slotGap;  // total length
ridgeWidth = width/3;                   // width of ridge on top and bottom

difference(){
    union(){
        difference(){
            union(){
                translate([tipLength,0,0])  // Main body
                    cube([slotLength-tipLength + slotGap + stringHoleRadius, width, thickness], center=false);
                translate([tipLength, width, (thickness + slotDepth)/2])  // add front angle
                    rotate([0,-tipAngle,180])
                    cube([tipLength, width, (thickness-slotDepth)/2]);
                translate([tipLength, 0, (thickness - slotDepth)/2])  // add front angle
                    rotate([180,tipAngle,180])
                    cube([tipLength, width, (thickness-slotDepth)/2]);
                translate([slotLength + stringHoleRadius + slotGap, width/2, 0])
                    cylinder(h=thickness, r=width/2, center=false);                              // string end
            }
            translate([slotLength + stringHoleRadius + slotGap, width/2, -.1])
                cylinder(h=thickness + .2, r=stringHoleRadius, center=false);                    // remove slot
            translate([-.1,-.1,(thickness-slotDepth)/2])
                cube([slotLength + .1, width + .2, slotDepth], center=false);                    // remove string hole
            translate([0,-.1,-slotDepth])         // shave off bottom
                cube([slotLength, width + .2, slotDepth], center=false);
            translate([0,-.1,thickness])         // shave off top
                cube([slotLength, width + .2, slotDepth], center=false);
        }

        // Add teeth
        translate([tipLength + (slotLength-tipLength)*.67, 0, (thickness - slotDepth)/2])
            cube([1, width, toothDepth], center=false);
        translate([tipLength + (slotLength-tipLength)*.67, 0, (thickness + slotDepth)/2 - toothDepth])
            cube([toothWidth, width, toothDepth], center=false);
        translate([tipLength + (slotLength-tipLength)*.33, 0, (thickness - slotDepth)/2])
            cube([1, width, toothDepth], center=false);
        translate([tipLength + (slotLength-tipLength)*.33, 0, (thickness + slotDepth)/2 - toothDepth])
            cube([toothWidth, width, toothDepth], center=false);
        translate([tipLength, 0, (thickness - slotDepth)/2])
            cube([1, width, toothDepth], center=false);
        translate([tipLength, 0, (thickness + slotDepth)/2 - toothDepth])
            cube([toothWidth, width, toothDepth], center=false);

        // Add ridge on top and bottom
        translate([
                    tipLength - stringHoleRadius*3/2 - slotGap/3.4,
                    ridgeWidth,
                    thickness])  // ridge on top
            cube([slotLength, ridgeWidth, ridgeHeight], center=false);
        translate([
                    tipLength - stringHoleRadius*3/2 - slotGap/3.4,
                    ridgeWidth,
                    -ridgeHeight])  // ridge on bottom
            cube([slotLength, ridgeWidth, ridgeHeight], center=false);

    }

    /* // FIXME: This is only to correct for a PCB mistake on 2022-thumb */
    /* translate([1, -1, 0])                // taper one side */
    /*     rotate([0, 0, -25]) */
    /*     cube([20, 10, thickness*2+2], center=true); */
}
