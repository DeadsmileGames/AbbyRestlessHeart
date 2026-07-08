started_story = false;
alarm_triggered = false;
scr_set_objective("Go to sleep");



if (variable_global_exists("load_data") && global.load_data != undefined) {
    if (variable_struct_exists(global.load_data, "started_story")) {
        started_story = global.load_data.started_story;
    }
}


CreateInteract(500, 253, [
    { title: "WARDROBE", text: "I really should organize this wardrobe. I'm getting old, still living alone... and god, what a disaster.", color: c_white }
], 50);

CreateInteract(700, 590, [
    { title: "WINDOW", text: "* You approach the window and the world answers. 'It's a waste to have you trapped in here...'", color: c_aqua }
], 50);

CreateInteract(850, 273, [
    { title: "DRAWERS", text: "Ugh... so many clothes to fold. Just looking at this makes me tired.", color: c_white }
], 50);
scr_show_location("Abby's Bedroom", c_white, true, 1);

if (!started_story) {
    alarm[1] = room_speed * 2.8;
}
