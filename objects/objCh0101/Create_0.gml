started_story = false;
global.current_objective = "Explore the world.";

if (!variable_global_exists("minigames")) global.minigames = 0;
global.porta_liberada = false;
if (!variable_global_exists("keyYellow")) global.keyYellow = false;
if (!variable_global_exists("keyBlue"))   global.keyBlue = false;
if (!variable_global_exists("keyGreen"))  global.keyGreen = false;

CreateInteract(1190, 294, [
    { title: "Abby", text: "Who... who is there? Why is it so cold out here?", color: c_white },
    { title: "???", text: "A shadow from your past, Abby. Look at that house beside us. Look at how the woods swallow it whole.", color: c_aqua },
    { title: "???", text: "This is a memory of when you were little. A place where you were completely alone... right before everything went dark.", color: c_aqua },
    { title: "???", text: "Your mind blocked it out to protect you, but the monster is still breathing inside those rooms. What do you want to do?", color: c_aqua, choices: ["Demand answers.", "Express fear.", "Stay silent."] }
], 50);

CreateInteract(1277, 181, [
    { title: "NOTICEBOARD", text: "A rusted community noticeboard stands cracked under the trees. Most papers are decayed, but one yellowed clipping is pinned tightly.", color: c_white },
    { title: "NOTICEBOARD", text: "\"COMMUNITY ALERT: Several reports of trespassing and strange noises near the eastern woods. Residents are advised to lock their doors at night.\"", color: c_white },
    { title: "Abby", text: "I remember my father laughing when he read this... He told me the woods were our private kingdom and nothing could ever reach us here.", color: c_aqua },
    { title: "Abby", text: "He was wrong. So completely wrong.", color: c_aqua }
], 50);

CreateInteract(860, 536, [
    { title: "SIGN", text: "\"ABBY'S AND HER SUPER DADDY HOUSE.\"", color: c_white },
    { title: "Abby", text: "It's written in rough, hand-carvel letters... His handwriting used to feel so warm. Now, just looking at it makes my chest feel tight.", color: c_aqua }
], 50);

var door_obj = instance_create_layer(928, 450, "Instances", objInteract);
with (door_obj) {
    is_door_trigger = true;
    trigger_distance = 50;
    
    if (global.keyYellow && global.keyBlue && global.keyGreen) {
        interact_pages = [
            { title: "DOOR", text: "A loud, heavy click echoes from inside. The frost on the surface begins to fracture.", color: c_white },
            { title: "Abby", text: "I guess the house decided I'm finally ready. Take a deep breath, Abby. No turning back.", color: c_aqua }
        ];
    } else {
        interact_pages = [
            { title: "DOOR", text: "The front door is frozen shut. Heavy, old locks bar the handle completely.", color: c_white },
            { title: "Abby", text: "Locked out... It looks like I'll have to search the woods to find a way into this place.", color: c_aqua }
        ];
    }
}
if (variable_global_exists("load_data") && global.load_data != undefined) {
    if (variable_struct_exists(global.load_data, "started_story")) {
        started_story = global.load_data.started_story;
    }
}

scr_show_location("Sweet Home", c_white, true, 1);

if (!started_story) {
    alarm[0] = room_speed * 2.5;
}