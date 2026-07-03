if (!config_open && config_y <= -350) exit;

gpu_set_texfilter(false);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
var base_y = config_y + 40;

var box_x1 = 50;
var box_y1 = base_y;
var box_x2 = gui_w - 50;
var box_y2 = base_y + 430;

draw_set_color(c_black);
draw_rectangle(box_x1, box_y1, box_x2, box_y2, false);

draw_set_color(c_white);
draw_line_width(box_x1, box_y1, box_x2, box_y1, 6);
draw_line_width(box_x1, box_y2, box_x2, box_y2, 6);
draw_line_width(box_x1, box_y1, box_x1, box_y2, 6);
draw_line_width(box_x2, box_y1, box_x2, box_y2, 6);

draw_set_font(global.fonteNormal);
draw_set_valign(fa_top);
draw_set_halign(fa_center);

var tabs = ["STATUS", "INVENTORY", "SETTINGS"];
var t_w = (box_x2 - box_x1) / 3;
var tab_y = box_y1 + 24;

for(var i = 0; i < 3; i++) {
    if (config_tab == i) {
        draw_set_color(c_yellow);
        var tab_label = "> " + tabs[i] + " <";
    } else {
        draw_set_color(c_white);
        var tab_label = tabs[i];
    }
    draw_text(box_x1 + (t_w * i) + (t_w / 2), tab_y, tab_label);
}

draw_set_color(c_white);
draw_line_width(box_x1 + 20, tab_y + 40, box_x2 - 20, tab_y + 40, 4);

var inner_y = tab_y + 65;

if (config_tab == 0) {
    var card_x = box_x1 + 45;
    var card_y = inner_y + 15;
    
    draw_set_halign(fa_left);
    draw_set_color(c_yellow);
    if (global.isMila) {
        draw_text(card_x, card_y, string_upper("MILA"));
    } else {
        draw_text(card_x, card_y, string_upper("ABBY"));
    }
    
    draw_set_color(c_white);
    draw_text(card_x, card_y + 45, "HP:  " + string(hp_actual) + " / " + string(hp_max));
    draw_text(card_x, card_y + 85, "ATK: " + string(stat_atk));
    draw_text(card_x, card_y + 125, "DEF: " + string(stat_def));
    
    draw_set_color(make_color_rgb(100, 100, 100));
    draw_line_width(card_x, card_y + 175, card_x + 280, card_y + 175, 2);
    
    draw_set_color(c_white);
    draw_text(card_x, card_y + 195, "WEAPON: " + string(equipped_weapon));
    draw_text(card_x, card_y + 235, "SHIELD: " + string(equipped_shield));
    
    if (sprite_exists(spr_idle)) {
        draw_sprite_part_ext(spr_idle, 0, 0, 0, frame_w, frame_h, box_x2 - 160, card_y + 20, 4.5, 4.5, c_white, 1.0);
    }
}

if (config_tab == 1) {
    if (array_length(inventory) == 0) {
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(100, 100, 100));
        draw_text(base_x, inner_y + 60, "* INVENTORY IS EMPTY *");
    } else {
        var item_spacing = 38;
        var start_x = box_x1 + 45;
        
        for(var i = 0; i < array_length(inventory); i++) {
            var eq_marker = "";
            if (inventory[i].type == "weapon" && equipped_weapon == inventory[i].name) eq_marker = " (E)";
            if (inventory[i].type == "shield" && equipped_shield == inventory[i].name) eq_marker = " (E)";
            
            draw_set_halign(fa_left);
            if (config_idx == i) {
                draw_set_color(c_yellow);
                var item_label = "* " + inventory[i].name + eq_marker;
            } else {
                draw_set_color(c_white);
                var item_label = "  " + inventory[i].name + eq_marker;
            }
            draw_text(start_x, inner_y + 15 + (i * item_spacing), item_label);
        }
        
        draw_set_color(c_white);
        draw_line_width(box_x1 + 20, box_y2 - 65, box_x2 - 20, box_y2 - 65, 4);
        
        draw_set_halign(fa_center);
        draw_set_color(c_yellow);
        draw_text(base_x, box_y2 - 45, inventory[config_idx].info);
    }
}

