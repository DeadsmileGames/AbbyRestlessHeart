started_story = false;
global.current_objective = "Explore the world.";
active_puzzle = false;

if (!variable_global_exists("minigames")) global.minigames = 0;
global.porta_liberada = false;
if (!variable_global_exists("keyYellow")) global.keyYellow = false;
if (!variable_global_exists("keyBlue"))   global.keyBlue = false;
if (!variable_global_exists("keyGreen"))  global.keyGreen = false;

var _col_blood = make_color_rgb(166, 45, 45);
var _col_margin = make_color_rgb(225, 130, 130);

CreateInteract(1190, 294, [
    { title: "Abby", text: "Wait... No, no, no! This is impossible! I was just in my room... why am I back in this clearing?!", color: c_white },
    { title: "???", text: "Because your mind can't run from reality forever, Abby. Look at this place. Look at how normal it seems, right before everything went wrong.", color: _col_blood },
    { title: "???", text: "This is the backyard of the night your father's mind shattered. The night before he vanished into thin air.", color: _col_blood },
    { title: "???", text: "The guilt you carry is still buried right under this green grass. What do you want to do?", color: _col_blood, choices: ["Demand answers.", "Scream in panic.", "Stay silent."] }
], 50);

CreateInteract(1277, 181, [
    { title: "NOTICEBOARD", text: "A rusted community noticeboard stands cracked under the trees. Most papers are decayed, but one yellowed clipping is pinned tightly.", color: c_white },
    { title: "NOTICEBOARD", text: "\"COMMUNITY ALERT: Several reports of trespassing and strange noises near the eastern woods. Residents are advised to lock their doors at night.\"", color: c_white },
    { title: "Abby", text: "I remember when he read this... He laughed. He told me the maze in his own head was far more dangerous than anything hiding in these trees.", color: c_aqua },
    { title: "Abby", text: "He wasn't afraid of the woods. He was already drowning in his own void.", color: c_aqua }
], 50);

CreateInteract(860, 536, [
    { title: "SIGN", text: "\"ABBY'S AND HER SUPER DADDY HOUSE.\"", color: c_white },
    { title: "Abby", text: "He carved this with his old pocket knife right before he started staring at blank walls... His handwriting used to feel so warm.", color: c_aqua },
    { title: "Abby", text: "Now, just looking at it makes my chest feel tight. I can still hear my mother screaming that it was all my fault.", color: _col_blood }
], 50);

door_x = 928;
door_y = 450;

var door_obj = instance_create_layer(door_x, door_y, "Instances", objInteract);
with (door_obj) {
    is_door_trigger = true;
    trigger_distance = 50;
    
    if (global.keyYellow && global.keyBlue && global.keyGreen) {
        interact_pages = [
            { title: "DOOR", text: "A loud, heavy click echoes from inside. The old wooden handle suddenly moves.", color: c_white },
            { title: "Abby", text: "I guess I have no choice but to face his sickness. Take a deep breath, Abby. No turning back.", color: c_aqua }
        ];
    } else {
        interact_pages = [
            { title: "DOOR", text: "The cabin door is locked tight. Old, heavy brass locks bar the entrance completely.", color: c_white },
            { title: "Abby", text: "Locked out of my own childhood... The missing fragments of his old diary must be scattered somewhere around these woods. I need to find them to get in.", color: c_aqua }
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