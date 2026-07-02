gpu_set_texfilter(false);

draw_sprite_ext(sprite_index, image_index, x, y + jump_y_offset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (state == "alert_anim") {
    var _percent_style = clamp(alert_timer / 10, 0, 1);
    var _size_mult_style = 1.0 + sin(_percent_style * pi) * 0.2;
    
    var _origin_x_style = x;
    var _origin_y_style = y - (sprite_height + 12) + jump_y_offset;
    
    var _w_balloon_style = 20 * _size_mult_style;
    var _h_balloon_style = 24 * _size_mult_style;
    var _rect_x1_style = _origin_x_style - (_w_balloon_style / 2);
    var _rect_y1_style = _origin_y_style - _h_balloon_style;
    var _rect_x2_style = _origin_x_style + (_w_balloon_style / 2);
    var _rect_y2_style = _origin_y_style;
    
    draw_set_alpha(1.0);
    draw_set_color(c_black);
    draw_rectangle(_rect_x1_style - 2, _rect_y1_style - 2, _rect_x2_style + 2, _rect_y2_style + 2, false);
    
    draw_set_color(c_white);
    draw_rectangle(_rect_x1_style, _rect_y1_style, _rect_x2_style, _rect_y2_style, false);
    
    draw_set_color(c_black);
    draw_triangle(_origin_x_style - 4, _rect_y2_style + 2, _origin_x_style + 4, _rect_y2_style + 2, _origin_x_style, _rect_y2_style + 8, false);
    draw_set_color(c_white);
    draw_triangle(_origin_x_style - 3, _rect_y2_style, _origin_x_style + 3, _rect_y2_style, _origin_x_style, _rect_y2_style + 5, false);
    
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_red);
    
    draw_text_transformed(_origin_x_style, _rect_y1_style + (_h_balloon_style / 2), "!", _size_mult_style, _size_mult_style, 0);
    
    draw_set_color(c_white);
}