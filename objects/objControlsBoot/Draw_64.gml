var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
var base_y = gui_h / 2;

gpu_set_texfilter(false);
draw_set_color(col_wood_base);
draw_rectangle(0, 0, gui_w, gui_h, false);

for (var xx = 0; xx < gui_w; xx += 4) {
    var wave_x = xx + floor(sin(xx * 0.02) * 12);
    if ((xx % 64) == 0) {
        draw_set_color(col_wood_deep);
        draw_rectangle(wave_x, 0, wave_x + 6, gui_h, false);
    } else if ((xx % 16) == 0) {
        draw_set_color(col_wood_grain);
        draw_line_width(wave_x, 0, wave_x + floor(cos(xx) * 2), gui_h, 1);
    }
}

for (var i = 0; i < 4; i++) {
    var knot_x = 120 + (i * 320) % (gui_w - 200);
    var knot_y = 80 + (i * 190) % (gui_h - 100);
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
    draw_rectangle(0, 0, gui_w, layer_thick, false);
    draw_rectangle(0, gui_h - layer_thick, gui_w, gui_h, false);
    draw_rectangle(0, 0, layer_thick, gui_h, false);
    draw_rectangle(gui_w - layer_thick, 0, gui_w, gui_h, false);
}
draw_set_alpha(1.0);
var matrix_saved = matrix_get(matrix_world);
var matrix_rotation = matrix_build(paper_x + paper_w / 2, paper_y + paper_h / 2, 0, 0, 0, page_flip_angle, 1, 1, 1);
matrix_set(matrix_world, matrix_rotation);
var lx1 = -paper_w / 2;
var ly1 = -paper_h / 2;
var lx2 = paper_w / 2;
var ly2 = paper_h / 2;
var sh_d = 10;
draw_set_color(col_ambient_shd);
draw_set_alpha(0.4);
draw_rectangle(lx1 + sh_d, ly1 + sh_d, lx2 + sh_d, ly2 + sh_d, false);
draw_set_alpha(1.0);
draw_set_color(col_paper);
draw_rectangle(lx1, ly1, lx2, ly2, false);
draw_set_color(col_notebook_line);
var line_gap = 24;
for (var ly = ly1 + 40; ly < ly2 - 20; ly += line_gap) {
    draw_line_width(lx1 + 16, ly, lx2 - 16, ly, 1);
}
draw_set_color(col_margin_line);
draw_line_width(lx1 + 52, ly1, lx1 + 52, ly2, 1);
draw_set_color(col_paper_shadow);
draw_rectangle(lx1, ly1, lx2, ly2, true);
draw_set_color(col_pencil_lead);
draw_rectangle(lx1 + 2, ly1 + 2, lx2 - 2, ly2 - 2, true);
var tear_w = 14;
var tear_count = ceil(paper_w / tear_w);
draw_set_color(col_paper_shadow);
for (var t = 0; t < tear_count; t++) {
    var tx = lx1 + (t * tear_w);
    if (t % 2 == 0) {
        draw_rectangle(tx, ly2, tx + tear_w, ly2 + 4, false);
    } else {
        draw_rectangle(tx + 2, ly2, tx + tear_w - 2, ly2 + 6, false);
    }
}
if (!credits_open) {
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(col_ink_main);
    draw_text(0, ly1 + 20, "CONTROLS");

    for (var i = 0; i < array_length(controls_list); i++) {
        var y_pos = ly1 + 75 + (i * 32);
        var text_color = (i == array_length(controls_list) - 1) ? col_blood_pencil : col_ink_sub;
        draw_set_color(text_color);
        draw_text(0, y_pos, controls_list[i]);
    }

    var menu_y = ly2 - 110;
    for (var i = 0; i < array_length(options); i++) {
        var y_pos = menu_y + (i * 45);
        var txt = options[i];
        if (selected_option == i) {
            draw_set_color(col_blood_pencil);
            txt = "> " + txt + " <";
        } else {
            draw_set_color(col_ink_sub);
        }
        draw_set_font(global.fonteNormal);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(0, y_pos, txt);
    }
} else {
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(col_blood_pencil);
    draw_text(0, ly1 + 20, "CREDITS");

    for (var i = 0; i < array_length(credits_list); i++) {
        var y_pos = ly1 + 65 + (i * 24);
        if (i == 0 || i == 2 || i == 5 || i == 8 || i == 11) {
            draw_set_color(col_ink_main);
        } else {
            draw_set_color(col_ink_sub);
        }
        draw_text(0, y_pos, credits_list[i]);
    }

    draw_set_font(global.fonteLegenda);
    draw_set_color(col_ink_sub);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(0, ly2 - 40, "Press [X] to return");
}
draw_set_font(global.fonteLegenda);
draw_set_color(col_ink_sub);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(0, ly2 - 12, title_text);
matrix_set(matrix_world, matrix_saved);
