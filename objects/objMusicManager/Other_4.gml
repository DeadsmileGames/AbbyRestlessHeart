var _target_room_track = -1;

switch (room) {
    case rm_Controls:
        _target_room_track = StartMenu;
        break;
    
    case rm_Intro:
        _target_room_track = StartMenu;
        break;

    case rm_GameOver:
        _target_room_track = FinalRest;
        break;

    case rm_AbbyBedroom:
        _target_room_track = AbbyMind;
        break;
        
    case rm_MazeOfMemories:
        _target_room_track = MazeOfMemories;
        break;
        
    default:
        _target_room_track = -1;
        break;
}

if (_target_room_track != current_track) {
    target_track = _target_room_track;
    
    if (current_track != -1) {
        fade_state = "fade_out";
    } else {
        fade_state = "fade_in";
        if (target_track != -1) {
            if (audio_is_playing(global.music_id)) {
                audio_stop_sound(global.music_id);
            }
            global.music_id = audio_play_sound(target_track, 10, true);
            audio_sound_gain(global.music_id, 0, 0);
            current_track = target_track;
        }
    }
}