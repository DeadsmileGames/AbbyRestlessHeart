enemy_name = "";
enemy_hp_max = 100;
enemy_hp = 100;
enemy_atk = 10;
enemy_sprite = -1;
enemy_inst = noone;
reward_item = "NONE";
reward_stat = "NONE";

battle_state = "intro_anim"; 
player_turn = true;

intro_timer = 0;
intro_flashes = 0;
intro_max_flashes = 6;
fade_alpha = 0;

menu_index = 0; 
submenu_index = 0;
attacks_list = [];
items_list = [];

mg_bar_width = 500;
mg_bar_height = 35;
mg_cursor_x = 0;
mg_cursor_speed = 7;
mg_cursor_dir = 1;

zone_green = 25;   
zone_orange = 65;  
zone_yellow = 120; 
zone_outer = 250;  

battle_text = "";
text_timer = 0;
selected_attack = noone;

enemy_hit_timer = 0;
enemy_shake_x = 0;
enemy_shake_y = 0;
enemy_is_dead_anim = false;
smoke_particles = [];

go_anim_timer = 0;
go_player_x = 300;
go_player_y = 260;
go_enemy_x = 0;
go_enemy_y = 260;
go_player_sprite = sprPlayerIdle;
