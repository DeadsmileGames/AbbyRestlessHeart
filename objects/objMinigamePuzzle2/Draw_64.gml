gpu_set_texfilter(false);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var box_w = 560;
var box_h = 540;
var bx1 = (gui_w - box_w) / 2;
var by1 = (gui_h - box_h) / 2;
var bx2 = bx1 + box_w;
var by2 = by1 + box_h;

var col_paper        = make_color_rgb(245, 238, 222); 
var col_paper_shadow = make_color_rgb(218, 208, 188); 
var col_paper_dark   = make_color_rgb(188, 178, 156); 
var col_ink_main     = make_color_rgb(35, 32, 28);    
var col_ink_sub      = make_color_rgb(95, 88, 76);    
var col_notebook_line = make_color_rgb(192, 214, 216); 
var col_margin_line  = make_color_rgb(225, 130, 130); 
var col_pencil_lead  = make_color_rgb(55, 52, 48);    
var col_blood_pencil = make_color_rgb(166, 45, 45);   

draw_set_color(c_black);
draw_set_alpha(0.75);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1.0);

var shadow_offset = 8;
draw_set_color(c_black);
draw_set_alpha(0.25);
draw_rectangle(bx1 + shadow_offset, by1 + shadow_offset, bx2 + shadow_offset, by2 + shadow_offset, false);
draw_set_alpha(1.0);

draw_set_color(col_paper);
draw_rectangle(bx1, by1, bx2, by2, false);

draw_set_color(col_notebook_line);
var line_gap = 24;
for (var ly = by1 + 45; ly < by2 - 30; ly += line_gap) {
    draw_line_width(bx1 + 16, ly, bx2 - 16, ly, 1);
}

draw_set_color(col_margin_line);
draw_line_width(bx1 + 52, by1, bx1 + 52, by2, 1);

draw_set_color(col_paper_shadow);
draw_rectangle(bx1, by1, bx2, by2, true);
draw_set_color(col_pencil_lead);
draw_rectangle(bx1 + 2, by1 + 2, bx2 - 2, by2 - 2, true);

var tear_w = 14;
var tear_count = ceil(box_w / tear_w);
draw_set_color(col_paper_shadow);
for (var t = 0; t < tear_count; t++) {
    var tx = bx1 + (t * tear_w);
    if (t % 2 == 0) {
        draw_rectangle(tx, by2, tx + tear_w, by2 + 4, false);
    } else {
        draw_rectangle(tx + 2, by2, tx + tear_w - 2, by2 + 6, false);
    }
}
draw_set_color(col_paper_dark);
for (var h = bx1 + 60; h < bx2 - 60; h += 40) {
    draw_line(h, by1 + 80, h + 20, by1 + 100);
    draw_line(h + 10, by2 - 120, h + 30, by2 - 100);
}

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(col_ink_main);
draw_text(bx1 + box_w / 2, by1 + 16, "RHYTHMIC HARVEST");

var meter_x = bx1 + 75;
var meter_y1 = by1 + 110;
var meter_w = 36;
var meter_h = 240;
var meter_y2 = meter_y1 + meter_h;

draw_set_color(col_pencil_lead);
draw_rectangle(meter_x, meter_y1, meter_x + meter_w, meter_y2, true);
draw_rectangle(meter_x + 1, meter_y1 + 1, meter_x + meter_w - 1, meter_y2 - 1, true);

for (var my = meter_y1 + 12; my < meter_y2; my += 24) {
    draw_line(meter_x, my, meter_x + 8, my);
    draw_line(meter_x + meter_w - 8, my, meter_x + meter_w, my);
}

var target_py1 = meter_y2 - (meter_h * (target_max / 100));
var target_py2 = meter_y2 - (meter_h * (target_min / 100));
draw_set_color(col_notebook_line);
draw_rectangle(meter_x + 3, target_py1, meter_x + meter_w - 3, target_py2, false);
draw_set_color(col_pencil_lead);
for (var t_line = target_py1 + 4; t_line < target_py2; t_line += 6) {
    draw_line(meter_x + 4, t_line, meter_x + meter_w - 4, t_line);
}

var indicator_y = meter_y2 - (meter_h * (rhythm_bar_y / 100));
draw_set_color(col_blood_pencil);
draw_line_width(meter_x - 12, indicator_y, meter_x + meter_w + 12, indicator_y, 2);
draw_line(meter_x - 12, indicator_y, meter_x - 6, indicator_y - 4);
draw_line(meter_x - 12, indicator_y, meter_x - 6, indicator_y + 4);
draw_line(meter_x + meter_w + 12, indicator_y, meter_x + meter_w + 6, indicator_y - 4);
draw_line(meter_x + meter_w + 12, indicator_y, meter_x + meter_w + 6, indicator_y + 4);

