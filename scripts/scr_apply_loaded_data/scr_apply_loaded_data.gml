function scr_apply_loaded_data(_data) {
    if (instance_exists(objPlayer)) {
        objPlayer.x = _data.x;
        objPlayer.y = _data.y;
        objPlayer.equipped_weapon = _data.equipped_weapon;
        objPlayer.equipped_shield = _data.equipped_shield;
    }

    global.hp = _data.hp;
    global.hp_max = _data.hp_max;
    global.atk = _data.atk;
    global.def = _data.def;
    global.inventory = _data.inventory;
    global.minigames = _data.minigames;
    global.porta_liberada = _data.porta_liberada;
    global.keyYellow = _data.keyYellow;
    global.keyGreen = _data.keyGreen;
    global.keyBlue = _data.keyBlue;
    global.current_objective = _data.current_objective;
    global.vol_bgm = _data.bgm;
    global.vol_sfx = _data.sfx;

    if (instance_exists(objCh0101)) {
        objCh0101.started_story = _data.started_story;
        objCh0101.active_puzzle = _data.active_puzzle;
    }
}