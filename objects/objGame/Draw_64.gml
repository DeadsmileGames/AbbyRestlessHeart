gpu_set_texfilter(false);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
var base_y = gui_h / 2;

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
draw_set_color(col_wood_light ?? make_color_rgb(59, 43, 34));
draw_set_alpha(0.4);
for (var i = 0; i < max_pixels; i++) {
    var px = pixel_list[i].xx;
    var py = pixel_list[i].yy;
    var psize = pixel_list[i].size;
    draw_rectangle(px, py, px + psize - 1, py + psize - 1, false);
}
draw_set_alpha(1.0);

if (current_text_index < array_length(history_texts)) {
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (show_menu_buttons && !config_open) draw_set_alpha(1.0);
    else draw_set_alpha(text_alpha);
    
    var is_question = (current_text_index >= 12 && current_text_index <= 24 && current_text_index % 2 == 0);
    var is_game_reply = (current_text_index % 2 != 0 && current_text_index >= 13 && current_text_index <= 25);
    
    var text_shake_x = 0;
    var text_shake_y = 0;
    if (current_text_index == 8 || current_text_index == 10 || is_question) {
        text_shake_x = random_range(-0.8, 0.8);
        text_shake_y = random_range(-0.5, 0.5);
    }

    if (current_text_index == array_length(history_texts) - 1) {
        var p1 = "Tomorrow will be a better "; var p2 = "DAY.";
        var w1 = string_width(p1) * text_scale; var w2 = string_width(p2) * text_scale;
        var start_x = base_x - ((w1 + w2) / 2);
        draw_set_color(col_paper);
        draw_text_transformed(start_x + (w1/2) + text_shake_x, gui_h / 2 + text_shake_y, p1, text_scale, text_scale, 0);
        draw_set_color(col_blood_pencil);
        draw_text_transformed(start_x + w1 + (w2/2) + text_shake_x, gui_h / 2 + text_shake_y, p2, text_scale, text_scale, 0);
    } else if (current_text_index == 8) {
        var p1 = "And honestly? "; var p2 = "A quiet part of me didn't care if it hit me.";
        var w1 = string_width(p1) * text_scale; var w2 = string_width(p2) * text_scale;
        var start_x = base_x - ((w1 + w2) / 2);
        draw_set_color(col_paper);
        draw_text_transformed(start_x + (w1/2) + text_shake_x, gui_h / 2 + text_shake_y, p1, text_scale, text_scale, 0);
        draw_set_color(col_margin_line);
        draw_text_transformed(start_x + w1 + (w2/2) + text_shake_x, gui_h / 2 + text_shake_y, p2, text_scale, text_scale, 0);
    } else if (is_question) {
        var by1 = base_y - 120 - 30;
        draw_set_color(col_paper);
        draw_text_ext_transformed(base_x + text_shake_x, by1 + 45 + text_shake_y, history_texts[current_text_index], 28, gui_w - 200, text_scale, text_scale, 0);
        
        var q_idx = (current_text_index - 12) / 2;
        var choices = history_choices[q_idx];
        var choice_y_start = by1 + 140;
        for (var i = 0; i < 3; i++) {
            if (choice_index == i) {
                draw_set_color(col_blood_pencil);
                var choice_label = "> " + choices[i] + " <";
            } else {
                draw_set_color(col_paper_shadow);
                var choice_label = choices[i];
            }
            draw_text_transformed(base_x, choice_y_start + (i * 40), choice_label, text_scale, text_scale, 0);
        }
    } else if (is_game_reply || current_text_index == 26 || current_text_index == 27) {
        draw_set_color(col_margin_line);
        draw_text_ext_transformed(base_x + text_shake_x, gui_h / 2 + text_shake_y, history_texts[current_text_index], 28, gui_w - 200, text_scale, text_scale, 0);
    } else {
        draw_set_color(col_paper);
        draw_text_ext_transformed(base_x + text_shake_x, gui_h / 2 + text_shake_y, history_texts[current_text_index], 28, gui_w - 200, text_scale, text_scale, 0);
    }
    
    if (show_skip_prompt) {
        var alpha = 0.4 + sin(current_time / 400) * 0.3;
        draw_set_font(global.fonteLegenda);
        draw_set_halign(fa_center); draw_set_valign(fa_bottom);
        draw_set_color(col_paper_shadow); draw_set_alpha(alpha);
        draw_text(gui_w / 2, gui_h - 20, "[X] to skip");
        draw_set_alpha(1.0);
    }
}

