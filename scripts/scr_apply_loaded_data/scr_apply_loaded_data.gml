function scr_apply_loaded_data(_data) {
    if (instance_exists(objPlayer)) {
        objPlayer.x = _data.player_x;
        objPlayer.y = _data.player_y;
        global.hp = _data.player_hp;
        global.atk = _data.player_stats.atk;
        global.def = _data.player_stats.def;
        global.inventory = _data.inventory;
    }
}