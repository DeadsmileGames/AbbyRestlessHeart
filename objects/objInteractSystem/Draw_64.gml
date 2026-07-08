if (processing && has_choices) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var box_w = gui_w - 100;
    var box_h = 300;
    var bx1 = 50;
    var by1 = gui_h - box_h - 35;
    var bx2 = gui_w - 50;
    var by2 = gui_h - 35;

    var col_paper        = make_color_rgb(245, 238, 222); 
    var col_paper_shadow = make_color_rgb(218, 208, 188); 
    var col_paper_dark   = make_color_rgb(188, 178, 156); 
    var col_ink_main     = make_color_rgb(35, 32, 28);    
    var col_ink_sub      = make_color_rgb(95, 88, 76);    
    var col_notebook_line = make_color_rgb(192, 214, 216); 
    var col_margin_line  = make_color_rgb(225, 130, 130); 
    var col_coffee_stain = make_color_rgb(140, 115, 85);  
    var sh_d = 5;
    draw_set_color(c_black);
    draw_set_alpha(0.25);
    draw_rectangle(bx1 + sh_d, by1 + sh_d, bx2 + sh_d, by2 + sh_d, false);
    draw_set_alpha(1.0);
    draw_set_color(col_paper);
    draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(col_notebook_line);
    var line_gap = 24;
    for (var ly = by1 + 45; ly < by2 - 20; ly += line_gap) {
        draw_line_width(bx1 + 20, ly, bx2 - 20, ly, 1);
    }
    draw_set_color(col_margin_line);
    draw_line_width(bx1 + 65, by1, bx1 + 65, by2, 1);
    draw_set_color(col_paper_shadow);
    draw_rectangle(bx1, by1, bx2, by2, true);
    draw_set_color(col_paper_dark);
    draw_rectangle(bx1 + 2, by1 + 2, bx2 - 2, by2 - 2, true);
    var tear_w = 12;
    var tear_count = ceil(box_w / tear_w);
    draw_set_color(col_paper_shadow);
    for (var t = 0; t < tear_count; t++) {
        var tx = bx1 + (t * tear_w);
        if (t % 2 == 0) {
            draw_rectangle(tx, by2, tx + tear_w, by2 + 3, false);
        } else {
            draw_rectangle(tx + 1, by2, tx + tear_w - 1, by2 + 4, false);
        }
    }
    draw_set_alpha(0.08);
    draw_set_color(col_coffee_stain);
    draw_circle(bx1 + 140, by1 + 80, 24, false);
    draw_circle(bx2 - 160, by2 - 70, 32, false);
    draw_set_alpha(1.0);

    var content_x = bx1 + 85; 
    var content_y = by1 + 35;
    var max_text_width = ((bx2 - bx1) * 0.55) / 1.3; 
    if (title != "" && title != "CHOICE") {
        draw_set_font(global.fonteNormal);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(make_color_rgb(180, 40, 45));
        draw_text_transformed(content_x, content_y, string_upper(title), 1.4, 1.4, 0);
    }
    draw_set_color(col_ink_main);
    var text_y_offset = (title != "" && title != "CHOICE") ? 64 : 32;
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
                
            draw_set_color(make_color_rgb(180, 40, 45));
            draw_text_transformed(_indicator_left_x, opt_y, "*", 1.8, 1.8, 0);
            draw_text_transformed(choice_col_x, opt_y, current_choice_text, 1.3, 1.3, 0);
            draw_text_transformed(_indicator_right_x, opt_y, "*", 1.8, 1.8, 0);
        } else {
            draw_set_color(col_ink_sub); 
            draw_text_transformed(choice_col_x, opt_y, current_choice_text, 1.3, 1.3, 0);
        }
    }
}