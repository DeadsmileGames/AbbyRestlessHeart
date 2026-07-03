function scr_apply_loaded_data(_data) {
    if (instance_exists(objPlayer)) {
        objPlayer.x = _data.x;
        objPlayer.y = _data.y;
        global.hp = _data.hp;
        global.hp_max = _data.hp_max;
        global.atk = _data.atk;
        global.def = _data.def;
        global.inventory = _data.inventory;
        objPlayer.equipped_weapon = _data.equipped_weapon;
        objPlayer.equipped_shield = _data.equipped_shield;
        
        global.ChapterOneIsComplete = variable_struct_exists(_data, "ChapterOneIsComplete") ? _data.ChapterOneIsComplete : false;
        global.ChapterTwoIsComplete = variable_struct_exists(_data, "ChapterTwoIsComplete") ? _data.ChapterTwoIsComplete : false;
        global.ChapterThreeIsComplete = variable_struct_exists(_data, "ChapterThreeIsComplete") ? _data.ChapterThreeIsComplete : false;
        global.ChapterFourIsComplete = variable_struct_exists(_data, "ChapterFourIsComplete") ? _data.ChapterFourIsComplete : false;
    }
}