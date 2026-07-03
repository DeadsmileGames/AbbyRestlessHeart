if (instance_exists(objDialogue)) exit;
if (instance_exists(objShowLocal)) exit;
if (instance_exists(objPlayer)) {
    if (objPlayer.config_open) exit;
}
if (global.puzzle_active) exit;
if (instance_exists(objSleepTrigger)) {
    if (objSleepTrigger.sleeping) exit;
}
if (instance_exists(objBattleManager)) {
     exit;
}

gpu_set_texfilter(false);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var obj_box_w = 300;
var obj_box_x = gui_w - obj_box_w - 24;
var obj_box_y = 24;

var obj_text = global.current_objective;
if (obj_text == undefined || obj_text == "") obj_text = "Explore the world.";

draw_set_font(font_normal);
var text_height = string_height_ext(obj_text, 22, obj_box_w - 32);
var obj_box_h = text_height + 56;

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(obj_box_x, obj_box_y, obj_box_x + obj_box_w, obj_box_y + obj_box_h, false);
draw_set_alpha(1.0);

draw_set_color(c_white);
draw_line_width(obj_box_x, obj_box_y, obj_box_x + obj_box_w, obj_box_y, 4);
draw_line_width(obj_box_x, obj_box_y + obj_box_h, obj_box_x + obj_box_w, obj_box_y + obj_box_h, 4);
draw_line_width(obj_box_x, obj_box_y, obj_box_x, obj_box_y + obj_box_h, 4);
draw_line_width(obj_box_x + obj_box_w, obj_box_y, obj_box_x + obj_box_w, obj_box_y + obj_box_h, 4);

draw_set_font(font_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_aqua);
draw_text(obj_box_x + 16, obj_box_y + 12, "OBJECTIVE");

draw_set_color(make_color_rgb(60, 60, 60));
draw_line_width(obj_box_x + 16, obj_box_y + 34, obj_box_x + obj_box_w - 16, obj_box_y + 34, 2);

draw_set_font(font_normal);
draw_set_color(c_white);
draw_text_ext(obj_box_x + 16, obj_box_y + 44, obj_text, 22, obj_box_w - 32);