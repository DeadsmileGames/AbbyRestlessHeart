if (processing && has_choices) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var box_w = gui_w - 100;
    var box_h = 300;
    var bx1 = 50;
    var by1 = gui_h - box_h - 35;
    var bx2 = gui_w - 50;
    var by2 = gui_h - 35;
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(bx1 + 10, by1 + 10, bx2 + 10, by2 + 10, false);
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_line_width(bx1, by1, bx2, by1, 8);
    draw_line_width(bx1, by2, bx2, by2, 8);
    draw_line_width(bx1, by1, bx1, by2, 8);
    draw_line_width(bx2, by1, bx2, by2, 8);
    var corner_size = 10;
    draw_rectangle(bx1, by1, bx1 + corner_size, by1 + corner_size, true);
    draw_rectangle(bx2 - corner_size, by1, bx2, by1 + corner_size, true);
    draw_rectangle(bx1, by2 - corner_size, bx1 + corner_size, by2, true);
    draw_rectangle(bx2 - corner_size, by2 - corner_size, bx2, by2, true);
    var content_x = bx1 + 50;
    var content_y = by1 + 35;
    var max_text_width = ((bx2 - bx1) * 0.55) / 1.3; 

    if (title != "" && title != "CHOICE") {
        draw_set_font(global.fonteNormal);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_yellow);
        draw_text_transformed(content_x, content_y, string_upper(title), 1.4, 1.4, 0);
    }

    draw_set_color(color);
    var text_y_offset = (title != "" && title != "CHOICE") ? 65 : 35;
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text_ext_transformed(content_x, content_y + text_y_offset, text, 28, max_text_width, 1.3, 1.3, 0);
    var choice_col_x = bx1 + ((bx2 - bx1) * 0.75);
    var choice_y_start = by1 + 80;
    var choice_spacing = 60;
        
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
        
    for (var i = 0; i < array_length(choice_array); i++) {
        var current_choice_text = choice_array[i];
        var opt_y = choice_y_start + (i * choice_spacing);

        if (choice_selected == i) {
            var _text_half_width = (string_width(current_choice_text) * 1.3) / 2;
            var _indicator_left_x = choice_col_x - _text_half_width - 25;
            var _indicator_right_x = choice_col_x + _text_half_width + 25;
                
            draw_set_color(c_yellow);
            draw_text_transformed(_indicator_left_x, opt_y, ">", 1.8, 1.8, 0);
            draw_text_transformed(choice_col_x, opt_y, current_choice_text, 1.3, 1.3, 0);
            draw_text_transformed(_indicator_right_x, opt_y, "<", 1.8, 1.8, 0);
        } else {
            draw_set_color(c_white);
            draw_text_transformed(choice_col_x, opt_y, current_choice_text, 1.3, 1.3, 0);
        }
    }
}