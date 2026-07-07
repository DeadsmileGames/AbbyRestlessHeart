if (cooldown > 0) cooldown--;
if (puzzle_solved) exit;
if (!instance_exists(objPlayer)) exit;
if (objPlayer.config_open) exit;
if (global.puzzle_active || instance_exists(objMinigamePuzzle)) {
    show_prompt = false;
    exit;
}

if (instance_exists(objBattleManager)) {
    hspd = 0;
    vspd = 0;
    state = "idle"; 
    exit; 
}



var dist = point_distance(x, y, objPlayer.x, objPlayer.y);
show_prompt = (dist < trigger_distance);

if (show_prompt && keyboard_check_pressed(ord("Z"))) {
    global.puzzle_active = true;
    var puzzle = instance_create_depth(0, 0, -10000, objMinigamePuzzle);
    puzzle.puzzle_x = x;
    puzzle.puzzle_y = y;
    show_prompt = false;
}