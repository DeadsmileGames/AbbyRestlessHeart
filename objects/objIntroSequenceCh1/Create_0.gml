timer = 0;
state = 0;
alpha = 1.0; 

lead_shards = []; 
ash_particles = [];

text_alpha = 0;
version_alpha = 0;
credits_alpha = 0;
game_version = "v0.15b";
paper_alpha = 1.0; 

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

paper_w = 640;
paper_h = 480;
paper_x = (_gw - paper_w) / 2;

paper_y = -paper_h - 100;
paper_target_y = (_gh - paper_h) / 2;
paper_angle = 18;
paper_target_angle = -2;

draw_text_progress = 0;
sub_text_progress = 0;

max_lead_shards = 30;
max_ash_particles = 60;

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
col_ink_sub      = make_color_rgb(115, 108, 96);