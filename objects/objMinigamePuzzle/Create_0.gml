global.puzzle_active = true;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

box_w = 740;
box_h = 500;
bx1 = (gui_w - box_w) / 2;
by1 = (gui_h - box_h) / 2;
bx2 = bx1 + box_w;
by2 = by1 + box_h;

col_paper        = make_color_rgb(245, 238, 222); 
col_paper_shadow = make_color_rgb(218, 208, 188); 
col_paper_dark   = make_color_rgb(188, 178, 156); 
col_ink_main     = make_color_rgb(35, 32, 28);    
col_ink_sub      = make_color_rgb(95, 88, 76);    
col_notebook_line = make_color_rgb(192, 214, 216); 
var_margin_line  = make_color_rgb(225, 130, 130); 
col_coffee_stain = make_color_rgb(140, 115, 85);  
col_blood_red    = make_color_rgb(180, 40, 45);   
col_memory_blue  = make_color_rgb(135, 206, 250);

current_round = 0;
total_rounds = 5;
puzzle_won = false;

target_phrases = [
    "He used to draw dark woods before vanishing into the trees.",
    "Abby, memories are like dry leaves scattered by the cold wind.",
    "His office clock stopped ticking at exactly three in the morning.",
    "Do not look below the pages, his old sketches are breathing.",
    "Father tried to lock the nightmare, but left the key inside."
];

keyboard_string = "";
typed_text = "";
message = "";
message_timer = 0;

button_selected = 0; 
total_buttons = 3;   
buttons_labels = ["CLEAR", "CONFIRM", "EXIT"];

screen_shake = 0;
flash_alpha = 0;
flash_color = c_white;

move_sound = Beep;
error_sound = Beep;

input_cooldown = 0;