switch (fade_state) {
    case "fade_out":
        if (audio_is_playing(global.music_id)) {
            var _current_vol = audio_sound_get_gain(global.music_id);
            _current_vol -= fade_speed;
            
            if (_current_vol <= 0) {
                audio_stop_sound(global.music_id);
                global.music_id = -1;
                current_track = -1;
                fade_state = "fade_in";
                
                if (target_track != -1) {
                    global.music_id = audio_play_sound(target_track, 10, true);
                    audio_sound_gain(global.music_id, 0, 0);
                    current_track = target_track;
                }
            } else {
                audio_sound_gain(global.music_id, _current_vol, 0);
            }
        } else {
            global.music_id = -1;
            current_track = -1;
            fade_state = "fade_in";
            
            if (target_track != -1) {
                global.music_id = audio_play_sound(target_track, 10, true);
                audio_sound_gain(global.music_id, 0, 0);
                current_track = target_track;
            }
        }
        break;
        
    case "fade_in":
        if (global.music_id != -1 && audio_is_playing(global.music_id)) {
            var _current_vol = audio_sound_get_gain(global.music_id);
            _current_vol += fade_speed;
            
            if (_current_vol >= music_volume) {
                audio_sound_gain(global.music_id, music_volume, 0);
                fade_state = "idle";
            } else {
                audio_sound_gain(global.music_id, _current_vol, 0);
            }
        } else {
            fade_state = "idle";
        }
        break;
}