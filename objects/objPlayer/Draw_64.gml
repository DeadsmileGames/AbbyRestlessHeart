if (!config_open) exit;

gpu_set_texfilter(false);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var menu_w = 840;
var menu_h = 540;
var box_x1 = (gui_w / 2) - (menu_w / 2);
var box_y1 = config_y + ((gui_h / 2) - (menu_h / 2));
var box_x2 = box_x1 + menu_w;
var box_y2 = box_y1 + menu_h;

var col_paper        = make_color_rgb(245, 238, 222); 
var col_paper_shadow = make_color_rgb(218, 208, 188); 
var col_paper_dark   = make_color_rgb(188, 178, 156); 
var col_ink_main     = make_color_rgb(35, 32, 28);    
var col_ink_sub      = make_color_rgb(95, 88, 76);    
var col_notebook_line = make_color_rgb(192, 214, 216); 
var col_margin_line  = make_color_rgb(225, 130, 130); 
var col_coffee_stain = make_color_rgb(140, 115, 85);  

draw_set_alpha(0.6);
draw_rectangle_color(0, 0, gui_w, gui_h, c_black, c_black, make_color_rgb(20, 15, 25), make_color_rgb(20, 15, 25), false);
draw_set_alpha(1.0);

var sh_d = 6;
draw_set_alpha(0.25);
draw_set_color(c_black);
draw_rectangle(box_x1 + sh_d, box_y1 + sh_d, box_x2 + sh_d, box_y2 + sh_d, false);
draw_set_alpha(1.0);

draw_set_color(col_paper);
draw_rectangle(box_x1, box_y1, box_x2, box_y2, false);

draw_set_color(col_paper_shadow);
draw_rectangle(box_x1 + (menu_w / 2) - 6, box_y1, box_x1 + (menu_w / 2) + 6, box_y2, false);
draw_set_color(col_paper_dark);
draw_line_width(box_x1 + (menu_w / 2), box_y1, box_x1 + (menu_w / 2), box_y2, 2);

draw_set_color(col_notebook_line);
var line_gap = 24;
var line_start_y = box_y1 + 90;
var line_end_y = box_y2 - 40;

for (var ly = line_start_y; ly < line_end_y; ly += line_gap) {
    draw_line_width(box_x1 + 40, ly, box_x1 + (menu_w / 2) - 20, ly, 1);
    draw_line_width(box_x1 + (menu_w / 2) + 20, ly, box_x2 - 40, ly, 1);
}

draw_set_color(col_margin_line);
draw_line_width(box_x1 + 52, box_y1, box_x1 + 52, box_y2, 1);
draw_line_width(box_x1 + (menu_w / 2) + 38, box_y1, box_x1 + (menu_w / 2) + 38, box_y2, 1);

var tear_w = 14;
var tear_count = ceil(menu_w / tear_w);
draw_set_color(col_paper_shadow);
for (var t = 0; t < tear_count; t++) {
    var tx = box_x1 + (t * tear_w);
    if (t % 2 == 0) {
        draw_rectangle(tx, box_y2, tx + tear_w, box_y2 + 3, false);
    } else {
        draw_rectangle(tx + 2, box_y2, tx + tear_w - 2, box_y2 + 5, false);
    }
}

draw_set_alpha(0.12);
draw_set_color(col_coffee_stain);
draw_circle(box_x1 + 120, box_y1 + 140, 32, false);
draw_circle(box_x1 + 145, box_y1 + 120, 20, false);
draw_circle(box_x2 - 100, box_y2 - 100, 48, false);
draw_set_alpha(1.0);

var tabs = ["STATUS", "INVENTORY", "SETTINGS"];
var tab_count = array_length(tabs);
var tab_w = 230; 
var tab_h = 36;
var tab_start_x = box_x1 + 45;

