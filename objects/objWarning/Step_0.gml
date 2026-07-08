var confirm_key = ord("Z");
if (instance_exists(objPlayer)) {
    if (variable_instance_exists(objPlayer, "controls")) {
        if (array_length(objPlayer.controls) > 2) {
            confirm_key = objPlayer.controls[2][1];
        }
    }
}

if (!is_fading_out) {
    paper_y += (paper_target_y - paper_y) * 0.08;
    
    if (text_alpha < 1 && abs(paper_y - paper_target_y) < 15) {
        text_alpha += 0.03;
    }
    
    if (keyboard_check_pressed(confirm_key) && text_alpha >= 0.7) {
        is_fading_out = true;
        paper_target_y = -paper_h - 150;
        if (audio_exists(Beep)) audio_play_sound(Beep, 1, false);
    }
} else {
    paper_y += (paper_target_y - paper_y) * 0.09;
    
    if (paper_y <= -paper_h - 20) {
        fade_out_alpha += 0.04;
        if (fade_out_alpha >= 1) {
            room_goto(rm_Controls);
        }
    }
}