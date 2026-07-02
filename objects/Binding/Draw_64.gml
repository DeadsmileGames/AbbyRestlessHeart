if (esc_hold_timer > 0) {
    gpu_set_texfilter(false);
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var _alpha = clamp(esc_hold_timer / 30, 0, 1);
    draw_set_alpha(_alpha);
    draw_set_color(c_white);
    
    draw_text(30, 30, "QUITTING...");
    draw_set_alpha(1.0);
}