if (variable_global_exists("last_choice_result")) {
    var resposta = global.last_choice_result;
    global.last_choice_result = -1;
    
    switch (resposta) {
        case 0:
            Interact([
                { title: "Abby", text: "Stop speaking in riddles! Tell me what happened inside that house!", color: c_white },
                { title: "???", text: "Your anger is just a shield for your terror, Abby. If you want answers, turn around and open that door. The truth doesn't knock.", color: c_red }
            ]);
            break;
            
        case 1:
            Interact([
                { title: "Abby", text: "I remember this place... I don't want to be here. Something horrible is inside, isn't it?", color: c_white },
                { title: "???", text: "Yes. It has been waiting for you for years, feeding on your numbness. Shaking out here won't make it disappear.", color: c_red }
            ]);
            break;
            
        case 2:
            Interact([
                { title: "Abby", text: "...", color: c_white },
                { title: "???", text: "Silence won't save you either. You can't freeze time forever. The woods are already closing in. Enter the house.", color: c_red }
            ]);
            break;
    }
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