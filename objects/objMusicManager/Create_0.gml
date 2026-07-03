if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

global.music_id = -1;
current_track = -1;
target_track = -1;

fade_state = "idle";
music_volume = 1.0;
fade_speed = 0.02;