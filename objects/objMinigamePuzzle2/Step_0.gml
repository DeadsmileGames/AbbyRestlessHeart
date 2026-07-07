if (win) {
    if (keyboard_check_pressed(ord("Z"))) {
        global.puzzle_solved = true;
        global.puzzle_active = false;
        global.keyBlue = true;
        
        if (!variable_global_exists("inventory")) global.inventory = [];
        array_push(global.inventory, {
            name: "Blue Key",
            type: "key",
            value: 0
        });
        Interact([
            { title: "SYSTEM", text: "Incredible! The corrupted sprout flowered perfectly!", color: c_yellow },
            { title: "SYSTEM", text: "You discovered a [BLUE KEY] tangled inside the roots. Added to inventory.", color: c_white },
		]);
        
        with (objMinigame2) { puzzle_solved = true; instance_destroy(); }
        instance_destroy();
    }
    exit;
}

if (game_over) {
    if (keyboard_check_pressed(ord("X"))) {
        global.puzzle_active = false;
        instance_destroy();
    }
    if (keyboard_check_pressed(ord("Z"))) {
        plant_growth = 0;
        fail_meter = 0;
        game_over = false;
        win = false;
    }
    exit;
}

rhythm_bar_y += rhythm_speed * rhythm_dir;
if (rhythm_bar_y >= 100 || rhythm_bar_y <= 0) {
    rhythm_dir *= -1;
}

flash_timer++;
if (flash_timer > 45) {
    flash_timer = 0;
    plant_flash = !plant_flash;
}

if (keyboard_check_pressed(ord("Z"))) {
    if (rhythm_bar_y >= target_min && rhythm_bar_y <= target_max) {
        plant_growth = min(100, plant_growth + 14);
        fail_meter = max(0, fail_meter - 10);
        audio_play_sound(move_sound, 1, false);
        rhythm_speed = min(6, rhythm_speed + 0.25); 
        
        if (plant_growth >= score_target) {
            win = true;
        }
    } else {
        fail_meter = min(max_fail, fail_meter + 20);
        plant_growth = max(0, plant_growth - 5);
        audio_play_sound(error_sound, 1, false);
        
        if (fail_meter >= max_fail) {
            game_over = true;
        }
    }
}

if (keyboard_check_pressed(ord("X"))) {
    global.puzzle_active = false;
    instance_destroy();
}