gpu_set_texfilter(false);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var d_bx1 = bx1 + shake_x;
var d_by1 = by1 + shake_y;
var d_bx2 = bx2 + shake_x;
var d_by2 = by2 + shake_y;

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
draw_rectangle(d_bx1 + shadow_offset, d_by1 + shadow_offset, d_bx2 + shadow_offset, d_by2 + shadow_offset, false);
draw_set_alpha(1.0);

draw_set_color(col_paper);
draw_rectangle(d_bx1, d_by1, d_bx2, d_by2, false);

draw_set_color(col_notebook_line);
var line_gap = 24;
for (var ly = d_by1 + 45; ly < d_by2 - 30; ly += line_gap) {
    draw_line_width(d_bx1 + 16, ly, d_bx2 - 16, ly, 1);
}

draw_set_color(col_margin_line);
draw_line_width(d_bx1 + 52, d_by1, d_bx1 + 52, d_by2, 1);

draw_set_color(col_paper_shadow);
draw_rectangle(d_bx1, d_by1, d_bx2, d_by2, true);
draw_set_color(col_pencil_lead);
draw_rectangle(d_bx1 + 2, d_by1 + 2, d_bx2 - 2, d_by2 - 2, true);

var tear_w = 14;
var tear_count = ceil(box_w / tear_w);
draw_set_color(col_paper_shadow);
for (var t = 0; t < tear_count; t++) {
    var tx = d_bx1 + (t * tear_w);
    if (t % 2 == 0) {
        draw_rectangle(tx, d_by2, tx + tear_w, d_by2 + 4, false);
    } else {
        draw_rectangle(tx + 2, d_by2, tx + tear_w - 2, d_by2 + 6, false);
    }
}

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(col_ink_main);
draw_text(d_bx1 + box_w / 2, d_by1 + 16, "FARM STONE BREAKER");

var d_stone_x = stone_x + shake_x;
var d_stone_y = stone_y + shake_y;

var stone_color = (hit_flash > 0) ? col_paper_dark : col_pencil_lead;
draw_set_color(stone_color);

var steps = 12;
var radius = 100;
var old_x = d_stone_x + radius;
var old_y = d_stone_y;
for (var i = 1; i <= steps; i++) {
    var angle = (i / steps) * 360;
    var rad = degtorad(angle);
    var r_mod = radius + ((i % 3 == 0) ? -6 : ((i % 2 == 0) ? 8 : -2));
    var new_x = d_stone_x + cos(rad) * r_mod;
    var new_y = d_stone_y + sin(rad) * r_mod;
    
    draw_line_width(old_x, old_y, new_x, new_y, 2);
    draw_line(old_x + 1, old_y + 1, new_x + 1, new_y + 1); 
    old_x = new_x;
    old_y = new_y;
}

if (hit_flash <= 0) {
    draw_set_color(col_paper_shadow);
    for (var h_offset = -60; h_offset <= 60; h_offset += 20) {
        draw_line(d_stone_x - 50 + h_offset, d_stone_y - 40, d_stone_x + h_offset, d_stone_y + 60);
        draw_line(d_stone_x - 30 + h_offset, d_stone_y + 50, d_stone_x + 30 + h_offset, d_stone_y - 50);
    }
}

if (crack_active) {
    var cx = crack_x + shake_x;
    var cy = crack_y + shake_y;
    
    var crack_color = (crack_hp > 2) ? col_blood_pencil : col_margin_line;
    draw_set_color(crack_color);
    
    var spread = crack_hp * 5; 
    
    draw_line_width(cx - spread, cy - (spread * 0.4), cx + spread, cy + (spread * 0.4), 3);
    draw_line_width(cx - (spread * 0.3), cy + spread, cx + (spread * 0.3), cy - spread, 3);
    
    draw_line(cx - spread, cy - (spread * 0.4), cx - spread - 8, cy - (spread * 0.4) + 6);
    draw_line(cx + spread, cy + (spread * 0.4), cx + spread + 8, cy + (spread * 0.4) - 6);
    
    for (var r_ang = 0; r_ang < 360; r_ang += 45) {
        var r_rad = degtorad(r_ang);
        draw_point(cx + cos(r_rad) * spread, cy + sin(r_rad) * spread);
    }
}