if (config_tab == 2) {
    if (menu_sub_state == "main") {
        draw_set_halign(fa_center);
        var main_opts = ["OPTIONS", "CONTROLS", "GAME PROGRESS", "QUIT GAME"];
        for(var i = 0; i < 4; i++) {
            if (config_idx == i) {
                draw_set_color(c_yellow);
                var lbl = "* " + main_opts[i] + " *";
            } else {
                draw_set_color(c_white);
                var lbl = main_opts[i];
            }
            draw_text(base_x, inner_y + 20 + (i * 45), lbl);
        }
    }
    
    if (menu_sub_state == "submenu_options") {
        draw_set_halign(fa_center);
        var opt_text = [
            "FULLSCREEN: " + (global.fullscreen ? "ON" : "OFF"),
            "BGM VOLUME: " + string(round(global.vol_bgm * 100)) + "%",
            "SFX VOLUME: " + string(round(global.vol_sfx * 100)) + "%",
            "BACK"
        ];
        for(var i = 0; i < 4; i++) {
            if (sub_menu_idx == i) {
                draw_set_color(c_yellow);
                var lbl = "* " + opt_text[i] + " *";
            } else {
                draw_set_color(c_white);
                var lbl = opt_text[i];
            }
            draw_text(base_x, inner_y + 20 + (i * 45), lbl);
        }
    }
    
    if (menu_sub_state == "submenu_controls") {
        draw_set_halign(fa_center);
        draw_set_color(c_yellow);
        draw_text(base_x, inner_y + 10, "CONTROLS CONF");
        draw_set_color(c_white);
        draw_text(base_x, inner_y + 55, "MOVE: ARROW KEYS");
        draw_text(base_x, inner_y + 95, "SPRINT: SHIFT");
        draw_text(base_x, inner_y + 135, "CONFIRM / ACTION: Z");
        draw_text(base_x, inner_y + 175, "CANCEL / BACK: X");
        draw_set_color(make_color_rgb(120, 120, 120));
        draw_text(base_x, inner_y + 235, "[ PRESS Z OR X TO RETURN ]");
    }
    
    if (menu_sub_state == "submenu_game") {
        draw_set_halign(fa_center);
        var game_opts = ["SAVE GAME", "LOAD GAME", "BACK"];
        for(var i = 0; i < 3; i++) {
            var fx = base_x;
            if (i == 1 && shake_continue > 0) fx += random_range(-shake_continue/4, shake_continue/4);
            
            if (i == 1 && error_flash_continue > 0) {
                draw_set_color(c_red);
            } else if (sub_menu_idx == i) {
                draw_set_color(c_yellow);
            } else {
                draw_set_color(c_white);
            }
            
            var lbl = sub_menu_idx == i ? "* " + game_opts[i] + " *" : game_opts[i];
            draw_text(fx, inner_y + 20 + (i * 45), lbl);
        }
    }
}

if (menu_sub_state == "submenu_save_confirm") {
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var box_w = 460;
    var box_h = 180;
    var bx1 = base_x - (box_w / 2);
    var by1 = (gui_h / 2) - (box_h / 2);
    var bx2 = base_x + (box_w / 2);
    var by2 = (gui_h / 2) + (box_h / 2);
    
    draw_set_color(c_black); draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_line_width(bx1, by1, bx2, by1, 6);
    draw_line_width(bx1, by2, bx2, by2, 6);
    draw_line_width(bx1, by1, bx1, by2, 6);
    draw_line_width(bx2, by1, bx2, by2, 6);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_yellow);
    draw_text(base_x, by1 + 55, "PROGRESS SAVED");
    draw_set_color(c_white);
    draw_text(base_x, by1 + 115, "PRESS Z TO CONTINUE");
    draw_set_valign(fa_top);
}

