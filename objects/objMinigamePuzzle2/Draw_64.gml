
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(bx1, by1, bx2, by2, false);

draw_set_color(c_white);
draw_line_width(bx1, by1, bx2, by1, 4);
draw_line_width(bx1, by2, bx2, by2, 4);
draw_line_width(bx1, by1, bx1, by2, 4);
draw_line_width(bx2, by1, bx2, by2, 4);
draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(bx1 + box_w / 2, by1 + 15, "RHYTHMIC HARVEST");
var meter_x = bx1 + 60;
var meter_y1 = by1 + 80;
var meter_w = 40;
var meter_h = 220;
var meter_y2 = meter_y1 + meter_h;

draw_set_color(c_dkgray);
draw_rectangle(meter_x, meter_y1, meter_x + meter_w, meter_y2, false);
var target_py1 = meter_y2 - (meter_h * (target_max / 100));
var target_py2 = meter_y2 - (meter_h * (target_min / 100));
draw_set_color(c_green);
draw_rectangle(meter_x, target_py1, meter_x + meter_w, target_py2, false);
var indicator_y = meter_y2 - (meter_h * (rhythm_bar_y / 100));
draw_set_color(c_yellow);
draw_line_width(meter_x - 6, indicator_y, meter_x + meter_w + 6, indicator_y, 4);
var plant_center_x = bx2 - 140;
var ground_y = by1 + 270;

draw_set_color(c_orange);
draw_rectangle(plant_center_x - 40, ground_y, plant_center_x + 40, ground_y + 15, false);

if (plant_growth > 0) {
    var current_plant_h = (plant_growth / 100) * 120;
    if (plant_flash && fail_meter > 50) draw_set_color(c_red);
    else draw_set_color(c_lime);
    draw_rectangle(plant_center_x - 8, ground_y - current_plant_h, plant_center_x + 8, ground_y, false);
    if (plant_growth >= 50) {
        draw_rectangle(plant_center_x - 28, ground_y - (current_plant_h * 0.5) - 6, plant_center_x, ground_y - (current_plant_h * 0.5) + 6, false);
        draw_rectangle(plant_center_x, ground_y - (current_plant_h * 0.7) - 6, plant_center_x + 28, ground_y - (current_plant_h * 0.7) + 6, false);
    }
}

draw_set_font(global.fonteLegenda);
draw_set_halign(fa_left);
draw_set_color(c_lime);
draw_text(bx1 + 160, by1 + 110, "GROWTH: " + string(floor(plant_growth)) + "%");

draw_set_color(c_red);
draw_text(bx1 + 160, by1 + 170, "STRESS: " + string(floor(fail_meter)) + "%");
draw_set_font(global.fonteLegenda);
draw_set_halign(fa_center);
draw_set_color(c_silver);
draw_text(bx1 + box_w / 2, by2 - 45, "Press Z exactly inside the GREEN zone!  |  X to Run Away");
if (win) {
    draw_set_color(c_black);
    draw_rectangle(bx1 + 30, by1 + 80, bx2 - 30, by2 - 80, false);
    draw_set_color(c_white);
    draw_rectangle(bx1 + 30, by1 + 80, bx2 - 30, by2 - 80, true);
    
    draw_set_font(global.fonteNormal);
    draw_set_color(c_lime);
    draw_text(gui_w / 2, gui_h / 2 - 15, "HARVEST SUCCESSFUL!");
    draw_set_font(global.fonteLegenda);
    draw_set_color(c_white);
    draw_text(gui_w / 2, gui_h / 2 + 30, "Press Z to take the Blue Key");
}

if (game_over) {
    draw_set_color(c_black);
    draw_rectangle(bx1 + 30, by1 + 80, bx2 - 30, by2 - 80, false);
    draw_set_color(c_white);
    draw_rectangle(bx1 + 30, by1 + 80, bx2 - 30, by2 - 80, true);
    
    draw_set_font(global.fonteNormal);
    draw_set_color(c_red);
    draw_text(gui_w / 2, gui_h / 2 - 15, "THE PLANT WITHERED!");
    draw_set_font(global.fonteLegenda);
    draw_set_color(c_white);
    draw_text(gui_w / 2, gui_h / 2 + 30, "Press Z to Try Again  |  X to Exit");
}