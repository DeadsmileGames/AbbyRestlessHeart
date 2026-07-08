selected_option = 0;
options = ["BEGIN GAME", "CREDITS"];
controls_list = [
    "[ARROWS] - Move",
    "[Z] - Confirm",
    "[X] - Cancel",
    "[C] - Menu (In-game)",
    "[F4] - Fullscreen",
    "[Hold ESC] - Quit to desktop",
    "[F6] - Toggle CRT effect",
    "When HP is 0, you lose."
];

credits_open = false;
credits_list = [
    "INSOMNIA - STAFF",
    "",
    "Development & Code",
    "LUXJSON",
    "",
    "Art & Pixel Art",
    "LUXJSON, SSCARY (sscary.itch.io).",
    "",
    "Original Soundtrack",
    "LUXJSON",
    "",
    "Special Thanks",
    "Our supportive community!"
];

title_text = "INSOMNIA v0.15b (C) SOMIARI GAMES";
target_menu_room = rm_Intro;
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

paper_w = 560;
paper_h = 480;
paper_x = (_gw - paper_w) / 2;
paper_y = _gh + 180; 
paper_target_y = (_gh - paper_h) / 2;

is_leaving = false;
leave_fade_alpha = 0;
page_flip_angle = 0;
page_flip_target_angle = 0;
col_wood_base    = make_color_rgb(28, 19, 14);
col_wood_deep    = make_color_rgb(18, 11, 8);
col_wood_grain   = make_color_rgb(46, 32, 24);
col_wood_knot    = make_color_rgb(13, 8, 6);
col_ambient_shd  = make_color_rgb(8, 5, 4);

col_paper        = make_color_rgb(245, 238, 222);
col_paper_shadow = make_color_rgb(218, 208, 188);
col_pencil_lead  = make_color_rgb(55, 52, 48);
col_blood_pencil = make_color_rgb(166, 45, 45);
col_notebook_line = make_color_rgb(192, 214, 216);
col_margin_line  = make_color_rgb(225, 130, 130);
col_ink_main     = make_color_rgb(35, 32, 28);
col_ink_sub      = make_color_rgb(115, 108, 96);