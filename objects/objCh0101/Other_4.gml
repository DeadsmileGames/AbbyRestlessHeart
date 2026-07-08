if (variable_global_exists("load_data") && global.load_data != undefined) {
    scr_apply_loaded_data(global.load_data);
    global.load_data = undefined;
}