if (message_timer > 0) message_timer--;
if (input_cooldown > 0) input_cooldown--;

if (screen_shake > 0) {
    screen_shake = max(0, screen_shake - 0.4);
}
if (flash_alpha > 0) {
    flash_alpha = max(0, flash_alpha - 0.025);
}

if (!puzzle_won) {
    var _clean_string = "";
    var _len = string_length(keyboard_string);
    
    for (var i = 1; i <= _len; i++) {
        var _char = string_char_at(keyboard_string, i);
        var _ascii = ord(_char);
        if (_ascii >= 32 && _ascii <= 126) {
            _clean_string += _char;
        }
    }
    
    if (string_length(_clean_string) > 75) {
        _clean_string = string_copy(_clean_string, 1, 75);
        keyboard_string = _clean_string;
    }
    
    typed_text = _clean_string;
    
    if (input_cooldown == 0) {
        if (keyboard_check_pressed(vk_left)) {
            button_selected--;
            if (button_selected < 0) button_selected = total_buttons - 1;
            if (audio_exists(move_sound)) audio_play_sound(move_sound, 1, false);
            input_cooldown = 4;
        }
        if (keyboard_check_pressed(vk_right)) {
            button_selected++;
            if (button_selected >= total_buttons) button_selected = 0;
            if (audio_exists(move_sound)) audio_play_sound(move_sound, 1, false);
            input_cooldown = 4;
        }
    }
    
    if (keyboard_check_pressed(vk_enter) || (keyboard_check_pressed(ord("Z")) && input_cooldown == 0)) {
        if (button_selected == 0) {
            keyboard_string = "";
            typed_text = "";
            message = "Input cleared.";
            message_timer = 30;
            if (audio_exists(move_sound)) audio_play_sound(move_sound, 1, false);
        } 
        else if (button_selected == 1) {
            var target = target_phrases[current_round];
            
            if (typed_text == target) {
                current_round++;
                keyboard_string = "";
                typed_text = "";
                
                flash_alpha = 1.0;
                flash_color = col_memory_blue;
                
                if (current_round >= total_rounds) {
                    puzzle_won = true;
                    global.puzzle_solved = true;
                    global.puzzle_active = false;
                    global.keyYellow = true;
                    
                    if (!variable_global_exists("inventory")) global.inventory = [];
                    array_push(global.inventory, {
                        name: "Yellow Key",
                        type: "key",
                        value: 0
                    });
                    
                    Interact([
                        { title: "SYSTEM", text: "Unbelievable. You reconstructed every lost memory block within the journal.", color: col_blood_red },
                        { title: "SYSTEM", text: "You received the [YELLOW KEY]. It has been embedded into your soul structure.", color: col_ink_main },
                        { title: "ABBY", text: "...What are these fading recollections? Why... why are they so heavily blurred?", color: col_ink_sub }
                    ]);
                    
                    with (objMinigame) { puzzle_solved = true; instance_destroy(); }
                    instance_destroy();
                } else {
                    message = "Memory restored... Advancing neural layers.";
                    message_timer = 50;
                    if (audio_exists(move_sound)) audio_play_sound(move_sound, 1, false);
                }
            } else {
                message = "The calligraphy or punctuation fails to sync.";
                message_timer = 65;
                screen_shake = 10;
                flash_alpha = 0.6;
                flash_color = col_blood_red;
                if (audio_exists(error_sound)) audio_play_sound(error_sound, 1, false);
            }
        } 
        else if (button_selected == 2) {
            global.puzzle_active = false;
            instance_destroy();
        }
        
        input_cooldown = 10;
    }
}