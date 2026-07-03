function scr_load_game(_fname) {
    if (file_exists(_fname)) {
        var _f = file_text_open_read(_fname);
        var _json = file_text_read_string(_f);
        file_text_close(_f);
        global.load_data = json_parse(_json);
        room_goto(asset_get_index(global.load_data.room_name));
    }
}

function scr_check_meta_save_value(_variable_name, _default_value) {
    if (file_exists("save.json")) {
        var _f = file_text_open_read("save.json");
        var _json = file_text_read_string(_f);
        file_text_close(_f);
        
        var _temp_data = json_parse(_json);
        
        if (_temp_data != undefined && variable_struct_exists(_temp_data, _variable_name)) {
            return _temp_data[$ _variable_name];
        }
    }
    return _default_value;
}