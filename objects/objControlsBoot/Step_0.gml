var _key_up    = keyboard_check_pressed(vk_up);
var _key_down  = keyboard_check_pressed(vk_down);
var _key_z     = keyboard_check_pressed(ord("Z"));
var _key_x     = keyboard_check_pressed(ord("X"));
if (!is_leaving) {
    paper_y += (paper_target_y - paper_y) * 0.08;
    page_flip_angle += (page_flip_target_angle - page_flip_angle) * 0.12;
    page_flip_target_angle += (0 - page_flip_target_angle) * 0.1;
    if (abs(paper_y - paper_target_y) < 30) {
        if (!credits_open) {
            if (_key_up) {
                selected_option = max(0, selected_option - 1);
                if (audio_exists(Beep)) audio_play_sound(Beep, 1, false);
            }
            if (_key_down) {
                selected_option = min(array_length(options) - 1, selected_option + 1);
                if (audio_exists(Beep)) audio_play_sound(Beep, 1, false);
            }
            if (_key_z) {
                if (selected_option == 0) {
                    is_leaving = true;
                    paper_target_y = -paper_h - 150;
                    if (audio_exists(Beep)) audio_play_sound(Beep, 1, false);
                } else if (selected_option == 1) {
                    credits_open = true;
                    page_flip_angle = -8; 
                    page_flip_target_angle = 4;
                    if (audio_exists(Beep)) audio_play_sound(Beep, 1, false);
                }
            }
        } else {
            if (_key_x) {
                credits_open = false;
                page_flip_angle = 8;
                page_flip_target_angle = -4;
                if (audio_exists(Beep)) audio_play_sound(Beep, 1, false);
            }
        }
    }
} else {
    paper_y += (paper_target_y - paper_y) * 0.09;
    
    if (paper_y <= -paper_h - 20) {
        leave_fade_alpha += 0.04;
        if (leave_fade_alpha >= 1) {
            room_goto(target_menu_room);
        }
    }
}