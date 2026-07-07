if (show_prompt && !instance_exists(objBattleManager)) {
    var _x = x;
    var _y = y - 40;
    var _w1 = 140;
    var _h1 = 28;
    var _bx11 = _x - (_w1 / 2);
    var _by11 = _y - (_h1 / 2);
    var _bx21 = _x + (_w1 / 2);
    var _by21 = _y + (_h1 / 2);
    
    var _offset = sin(current_time / 300) * 3;
    _by11 += _offset;
    _by21 += _offset;
    
    draw_set_color(c_black);
    draw_rectangle(_bx11, _by11, _bx21, _by21, false);
    
    draw_set_color(c_white);
    draw_line_width(_bx11, _by11, _bx21, _by11, 2);
    draw_line_width(_bx11, _by21, _bx21, _by21, 2);
    draw_line_width(_bx11, _by11, _bx11, _by21, 2);
    draw_line_width(_bx21, _by11, _bx21, _by21, 2);
    
    var corner = 4;
    draw_rectangle(_bx11, _by11, _bx11 + corner, _by11 + corner, true);
    draw_rectangle(_bx21 - corner, _by11, _bx21, _by11 + corner, true);
    draw_rectangle(_bx11, _by21 - corner, _bx11 + corner, _by21, true);
    draw_rectangle(_bx21 - corner, _by21 - corner, _bx21, _by21, true);
    
    draw_set_font(global.fonteLegenda);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_x, _y + _offset, "[Z] to Interact");
}

if (debug_mode1) {
    draw_set_color(c_red);
    draw_set_alpha(0.3);
    draw_circle(x, y, trigger_distance, false);
    draw_set_alpha(1);
    draw_rectangle(x - 16, y - 16, x + 16, y + 16, false);
}