for (var i = 0; i < tab_count; i++) {
    var tx1 = tab_start_x + (i * (tab_w + 12));
    var tx2 = tx1 + tab_w;
    var ty1 = box_y1 - tab_h + 4;
    var ty2 = box_y1;
    
    if (config_tab == i) {
        draw_set_color(col_paper);
        draw_rectangle(tx1, ty1 - 4, tx2, ty2 + 4, false);
        draw_set_color(col_paper_shadow);
        draw_rectangle(tx1, ty1 - 4, tx2, ty2 + 4, true);
        draw_set_color(col_ink_main);
    } else {
        draw_set_color(col_paper_shadow);
        draw_rectangle(tx1, ty1, tx2, ty2, false);
        draw_set_color(col_paper_dark);
        draw_rectangle(tx1, ty1, tx2, ty2, true);
        draw_set_color(col_ink_sub);
    }
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.fonteNormal);
    
    var tab_label = tabs[i];
    if (config_tab == i) tab_label = "> " + tab_label + " <";
    draw_text((tx1 + tx2) / 2, (ty1 + ty2) / 2, tab_label);
}

if (config_tab == 0) {
    var left_x = box_x1 + 70;
    var left_y = box_y1 + 55;
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(global.fonteNormal);
    
    draw_set_color(col_ink_main);
    if (global.isMila) {
        draw_text(left_x, left_y, "CHARACTER: MILA");
    } else {
        draw_text(left_x, left_y, "CHARACTER: ABBY");
    }
    
    var text_start_y = left_y + 48;
    var row_g = 44;
    
    draw_set_color(col_ink_sub);
    draw_text(left_x, text_start_y, "HP:");
    draw_set_color(col_ink_main);
    draw_text(left_x + 80, text_start_y, string(hp_actual) + " / " + string(hp_max));
    
    draw_set_color(col_ink_sub);
    draw_text(left_x, text_start_y + row_g, "ATK:");
    draw_set_color(col_ink_main);
    draw_text(left_x + 80, text_start_y + row_g, string(stat_atk));
    
    draw_set_color(col_ink_sub);
    draw_text(left_x, text_start_y + (row_g * 2), "DEF:");
    draw_set_color(col_ink_main);
    draw_text(left_x + 80, text_start_y + (row_g * 2), string(stat_def));
    
    draw_set_color(col_paper_shadow);
    draw_line_width(left_x, text_start_y + (row_g * 3), left_x + 300, text_start_y + (row_g * 3), 2);
    
    draw_set_color(col_ink_sub);
    draw_text(left_x, text_start_y + (row_g * 3) + 16, "EQUIPMENT:");
    draw_set_color(col_ink_main);
    draw_text(left_x, text_start_y + (row_g * 3) + 48, "WEAPON: " + string(equipped_weapon));
    draw_text(left_x, text_start_y + (row_g * 3) + 76, "SHIELD: " + string(equipped_shield));

    var right_cx = box_x1 + (menu_w / 2) + (menu_w / 4);
    var right_cy = box_y1 + (menu_h / 2);
    
    draw_set_color(col_paper_shadow);
    draw_rectangle(right_cx - 70, right_cy - 100, right_cx + 70, right_cy + 60, false);
    draw_set_color(col_paper_dark);
    draw_rectangle(right_cx - 70, right_cy - 100, right_cx + 70, right_cy + 60, true);
    
    draw_set_color(c_black);
    draw_rectangle(right_cx - 60, right_cy - 90, right_cx + 60, right_cy + 20, false);
    
    if (sprite_exists(spr_idle)) {
        var p_shake_x = 0;
        var p_shake_y = 0;
        if (hp_actual / hp_max <= 0.35) {
            p_shake_x = random_range(-1.5, 1.5);
            p_shake_y = random_range(-1.5, 1.5);
        }
        draw_sprite_part_ext(spr_idle, 0, 0, 0, frame_w, frame_h, right_cx - ((frame_w * 4) / 2) + p_shake_x, right_cy - 35 - ((frame_h * 4) / 2) + p_shake_y, 4.0, 4.0, c_white, 1.0);
    }
}