if (show_menu_buttons && !config_open && menu_sub_state == "main" && !is_transitioning) {
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    var menu_start_y = gui_h / 2 - 20;
    var menu_spacing = 45;
    for (var i = 0; i < array_length(main_options); i++) {
        var final_x = base_x;
        var final_y = menu_start_y + (i * menu_spacing);
        var is_load = (main_options[i] == "LOAD SAVE");
        if (is_load && shake_load > 0) final_x += random_range(-shake_load/4, shake_load/4);
        
        if (is_load && error_flash_load > 0) draw_set_color(col_blood_pencil);
        else draw_set_color(menu_index == i ? col_paper : col_ink_sub);
        
        var label = menu_index == i ? "* " + main_options[i] + "  *" : main_options[i];
        draw_text_transformed(final_x, final_y, label, text_scale, text_scale, 0);
    }
    draw_set_font(global.fonteLegenda);
    draw_set_halign(fa_right); draw_set_valign(fa_bottom);
    draw_set_color(col_ink_sub);
    draw_text(gui_w - 20, gui_h - 20, game_version);
}
if (config_y > -450) {
    var matrix_saved_cfg = matrix_get(matrix_world);
    var box_w = gui_w - 120;
    var box_height = 360;
    
    var matrix_rotation_cfg = matrix_build(60 + box_w/2, config_y + 40 + box_height/2, 0, 0, 0, config_angle, 1, 1, 1);
    matrix_set(matrix_world, matrix_rotation_cfg);
    
    var lx1 = -box_w / 2; var ly1 = -box_height / 2;
    var lx2 = box_w / 2;  var ly2 = box_height / 2;
    
    draw_set_color(col_ambient_shd); draw_set_alpha(0.35);
    draw_rectangle(lx1 + 8, ly1 + 8, lx2 + 8, ly2 + 8, false);
    draw_set_alpha(1.0);
    
    draw_set_color(col_paper); draw_rectangle(lx1, ly1, lx2, ly2, false);
    
    draw_set_color(col_notebook_line);
    for (var ly = ly1 + 35; ly < ly2 - 20; ly += 24) draw_line_width(lx1 + 16, ly, lx2 - 16, ly, 1);
    
    draw_set_color(col_margin_line); draw_line_width(lx1 + 52, ly1, lx1 + 52, ly2, 1);
    
    draw_set_color(col_paper_shadow); draw_rectangle(lx1, ly1, lx2, ly2, true);
    draw_set_color(col_pencil_lead); draw_rectangle(lx1 + 2, ly1 + 2, lx2 - 2, ly2 - 2, true);
    
    draw_set_font(global.fonteNormal); draw_set_valign(fa_top);
    var tabs = ["GRAPHICS", "AUDIO", "CONTROLS", "SUPPORT"];
    var t_w = box_w / 4;
    for (var i = 0; i < 4; i++) {
        draw_set_color(config_tab == i ? col_blood_pencil : col_ink_sub);
        var tab_label = config_tab == i ? "* " + tabs[i] + " *" : tabs[i];
        draw_set_halign(fa_center);
        draw_text(lx1 + (t_w * i) + (t_w / 2), ly1 + 25, tab_label);
    }
    
    var inner_y = ly1 + 95;
    if (config_tab == 0) {
        draw_set_halign(fa_center); draw_set_color(config_idx == 0 ? col_blood_pencil : col_ink_main);
        draw_text(0, inner_y + 40, "FULLSCREEN: " + (global.fullscreen ? "[ ON ]" : "[ OFF ]"));
    } else if (config_tab == 1) {
        var opt_text = ["BGM VOLUME: " + string(round(global.vol_bgm * 100)) + "%", "SFX VOLUME: " + string(round(global.vol_sfx * 100)) + "%"];
        for (var i = 0; i < 2; i++) {
            draw_set_halign(fa_center); draw_set_color(config_idx == i ? col_blood_pencil : col_ink_main);
            draw_text(0, inner_y + (i * 50), opt_text[i]);
        }
    } else if (config_tab == 2) {
        draw_set_halign(fa_center); draw_set_color(col_ink_main);
        draw_text(0, inner_y, "MOVE: ARROW KEYS");
        draw_text(0, inner_y + 35, "SPRINT: SHIFT");
        draw_text(0, inner_y + 70, "CONFIRM / ACTION: Z");
        draw_text(0, inner_y + 105, "CANCEL / BACK: X");
    } else if (config_tab == 3) {
        draw_set_halign(fa_center); draw_set_color(col_ink_main);
        draw_text(0, inner_y, "SUPPORT THE GAME");
        draw_set_color(col_ink_sub); draw_text(0, inner_y + 40, "Visit our Itch.io page:");
        draw_set_color(col_blood_pencil); draw_text(0, inner_y + 75, "https://somiari.itch.io/insomnia");
        draw_set_color(config_idx == 0 ? col_blood_pencil : col_ink_main);
        var btn_txt = config_idx == 0 ? "* VISIT PAGE *" : "VISIT PAGE";
        draw_text(0, inner_y + 140, btn_txt);
    }
    
    draw_set_font(global.fonteLegenda); draw_set_color(col_ink_sub); draw_set_halign(fa_center);
    draw_text(0, ly2 - 25, "PRESS X TO RETURN TO MAIN MENU");
    
    matrix_set(matrix_world, matrix_saved_cfg);
}

