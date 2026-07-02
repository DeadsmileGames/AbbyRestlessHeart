var _w_screen_battle = display_get_gui_width();
var _h_screen_battle = display_get_gui_height();

if (battle_state == "intro_anim") {
    draw_set_color((intro_flashes % 2 == 0) ? c_white : c_black);
    draw_rectangle(0, 0, _w_screen_battle, _h_screen_battle, false);
    exit;
}

gpu_set_texfilter(false);

draw_set_color(c_black);
draw_rectangle(0, 0, _w_screen_battle, _h_screen_battle, false);

var _strip_height_style = 24;
draw_set_color(make_color_rgb(50, 40, 70));   
draw_rectangle(0, 40, _w_screen_battle, 40 + _strip_height_style, false);
draw_set_color(make_color_rgb(85, 35, 75));   
draw_rectangle(0, 40 + _strip_height_style, _w_screen_battle, 40 + (_strip_height_style * 2), false);
draw_set_color(make_color_rgb(130, 30, 50));  
draw_rectangle(0, 40 + (_strip_height_style * 2), _w_screen_battle, 40 + (_strip_height_style * 3), false);
draw_set_color(make_color_rgb(180, 20, 20));  
draw_rectangle(0, 40 + (_strip_height_style * 3), _w_screen_battle, 40 + (_strip_height_style * 6), false);

draw_set_color(c_black);
var _mount_base_y_style = 40 + (_strip_height_style * 5);
var _step_width_style = 40;
for (var i = 0; i < _w_screen_battle; i += _step_width_style) {
    var _calculated_offset_style = (floor(sin(i * 0.05) * 3) * 12) + (floor(cos(i * 0.02) * 2) * 8);
    draw_rectangle(i, _mount_base_y_style + _calculated_offset_style, i + _step_width_style, _h_screen_battle, false);
}

if (battle_state == "gameover_anim") {
    if (sprite_exists(go_player_sprite)) {
        draw_sprite_ext(go_player_sprite, 0, go_player_x, go_player_y, 5, 5, 0, c_white, 1);
    }
    if (sprite_exists(enemy_sprite)) {
        draw_sprite_ext(enemy_sprite, 0, go_enemy_x, go_enemy_y, 5, 5, 0, c_white, 1);
    }
    if (fade_alpha > 0) {
        draw_set_alpha(fade_alpha);
        draw_set_color(c_black);
        draw_rectangle(0, 0, _w_screen_battle, _h_screen_battle, false);
        draw_set_alpha(1.0);
    }
    exit;
}

if (sprite_exists(enemy_sprite) && !enemy_is_dead_anim) {
    var _bounce_offset_y_style = sin(current_time * 0.003) * 8;
    var _render_enemy_x_style = (_w_screen_battle - 300) + enemy_shake_x;
    var _render_enemy_y_style = 260 + enemy_shake_y + _bounce_offset_y_style;
    var _enemy_blend_color_style = (enemy_hit_timer > 0) ? c_red : c_white;
    draw_sprite_ext(enemy_sprite, 0, _render_enemy_x_style, _render_enemy_y_style, 5, 5, 0, _enemy_blend_color_style, 1);
}

draw_set_color(make_color_rgb(120, 120, 120));
for (var i = 0; i < array_length(smoke_particles); i++) {
    var _smoke_p_style = smoke_particles[i];
    draw_set_alpha(_smoke_p_style.alpha);
    draw_rectangle(_smoke_p_style.xx - _smoke_p_style.size, _smoke_p_style.yy - _smoke_p_style.size, _smoke_p_style.xx + _smoke_p_style.size, _smoke_p_style.yy + _smoke_p_style.size, false);
}
draw_set_alpha(1.0);

draw_set_font(global.fonteNormal);
draw_set_halign(fa_left);

var _hud_anchor_y_style = _h_screen_battle - 330;

draw_set_color(c_white);
draw_text(80, _hud_anchor_y_style, string_upper(enemy_name));
draw_text(350, _hud_anchor_y_style, "HP: " + string(max(0, enemy_hp)) + "/" + string(enemy_hp_max));
draw_set_color(c_red); draw_rectangle(80, _hud_anchor_y_style + 30, 330, _hud_anchor_y_style + 40, false);
draw_set_color(c_green); draw_rectangle(80, _hud_anchor_y_style + 30, 80 + (250 * clamp(enemy_hp / enemy_hp_max, 0, 1)), _hud_anchor_y_style + 40, false);

draw_set_color(c_white);
var _string_player_name_style = global.isMila ? "MILA" : "ABBY";
draw_text(80, _hud_anchor_y_style + 60, "> " + _string_player_name_style);
draw_text(350, _hud_anchor_y_style + 60, "HP: " + string(max(0, objPlayer.hp_actual)) + "/" + string(objPlayer.hp_max));
draw_set_color(c_red); draw_rectangle(80, _hud_anchor_y_style + 90, 330, _hud_anchor_y_style + 100, false);
draw_set_color(c_green); draw_rectangle(80, _hud_anchor_y_style + 90, 80 + (250 * clamp(objPlayer.hp_actual / objPlayer.hp_max, 0, 1)), _hud_anchor_y_style + 100, false);

var _box_fixed_height_style = 160; 
var _text_box_y2_style = _h_screen_battle - 20; 
var _text_box_y1_style = _text_box_y2_style - _box_fixed_height_style; 

draw_set_color(c_black); draw_rectangle(40, _text_box_y1_style, _w_screen_battle - 40, _text_box_y2_style, false);
draw_set_color(c_white); draw_rectangle(40, _text_box_y1_style, _w_screen_battle - 40, _text_box_y2_style, true);

