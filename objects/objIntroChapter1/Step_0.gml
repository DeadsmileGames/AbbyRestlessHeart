if (!instance_exists(objPlayer)) {
}

var key_z = keyboard_check_pressed(ord("Z"));
var key_x = keyboard_check(ord("X")); 

timer++;
var current_speed = key_x ? (text_speed * 3) : text_speed;

switch (state) {
    case 0: 
        illustration_alpha = min(1, illustration_alpha + 0.02);
        if (illustration_alpha >= 1) {
            state = 1;
            timer = 0;
        }
        break;

    case 1:
        var target_text = intro_text_list[current_line];
        if (drawn_chars < string_length(target_text)) {
            drawn_chars += current_speed;
            current_display_text = string_copy(target_text, 1, floor(drawn_chars));
            
           
            if (floor(drawn_chars) % 3 == 0 && timer % 3 == 0) {
                if (audio_exists(Beep)) {
                    var sfx = audio_play_sound(Beep, 1, false);
                    audio_sound_gain(sfx, global.vol_sfx * 0.15, 0);
                    audio_sound_pitch(sfx, random_range(0.8, 1.2));
                }
            }
        } else {
            state = 2;
            timer = 0;
        }
        break;

    case 2:
        if (key_z) {
            if (current_line < array_length(intro_text_list) - 1) {
                current_line++;
                drawn_chars = 0;
                current_display_text = "";
                sketch_shake = 15;
                state = 1;
                timer = 0;
                if (audio_exists(Beep)) audio_play_sound(Beep, 1, false);
            } else {
                state = 3;
                timer = 0;
            }
        }
        break;

    case 3:
        text_alpha = max(0, text_alpha - 0.02);
        illustration_alpha = max(0, illustration_alpha - 0.02);
        if (text_alpha <= 0) {
            state = 4;
            timer = 0;
        }
        break;

    case 4:
        whisper_alpha = min(1, whisper_alpha + 0.02);
        if (whisper_alpha >= 1) {
            state = 5;
            timer = 0;
        }
        break;

    case 5:
        whisper_btn_alpha = min(1, whisper_btn_alpha + 0.04);
        if (key_z) {
            state = 6;
            timer = 0;
            if (audio_exists(Beep)) audio_play_sound(Beep, 1, false);
        }
        break;

    case 6:
        whisper_alpha = max(0, whisper_alpha - 0.03);
        whisper_btn_alpha = max(0, whisper_btn_alpha - 0.03);
        fade_alpha = min(1, fade_alpha + 0.03);
        
        if (whisper_alpha <= 0 && fade_alpha >= 1) {
            if (room_exists(rm_AbbyBedroom)) {
                room_goto(rm_AbbyBedroom);
            } else {
                room_goto_next();
            }
            instance_destroy();
        }
        break;
}
if (sketch_shake > 0) sketch_shake = max(0, sketch_shake - 1);