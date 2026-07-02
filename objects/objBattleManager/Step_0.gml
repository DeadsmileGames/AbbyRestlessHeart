if (!instance_exists(objPlayer)) exit;

var _key_up    = keyboard_check_pressed(vk_up);
var _key_down  = keyboard_check_pressed(vk_down);
var _key_left  = keyboard_check_pressed(vk_left);
var _key_right = keyboard_check_pressed(vk_right);
var _key_z     = keyboard_check_pressed(objPlayer.controls[2][1]);
var _key_x     = keyboard_check_pressed(objPlayer.controls[3][1]);

if (enemy_hit_timer > 0) {
    enemy_hit_timer--;
    enemy_shake_x = random_range(-6, 6);
    enemy_shake_y = random_range(-6, 6);
} else {
    enemy_shake_x = 0;
    enemy_shake_y = 0;
}

for (var i = array_length(smoke_particles) - 1; i >= 0; i--) {
    var _p = smoke_particles[i];
    _p.xx += _p.vx;
    _p.yy += _p.vy;
    _p.alpha -= 0.03;
    _p.size += 0.4;
    if (_p.alpha <= 0) array_delete(smoke_particles, i, 1);
}

if (battle_state == "intro_anim") {
    intro_timer++;
    if (intro_timer >= 5) {
        intro_timer = 0;
        intro_flashes++;
    }
    if (intro_flashes >= intro_max_flashes) {
        battle_state = player_turn ? "main_menu" : "enemy_turn";
        battle_text = player_turn ? "Your turn! What will you do?" : (enemy_name + " prepares to attack!");
    }
    exit;
}

if (battle_state == "gameover_anim") {
    go_anim_timer++;
    if (go_anim_timer < 30) {
        go_enemy_x += ((go_player_x + 80) - go_enemy_x) * 0.05;
    } else if (go_anim_timer < 45) {
        go_enemy_x += (go_player_x - go_enemy_x) * 0.4;
        if (abs(go_enemy_x - go_player_x) < 20) {
            go_player_sprite = sprPlayerDeath;
        }
    } else {
        fade_alpha += 0.04;
        if (fade_alpha >= 1) {
            room_goto(rm_GameOver);
        }
    }
    exit;
}

if (battle_state == "main_menu") {
    if (_key_left)  menu_index = max(0, menu_index - 1);
    if (_key_right) menu_index = min(2, menu_index + 1);
    
    if (_key_z) {
        if (menu_index == 0) { 
            attacks_list = [];
            array_push(attacks_list, { name: "Bare Hands", dmg: 1 });
            if (objPlayer.equipped_weapon != "NONE") {
                array_push(attacks_list, { name: objPlayer.equipped_weapon, dmg: objPlayer.stat_atk });
            }
            submenu_index = 0;
            battle_state = "attack_menu";
        }
        else if (menu_index == 1) { 
            items_list = [];
            for (var i = 0; i < array_length(objPlayer.inventory); i++) {
                var _item = objPlayer.inventory[i];
                if (_item.type == "heal") {
                    array_push(items_list, { name: _item.name, value: _item.value, inv_index: i });
                }
            }
            submenu_index = 0;
            if (array_length(items_list) == 0) {
                battle_text = "You have no healing items!";
            } else {
                battle_state = "item_menu";
            }
        }
        else if (menu_index == 2) { 
            battle_text = "You fled from battle!";
            battle_state = "fade_out";
            
            if (instance_exists(enemy_inst)) {
                var _base_dir = point_direction(objPlayer.x, objPlayer.y, enemy_inst.x, enemy_inst.y);
                var _push_dist = 100;
                var _found_path = false;
                var _final_dir = _base_dir;
                for (var _angle_offset = 0; _angle_offset < 360; _angle_offset += 10) {
                    var _check_dir = _base_dir + _angle_offset;
                    var _target_x = enemy_inst.x + lengthdir_x(_push_dist, _check_dir);
                    var _target_y = enemy_inst.y + lengthdir_y(_push_dist, _check_dir);
                    if (!collision_line(enemy_inst.x, enemy_inst.y, _target_x, _target_y, obj, true, true) && !place_meeting(_target_x, _target_y, obj)) {
                        _final_dir = _check_dir;
                        _found_path = true;
                        break;
                    }
                }
                
                if (_found_path) {
                    enemy_inst.x += lengthdir_x(_push_dist, _final_dir);
                    enemy_inst.y += lengthdir_y(_push_dist, _final_dir);
                } else {
                    var _step_x = lengthdir_x(1, _base_dir);
                    var _step_y = lengthdir_y(1, _base_dir);
                    
                    repeat(_push_dist) {
                        if (!place_meeting(enemy_inst.x + _step_x, enemy_inst.y, obj)) {
                            enemy_inst.x += _step_x;
                        }
                        if (!place_meeting(enemy_inst.x, enemy_inst.y + _step_y, obj)) {
                            enemy_inst.y += _step_y;
                        }
                    }
                }
            }
        }
    }
    exit;
}

if (battle_state == "attack_menu") {
    if (_key_x) { battle_state = "main_menu"; exit; }
    if (_key_up)   submenu_index = max(0, submenu_index - 1);
    if (_key_down) submenu_index = min(array_length(attacks_list) - 1, submenu_index + 1);
    
    if (_key_z) {
        selected_attack = attacks_list[submenu_index];
        mg_cursor_x = 0;
        mg_cursor_dir = 1;
        battle_state = "minigame";
    }
    exit;
}

