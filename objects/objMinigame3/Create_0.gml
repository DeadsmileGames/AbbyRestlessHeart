puzzle_solved = false;
trigger_distance = 45;
cooldown = 0;
show_prompt = false;
if (variable_global_exists("keyGreen") && global.keyGreen) {
    instance_destroy();
    exit;
}

interact_text = "Press Z to Break Stone";