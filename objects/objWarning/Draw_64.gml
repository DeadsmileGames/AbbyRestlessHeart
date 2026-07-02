var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

gpu_set_texfilter(false);

draw_clear(c_black);

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_alpha(text_alpha);
draw_set_color(c_white);
draw_text(_gw / 2, _gh / 2, warning_text);

if (is_fading_out) {
    draw_set_alpha(fade_out_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
}

draw_set_alpha(1.0);