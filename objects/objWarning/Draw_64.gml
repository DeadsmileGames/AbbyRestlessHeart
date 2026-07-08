var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

gpu_set_texfilter(false);
draw_set_color(col_wood_base);
draw_rectangle(0, 0, _gw, _gh, false);
for (var xx = 0; xx < _gw; xx += 4) {
    var wave_x = xx + floor(sin(xx * 0.02) * 12);
    if ((xx % 64) == 0) {
        draw_set_color(col_wood_deep);
        draw_rectangle(wave_x, 0, wave_x + 6, _gh, false);
    } else if ((xx % 16) == 0) {
        draw_set_color(col_wood_grain);
        draw_line_width(wave_x, 0, wave_x + floor(cos(xx) * 2), _gh, 1);
    }
}

for (var i = 0; i < 4; i++) {
    var knot_x = 120 + (i * 320) % (_gw - 200);
    var knot_y = 80 + (i * 190) % (_gh - 100);
    
    draw_set_color(col_wood_knot);
    draw_ellipse(knot_x, knot_y, knot_x + 40, knot_y + 24, false);
    draw_set_color(col_wood_deep);
    draw_ellipse(knot_x + 6, knot_y + 4, knot_x + 34, knot_y + 20, false);
    
    draw_line_width(knot_x - 30, knot_y + 12, knot_x, knot_y + 12, 2);
    draw_line_width(knot_x + 40, knot_y + 12, knot_x + 80, knot_y + 12, 1);
}

for (var v_idx = 0; v_idx < 12; v_idx++) {
    draw_set_color(col_ambient_shd);
    draw_set_alpha(0.06 * (v_idx + 1));
    var layer_thick = 32 * (12 - v_idx);
    draw_rectangle(0, 0, _gw, layer_thick, false);
    draw_rectangle(0, _gh - layer_thick, _gw, _gh, false);
    draw_rectangle(0, 0, layer_thick, _gh, false);
    draw_rectangle(_gw - layer_thick, 0, _gw, _gh, false);
}
draw_set_alpha(1.0);

var px1 = paper_x;
var py1 = paper_y;
var px2 = px1 + paper_w;
var py2 = py1 + paper_h;

var sh_d = 10;
draw_set_color(col_ambient_shd);
draw_set_alpha(0.4);
draw_rectangle(px1 + sh_d, py1 + sh_d, px2 + sh_d, py2 + sh_d, false);
draw_set_alpha(1.0);

draw_set_color(col_paper);
draw_rectangle(px1, py1, px2, py2, false);

draw_set_color(col_notebook_line);
var line_gap = 24;
for (var ly = py1 + 40; ly < py2 - 20; ly += line_gap) {
    draw_line_width(px1 + 16, ly, px2 - 16, ly, 1);
}

draw_set_color(col_margin_line);
draw_line_width(px1 + 52, py1, px1 + 52, py2, 1);

draw_set_color(col_paper_shadow);
draw_rectangle(px1, py1, px2, py2, true);
draw_set_color(col_pencil_lead);
draw_rectangle(px1 + 2, py1 + 2, px2 - 2, py2 - 2, true);

var tear_w = 14;
var tear_count = ceil(paper_w / tear_w);
draw_set_color(col_paper_shadow);
for (var t = 0; t < tear_count; t++) {
    var tx = px1 + (t * tear_w);
    if (t % 2 == 0) {
        draw_rectangle(tx, py2, tx + tear_w, py2 + 4, false);
    } else {
        draw_rectangle(tx + 2, py2, tx + tear_w - 2, py2 + 6, false);
    }
}

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(text_alpha);

draw_set_color(col_ink_main);
draw_text_ext(px1 + paper_w / 2, py1 + (paper_h / 2) - 30, warning_text, 28, paper_w - 100);

var confirm_key = ord("Z");
if (instance_exists(objPlayer)) {
    if (variable_instance_exists(objPlayer, "controls")) {
        if (array_length(objPlayer.controls) > 2) {
            confirm_key = objPlayer.controls[2][1];
        }
    }
}
var is_pressing = keyboard_check(confirm_key);

var btn_x = px1 + paper_w / 2;
var btn_y = py2 - 50;
var key_size = 32;

var _bx11 = btn_x - (key_size / 2);
var _by11 = btn_y - (key_size / 2);
var _bx21 = btn_x + (key_size / 2);
var _by21 = btn_y + (key_size / 2);

var _offset = is_pressing ? 3 : (sin(current_time / 250) * 2);
_by11 += _offset;
_by21 += _offset;

if (!is_pressing) {
    var k_sh = 4;
    draw_set_color(col_paper_shadow);
    draw_rectangle(_bx11 + k_sh, _by11 + k_sh, _bx21 + k_sh, _by21 + k_sh, false);
    draw_set_color(col_pencil_lead);
    draw_rectangle(_bx11 + k_sh, _by11 + k_sh, _bx21 + k_sh, _by21 + k_sh, true);
}

draw_set_color(col_paper);
draw_rectangle(_bx11, _by11, _bx21, _by21, false);

draw_set_color(col_pencil_lead);
draw_rectangle(_bx11, _by11, _bx21, _by21, true);
draw_rectangle(_bx11 + 1, _by11 + 1, _bx21 - 1, _by21 - 1, true);

if (!is_pressing) {
    draw_set_color(col_paper_shadow);
    draw_rectangle(_bx11 + 2, _by21 - 4, _bx21 - 2, _by21 - 2, false);
}

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var text_y_adjust = is_pressing ? 1 : -1;
draw_set_color(col_blood_pencil);
draw_text_transformed(btn_x, btn_y + _offset + text_y_adjust, "Z", 1.1, 1.1, 0);

draw_set_font(global.fonteLegenda);
draw_set_halign(fa_right);
draw_set_color(col_ink_sub);
draw_text(_bx11 - 12, btn_y + _offset, "Press");

draw_set_halign(fa_left);
draw_text(_bx21 + 12, btn_y + _offset, "to continue");


draw_set_alpha(1.0);