if (array_length(global.interact_queue) == 0 && !processing) {
    instance_destroy();
    exit;
}

if (!processing && array_length(global.interact_queue) > 0) {
    var data = global.interact_queue[0];
    title = data.title;
    text = data.text;
    color = data.color;
    
    if (variable_struct_exists(data, "choices")) {
        has_choices = true;
        choice_array = data.choices;
        choice_selected = 0;
    } else {
        has_choices = false;
        choice_array = [];
    }
    
    processing = true;
    array_delete(global.interact_queue, 0, 1);
    
    if (!has_choices) {
        dialogue(title, text, 0.3, color, global.fonteNormal, -1);
    }
}

if (processing) {
    if (has_choices) {
        if (keyboard_check_pressed(vk_up)) {
            choice_selected--;
            if (choice_selected < 0) choice_selected = array_length(choice_array) - 1;
        }
        if (keyboard_check_pressed(vk_down)) {
            choice_selected++;
            if (choice_selected >= array_length(choice_array)) choice_selected = 0;
        }
        if (keyboard_check_pressed(ord("Z"))) {
            global.last_choice_result = choice_selected; 
            has_choices = false;
            processing = false;
        }
    } else {
        if (!instance_exists(objDialogue)) {
            processing = false;
        }
    }
}