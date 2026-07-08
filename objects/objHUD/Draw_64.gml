if (instance_exists(objDialogue)) exit;
if (instance_exists(objShowLocal)) exit;
if (instance_exists(objPlayer)) {
    if (objPlayer.config_open) exit;
}
if (global.puzzle_active) exit;
if (instance_exists(objSleepTrigger)) {
    if (objSleepTrigger.sleeping) exit;
}
if (instance_exists(objBattleManager)) exit;

gpu_set_texfilter(false);

font_normal = global.fonteNormal;
font_small = global.fonteLegenda;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var obj_text = global.current_objective;
if (obj_text == undefined || obj_text == "") obj_text = "Explore the world.";

draw_set_font(font_normal);
var text_max_w = 260;
var text_h = string_height_ext(obj_text, 18, text_max_w);

var paper_w = 310;
var paper_h = max(160, text_h + 96);

var base_x = gui_w - paper_w - 32;
var base_y = 32;

var col_paper      = make_color_rgb(242, 233, 213);
var col_paper_shadow = make_color_rgb(214, 203, 180);
var col_paper_dark   = make_color_rgb(186, 175, 153);
var col_ink        = make_color_rgb(45, 42, 38);
var col_ink_light  = make_color_rgb(110, 102, 90);
var col_blood      = make_color_rgb(120, 20, 24);
var col_blood_dark = make_color_rgb(70, 10, 12);
var col_line       = make_color_rgb(198, 222, 224);

var sh_v = 4;
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_rectangle(base_x + sh_v, base_y + sh_v, base_x + paper_w + sh_v, base_y + paper_h + sh_v, false);
draw_rectangle(base_x + sh_v + 2, base_y + paper_h + sh_v, base_x + paper_w - 12 + sh_v, base_y + paper_h + 8 + sh_v, false);
draw_set_alpha(1.0);

draw_set_color(col_paper);
draw_rectangle(base_x, base_y, base_x + paper_w, base_y + paper_h, false);

var seg_w = 10;
var seg_count = ceil(paper_w / seg_w);
draw_set_color(col_paper_shadow);
for (var i = 0; i < seg_count; i++) {
    var sx = base_x + (i * seg_w);
    if (i % 2 == 0) {
        draw_rectangle(sx, base_y + paper_h, sx + seg_w, base_y + paper_h + 4, false);
    } else {
        draw_rectangle(sx + 2, base_y + paper_h, sx + seg_w - 2, base_y + paper_h + 6, false);
    }
}

var tear_h = 12;
var tx = base_x + paper_w;
draw_set_color(col_paper_dark);
draw_primitive_begin(pr_trianglestrip);
draw_vertex_color(tx, base_y + 30, col_paper_dark, 1.0);
draw_vertex_color(tx - 10, base_y + 40, col_paper_shadow, 1.0);
draw_vertex_color(tx, base_y + 50, col_paper_dark, 1.0);
draw_vertex_color(tx - 6, base_y + 60, col_paper_shadow, 1.0);
draw_vertex_color(tx, base_y + 70, col_paper_dark, 1.0);
draw_primitive_end();

draw_set_color(col_line);
var line_gap = 18;
var start_line_y = base_y + 64;
var end_line_y = base_y + paper_h - 20;
for (var ly = start_line_y; ly < end_line_y; ly += line_gap) {
    draw_line_width(base_x + 36, ly, base_x + paper_w - 16, ly, 1);
}

draw_set_color(make_color_rgb(220, 140, 140));
draw_line_width(base_x + 28, base_y, base_x + 28, base_y + paper_h, 1);

var fold_size = 24;
var fx1 = base_x;
var fy1 = base_y + paper_h;
draw_set_color(col_paper_dark);
draw_triangle(fx1, fy1, fx1 + fold_size, fy1, fx1, fy1 - fold_size, false);
draw_set_color(col_paper_shadow);
draw_triangle(fx1 + 1, fy1 - 1, fx1 + fold_size - 2, fy1 - 1, fx1 + 1, fy1 - fold_size + 2, false);

var cf_size = 18;
var cx1 = base_x + paper_w;
var cy1 = base_y;
draw_set_color(make_color_rgb(30, 30, 35));
draw_triangle(cx1, cy1, cx1 - cf_size, cy1, cx1, cy1 + cf_size, false);
draw_set_color(col_paper_shadow);
draw_triangle(cx1 - 1, cy1 + 1, cx1 - cf_size + 2, cy1 + 1, cx1 - 1, cy1 + cf_size - 2, false);

