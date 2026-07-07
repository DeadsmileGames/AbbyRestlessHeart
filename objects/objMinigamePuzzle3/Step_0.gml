if (win) {
    if (keyboard_check_pressed(ord("Z"))) {
        global.puzzle_solved = true;
        global.puzzle_active = false;
        global.keyGreen = true;
        if (!variable_global_exists("inventory")) global.inventory = [];
        array_push(global.inventory, {
            name: "Green Key",
            type: "key",
            value: 0
        });
        
        Interact([
            { title: "SYSTEM", text: "Success! The giant field boulder shattered into pieces!", color: c_yellow },
            { title: "SYSTEM", text: "Underneath the rubble, you uncovered the [GREEN KEY]. Added to inventory.", color: c_white },
        ]);
        
        with (objMinigame3) { puzzle_solved = true; instance_destroy(); }
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
        cursor_x = stone_x;
        cursor_y = stone_y;
        crack_active = false;
        cracks_broken = 0;
        pickaxe_durability = 100;
        hit_flash = 0;
        game_over = false;
        win = false;
    }
    exit;
}

pickaxe_durability -= 0.12;
if (pickaxe_durability <= 0) {
    game_over = true;
    audio_play_sound(error_sound, 1, false);
}
var move_speed = 7;
if (keyboard_check(vk_left))  cursor_x -= move_speed;
if (keyboard_check(vk_right)) cursor_x += move_speed;
if (keyboard_check(vk_up))    cursor_y -= move_speed;
if (keyboard_check(vk_down))  cursor_y += move_speed;

cursor_x = clamp(cursor_x, bx1 + 20, bx2 - 20);
cursor_y = clamp(cursor_y, by1 + 60, by2 - 20);

if (!crack_active) {
    var random_angle = random(360);
    var random_dist = random_range(10, 85);
    crack_x = stone_x + lengthdir_x(random_dist, random_angle);
    crack_y = stone_y + lengthdir_y(random_dist, random_angle);
    
    crack_hp = 4;
    crack_active = true;
}
if (keyboard_check_pressed(ord("Z"))) {
    if (point_distance(cursor_x, cursor_y, crack_x, crack_y) < 30) {
        crack_hp--;
        hit_flash = 5;
        shake_x = choose(-4, 4);
        shake_y = choose(-4, 4);
        audio_play_sound(move_sound, 1, false);
        
        if (crack_hp <= 0) {
            crack_active = false;
            cracks_broken++;
            if (cracks_broken >= target_cracks) {
                win = true;
            }
        }
    } else {
        pickaxe_durability -= 5;
        shake_x = choose(-2, 2);
        audio_play_sound(error_sound, 1, false);
    }
}

shake_x = lerp(shake_x, 0, 0.2);
shake_y = lerp(shake_y, 0, 0.2);
if (hit_flash > 0) hit_flash--;

if (keyboard_check_pressed(ord("X"))) {
    global.puzzle_active = false;
    instance_destroy();
}