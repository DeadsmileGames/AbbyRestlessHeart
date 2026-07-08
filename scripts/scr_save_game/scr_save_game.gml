function scr_save_game() {
    if (instance_exists(objPlayer)) {
        var _story_started = false;
        var _active_puzzle = false;
        var _current_objective = global.current_objective;
        
        if (instance_exists(objAbbyBedroom)) {
            _story_started = objAbbyBedroom.started_story;
        } else if (instance_exists(objCh0101)) {
            _story_started = objCh0101.started_story;
            _active_puzzle = objCh0101.active_puzzle;
        }
        
        var _data = {
            room_name: room_get_name(room),
            x: objPlayer.x,
            y: objPlayer.y,
            hp: global.hp,
            hp_max: global.hp_max,
            atk: global.atk,
            def: global.def,
            inventory: global.inventory,
            equipped_weapon: objPlayer.equipped_weapon,
            equipped_shield: objPlayer.equipped_shield,
            started_story: _story_started,
            active_puzzle: _active_puzzle,
            current_objective: _current_objective,
            minigames: global.minigames,
            porta_liberada: global.porta_liberada,
            bgm: global.vol_bgm,
            sfx: global.vol_sfx,
            keyYellow: global.keyYellow,
            keyGreen: global.keyGreen,
            keyBlue: global.keyBlue,
        };
        
        var _f = file_text_open_write("save.json");
        file_text_write_string(_f, json_stringify(_data));
        file_text_close(_f);
    }
}