var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var base_x = _gw / 2;
var base_y = _gh / 2;

gpu_set_texfilter(false);
draw_set_color(col_wood_base);
draw_rectangle(0, 0, _gw, _gh, false);

for (var xx = 0; xx < _gw; xx += 8) {
    var wave_x = xx + floor(sin(xx * 0.02) * 12);
    if ((xx % 64) == 0) {
        draw_set_color(col_wood_deep);
        draw_rectangle(wave_x, 0, wave_x + 5, _gh, false);
    } else if ((xx % 32) == 0) {
        draw_set_color(col_wood_grain);
        draw_line(wave_x, 0, wave_x, _gh);
    }
}

draw_set_color(col_wood_knot);
for (var i = 0; i < 3; i++) {
    var knot_x = 200 + (i * 350) % (_gw - 200);
    var knot_y = 150 + (i * 200) % (_gh - 100);
    draw_rectangle(knot_x, knot_y, knot_x + 32, knot_y + 16, false);
}

for (var v_idx = 0; v_idx < 4; v_idx++) {
    draw_set_color(col_ambient_shd);
    draw_set_alpha(0.15 * (v_idx + 1));
    var layer_thick = 80 * (4 - v_idx);
    draw_rectangle(0, 0, _gw, layer_thick, false);
    draw_rectangle(0, _gh - layer_thick, _gw, _gh, false);
    draw_rectangle(0, 0, layer_thick, _gh, false);
    draw_rectangle(_gw - layer_thick, 0, _gw, _gh, false);
}
draw_set_alpha(1.0);
if (state < 7) {
    var matrix_saved = matrix_get(matrix_world);
    var matrix_rotation = matrix_build(paper_x + paper_w / 2, paper_y + paper_h / 2, 0, 0, 0, paper_angle, 1, 1, 1);
    matrix_set(matrix_world, matrix_rotation);

    var lx1 = -paper_w / 2;
    var ly1 = -paper_h / 2;
    var lx2 = paper_w / 2;
    var ly2 = paper_h / 2;

    draw_set_alpha(paper_alpha);

    draw_set_color(col_ambient_shd);
    draw_set_alpha(0.3 * paper_alpha);
    draw_rectangle(lx1 + 10, ly1 + 10, lx2 + 10, ly2 + 10, false);
    draw_set_alpha(paper_alpha);

    draw_set_color(col_paper);
    draw_rectangle(lx1, ly1, lx2, ly2, false);

    draw_set_color(col_notebook_line);
    for (var ly = ly1 + 40; ly < ly2 - 20; ly += 24) {
        draw_line(lx1 + 16, ly, lx2 - 16, ly);
    }

    draw_set_color(col_margin_line);
    draw_line(lx1 + 52, ly1, lx1 + 52, ly2);

    draw_set_color(col_pencil_lead);
    draw_rectangle(lx1, ly1, lx2, ly2, true);
    draw_rectangle(lx1 + 2, ly1 + 2, lx2 - 2, ly2 - 2, true);

    var tear_w = 14;
    var tear_count = ceil(paper_w / tear_w);
    draw_set_color(col_paper_shadow);
    for (var t = 0; t < tear_count; t++) {
        var tx = lx1 + (t * tear_w);
        if (t % 2 == 0) draw_rectangle(tx, ly2, tx + tear_w, ly2 + 4, false);
        else draw_rectangle(tx + 2, ly2, tx + tear_w - 2, ly2 + 6, false);
    }
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    if (state >= 1) {
        draw_set_font(global.fonteTitulo2);
        draw_set_color(col_pencil_lead);
        var current_string = string_copy("INSOMNIA", 1, floor(draw_text_progress));
        var t_shake = (state == 1) ? random_range(-1, 1) : 0;
        
        var title_a = (state == 6) ? paper_alpha : 1.0;
        draw_set_alpha(title_a);
        draw_text(t_shake, -40 + t_shake, current_string);
    }

    if (state >= 3) {
        draw_set_font(global.fonteTitulo);
        draw_set_color(col_blood_pencil);
        var current_sub = string_copy("CHAPTER 1", 1, floor(sub_text_progress));
        var s_shake = (state == 3) ? random_range(-1, 1) : 0;
        
        var subtitle_a = (state == 6) ? paper_alpha : 1.0;
        draw_set_alpha(subtitle_a);
        draw_text(s_shake, 40 + s_shake, current_sub);
    }

    matrix_set(matrix_world, matrix_saved);
}

if (version_alpha > 0 && state < 6) {
    draw_set_font(global.fonteNormal);
    draw_set_color(col_ink_sub); draw_set_alpha(version_alpha);
    
    draw_set_halign(fa_left); draw_set_valign(fa_bottom);
    draw_text(40, _gh - 40, game_version);
    
    draw_set_halign(fa_right);
    draw_text(_gw - 40, _gh - 40, "Created by SOMIARI GAMES");
    draw_set_alpha(1.0);
}

var shards_len = array_length(lead_shards);
for (var i = 0; i < shards_len; i++) {
    var s = lead_shards[i];
    draw_set_color(col_blood_pencil); draw_set_alpha(s.alpha);
    draw_rectangle(s.xx, s.yy, s.xx + s.size, s.yy + s.size, false);
}

var ash_len = array_length(ash_particles);
for (var i = 0; i < ash_len; i++) {
    var a = ash_particles[i];
    draw_set_color(col_pencil_lead); draw_set_alpha(a.alpha);
    draw_rectangle(a.xx, a.yy, a.xx + a.size, a.yy + a.size, false);
}

draw_set_alpha(1.0);