
/*
   settings
*/

generate                = "all";   // all, base, text

// settings for script

diameter                = 4;        // magnet_diameter
height                  = 3;        // magnet_height
cover                   = 3;        // base_cover_layers

// other settings

layer_height            = 0.2;

magnet_padding          = 1;        // added to the diameter of the magnet for loose fit

base_diameter_add       = 6;
base_height             = 10;

font_size               = 4;
font_layers             = 2;        // layer height x layers => 0.2 x 2 = 0.4
font_family             = "Liberation Sans:style=Bold";

$fa  = 6;
$fs  = 0.5;
//$fn  = 64;

// double conversion -- if diameter/height comes from make-script it is a str
magnet_diameter     = int(str(diameter));
magnet_height       = int(str(height));
base_cover_layers   = int(str(cover));

base_cover_height   = layer_height * base_cover_layers;
font_height         = layer_height * font_layers;


/*
   draw
*/

if(generate=="base" || generate=="all") {

    color("white")
    difference() {
        // base
        cylinder(h = base_height, r = (magnet_diameter + base_diameter_add)/2 );

        // cutout for magnet
        translate([0,0,base_height-magnet_height-magnet_padding/2])
            cylinder(h = magnet_height + magnet_padding/2, r = (magnet_diameter + magnet_padding)/2 );

        // text on the tool
        translate([0,0,-1])
            linear_extrude(font_height + 1)
                rotate(a=180, v=[0,1,0])
                    text( str(magnet_diameter, "x", magnet_height), size = font_size, halign = "center", valign = "center", font=font_family );
    }

    // number of cover layers
    color("white")
        translate([0,0,base_height+base_cover_height-font_height+0.0001])
        linear_extrude(font_height)
            text( str(cover), size = font_size+1, halign = "center", valign = "center", font=font_family );

}

if(generate=="text" || generate=="all") {

    difference() {
        color("red")
            // base cover
            translate([0,0,base_height])
                cylinder(h = base_cover_height, r = (magnet_diameter + base_diameter_add)/2 );

    // number of cover layers
    color("white")
        translate([0,0,base_height+base_cover_height-font_height+0.0001])
        linear_extrude(font_height+1)
            text( str(cover), size = font_size+1, halign = "center", valign = "center", font=font_family );

    }

    // text on the tool
    color("red")
        translate([0,0,-0.0001])
            linear_extrude(font_height)
                rotate(a=180, v=[0,1,0])
                    text( str(magnet_diameter, "x", magnet_height), size = font_size, halign = "center", valign = "center", font=font_family );

    // help text on build plate
    color("red")
        translate([0, -(magnet_diameter + base_diameter_add)/2 - 5,0])
        linear_extrude(font_height)
            text( str(magnet_diameter, "x", magnet_height, "/", str(cover) ), size = font_size, halign = "center", valign = "center", font=font_family );

}


// convert string to number
// source: https://github.com/openscad/openscad/issues/4568
function int(s, ret=0, i=0) =
    i >= len(s)
    ? ret
    : int(s, ret*10 + ord(s[i]) - ord("0"), i+1);
