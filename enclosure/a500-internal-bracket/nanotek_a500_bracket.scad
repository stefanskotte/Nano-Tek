// ============================================================================
//  Nano-Tek -> Amiga 500 internal drive bracket
//  - Mounts to the 3 factory floppy-drive screw points (fits Rev A and Rev B cases)
//  - Solid front plate blanks the floppy slot
//  - Separate cosmetic dummy eject button (pegs into the front lip)
//  - Side fixing lug (sideways screw) at the front-right corner, as on the A500 drive
//  - Nano-Tek at the rear, 34-pin header on the rear edge (where a real drive's
//    data connector is). The stock A500 ribbon and power leads are cut to suit the
//    factory drive, so a longer 34-way cable and a power extension are needed.
//  - Cradle for an ESP32-S3 SuperMini on a straight USB-C male-male coupler
//
//  Case geometry (screw points, front-plate envelope) taken from measurements of
//  jbilander/gotek_internal_a500_mount (GPL-2), which fits both A500 case revisions.
//  Eject cap and side lug positions measured from _CrazyBob_'s "Amiga 500 Gotek USB
//  bracket v2" (thingiverse 2745049, CC BY-SA). This file is an independent design;
//  only the measured positions are reused.
//
//  Coordinates (mm), looking down on the bracket as installed:
//    X = across the drive width (0..101; the side lug reaches 101.5)
//    Y = front/back; +Y towards the case side wall (floppy slot), -Y towards the
//        motherboard. The front lip's outer face is at Y = 12, the rear edge at -95.
//    Z = up; Z = 0 sits on the case's drive bosses
//
//  Render one part at a time:  openscad -D 'part="bracket"' -o bracket.stl this.scad
//  part = "assembly" | "bracket" | "eject" | "fitcheck"
//  (also "nt_pcb", "nt_parts", "usb", "coupler", "esp_pcb", "eject_placed":
//   placeholder blocks in assembled position, used for preview renders)
// ============================================================================

part = "assembly";

/* [Case interface - factory drive screw points] */
drive_w        = 101;        // drive envelope width (3.5" drive = 101.6)
case_holes     = [[3.5, -19], [3.5, -89], [97.5, -89]];   // 94.0 x 70.0 mm pattern
case_pilot_d   = 2.5;        // pilot for the original A500 drive screws (M3)
case_boss_d    = 9;
frame_rear_y   = -95;
base_t         = 3;          // base rail thickness
rail_w         = 7;

/* [Side fixing lug - front right corner] */
// Horizontal screw boss on the right-hand edge, measured from _CrazyBob_'s A500 base
// (thingiverse 2745049). A screw goes in sideways through the pilot hole.
side_lug       = true;
lug_y          = -9;         // hole centre, Y
lug_z          = 5;          // hole centre, Z
lug_pilot_d    = 2.5;
lug_x0         = 93.5;       // inner end of the lug
lug_x1         = 101.5;      // outer face (0.5 mm proud of the 101 mm envelope)
lug_boss_d     = 7;          // round boss on the outer face
lug_boss_t     = 1;

/* [Front plate / slot blank] */
plate_y0       = 3;          // inner face of the solid plate
plate_y1       = 9;          // outer face (sits behind the case slot)
plate_h        = 29;
lip_y1         = 12;         // lower lip protrudes further (towards eject hole)
lip_h          = 12;

/* [Dummy eject button] */
// Position and size measured from _CrazyBob_'s "Amiga 500 Gotek USB bracket v2"
// (thingiverse 2745049, CC BY-SA), which covers the A500's drive-button hole.
// Low X = the right-hand end when you look at the slot from outside the case.
eject_x        = 12.25;      // centre, X
eject_z        = 9.9;        // centre, Z
eject_w        = 17.5;       // face width  (X)
eject_h        = 6.8;        // face height (Z)
eject_face_t   = 2;          // face thickness
stem_w         = 13.5;       // stem behind the face
stem_h         = 3.5;
eject_reach    = 9;          // face stands this far proud of the front lip (Y)
eject_peg      = 3;          // square peg size
eject_peg_len  = 5;
eject_clear    = 0.25;       // per-side clearance for the peg socket

