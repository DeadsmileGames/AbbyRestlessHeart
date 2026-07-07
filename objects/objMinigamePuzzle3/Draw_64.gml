
draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

var d_bx1 = bx1 + shake_x;
var d_by1 = by1 + shake_y;
var d_bx2 = bx2 + shake_x;
var d_by2 = by2 + shake_y;

draw_set_color(c_black);
draw_rectangle(d_bx1, d_by1, d_bx2, d_by2, false);

draw_set_color(c_white);
draw_line_width(d_bx1, d_by1, d_bx2, d_by1, 4);
draw_line_width(d_bx1, d_by2, d_bx2, d_by2, 4);
draw_line_width(d_bx1, d_by1, d_bx1, d_by2, 4);
draw_line_width(d_bx2, d_by1, d_bx2, d_by2, 4);

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(d_bx1 + box_w / 2, d_by1 + 15, "FARM STONE BREAKER");

var d_stone_x = stone_x + shake_x;
var d_stone_y = stone_y + shake_y;

draw_set_color(hit_flash > 0 ? c_silver : c_gray);
draw_circle(d_stone_x, d_stone_y, 100, false);
draw_set_color(hit_flash > 0 ? c_white : c_dkgray);
draw_circle(d_stone_x - 30, d_stone_y - 20, 60, false);
draw_circle(d_stone_x + 40, d_stone_y + 30, 50, false);
draw_circle(d_stone_x + 20, d_stone_y - 40, 45, false);

draw_set_color(c_white);
draw_circle(d_stone_x, d_stone_y, 100, true);

if (crack_active) {
    var cx = crack_x + shake_x;
    var cy = crack_y + shake_y;
    
    draw_set_color(crack_hp > 2 ? c_red : c_orange);
    
    var spread = crack_hp * 4; 
    draw_line_width(cx - spread, cy - spread, cx + spread, cy + spread, 3);
    draw_line_width(cx - spread, cy + spread, cx + spread, cy - spread, 3);
    draw_circle(cx, cy, spread, true);
}

var cur_x = cursor_x + shake_x;
var cur_y = cursor_y + shake_y;

draw_set_color(c_lime);
draw_line_width(cur_x - 15, cur_y, cur_x + 15, cur_y, 2);
draw_line_width(cur_x, cur_y - 15, cur_x, cur_y + 15, 2);
draw_rectangle(cur_x - 4, cur_y - 4, cur_x + 4, cur_y + 4, true); 

var bar_w = 400;
var bar_h = 12;
var bar_x = d_bx1 + (box_w - bar_w) / 2;
var bar_y = d_by1 + 60;

draw_set_color(c_dkgray);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);
draw_set_color((pickaxe_durability > 30) ? c_aqua : c_red);
draw_rectangle(bar_x, bar_y, bar_x + (bar_w * (pickaxe_durability / 100)), bar_y + bar_h, false);
draw_set_color(c_white);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, true);

draw_set_font(global.fonteLegenda);
draw_text(d_bx1 + box_w / 2, bar_y - 18, "TOOL DURABILITY: " + string(floor(pickaxe_durability)) + "%");

draw_set_color(c_yellow);
draw_text(d_bx1 + box_w / 2, d_by2 - 45, "CRACKS SMASHED: " + string(cracks_broken) + " / " + string(target_cracks));

draw_set_color(c_silver);
draw_text(d_bx1 + box_w / 2, d_by2 - 20, "ARROWS to Move Aim  |  Mash Z on the RED Cracks!");

if (win) {
    draw_set_color(c_black);
    draw_rectangle(bx1 + 30, by1 + 80, bx2 - 30, by2 - 80, false);
    draw_set_color(c_white);
    draw_rectangle(bx1 + 30, by1 + 80, bx2 - 30, by2 - 80, true);
    
    draw_set_font(global.fonteNormal);
    draw_set_color(c_lime);
    draw_text(gui_w / 2, gui_h / 2 - 15, "STONE SHATTERED!");
    draw_set_font(global.fonteLegenda);
    draw_set_color(c_white);
    draw_text(gui_w / 2, gui_h / 2 + 30, "Press Z to Claim Green Key");
}

if (game_over) {
    draw_set_color(c_black);
    draw_rectangle(bx1 + 30, by1 + 80, bx2 - 30, by2 - 80, false);
    draw_set_color(c_white);
    draw_rectangle(bx1 + 30, by1 + 80, bx2 - 30, by2 - 80, true);
    
    draw_set_font(global.fonteNormal);
    draw_set_color(c_red);
    draw_text(gui_w / 2, gui_h / 2 - 15, "TOOL BROKEN!");
    draw_set_font(global.fonteLegenda);
    draw_set_color(c_white);
    draw_text(gui_w / 2, gui_h / 2 + 30, "Press Z to Try Again  |  X to Abandon");
}