if (menu_sub_state == "submenu_load_info") {
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var box_w = 520;
    var box_h = 240;
    var bx1 = base_x - (box_w / 2);
    var by1 = (gui_h / 2) - (box_h / 2);
    var bx2 = base_x + (box_w / 2);
    var by2 = (gui_h / 2) + (box_h / 2);
    
    draw_set_color(c_black); draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_line_width(bx1, by1, bx2, by1, 6);
    draw_line_width(bx1, by2, bx2, by2, 6);
    draw_line_width(bx1, by1, bx1, by2, 6);
    draw_line_width(bx2, by1, bx2, by2, 6);
    
    draw_set_halign(fa_left);
    var ox = bx1 + 45;
    var oy = by1 + 35;
    
    draw_set_color(c_yellow);
    draw_text(ox, oy, "FILE DATA LOAD");
    
    if (file_exists("save.json")) {
        var _f = file_text_open_read("save.json");
        var _json = file_text_read_string(_f);
        file_text_close(_f);
        var _data = json_parse(_json);
        
        draw_set_color(c_white);
        draw_text(ox, oy + 45, "HP: " + string(_data.hp) + " / " + string(_data.hp_max));
        draw_text(ox, oy + 85, "INVENTORY: " + string(array_length(_data.inventory)) + " ITEMS");
        
        draw_set_halign(fa_center);
        draw_set_color(c_yellow);
        draw_text(base_x, by2 - 40, "Z - LOAD FILE / X - CANCEL");
    } else {
        draw_set_color(c_white);
        draw_text(ox, oy + 45, "NO SAVE DATA FOUND");
        draw_set_halign(fa_center);
        draw_text(base_x, by2 - 40, "PRESS X TO RETURN");
    }
}

for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    draw_set_color(c_red);
    draw_set_alpha(p.alpha);
    draw_rectangle(p.xx, p.yy + config_y, p.xx + choose(2,3), p.yy + config_y + choose(2,3), false);
}
draw_set_alpha(1.0);

if (menu_sub_state == "item_box") {
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    
    var box_w = 480;
    var box_h = 240;
    var bx1 = base_x - (box_w / 2);
    var by1 = (gui_h / 2) - (box_h / 2);
    var bx2 = base_x + (box_w / 2);
    var by2 = (gui_h / 2) + (box_h / 2);
    
    draw_set_color(c_black); draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_line_width(bx1, by1, bx2, by1, 6);
    draw_line_width(bx1, by2, bx2, by2, 6);
    draw_line_width(bx1, by1, bx1, by2, 6);
    draw_line_width(bx2, by1, bx2, by2, 6);
    
    var current_item = inventory[config_idx];
    
    if (sprite_exists(current_item.sprite)) {
        draw_sprite_ext(current_item.sprite, 0, bx1 + 60, by1 + (box_h / 2), 4, 4, 0, c_white, 1.0);
    }
    
    draw_set_halign(fa_left);
    var ox = bx1 + 150;
    var oy = by1 + 35;
    
    draw_set_color(c_yellow);
    draw_text(ox, oy, current_item.name);
    
    var action_text = "EQUIP";
    if (current_item.type == "weapon" && equipped_weapon == current_item.name) action_text = "UNEQUIP";
    if (current_item.type == "shield" && equipped_shield == current_item.name) action_text = "UNEQUIP";
    
    var sub_opts = (current_item.type == "heal") ? ["USE", "DROP", "CANCEL"] : [action_text, "DROP", "CANCEL"];
    
    var opt_y = oy + 50;
    for(var i = 0; i < 3; i++) {
        if (box_selected_opt == i) {
            draw_set_color(c_yellow);
            var lbl = "* " + sub_opts[i];
        } else {
            draw_set_color(c_white);
            var lbl = "  " + sub_opts[i];
        }
        draw_text(ox, opt_y + (i * 42), lbl);
    }
}