/* [Nano-Tek placement] */
nt_w           = 51;
nt_h           = 42;
nt_t           = 1.6;
// The board sits at the REAR, like a real drive's connectors: the 34-pin header (CN3)
// runs along the rear edge so the ribbon comes straight in from the motherboard.
nt_rear_clear  = 0;          // gap between the CN3 shroud and the rear of the frame
cn3_overhang   = 1.32;       // CN3 shroud sticks out this far past the board edge
// Board left edge (USB-C edge). Measured run: ESP32 22.4 + socket 0.6 + coupler 20
// + board 51 = 94 mm. At 44 the ESP32 end sits 1 mm inside the left edge and the
// CN1 power connector (2.5 mm past the board) ends at 97.5. Centred would be 46.5.
nt_x0          = 44;
standoff_h     = 5;          // above base -> board underside at base_t + standoff_h
standoff_d     = 5.4;        // = copper keep-out ring on the PCB
use_inserts    = true;       // true: M2.5 heat-set insert hole; false: self-tap pilot
insert_d       = 3.6;        // typical M2.5 x 4 insert (check yours)
insert_depth   = 4.5;
selftap_d      = 2.1;
// Nano-Tek holes, board coords from its top-left corner. H4 (47,8) is under CN1:
// no screw there, only a support post so pushing the power plug in doesn't flex the PCB.
nt_holes       = [[4, 8], [4, 29], [47, 29]];
nt_support     = [[47, 8]];

/* [ESP32-S3 SuperMini + straight USB-C coupler] */
nt_usb_cy      = 19.6;       // Nano-Tek USB-C centre, from board top edge
usb_cz_above   = 1.63;       // receptacle centre above PCB top (top-mount Type-C)
coupler_gap    = 20;         // measured: gap between the Nano-Tek edge and the ESP32 socket
coupler_w      = 12;         // coupler body width (estimate)
coupler_h      = 5.5;        // coupler body height (estimate)
esp_len        = 22.4;       // measured ESP32-S3 SuperMini PCB: 22.4 x 18
esp_usb_overhang = 0.6;      // ESP32 USB-C socket sticks out past its PCB
esp_w          = 18;
esp_pcb_t      = 1.2;
cradle_clear   = 0.4;
cradle_wall    = 2;
cradle_lip     = 2.5;        // side lip height above the ESP32 PCB underside

/* [Cable tie points for OLED/encoder leads] */
tie_slots      = [[20, -5], [39, -50]];   // X,Y of 4 x 2 mm zip-tie slots (on rails)

$fn = 48;
eps = 0.01;

// ---------------------------------------------------------------- derived
nt_top_y   = frame_rear_y + nt_rear_clear + cn3_overhang + nt_h;   // board front edge
nt_bot_z   = base_t + standoff_h;
usb_cz     = nt_bot_z + nt_t + usb_cz_above;
usb_cy     = nt_top_y - nt_usb_cy;
esp_x1     = nt_x0 - coupler_gap - esp_usb_overhang;   // ESP32 PCB, USB end
esp_x0     = esp_x1 - esp_len;              // ESP32 antenna end
esp_bot_z  = usb_cz - usb_cz_above - esp_pcb_t;
cradle_top = esp_bot_z - cradle_clear;

function nt2xy(p) = [nt_x0 + p[0], nt_top_y - p[1]];

// ---------------------------------------------------------------- base frame
module rail_x(y0, y1, x0 = 0, x1 = drive_w) translate([x0, y0, 0]) cube([x1 - x0, y1 - y0, base_t]);
module rail_y(x0, x1, y0 = frame_rear_y, y1 = plate_y0) translate([x0, y0, 0]) cube([x1 - x0, y1 - y0, base_t]);