if (battle_state != "minigame") {
    draw_set_halign(fa_center);
    
    var _is_victory_text_style = (string_pos("VICTORY", string_upper(battle_text)) > 0 || string_pos("GANHOU", string_upper(battle_text)) > 0 || string_pos("VENCEU", string_upper(battle_text)) > 0);
    
    if (_is_victory_text_style) {
        draw_set_valign(fa_top);
        
        draw_set_font(global.fonteNormal);
        draw_set_color(c_yellow);
        draw_text(_w_screen_battle / 2, _text_box_y1_style + 20, "VICTORY");
        
        var _clean_reward_text_style = battle_text;
        _clean_reward_text_style = string_replace(_clean_reward_text_style, "Victory! ", "");
        _clean_reward_text_style = string_replace(_clean_reward_text_style, "Victory!", "");
        
        draw_set_color(c_white);
        draw_text_ext(_w_screen_battle / 2, _text_box_y1_style + 58, _clean_reward_text_style, 32, _w_screen_battle - 120);
        
        draw_set_font(global.fonteLegenda);
        draw_set_color(c_gray);
        var _prompt_pulse_alpha_style = 0.5 + sin(current_time * 0.004) * 0.3;
        draw_set_alpha(_prompt_pulse_alpha_style);
        draw_text(_w_screen_battle / 2, _text_box_y2_style - 26, "PRESS [Z] TO CONTINUE");
        draw_set_alpha(1.0);
    } else {
        draw_set_valign(fa_middle);
        draw_set_font(global.fonteNormal);
        draw_set_color(c_white);
        
        var _text_target_offset_style = (battle_state == "main_menu") ? 35 : 0;
        var _text_center_y_style = _text_box_y1_style + (_box_fixed_height_style / 2) - _text_target_offset_style;
        
        draw_text_ext(_w_screen_battle / 2, _text_center_y_style, battle_text, 28, _w_screen_battle - 120);
    }
    draw_set_valign(fa_top); 
}

if (battle_state == "main_menu") {
    var _options_array_style = ["ATTACK", "ITEM", "RUN"];
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    for (var i = 0; i < 3; i++) {
        var _option_x_position_style = _w_screen_battle / 2 + (i - 1) * 220;
        var _option_y_position_style = _text_box_y2_style - 45;
        
        if (menu_index == i) {
            draw_set_color(c_white);
            draw_text(_option_x_position_style, _option_y_position_style, "* " + _options_array_style[i] + " *");
        } else {
            draw_set_color(make_color_rgb(100, 100, 100));
            draw_text(_option_x_position_style, _option_y_position_style, _options_array_style[i]);
        }
    }
}

if (battle_state == "attack_menu" || battle_state == "item_menu") {
    var _active_submenu_list_style = (battle_state == "attack_menu") ? attacks_list : items_list;
    draw_set_font(global.fonteNormal);
    draw_set_color(c_black); draw_rectangle(_w_screen_battle - 360, _h_screen_battle - 380, _w_screen_battle - 50, _h_screen_battle - 180, false);
    draw_set_color(c_white); draw_rectangle(_w_screen_battle - 360, _h_screen_battle - 380, _w_screen_battle - 50, _h_screen_battle - 180, true);
    draw_set_halign(fa_left);
    for (var i = 0; i < array_length(_active_submenu_list_style); i++) {
        if (submenu_index == i) draw_text(_w_screen_battle - 330, _h_screen_battle - 340 + (i * 35), "* " + _active_submenu_list_style[i].name);
        else { draw_set_color(make_color_rgb(120, 120, 120)); draw_text(_w_screen_battle - 330, _h_screen_battle - 340 + (i * 35), _active_submenu_list_style[i].name); }
        draw_set_color(c_white);
    }
}

if (battle_state == "minigame") {
    var _mg_bar_x_style = (_w_screen_battle / 2) - (mg_bar_width / 2);
    var _mg_bar_y_style = _text_box_y1_style + ((_text_box_y2_style - _text_box_y1_style) / 2) - (mg_bar_height / 2);
    
    draw_set_color(make_color_rgb(50, 50, 50)); draw_rectangle(_mg_bar_x_style, _mg_bar_y_style, _mg_bar_x_style + mg_bar_width, _mg_bar_y_style + mg_bar_height, false);
    draw_set_color(c_yellow); draw_rectangle(_mg_bar_x_style + (mg_bar_width/2) - zone_yellow, _mg_bar_y_style, _mg_bar_x_style + (mg_bar_width/2) + zone_yellow, _mg_bar_y_style + mg_bar_height, false);
    draw_set_color(c_orange); draw_rectangle(_mg_bar_x_style + (mg_bar_width/2) - zone_orange, _mg_bar_y_style, _mg_bar_x_style + (mg_bar_width/2) + zone_orange, _mg_bar_y_style + mg_bar_height, false);
    draw_set_color(c_green); draw_rectangle(_mg_bar_x_style + (mg_bar_width/2) - zone_green, _mg_bar_y_style, _mg_bar_x_style + (mg_bar_width/2) + zone_green, _mg_bar_y_style + mg_bar_height, false);
    
    draw_set_color(c_white); draw_rectangle(_mg_bar_x_style, _mg_bar_y_style, _mg_bar_x_style + mg_bar_width, _mg_bar_y_style + mg_bar_height, true);
    draw_set_color(c_red); draw_rectangle(_mg_bar_x_style + mg_cursor_x - 3, _mg_bar_y_style - 6, _mg_bar_x_style + mg_cursor_x + 3, _mg_bar_y_style + mg_bar_height + 6, false);
}

if (battle_state == "fade_out") {
    draw_set_alpha(fade_alpha); draw_set_color(c_black); draw_rectangle(0, 0, _w_screen_battle, _h_screen_battle, false); draw_set_alpha(1.0);
}