if (config_tab == 1) {
    var left_page_x = box_x1 + 65;
    var page_start_y = box_y1 + 60;
    var list_w = 320;
    
    if (array_length(inventory) == 0) {
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_font(global.fonteNormal);
        draw_set_color(col_ink_sub);
        draw_text(left_page_x, page_start_y + 40, "* INVENTORY IS EMPTY *");
    } else {
        var item_h = 42;
        var max_visible = 8;
        
        for (var i = 0; i < min(array_length(inventory), max_visible); i++) {
            var item_y = page_start_y + (i * item_h);
            
            var is_equipped = false;
            if (inventory[i].type == "weapon" && equipped_weapon == inventory[i].name) is_equipped = true;
            if (inventory[i].type == "shield" && equipped_shield == inventory[i].name) is_equipped = true;
            
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_set_font(global.fonteNormal);
            
            if (config_idx == i) {
                draw_set_color(make_color_rgb(180, 40, 45));
                draw_text(left_page_x, item_y + (item_h / 2), "*");
                draw_set_color(col_ink_main);
            } else {
                draw_set_color(col_ink_sub);
            }
            
            var item_str = inventory[i].name;
            if (is_equipped) item_str += " (E)";
            draw_text(left_page_x + 20, item_y + (item_h / 2), item_str);
        }
        
        var right_page_x = box_x1 + (menu_w / 2) + 50;
        var r_box_cx = right_page_x + 150;
        
        var selected_item = inventory[config_idx];
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_set_font(global.fonteNormal);
        draw_set_color(col_ink_main);
        var text_name_y = page_start_y + 24; 
        draw_text(r_box_cx, text_name_y, selected_item.name);
        var line_y = text_name_y + 32;
        draw_set_color(col_notebook_line);
        draw_line_width(right_page_x, line_y, right_page_x + 300, line_y, 2);
        draw_set_color(col_ink_sub);
        draw_text_ext(r_box_cx, line_y + 20, selected_item.info, 22, 280); 
    }
}

