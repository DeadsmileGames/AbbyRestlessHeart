if (variable_global_exists("last_choice_result")) {
    var resposta = global.last_choice_result;
    global.last_choice_result = -1;
    
    switch (resposta) {
        case 0:
            Interact([
                { title: "Abby", text: "Stop speaking in riddles! Tell me what happened inside that house!", color: c_white },
                { title: "???", text: "Your anger is just a shield for your terror, Abby. If you want answers, turn around and open that door. The truth doesn't knock.", color: c_red }
            ]);
            global.current_objective = "Check the noticeboard.";
            break;
            
        case 1:
            Interact([
                { title: "Abby", text: "I remember this place... I don't want to be here. Something horrible is inside, isn't it?", color: c_white },
                { title: "???", text: "Yes. It has been waiting for you for years, feeding on your numbness. Shaking out here won't make it disappear.", color: c_red }
            ]);
            global.current_objective = "Check the noticeboard.";
            break;
            
        case 2:
            Interact([
                { title: "...", color: c_white },
                { title: "???", text: "Silence won't save you either. You can't freeze time forever. The woods are already closing in. Enter the house.", color: c_red }
            ]);
            global.current_objective = "Check the noticeboard.";
            break;
    }
}

var notice_inst = instance_nearest(1277, 181, objInteract);
if (notice_inst != noone && global.current_objective == "Check the noticeboard.") {
    if (notice_inst.is_triggered && !instance_exists(objInteractSystem) && !instance_exists(objDialogue)) {
        global.current_objective = "Inspect the cabin door.";
    }
}

if (!active_puzzle && instance_exists(objPlayer)) {
    if (point_distance(objPlayer.x, objPlayer.y, door_x, door_y) < 60) {
        if (keyboard_check_pressed(ord("Z"))) {
            if (!global.keyYellow || !global.keyBlue || !global.keyGreen) {
                active_puzzle = true;
            }
        }
    }
}

if (active_puzzle) {
    global.current_objective = "Collect the 3 keys [" + string(global.minigames) + "/3]";
}

var door_inst = instance_nearest(928, 450, objInteract);
if (door_inst != noone) {
    if (global.minigames == 3 && !global.porta_liberada) {
        global.porta_liberada = true;
        with (door_inst) {
            interact_pages = [
                { title: "DOOR", text: "A loud, heavy click echoes from inside the lock. The frost on the wooden surface begins to fracture.", color: c_white },
                { title: "Abby", text: "Wow, okay... I guess the house decided I'm finally ready to suffer. Take a deep breath, Abby. No turning back now.", color: c_aqua }
            ];
        }
    }
    
    if (door_inst.is_triggered && global.minigames >= 3 && !instance_exists(objInteractSystem) && !instance_exists(objDialogue)) {
        door_inst.is_triggered = false;
        if (audio_is_playing(Walk)) audio_stop_sound(Walk);
        room_goto(rm_dev);
    }
}