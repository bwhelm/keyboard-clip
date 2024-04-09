$fn= $preview ? 32 : 128;  // render more accurately than preview
clipThickness = 7.0;       // Thickness of clip in mm
clipToothDepth = .15;      // thickness of tooth at front of slot
clipToothWidth = 1;        // thickness of front teeth
stringHoleRadius = 2;  // radius of hole for string
clipSlotDepth = 1.7;       // depth of slot; PCB is 1.6mm
clipSlotLength = 14;       // length of slot
clipSlotGap = 0.5;         // gap between slot and string hole
clipTipAngle = 9;          // angle of opening of slot
clipTipLength = 3.5;       // length of (angled) tip
clipRidgeHeight = 0.5;     // height of ridge above and below

clipWidth = stringHoleRadius * 4;           // width of clip
clipRidgeWidth = clipWidth/3;                   // width of ridge on top and bottom

module clip(){
    difference(){
        union(){
            difference(){
                union(){
                    translate([clipTipLength,0,0])  // Main body
                        cube([clipSlotLength-clipTipLength + clipSlotGap + stringHoleRadius, clipWidth, clipThickness], center=false);
                    translate([clipTipLength, clipWidth, (clipThickness + clipSlotDepth)/2])  // add front angle
                        rotate([0,-clipTipAngle,180])
                        cube([clipTipLength, clipWidth, (clipThickness-clipSlotDepth)/2]);
                    translate([clipTipLength, 0, (clipThickness - clipSlotDepth)/2])  // add front angle
                        rotate([180,clipTipAngle,180])
                        cube([clipTipLength, clipWidth, (clipThickness-clipSlotDepth)/2]);
                    translate([clipSlotLength + stringHoleRadius + clipSlotGap, clipWidth/2, 0])
                        cylinder(h=clipThickness, r=clipWidth/2, center=false);                              // string end
                }
                translate([clipSlotLength + stringHoleRadius + clipSlotGap, clipWidth/2, -.1])
                    cylinder(h=clipThickness + .2, r=stringHoleRadius, center=false);                    // remove slot
                translate([-.1,-.1,(clipThickness-clipSlotDepth)/2])
                    cube([clipSlotLength + .1, clipWidth + .2, clipSlotDepth], center=false);                    // remove string hole
                translate([0,-.1,-clipSlotDepth])         // shave off bottom
                    cube([clipSlotLength, clipWidth + .2, clipSlotDepth], center=false);
                translate([0,-.1,clipThickness])         // shave off top
                    cube([clipSlotLength, clipWidth + .2, clipSlotDepth], center=false);
            }

            // Add teeth
            translate([clipTipLength + (clipSlotLength-clipTipLength)*.67, 0, (clipThickness - clipSlotDepth)/2])
                cube([1, clipWidth, clipToothDepth], center=false);
            translate([clipTipLength + (clipSlotLength-clipTipLength)*.67, 0, (clipThickness + clipSlotDepth)/2 - clipToothDepth])
                cube([clipToothWidth, clipWidth, clipToothDepth], center=false);
            translate([clipTipLength + (clipSlotLength-clipTipLength)*.33, 0, (clipThickness - clipSlotDepth)/2])
                cube([1, clipWidth, clipToothDepth], center=false);
            translate([clipTipLength + (clipSlotLength-clipTipLength)*.33, 0, (clipThickness + clipSlotDepth)/2 - clipToothDepth])
                cube([clipToothWidth, clipWidth, clipToothDepth], center=false);
            translate([clipTipLength, 0, (clipThickness - clipSlotDepth)/2])
                cube([1, clipWidth, clipToothDepth], center=false);
            translate([clipTipLength, 0, (clipThickness + clipSlotDepth)/2 - clipToothDepth])
                cube([clipToothWidth, clipWidth, clipToothDepth], center=false);

            // Add ridge on top and bottom
            translate([
                    clipTipLength - stringHoleRadius*3/2 - clipSlotGap/3.4,
                    clipRidgeWidth,
                    clipThickness])  // ridge on top
                cube([clipSlotLength, clipRidgeWidth, clipRidgeHeight], center=false);
            translate([
                    clipTipLength - stringHoleRadius*3/2 - clipSlotGap/3.4,
                    clipRidgeWidth,
                    -clipRidgeHeight])  // ridge on bottom
                cube([clipSlotLength, clipRidgeWidth, clipRidgeHeight], center=false);

        }

        /* // FIXME: This is only to correct for a PCB mistake on 2022-thumb */
        /* translate([1, -1, 0])                // taper one side */
        /*     rotate([0, 0, -25]) */
        /*     cube([20, 10, clipThickness*2+2], center=true); */
    }
}

clip();
