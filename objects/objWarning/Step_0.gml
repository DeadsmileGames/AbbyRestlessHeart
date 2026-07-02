if (!is_fading_out) {
    if (text_alpha < 1) {
        text_alpha += 0.02;
    }
    
    if (keyboard_check_pressed(ord("Z")) && text_alpha >= 0.8) {
        is_fading_out = true;
        audio_play_sound(Beep, 1, false);
    }
} else {
    fade_out_alpha += 0.03;
    if (fade_out_alpha >= 1) {
        room_goto(rm_Controls);
    }
}