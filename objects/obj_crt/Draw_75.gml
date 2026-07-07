if (!global.crt_active) exit;

var target_w = 1080;
var target_h = 768;

var window_w = display_get_gui_width();
var window_h = display_get_gui_height();
var scale = min(window_w / target_w, window_h / target_h);

var draw_w = target_w * scale;
var draw_h = target_h * scale;
var draw_x = (window_w - draw_w) / 2;
var draw_y = (window_h - draw_h) / 2;
draw_set_color(c_black);
draw_set_alpha(0.09);

for (var i = draw_y; i < draw_y + draw_h; i += scanline_thickness * 2) {
    draw_rectangle(draw_x, i, draw_x + draw_w, i + (scanline_thickness - 1), false);
}

var _pulse = sin(current_time * 0.05) * 0.004;
var _random_noise = random_range(-0.002, 0.002);

draw_set_color(c_white);
draw_set_alpha(0.01 + _pulse + _random_noise); 
draw_rectangle(draw_x, draw_y, draw_x + draw_w, draw_y + draw_h, false);
var _v_size = 40 * scale; 
draw_set_alpha(0.25); draw_rectangle_color(draw_x, draw_y, draw_x + draw_w, draw_y + (_v_size / 2), c_black, c_black, c_black, c_black, false);
draw_set_alpha(0.12); draw_rectangle_color(draw_x, draw_y + (_v_size / 2), draw_x + draw_w, draw_y + _v_size, c_black, c_black, c_black, c_black, false);

draw_set_alpha(0.25); draw_rectangle_color(draw_x, (draw_y + draw_h) - (_v_size / 2), draw_x + draw_w, draw_y + draw_h, c_black, c_black, c_black, c_black, false);
draw_set_alpha(0.12); draw_rectangle_color(draw_x, (draw_y + draw_h) - _v_size, draw_x + draw_w, (draw_y + draw_h) - (_v_size / 2), c_black, c_black, c_black, c_black, false);
draw_set_alpha(0.25); draw_rectangle_color(draw_x, draw_y, draw_x + (_v_size / 2), draw_y + draw_h, c_black, c_black, c_black, c_black, false);
draw_set_alpha(0.12); draw_rectangle_color(draw_x + (_v_size / 2), draw_y, draw_x + _v_size, draw_y + draw_h, c_black, c_black, c_black, c_black, false);

draw_set_alpha(0.25); draw_rectangle_color((draw_x + draw_w) - (_v_size / 2), draw_y, draw_x + draw_w, draw_y + draw_h, c_black, c_black, c_black, c_black, false);
draw_set_alpha(0.12); draw_rectangle_color((draw_x + draw_w) - _v_size, draw_y, (draw_x + draw_w) - (_v_size / 2), draw_y + draw_h, c_black, c_black, c_black, c_black, false);

draw_set_alpha(1);