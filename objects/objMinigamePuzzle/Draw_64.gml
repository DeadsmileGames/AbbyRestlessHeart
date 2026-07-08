var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var shake_offset_x = random_range(-screen_shake, screen_shake);
var shake_offset_y = random_range(-screen_shake, screen_shake);

draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1.0);

var current_bx1 = bx1 + shake_offset_x;
var current_by1 = by1 + shake_offset_y;
var current_bx2 = bx2 + shake_offset_x;
var current_by2 = by2 + shake_offset_y;

var sh_d = 8;
draw_set_color(c_black);
draw_set_alpha(0.3);
draw_rectangle(current_bx1 + sh_d, current_by1 + sh_d, current_bx2 + sh_d, current_by2 + sh_d, false);
draw_set_alpha(1.0);

draw_set_color(col_paper);
draw_rectangle(current_bx1, current_by1, current_bx2, current_by2, false);

draw_set_color(col_notebook_line);
var line_gap = 26;
for (var ly = current_by1 + 60; ly < current_by2 - 40; ly += line_gap) {
    draw_line_width(current_bx1 + 20, ly, current_bx2 - 20, ly, 1);
}

draw_set_color(var_margin_line);
draw_line_width(current_bx1 + 55, current_by1, current_bx1 + 55, current_by2, 1);

draw_set_color(col_paper_shadow);
draw_rectangle(current_bx1, current_by1, current_bx2, current_by2, true);
draw_set_color(col_paper_dark);
draw_rectangle(current_bx1 + 2, current_by1 + 2, current_bx2 - 2, current_by2 - 2, true);

var tear_w = 14;
var tear_count = ceil(box_w / tear_w);
draw_set_color(col_paper_shadow);
for (var t = 0; t < tear_count; t++) {
    var tx = current_bx1 + (t * tear_w);
    if (t % 2 == 0) {
        draw_rectangle(tx, current_by2, tx + tear_w, current_by2 + 4, false);
    } else {
        draw_rectangle(tx + 2, current_by2, tx + tear_w - 2, current_by2 + 6, false);
    }
}

draw_set_alpha(0.12);
draw_set_color(col_coffee_stain);
draw_circle(current_bx1 + 100, current_by1 + 140, 32, false);
draw_circle(current_bx2 - 120, current_by2 - 110, 40, false);
draw_set_alpha(1.0);

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(col_blood_red);
draw_text(gui_w / 2 + shake_offset_x, current_by1 + 20, "MEMORY RECONSTRUCTION (ROUND " + string(current_round + 1) + " / " + string(total_rounds) + ")");

var center_x = gui_w / 2 + shake_offset_x;
var target_y = current_by1 + 90;

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(col_ink_sub);
draw_text(center_x, target_y, "Fading notes from your father's old journal:");

draw_set_color(col_ink_main);
var current_target_phrase = target_phrases[current_round];
draw_text_ext_transformed(center_x, target_y + 36, current_target_phrase, 32, box_w - 120, 1.1, 1.1, 0);

var input_y = current_by1 + 240;
draw_set_color(col_ink_sub);
draw_text(center_x, input_y, "Type the exact matching string block:");

var in_w = box_w - 100;
var in_h = 64;
var in_x1 = center_x - (in_w / 2);
var in_y1 = input_y + 36;
var in_x2 = in_x1 + in_w;
var in_y2 = in_y1 + in_h;

draw_set_color(col_paper_shadow);
draw_rectangle(in_x1, in_y1, in_x2, in_y2, false);
draw_set_color(col_paper_dark);
draw_rectangle(in_x1, in_y1, in_x2, in_y2, true);

draw_set_color(make_color_rgb(40, 60, 130)); 
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var display_string = typed_text;
if ((floor(current_time / 300) % 2) == 0 && !puzzle_won) {
    display_string += "|";
}
draw_text_ext_transformed(in_x1 + 16, in_y1 + (in_h / 2), display_string, 24, in_w - 32, 1.1, 1.1, 0);

var button_w = 140;
var button_h = 36;
var total_btn_w = (button_w * total_buttons) + (30 * (total_buttons - 1));
var btn_start_x = center_x - (total_btn_w / 2);
var btn_y = current_by2 - 65;

for (var b = 0; b < total_buttons; b++) {
    var bx_left = btn_start_x + (b * (button_w + 30));
    var bx_right = bx_left + button_w;
    var by_top = btn_y;
    var by_bottom = by_top + button_h;
    
    if (button_selected == b) {
        draw_set_color(col_blood_red);
        draw_rectangle(bx_left - 3, by_top - 3, bx_right + 3, by_bottom + 3, false);
        draw_set_color(col_paper);
    } else {
        draw_set_color(col_paper_shadow);
    }
    
    draw_rectangle(bx_left, by_top, bx_right, by_bottom, false);
    draw_set_color(col_paper_dark);
    draw_rectangle(bx_left, by_top, bx_right, by_bottom, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.fonteNormal);
    
    if (button_selected == b) {
        draw_set_color(col_ink_main);
        draw_text(bx_left + button_w / 2, by_top + button_h / 2, "> " + buttons_labels[b] + " <");
    } else {
        draw_set_color(col_ink_sub);
        draw_text(bx_left + button_w / 2, by_top + button_h / 2, buttons_labels[b]);
    }
}

if (message_timer > 0) {
    var alpha_val = message_timer / 30;
    draw_set_color(col_blood_red);
    draw_set_alpha(alpha_val);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.fonteNormal);
    draw_text(center_x, current_by2 - 110, message);
    draw_set_alpha(1.0);
}

if (flash_alpha > 0) {
    draw_set_color(flash_color);
    draw_set_alpha(flash_alpha);
    
    var b_thick = 32;
    draw_rectangle(0, 0, gui_w, b_thick, false);
    draw_rectangle(0, gui_h - b_thick, gui_w, gui_h, false);
    draw_rectangle(0, 0, b_thick, gui_h, false);
    draw_rectangle(gui_w - b_thick, 0, gui_w, gui_h, false);
    
    draw_set_alpha(flash_alpha * 0.25);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    
    draw_set_alpha(1.0);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);