module base_frame() {
    h1 = nt2xy(nt_holes[0]); h2 = nt2xy(nt_holes[1]); h3 = nt2xy(nt_holes[2]);
    union() {
        rail_y(0, rail_w);                                   // left side
        rail_y(drive_w - rail_w, drive_w);                   // right side
        rail_x(frame_rear_y, frame_rear_y + 12);             // rear (case holes)
        rail_x(-8, plate_y0);                                // front, under the plate
        rail_x(h1[1] - rail_w/2, h1[1] + rail_w/2);          // under H1 / H4 row
        rail_x(h2[1] - rail_w/2, h2[1] + rail_w/2);          // under H2 / H3 row
        rail_y(h1[0] - rail_w/2, h1[0] + rail_w/2, frame_rear_y, plate_y0);
        rail_y(h3[0] - rail_w/2, h3[0] + rail_w/2, frame_rear_y, plate_y0);
        for (c = case_holes) translate([c[0], c[1], 0]) cylinder(d = case_boss_d, h = base_t);
    }
}

// ---------------------------------------------------------------- front plate
module front_plate() {
    translate([0, plate_y0, 0]) cube([drive_w, plate_y1 - plate_y0, plate_h]);
    translate([0, plate_y0, 0]) cube([drive_w, lip_y1 - plate_y0, lip_h]);
    // gussets bracing the front plate
    for (gx = [rail_w + 1, 30, 70, drive_w - rail_w - 4])
        hull() {
            translate([gx, plate_y0 - eps, 0]) cube([3, eps, plate_h - 4]);
            translate([gx, plate_y0 - 16, 0]) cube([3, eps, base_t]);
        }
}

module eject_socket() {
    s = eject_peg + 2 * eject_clear;
    translate([eject_x - s/2, lip_y1 - eject_peg_len - 0.5, eject_z - s/2])
        cube([s, eject_peg_len + 0.5 + eps, s]);
}

// ---------------------------------------------------------------- side lug
module side_lug_body() {
    // tapered block: 19 mm long at the base, 8 mm long at the 8.5 mm top
    translate([lug_x0, 0, 0]) rotate([90, 0, 90])
        linear_extrude(lug_x1 - lug_x0)
            polygon([[lug_y - 9.5, 0], [lug_y + 9.5, 0], [lug_y + 4, 8.5], [lug_y - 4, 8.5]]);
    translate([lug_x1 - lug_boss_t, lug_y, lug_z]) rotate([0, 90, 0]) cylinder(d = lug_boss_d, h = lug_boss_t);
}
module side_lug_hole() {
    translate([lug_x0 - 1, lug_y, lug_z]) rotate([0, 90, 0]) cylinder(d = lug_pilot_d, h = lug_x1 - lug_x0 + 2);
}

// ---------------------------------------------------------------- Nano-Tek mounts
module standoffs() {
    for (p = nt_holes) translate([each nt2xy(p), 0]) cylinder(d = standoff_d, h = nt_bot_z);
    for (p = nt_support) translate([each nt2xy(p), 0]) cylinder(d = standoff_d, h = nt_bot_z);
}
module standoff_holes() {
    for (p = nt_holes) translate([each nt2xy(p), nt_bot_z - (use_inserts ? insert_depth : nt_bot_z - 1)])
        cylinder(d = use_inserts ? insert_d : selftap_d, h = 20);
}