var cur_x = cursor_x + shake_x;
var cur_y = cursor_y + shake_y;

var col_ballpoint = make_color_rgb(40, 70, 150);
draw_set_color(col_ballpoint);
draw_line_width(cur_x - 18, cur_y, cur_x + 18, cur_y, 2);
draw_line_width(cur_x, cur_y - 18, cur_x, cur_y + 18, 2);

draw_rectangle(cur_x - 5, cur_y - 5, cur_x + 5, cur_y + 5, true);
draw_rectangle(cur_x - 6, cur_y - 6, cur_x + 6, cur_y + 6, true);

var bar_w = 400;
var bar_h = 14;
var bar_x = d_bx1 + (box_w - bar_w) / 2;
var bar_y = d_by1 + 65;

draw_set_color(col_pencil_lead);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, true);
draw_rectangle(bar_x + 1, bar_y + 1, bar_x + bar_w - 1, bar_y + bar_h - 1, true);

var filled_w = bar_w * (pickaxe_durability / 100);
if (pickaxe_durability > 30) {
    draw_set_color(col_notebook_line);
    draw_rectangle(bar_x + 3, bar_y + 3, bar_x + filled_w - 3, bar_y + bar_h - 3, false);
    draw_set_color(col_ink_sub);
} else {
    draw_set_color(col_paper_shadow);
    draw_rectangle(bar_x + 3, bar_y + 3, bar_x + filled_w - 3, bar_y + bar_h - 3, false);
    draw_set_color(col_blood_pencil);
}

for (var bx = bar_x + 4; bx < bar_x + filled_w - 3; bx += 5) {
    draw_line(bx, bar_y + 3, bx + 2, bar_y + bar_h - 3);
}

draw_set_font(global.fonteLegenda);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(col_ink_sub);
draw_text(d_bx1 + box_w / 2, bar_y - 20, "TOOL DURABILITY: " + string(floor(pickaxe_durability)) + "%");

draw_set_color(col_ink_main);
draw_text(d_bx1 + box_w / 2, d_by2 - 50, "CRACKS SMASHED: " + string(cracks_broken) + " / " + string(target_cracks));

draw_set_color(col_ink_sub);
draw_text(d_bx1 + box_w / 2, d_by2 - 25, "ARROWS to Move Aim  |  Mash Z on the RED Cracks!");

if (win) {
    draw_set_color(col_paper);
    draw_rectangle(bx1 + 24, by1 + 80, bx2 - 24, by2 - 44, false);
    draw_set_color(col_pencil_lead);
    draw_rectangle(bx1 + 24, by1 + 80, bx2 - 24, by2 - 44, true);
    draw_rectangle(bx1 + 26, by1 + 82, bx2 - 26, by2 - 46, true);
    
    draw_set_font(global.fonteNormal);
    draw_set_color(col_ink_main);
    draw_text(gui_w / 2, gui_h / 2 - 20, "STONE SHATTERED!");
    draw_set_font(global.fonteLegenda);
    draw_text(gui_w / 2, gui_h / 2 + 30, "Press Z to Claim Green Key");
}

if (game_over) {
    draw_set_color(col_paper);
    draw_rectangle(bx1 + 24, by1 + 80, bx2 - 24, by2 - 44, false);
    draw_set_color(col_blood_pencil);
    draw_rectangle(bx1 + 24, by1 + 80, bx2 - 24, by2 - 44, true);
    draw_rectangle(bx1 + 26, by1 + 82, bx2 - 26, by2 - 46, true);
    
    draw_set_font(global.fonteNormal);
    draw_text(gui_w / 2, gui_h / 2 - 20, "TOOL BROKEN!");
    draw_set_font(global.fonteLegenda);
    draw_text(gui_w / 2, gui_h / 2 + 30, "Press Z to Try Again  |  X to Abandon");
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);