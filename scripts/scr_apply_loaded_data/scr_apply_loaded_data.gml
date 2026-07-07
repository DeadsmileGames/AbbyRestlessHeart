function scr_apply_loaded_data(_data) {
    if (instance_exists(objPlayer)) {
        objPlayer.x = _data.x;
        objPlayer.y = _data.y;
        global.hp = _data.hp;
        global.atk = _data.atk;
        global.def = _data.def;
        global.inventory = _data.inventory;
        if (variable_struct_exists(_data, "ChapterOneIsComplete")) {
            global.ChapterOneIsComplete = _data.ChapterOneIsComplete;
        }
        global.vol_bgm = _data.bgm;
        global.vol_sfx = _data.sfx;
        global.keyYellow = _data.keyYellow;
        global.keyGreen = _data.keyGreen;
        global.keyBlue = _data.keyBlue;
    }
}