// ---------------------------------------------------------------- ESP32 cradle
module esp_cradle() {
    x0 = max(0, esp_x0 - cradle_clear - cradle_wall);
    stop_t = esp_x0 - cradle_clear - x0;     // room left for an end stop
    x1 = esp_x1 + 1;
    y0 = usb_cy - esp_w/2 - cradle_clear - cradle_wall;
    y1 = usb_cy + esp_w/2 + cradle_clear + cradle_wall;
    difference() {
        union() {
            // floor + supports down to the base
            translate([x0, y0, 0]) cube([x1 - x0, y1 - y0, cradle_top]);
            // side lips
            for (yy = [y0, y1 - cradle_wall])
                translate([x0, yy, 0]) cube([x1 - x0, cradle_wall, esp_bot_z + cradle_lip]);
            // low end stop at the antenna end (keeps the antenna clear)
            if (stop_t >= 1.2) translate([x0, y0, 0]) cube([stop_t, y1 - y0, esp_bot_z + 0.8]);
            // saddle under the coupler
            translate([esp_x1 + esp_usb_overhang + 0.5, usb_cy - coupler_w/2 - 1.5, 0])
                cube([coupler_gap - 1, coupler_w + 3, usb_cz - coupler_h/2 - 0.3]);
        }
        // hollow out the pedestal to save plastic
        translate([x0 + cradle_wall, y0 + cradle_wall, base_t]) cube([x1 - x0 - 2*cradle_wall - 1, y1 - y0 - 2*cradle_wall, cradle_top - base_t - 2]);
        // zip-tie slots across the ESP32
        for (xx = [esp_x0 + 5, esp_x1 - 6])
            for (yy = [y0 - 1, y1 - cradle_wall - 1])
                translate([xx, yy, cradle_top - 6]) cube([4, cradle_wall + 2, 4.5]);
        // coupler channel (clears the coupler body)
        translate([esp_x1 + esp_usb_overhang - 1, usb_cy - coupler_w/2 - 0.3, usb_cz - coupler_h/2])
            cube([coupler_gap + 2, coupler_w + 0.6, 20]);
    }
    // keep a solid column round any case screw hole that falls under the cradle,
    // so the drive screw gets full thread length
    for (c = case_holes)
        if (c[0] > x0 && c[0] < x1 && c[1] > y0 && c[1] < y1)
            translate([c[0], c[1], 0]) cylinder(d = case_boss_d, h = cradle_top);
}

// ---------------------------------------------------------------- bracket
module envelope() translate([0, -200, -1]) cube([side_lug ? lug_x1 : drive_w, 400, 100]);

module bracket() {
    intersection() { envelope(); difference() {
        union() {
            base_frame();
            front_plate();
            standoffs();
            esp_cradle();
            if (side_lug) side_lug_body();
        }
        if (side_lug) side_lug_hole();
        for (c = case_holes) translate([c[0], c[1], -eps]) cylinder(d = case_pilot_d, h = 30);
        standoff_holes();
        eject_socket();
        for (t = tie_slots) translate([t[0] - 2, t[1] - 1, -eps]) cube([4, 2, base_t + 2*eps]);
    } }
}

// ---------------------------------------------------------------- dummy eject
module eject_button() {     // printed face-down: face at z = 0, peg pointing up
    r = 1.2;
    hull() for (dx = [-1, 1], dz = [-1, 1])
        translate([dx * (eject_w/2 - r), dz * (eject_h/2 - r), 0]) cylinder(r = r, h = eject_face_t);
    translate([-stem_w/2, -stem_h/2, eject_face_t - eps]) cube([stem_w, stem_h, eject_reach - eject_face_t + eps]);
    translate([-eject_peg/2, -eject_peg/2, eject_reach - eps]) cube([eject_peg, eject_peg, eject_peg_len]);
}

// ---------------------------------------------------------------- fit check
// Thin, quick print: the three screw holes, the front plate outline, eject socket
// and Nano-Tek standoff positions. Screw it into the case before printing the real one.
module fitcheck() {
    intersection() { envelope(); difference() {
        union() {
            intersection() { base_frame(); translate([-10, -200, 0]) cube([200, 400, 1.2]); }
            for (c = case_holes) translate([c[0], c[1], 0]) cylinder(d = case_boss_d, h = base_t);
            translate([0, plate_y1 - 1.6, 0]) cube([drive_w, 1.6, plate_h]);
            translate([0, plate_y0, 0]) cube([drive_w, lip_y1 - plate_y0, lip_h]);
            for (p = concat(nt_holes, nt_support)) translate([each nt2xy(p), 0]) cylinder(d = standoff_d, h = 3);
            if (side_lug) side_lug_body();
        }
        if (side_lug) side_lug_hole();
        for (c = case_holes) translate([c[0], c[1], -eps]) cylinder(d = case_pilot_d, h = 10);
        translate([1.6, plate_y0 - eps, -eps]) cube([drive_w - 3.2, lip_y1 - plate_y0 - 1.6 + eps, lip_h - 1.6]);
        for (p = nt_holes) translate([each nt2xy(p), -eps]) cylinder(d = 2.7, h = 10);
        eject_socket();
    } }
}