if (load_paper_y < gui_h + 100) {
    var matrix_saved_ld = matrix_get(matrix_world);
    var box_w = 580; var box_h = 300;
    
    var matrix_rotation_ld = matrix_build(base_x, load_paper_y + box_h/2, 0, 0, 0, load_paper_angle, 1, 1, 1);
    matrix_set(matrix_world, matrix_rotation_ld);
    
    var lx1 = -box_w / 2; var ly1 = -box_h / 2;
    var lx2 = box_w / 2;  var ly2 = box_h / 2;
    
    draw_set_color(col_ambient_shd); draw_set_alpha(0.35);
    draw_rectangle(lx1 + 8, ly1 + 8, lx2 + 8, ly2 + 8, false);
    draw_set_alpha(1.0);
    
    draw_set_color(col_paper); draw_rectangle(lx1, ly1, lx2, ly2, false);
    
    draw_set_color(col_notebook_line);
    for (var ly = ly1 + 35; ly < ly2 - 20; ly += 24) draw_line_width(lx1 + 16, ly, lx2 - 16, ly, 1);
    
    draw_set_color(col_margin_line); draw_line_width(lx1 + 52, ly1, lx1 + 52, ly2, 1);
    draw_set_color(col_paper_shadow); draw_rectangle(lx1, ly1, lx2, ly2, true);
    draw_set_color(col_pencil_lead); draw_rectangle(lx1 + 2, ly1 + 2, lx2 - 2, ly2 - 2, true);
    
    draw_set_font(global.fonteNormal); draw_set_halign(fa_center); draw_set_valign(fa_top);
    draw_set_color(col_blood_pencil); draw_text(0, ly1 + 25, "LOAD DATA PROGRESS");
    
    var ox = lx1 + 60; var oy = ly1 + 80;
    
    if (file_exists("save.json")) {
        var _f = file_text_open_read("save.json");
        var _json = file_text_read_string(_f);
        file_text_close(_f);
        var _data = json_parse(_json);
        
        draw_set_halign(fa_left);
        draw_set_color(col_ink_sub); draw_text(ox, oy, "STATUS");
        draw_set_color(col_ink_main); draw_text(ox + 120, oy, "ACTIVE FILE");
        
        draw_set_color(col_ink_sub); draw_text(ox, oy + 40, "HP");
        draw_set_color(col_blood_pencil); draw_text(ox + 120, oy + 40, string(_data.hp) + "/" + string(_data.hp_max));
        
        draw_set_color(col_ink_sub); draw_text(ox, oy + 80, "INVENTORY");
        draw_set_color(col_ink_main); draw_text(ox + 120, oy + 80, string(array_length(_data.inventory)) + " ITEMS");
        
        draw_set_font(global.fonteLegenda); draw_set_color(col_ink_sub); draw_set_halign(fa_center);
        draw_text(0, ly2 - 35, "Z - CONFIRM LOAD / X - CANCEL");
    } else {
        draw_set_halign(fa_center); draw_set_color(col_blood_pencil);
        draw_text(0, oy + 40, "NO SAVE DATA FOUND IN THIS DIRECTORY");
        draw_set_font(global.fonteLegenda); draw_set_color(col_ink_sub);
        draw_text(0, ly2 - 35, "PRESS Z OR X TO CLOSE");
    }
    
    matrix_set(matrix_world, matrix_saved_ld);
}

for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    draw_set_color(col_blood_pencil); draw_set_alpha(p.alpha);
    draw_rectangle(p.xx, p.yy, p.xx + choose(2,3), p.yy + choose(2,3), false);
}
draw_set_alpha(1.0);

if (is_transitioning) {
    draw_set_color(col_pencil_lead);
    draw_set_alpha(1.0);
    var slice_height = gui_h / slice_count;
    for (var i = 0; i < slice_count; i++) {
        var yy1 = i * slice_height;
        var yy2 = yy1 + slice_height;
        if (i % 2 == 0) draw_rectangle(0, yy1, slice_widths[i], yy2, false);
        else draw_rectangle(gui_w - slice_widths[i], yy1, gui_w, yy2, false);
    }
}
draw_set_alpha(1.0);
draw_set_color(c_white);