draw_set_color(col_blood_dark);
draw_circle(base_x + 45, base_y + paper_h - 35, 8, false);
draw_circle(base_x + 52, base_y + paper_h - 28, 5, false);
draw_circle(base_x + 38, base_y + paper_h - 40, 3, false);
draw_set_color(col_blood);
draw_circle(base_x + 44, base_y + paper_h - 36, 7, false);
draw_circle(base_x + 51, base_y + paper_h - 29, 4, false);

draw_set_color(col_blood_dark);
draw_line_width(base_x + 52, base_y + paper_h - 28, base_x + 55, base_y + paper_h - 10, 2);
draw_line_width(base_x + 45, base_y + paper_h - 35, base_x + 47, base_y + paper_h - 18, 3);
draw_set_color(col_blood);
draw_line_width(base_x + 52, base_y + paper_h - 28, base_x + 54, base_y + paper_h - 11, 1);
draw_line_width(base_x + 45, base_y + paper_h - 35, base_x + 46, base_y + paper_h - 19, 1);

var stain_x = base_x + paper_w - 50;
var stain_y = base_y + 45;
draw_set_alpha(0.18);
draw_set_color(make_color_rgb(130, 110, 80));
draw_circle(stain_x, stain_y, 16, false);
draw_circle(stain_x + 10, stain_y - 6, 12, false);
draw_circle(stain_x - 8, stain_y + 8, 10, false);
draw_set_alpha(0.08);
draw_circle(stain_x, stain_y, 28, false);
draw_set_alpha(1.0);

var pin_x = base_x + (paper_w / 2);
var pin_y = base_y + 4;
draw_set_alpha(0.4);
draw_set_color(c_black);
draw_circle(pin_x + 2, pin_y + 4, 5, false);
draw_line_width(pin_x + 2, pin_y + 4, pin_x + 6, pin_y + 14, 3);
draw_set_alpha(1.0);

draw_set_color(make_color_rgb(90, 95, 105));
draw_circle(pin_x, pin_y, 5, false);
draw_set_color(make_color_rgb(140, 145, 155));
draw_circle(pin_x - 1, pin_y - 1, 4, false);
draw_set_color(make_color_rgb(200, 205, 215));
draw_circle(pin_x - 1, pin_y - 1, 2, false);

draw_set_color(make_color_rgb(70, 75, 85));
draw_line_width(pin_x, pin_y + 3, pin_x + 3, pin_y + 12, 2);
draw_set_color(make_color_rgb(160, 165, 175));
draw_point(pin_x + 3, pin_y + 12);

draw_set_color(col_ink_light);
for (var i = 0; i < 3; i++) {
    var wx = base_x + 40 + (i * 24);
    var wy = base_y + 24;
    draw_line_width(wx, wy, wx + 14, wy + 4, 1);
    draw_line_width(wx + 14, wy + 4, wx + 20, wy - 2, 1);
}

draw_set_color(col_ink);
for (var i = 0; i < 4; i++) {
    var clip_x = base_x + 12;
    var clip_y = base_y + 50 + (i * 36);
    if (clip_y < base_y + paper_h - 20) {
        draw_primitive_begin(pr_linestrip);
        draw_vertex(clip_x, clip_y);
        draw_vertex(clip_x + 6, clip_y - 4);
        draw_vertex(clip_x + 12, clip_y);
        draw_vertex(clip_x + 4, clip_y + 6);
        draw_vertex(clip_x, clip_y);
        draw_primitive_end();
    }
}

var fiber_x = base_x + 70;
var fiber_y = base_y + paper_h - 50;
draw_set_color(col_paper_shadow);
draw_line(fiber_x, fiber_y, fiber_x + 15, fiber_y - 10);
draw_line(fiber_x + 5, fiber_y + 8, fiber_x + 22, fiber_y);
draw_line(base_x + paper_w - 60, base_y + 90, base_x + paper_w - 45, base_y + 75);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_font(font_small);
var label_x = base_x + 40;
var label_y = base_y + 40;

draw_set_color(col_ink_light);
draw_text(label_x, label_y, "REMINDER:");

draw_set_font(font_normal);
var content_x = base_x + 40;
var content_y = base_y + 58;

draw_set_color(col_ink);
draw_text_ext(content_x, content_y, obj_text, 18, text_max_w);

if (global.minigames > 0) {
    var check_y = content_y + text_h + 12;
    if (check_y < base_y + paper_h - 24) {
        draw_set_font(font_small);
        draw_set_color(col_blood);
        draw_text(content_x, check_y, "X");
        draw_set_color(col_ink_light);
        draw_text(content_x + 16, check_y, "PROGRESS NOTED");
    }
}

draw_set_color(c_white);
draw_set_alpha(1.0);