if (config_tab == 2) {
    var opt_x = box_x1 + 80;
    var second_col_x = box_x1 + (menu_w / 2) + 60;
    
    if (menu_sub_state == "main") {
        var options_list = ["OPTIONS", "CONTROLS", "GAME PROGRESS", "QUIT GAME"];
        var descriptions_list = [
            "Adjust audio, display mode and screens.",
            "View active keyboard device action map.",
            "Save or load your current session.",
            "Safely abandon play back to core."
        ];
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_font(global.fonteNormal);
        
        for (var i = 0; i < 4; i++) {
            var opt_y = box_y1 + 80 + (i * 64);
            
            if (config_idx == i) {
                draw_set_color(make_color_rgb(180, 40, 45));
                draw_text(opt_x, opt_y, "* " + options_list[i]);
                draw_set_color(col_ink_main);
                draw_text_ext(second_col_x, opt_y, descriptions_list[i], 20, 280);
            } else {
                draw_set_color(col_ink_main);
                draw_text(opt_x + 16, opt_y, options_list[i]);
                draw_set_color(col_ink_sub);
                draw_text_ext(second_col_x, opt_y, descriptions_list[i], 20, 280);
            }
        }
    }
    
    if (menu_sub_state == "submenu_options") {
        var sub_texts = [
            "FULLSCREEN: " + (global.fullscreen ? "ON" : "OFF"),
            "BGM VOLUME: " + string(round(global.vol_bgm * 100)) + "%",
            "SFX VOLUME: " + string(round(global.vol_sfx * 100)) + "%",
            "BACK"
        ];
        var sub_desc_list = [
            "Toggle display bounds mode.",
            "Set level background track volume.",
            "Set responsive sound triggers force.",
            "Return back to utility index."
        ];
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_font(global.fonteNormal);
        
        for (var i = 0; i < 4; i++) {
            var opt_y = box_y1 + 80 + (i * 64);
            
            if (sub_menu_idx == i) {
                draw_set_color(make_color_rgb(180, 40, 45));
                draw_text(opt_x, opt_y, "* " + sub_texts[i]);
                draw_set_color(col_ink_main);
                draw_text_ext(second_col_x, opt_y, sub_desc_list[i], 20, 280);
            } else {
                draw_set_color(col_ink_main);
                draw_text(opt_x + 16, opt_y, sub_texts[i]);
                draw_set_color(col_ink_sub);
                draw_text_ext(second_col_x, opt_y, sub_desc_list[i], 20, 280);
            }
        }
    }
    
    if (menu_sub_state == "submenu_controls") {
        var center_page_x = box_x1 + (menu_w / 2);
        var ctrl_y = box_y1 + 75;
        
        draw_set_halign(fa_center);
        draw_set_font(global.fonteNormal);
        draw_set_color(make_color_rgb(180, 40, 45));
        draw_text(center_page_x, ctrl_y, "CONTROLS");
        
        var binds_g = 42;
        var start_b_y = ctrl_y + 55;
        var actions = ["MOVE:", "SPRINT:", "CONFIRM / ACTION:", "CANCEL / BACK:", "FULLSCREEN:", "CRT TOGGLE:"];
        var keys    = ["ARROW KEYS", "LEFT SHIFT", "Z KEY", "X KEY", "F4 KEY", "F6 KEY"];
        
        for (var k = 0; k < 6; k++) {
            draw_set_halign(fa_left);
            draw_set_color(col_ink_sub);
            draw_text(box_x1 + 80, start_b_y + (k * binds_g), actions[k]);
            
            draw_set_halign(fa_right);
            draw_set_color(col_ink_main);
            draw_text(box_x2 - 80, start_b_y + (k * binds_g), keys[k]);
        }
    }
    
    if (menu_sub_state == "submenu_game") {
        var game_actions = ["SAVE GAME", "LOAD GAME", "BACK"];
        var game_desc_list = [
            "Commit your state variables to storage file.",
            "Fetch snapshot record arrays from system.",
            "Revert configuration view index state."
        ];
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_font(global.fonteNormal);
        
        for (var i = 0; i < 3; i++) {
            var opt_y = box_y1 + 100 + (i * 70);
            var draw_x = opt_x;
            
            if (i == 1 && shake_continue > 0) draw_x += random_range(-2, 2);
            
            if (i == 1 && error_flash_continue > 0) {
                draw_set_color(make_color_rgb(180, 40, 45));
                draw_text(draw_x, opt_y, "* " + game_actions[i]);
            } else if (sub_menu_idx == i) {
                draw_set_color(make_color_rgb(180, 40, 45));
                draw_text(draw_x, opt_y, "* " + game_actions[i]);
                draw_set_color(col_ink_main);
                draw_text_ext(second_col_x, opt_y, game_desc_list[i], 20, 280);
            } else {
                draw_set_color(col_ink_main);
                draw_text(draw_x + 16, opt_y, game_actions[i]);
                draw_set_color(col_ink_sub);
                draw_text_ext(second_col_x, opt_y, game_desc_list[i], 20, 280);
            }
        }
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_font(global.fonteLegenda);
draw_set_color(col_ink_sub);
draw_text(box_x1 + 30, box_y2 - 14, "Z: CONFIRM");
draw_set_halign(fa_right);
draw_text(box_x2 - 30, box_y2 - 14, "X: BACK / CLOSE");

if (menu_sub_state == "submenu_save_confirm") {
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var pop_w = 420;
    var pop_h = 130;
    var px1 = (gui_w / 2) - (pop_w / 2);
    var py1 = (gui_h / 2) - (pop_h / 2);
    
    draw_set_color(make_color_rgb(245, 240, 180));
    draw_rectangle(px1, py1, px1 + pop_w, py1 + pop_h, false);
    draw_set_color(col_paper_dark);
    draw_rectangle(px1, py1, px1 + pop_w, py1 + pop_h, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.fonteNormal);
    draw_set_color(col_ink_main);
    draw_text(gui_w / 2, py1 + 40, "PROGRESS SAVED");
    draw_set_color(col_ink_sub);
    draw_text(gui_w / 2, py1 + 90, "PRESS Z TO CONTINUE");
}

if (menu_sub_state == "submenu_load_info") {
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var pop_w = 460;
    var pop_h = 200;
    var px1 = (gui_w / 2) - (pop_w / 2);
    var py1 = (gui_h / 2) - (pop_h / 2);
    
    draw_set_color(make_color_rgb(240, 230, 210));
    draw_rectangle(px1, py1, px1 + pop_w, py1 + pop_h, false);
    draw_set_color(col_paper_dark);
    draw_rectangle(px1, py1, px1 + pop_w, py1 + pop_h, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(global.fonteNormal);
    draw_set_color(make_color_rgb(180, 40, 45));
    draw_text(gui_w / 2, py1 + 20, "FILE DATA LOAD");
    
    draw_set_color(col_notebook_line);
    draw_line(px1 + 30, py1 + 54, px1 + pop_w - 30, py1 + 54);
    
    if (file_exists("save.json")) {
        var _f = file_text_open_read("save.json");
        var _json = file_text_read_string(_f);
        file_text_close(_f);
        var _data = json_parse(_json);
        
        draw_set_halign(fa_left);
        draw_set_color(col_ink_main);
        draw_text(px1 + 40, py1 + 75, "SAVE DATA FOUND");
        draw_text(px1 + 40, py1 + 110, "HP: " + string(_data.hp) + " / " + string(_data.hp_max));
        
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(180, 40, 45));
        draw_text(gui_w / 2, py1 + 160, "Z - LOAD FILE / X - CANCEL");
    } else {
        draw_set_valign(fa_middle);
        draw_set_color(col_ink_sub);
        draw_text(gui_w / 2, py1 + 100, "NO SAVE DATA FOUND");
        draw_set_valign(fa_top);
        draw_set_color(col_ink_sub);
        draw_text(gui_w / 2, py1 + 160, "PRESS X TO RETURN");
    }
}

if (menu_sub_state == "item_box") {
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var pop_w = 420;
    var pop_h = 210;
    var px1 = (gui_w / 2) - (pop_w / 2);
    var py1 = (gui_h / 2) - (pop_h / 2);
    
    draw_set_color(col_paper);
    draw_rectangle(px1, py1, px1 + pop_w, py1 + pop_h, false);
    draw_set_color(col_paper_dark);
    draw_rectangle(px1, py1, px1 + pop_w, py1 + pop_h, true);
    
    var current_item = inventory[config_idx];
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(global.fonteNormal);
    draw_set_color(col_ink_main);
    draw_text(px1 + 32, py1 + 20, current_item.name);
    
    var action_text = "EQUIP";
    if (current_item.type == "weapon" && equipped_weapon == current_item.name) action_text = "UNEQUIP";
    if (current_item.type == "shield" && equipped_shield == current_item.name) action_text = "UNEQUIP";
    
    var sub_opts = (current_item.type == "heal") ? ["USE", "DROP", "CANCEL"] : [action_text, "DROP", "CANCEL"];
    
    var opt_start_y = py1 + 60;
    var opt_gap_y = 40;
    for (var i = 0; i < 3; i++) {
        var opt_box_y = opt_start_y + (i * opt_gap_y);
        
        if (box_selected_opt == i) {
            draw_set_color(col_paper_shadow);
            draw_rectangle(px1 + 32, opt_box_y, px1 + pop_w - 32, opt_box_y + 32, false);
            draw_set_color(make_color_rgb(180, 40, 45));
            draw_rectangle(px1 + 32, opt_box_y, px1 + pop_w - 32, opt_box_y + 32, true);
            draw_set_color(col_ink_main);
        } else {
            draw_set_color(col_paper);
            draw_rectangle(px1 + 32, opt_box_y, px1 + pop_w - 32, opt_box_y + 32, false);
            draw_set_color(col_paper_shadow);
            draw_rectangle(px1 + 32, opt_box_y, px1 + pop_w - 32, opt_box_y + 32, true);
            draw_set_color(col_ink_sub);
        }
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text((px1 + 32 + px1 + pop_w - 32) / 2, opt_box_y + 16, sub_opts[i]);
    }
}
for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    var p_size = 6;
    var p_angle = (current_time / 4) * (p.alpha * 1.5) + (i * 45);
    
    var rad = degtorad(p_angle);
    var cos_a = cos(rad) * p_size;
    var sin_a = sin(rad) * p_size;

    draw_set_color(col_paper_shadow);
    draw_set_alpha(p.alpha * 0.35);
    
    draw_primitive_begin(pr_trianglestrip);
    draw_vertex(p.xx - cos_a, p.yy + config_y - sin_a);
    draw_vertex(p.xx + sin_a, p.yy + config_y - cos_a);
    draw_vertex(p.xx - sin_a, p.yy + config_y + cos_a);
    draw_vertex(p.xx + cos_a, p.yy + config_y + sin_a);
    draw_primitive_end();
}

draw_set_alpha(1.0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);