started_story = false;
global.current_objective = "Explore the world.";

CreateInteract(1490, 318, "???", "HELLOOOO!!!!! Welcome to your mind, Mila!!!!", c_white, 50);
CreateInteract(2460, 335, "???", "OOOMG, IT'S RELLY YOU MILA!!!!!", c_white, 50);
CreateInteract(3120, 378, "???", "OOOMG, IT'S RELLY YOU MILA!!!!!", c_white, 50);

if (variable_global_exists("load_data") && global.load_data != undefined) {
    if (variable_struct_exists(global.load_data, "started_story")) {
        started_story = global.load_data.started_story;
    }
}

scr_show_location("Maze Of Memories", c_white, true, 1);

if (!started_story) {
	alarm[0] = room_speed * 2.5;
}

global.isMila = true