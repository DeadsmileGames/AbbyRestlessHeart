if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

global.music_id = -1;
current_track = -1;
target_track = -1;

fade_state = "idle";
fade_speed = 0.02;

if (!variable_global_exists("vol_bgm")) {
    global.vol_bgm = 1.0;
}