if (battle_state == "item_menu") {
    if (_key_x) { battle_state = "main_menu"; exit; }
    if (_key_up)   submenu_index = max(0, submenu_index - 1);
    if (_key_down) submenu_index = min(array_length(items_list) - 1, submenu_index + 1);
    
    if (_key_z) {
        var _item = items_list[submenu_index];
        objPlayer.hp_actual = min(objPlayer.hp_max, objPlayer.hp_actual + _item.value);
        array_delete(objPlayer.inventory, _item.inv_index, 1);
        
        battle_text = "Used " + _item.name + " and restored " + string(_item.value) + " HP!";
        battle_state = "enemy_turn";
        text_timer = 0;
    }
    exit;
}

if (battle_state == "minigame") {
    mg_cursor_x += mg_cursor_speed * mg_cursor_dir;
    if (mg_cursor_x >= mg_bar_width || mg_cursor_x <= 0) mg_cursor_dir *= -1;
    
    if (_key_z) {
        var _center = mg_bar_width / 2;
        var _dist = abs(mg_cursor_x - _center);
        var _base_dmg = selected_attack.dmg;
        var _final_dmg = _base_dmg;
        var _mod_text = "";
        
        if (_dist <= zone_green) { _final_dmg += 3; _mod_text = "PERFECT!"; } 
        else if (_dist <= zone_orange) { _final_dmg += 1; _mod_text = "GOOD!"; } 
        else if (_dist <= zone_yellow) { _mod_text = "OK!"; } 
        else if (_dist <= zone_outer) { _final_dmg = round(_base_dmg * 0.75); _mod_text = "CLOSE..."; } 
        else { _final_dmg = round(_base_dmg * 0.50); _mod_text = "BAD TIMING!"; }
        
        enemy_hp -= _final_dmg;
       
        enemy_hit_timer = 25; 
        
        battle_text = _mod_text + "\nYou used " + string_upper(selected_attack.name) + " and dealt " + string(_final_dmg) + " damage!";
        text_timer = 0;
        
        battle_state = "attack_delay";
    }
    exit;
}

if (battle_state == "attack_delay") {
    text_timer++;
    if (text_timer >= 60) {
        text_timer = 0;
        if (enemy_hp <= 0) {
            battle_state = "enemy_death_trigger";
        } else {
            battle_state = "enemy_turn";
        }
    }
    exit;
}

if (battle_state == "enemy_death_trigger") {
    enemy_is_dead_anim = true;
    var _ex = display_get_gui_width() - 300;
    var _ey = 260;
    repeat(30) {
        array_push(smoke_particles, {
            xx: _ex + random_range(-40, 40),
            yy: _ey + random_range(-40, 40),
            vx: random_range(-2, 2),
            vy: random_range(-3, -1),
            size: random_range(10, 25),
            alpha: 1.0
        });
    }
    battle_state = "win_screen";
    text_timer = 0;
    exit;
}

if (battle_state == "enemy_turn") {
    text_timer++;
    if (text_timer > 80) {
        var _shield_def = (objPlayer.equipped_shield != "NONE") ? objPlayer.stat_def : 0;
        var _enemy_dmg = max(1, enemy_atk - _shield_def);
        objPlayer.hp_actual -= _enemy_dmg;
        
        battle_text = enemy_name + " counter-attacked dealing " + string(_enemy_dmg) + " damage!";
        text_timer = 0;
        
        if (objPlayer.hp_actual <= 0) {
            go_anim_timer = 0;
            go_enemy_x = display_get_gui_width() - 300;
            go_player_sprite = sprPlayerIdle;
            battle_state = "gameover_anim"; 
        } else {
            battle_state = "main_menu";
        }
    }
    exit;
}

if (battle_state == "win_screen") {
    text_timer++;
    if (text_timer == 1) {
        battle_text = "The " + enemy_name + " was defeated!\n";
        
        var _roll = irandom(99); 
        if (_roll < 50) {
            objPlayer.base_atk += 1;
            objPlayer.stat_atk += 1;
            battle_text += "Reward: +1 ATK permanently!";
        } 
        else if (_roll < 75) {
            array_push(objPlayer.inventory, { 
                name: "MYSTIC HEAL", 
                type: "heal", 
                value: 15, 
                info: "HEAL 15 HP",
                sprite: sprPlayerIdle
            });
            battle_text += "Reward obtained: MYSTIC HEAL!";
        } 
        else {
            objPlayer.hp_actual = min(objPlayer.hp_max, objPlayer.hp_actual + 5);
            battle_text += "Reward: Restored +5 HP!";
        }
    }
    
    if (text_timer > 40 && _key_z) {
        if (instance_exists(enemy_inst)) instance_destroy(enemy_inst);
        battle_state = "fade_out";
    }
    exit;
}

if (battle_state == "fade_out") {
    fade_alpha += 0.05;
    if (fade_alpha >= 1) {
        audio_stop_sound(ItsTimeForABattle);
        
        if (room_music != noone && audio_is_playing(room_music)) {
            audio_sound_gain(room_music, global.vol_bgm, 500);
        }
        
        instance_destroy();
    }
}