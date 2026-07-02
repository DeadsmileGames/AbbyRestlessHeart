gpu_set_texfilter(false);

var _display_h_style = display_get_gui_height();

var _pad_x_style = 50;
var _anchor_y_style = _display_h_style - 60;
var _calculated_x_style = _pad_x_style + slide_offset;

draw_set_halign(fa_left);

if (chapter_number >= 0) {
    var _offset_chap_y_style = _anchor_y_style - 50;
    draw_set_font(global.fonteNormal);
    
    if (shadow) {
        draw_set_color(c_black);
        draw_set_alpha(alpha * 0.5);
        draw_text(_calculated_x_style + 2, _offset_chap_y_style + 2, "CHAPTER " + string(chapter_number));
    }
    
    draw_set_color(c_aqua);
    draw_set_alpha(alpha * 0.8);
    draw_text(_calculated_x_style, _offset_chap_y_style, "CHAPTER " + string(chapter_number));
}

draw_set_font(global.fonteTitulo);
draw_set_valign(fa_bottom);

if (shadow) {
    draw_set_color(c_black);
    draw_set_alpha(alpha * 0.5);
    draw_text(_calculated_x_style + 3, _anchor_y_style + 3, string_upper(text));
}

draw_set_color(color);
draw_set_alpha(alpha);
draw_text(_calculated_x_style, _anchor_y_style, string_upper(text));

draw_set_alpha(1.0);
draw_set_color(c_white);