var plant_center_x = bx2 - 160;
var ground_y = by1 + 330;

draw_set_color(col_ink_sub);
for (var i = 0; i < 6; i++) {
    draw_ellipse(plant_center_x - 45 + i, ground_y - 4 + (i/2), plant_center_x + 45 - i, ground_y + 8 - (i/2), true);
}

if (plant_growth > 0) {
    var current_plant_h = (plant_growth / 100) * 140;
 
    var sketch_color = (plant_flash && fail_meter > 50) ? col_blood_pencil : col_pencil_lead;
    draw_set_color(sketch_color);
    
    draw_line_width(plant_center_x - 2, ground_y, plant_center_x - 2, ground_y - current_plant_h, 1);
    draw_line_width(plant_center_x + 2, ground_y, plant_center_x + 2, ground_y - current_plant_h, 1);
    draw_line_width(plant_center_x, ground_y, plant_center_x, ground_y - current_plant_h, 1); // Linha central de reforço

    if (plant_growth >= 30) {
        var leaf_1_y = ground_y - (current_plant_h * 0.4);
        draw_line_width(plant_center_x - 2, leaf_1_y, plant_center_x - 30, leaf_1_y - 12, 1);
        draw_line_width(plant_center_x - 30, leaf_1_y - 12, plant_center_x - 2, leaf_1_y + 8, 1);
        for (var hx = 4; hx < 26; hx += 5) {
            draw_line(plant_center_x - hx, leaf_1_y - 2, plant_center_x - hx - 4, leaf_1_y + 3);
        }
        
        var leaf_2_y = ground_y - (current_plant_h * 0.7);
        draw_line_width(plant_center_x + 2, leaf_2_y, plant_center_x + 30, leaf_2_y - 12, 1);
        draw_line_width(plant_center_x + 30, leaf_2_y - 12, plant_center_x + 2, leaf_2_y + 8, 1);
        for (var hx = 4; hx < 26; hx += 5) {
            draw_line(plant_center_x + hx, leaf_2_y - 2, plant_center_x + hx + 4, leaf_2_y + 3);
        }
    }
    
    if (plant_growth >= 75) {
        var bloom_y = ground_y - current_plant_h - 16;
        
        draw_circle(plant_center_x, bloom_y, 16, true);
        draw_circle(plant_center_x, bloom_y, 14, true);
        draw_circle(plant_center_x, bloom_y, 8, true);
        
        for (var angle = 0; angle < 360; angle += 45) {
            var rad = degtorad(angle);
            draw_line(plant_center_x + cos(rad)*8, bloom_y + sin(rad)*8, plant_center_x + cos(rad)*16, bloom_y + sin(rad)*16);
        }
    }
}

draw_set_font(global.fonteNormal);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_color(col_ink_sub);
draw_text(bx1 + 140, by1 + 130, "GROWTH: " + string(floor(plant_growth)) + "%");
draw_set_color(col_blood_pencil);
draw_text(bx1 + 140, by1 + 180, "STRESS: " + string(floor(fail_meter)) + "%");

draw_set_font(global.fonteLegenda);
draw_set_halign(fa_center);
draw_set_color(col_ink_sub);
draw_text(bx1 + box_w / 2, by2 - 90, "Press Z exactly inside the GREEN zone!  |  X to Run Away");
if (win) {
    draw_set_color(col_paper);
    draw_rectangle(bx1 + 24, by1 + 80, bx2 - 24, by2 - 44, false);
    draw_set_color(col_pencil_lead);
    draw_rectangle(bx1 + 24, by1 + 80, bx2 - 24, by2 - 44, true);
    draw_rectangle(bx1 + 26, by1 + 82, bx2 - 26, by2 - 46, true);
    
    draw_set_font(global.fonteNormal);
    draw_text(gui_w / 2, gui_h / 2 - 20, "HARVEST SUCCESSFUL!");
    draw_set_font(global.fonteLegenda);
    draw_text(gui_w / 2, gui_h / 2 + 30, "Press Z to take the Blue Key");
}

if (game_over) {
    draw_set_color(col_paper);
    draw_rectangle(bx1 + 24, by1 + 80, bx2 - 24, by2 - 44, false);
    draw_set_color(col_blood_pencil);
    draw_rectangle(bx1 + 24, by1 + 80, bx2 - 24, by2 - 44, true);
    draw_rectangle(bx1 + 26, by1 + 82, bx2 - 26, by2 - 46, true);
    
    draw_set_font(global.fonteNormal);
    draw_text(gui_w / 2, gui_h / 2 - 20, "THE PLANT WITHERED!");
    draw_set_font(global.fonteLegenda);
    draw_text(gui_w / 2, gui_h / 2 + 30, "Press Z to Try Again  |  X to Exit");
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);