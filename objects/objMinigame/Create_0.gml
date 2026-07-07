puzzle_solved = false;
trigger_distance = 50;
cooldown = 0;
show_prompt = false;
interact_text = "Press Z to solve puzzle";
if (variable_global_exists("keyYellow") && global.keyYellow) {
    instance_destroy();
    exit;
}