// ---------------------------------------------------------------- preview dummies
module nanotek_dummy() {
    translate([nt_x0, nt_top_y - nt_h, nt_bot_z]) {
        color("darkgreen") difference() {
            cube([nt_w, nt_h, nt_t]);
            for (p = concat(nt_holes, nt_support)) translate([p[0], nt_h - p[1], -1]) cylinder(d = 2.7, h = 5);
        }
        color("dimgray") {
            translate([-0.5, nt_h - 43.3, nt_t]) cube([51.8, 10.9, 9]);       // CN3 34-pin shroud
            translate([39.5, nt_h - 11.2, nt_t]) cube([14, 10.7, 8]);         // CN1 power
            translate([0, nt_h - 3.8, nt_t]) cube([21, 2.6, 8.5]);            // J4 1x8
            translate([20.4, nt_h - 7.6, nt_t]) cube([11.2, 2.6, 8.5]);       // J3 1x4
            translate([44.6, nt_h - 25, nt_t]) cube([6, 13.7, 8.5]);          // J2 2x5
            translate([12.2, nt_h - 9.3, nt_t]) cylinder(d = 9, h = 5.5);     // buzzer
        }
        color("silver") translate([-0.5, nt_h - 24.07, nt_t]) cube([7.8, 8.94, 3.26]); // USB-C
    }
}
module esp_dummy() {
    color("navy") translate([esp_x0, usb_cy - esp_w/2, esp_bot_z]) cube([esp_len, esp_w, esp_pcb_t]);
    color("silver") translate([esp_x1 + esp_usb_overhang - 7.5, usb_cy - 4.47, esp_bot_z + esp_pcb_t]) cube([7.5, 8.94, 3.26]);
    color("gray") translate([esp_x1 + esp_usb_overhang, usb_cy - coupler_w/2, usb_cz - coupler_h/2]) cube([coupler_gap, coupler_w, coupler_h]);
}

// ---------------------------------------------------------------- output
if (part == "nt_dummy") nanotek_dummy();
else if (part == "nt_pcb") translate([nt_x0, nt_top_y - nt_h, nt_bot_z]) difference() { cube([nt_w, nt_h, nt_t]); for (p = concat(nt_holes, nt_support)) translate([p[0], nt_h - p[1], -1]) cylinder(d = 2.7, h = 5); }
else if (part == "esp_pcb") translate([esp_x0, usb_cy - esp_w/2, esp_bot_z]) cube([esp_len, esp_w, esp_pcb_t]);
else if (part == "coupler") translate([esp_x1 + esp_usb_overhang, usb_cy - coupler_w/2, usb_cz - coupler_h/2]) cube([coupler_gap, coupler_w, coupler_h]);
else if (part == "usb") { translate([nt_x0 - 0.5, nt_top_y - 24.07, nt_bot_z + nt_t]) cube([7.8, 8.94, 3.26]); translate([esp_x1 + esp_usb_overhang - 7.5, usb_cy - 4.47, esp_bot_z + esp_pcb_t]) cube([7.5, 8.94, 3.26]); }
else if (part == "nt_parts") translate([nt_x0, nt_top_y - nt_h, nt_bot_z]) {
            translate([-0.5, nt_h - 43.3, nt_t]) cube([51.8, 10.9, 9]);
            translate([39.5, nt_h - 11.2, nt_t]) cube([14, 10.7, 8]);
            translate([0, nt_h - 3.8, nt_t]) cube([21, 2.6, 8.5]);
            translate([20.4, nt_h - 7.6, nt_t]) cube([11.2, 2.6, 8.5]);
            translate([44.6, nt_h - 25, nt_t]) cube([6, 13.7, 8.5]);
            translate([12.2, nt_h - 9.3, nt_t]) cylinder(d = 9, h = 5.5); }
else if (part == "eject_placed") translate([eject_x, lip_y1 + eject_reach, eject_z]) rotate([90, 0, 0]) eject_button();
else if (part == "bracket") bracket();
else if (part == "eject") eject_button();
else if (part == "fitcheck") fitcheck();
else {
    color("wheat") bracket();
    nanotek_dummy();
    esp_dummy();
    color("ivory") translate([eject_x, lip_y1 + eject_reach, eject_z]) rotate([90, 0, 0]) eject_button();
}
