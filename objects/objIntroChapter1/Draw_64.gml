var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var base_x = _gw / 2;

gpu_set_texfilter(false);
draw_set_color(col_bg_dark);
draw_rectangle(0, 0, _gw, _gh, false);
if (state <= 3) {
    var img_w = 600;
    var img_h = 320;
    var ix1 = (_gw - img_w) / 2 + random_range(-sketch_shake, sketch_shake) * 0.3;
    var iy1 = 60 + random_range(-sketch_shake, sketch_shake) * 0.3;
    var ix2 = ix1 + img_w;
    var iy2 = iy1 + img_h;

    draw_set_alpha(illustration_alpha);
    draw_set_color(col_paper);
    draw_rectangle(ix1, iy1, ix2, iy2, false);

    draw_set_color(col_pencil_lead);

    for (var hx = ix1 + 40; hx < ix2 - 40; hx += 30) {
        draw_line(hx, iy1 + 40, hx - 20, iy2 - 40);
    }
    var cx = ix1 + img_w / 2;
    var cy = iy1 + img_h / 2 + 20;
    draw_rectangle(cx - 50, cy - 50, cx + 50, cy + 20, true);
    for (var hx = cx - 40; hx < cx + 40; hx += 6) {
        draw_line(hx, cy - 40, hx + 10, cy + 15);
    }
    draw_set_color(col_pencil_lead);
    draw_rectangle(ix1, iy1, ix2, iy2, true);
    draw_rectangle(ix1 + 3, iy1 + 3, ix2 - 3, iy2 - 3, true);
    
    var corner = 10;
    draw_rectangle(ix1, iy1, ix1 + corner, iy1 + corner, true);
    draw_rectangle(ix2 - corner, iy1, ix2, iy1 + corner, true);
    var tx1 = ix1;
    var ty1 = iy2 + 40;
    var tx2 = ix2;
    var ty2 = _gh - 60;

    draw_set_alpha(text_alpha);
    
    draw_set_color(col_paper);
    draw_rectangle(tx1, ty1, tx2, ty2, false);
    
    draw_set_color(col_pencil_lead);
    draw_rectangle(tx1, ty1, tx2, ty2, true);
    draw_rectangle(tx1 + 2, ty1 + 2, tx2 - 2, ty2 - 2, true);
    
    draw_set_color(make_color_rgb(230, 220, 200));
    draw_line(tx1 + 15, ty1 + 45, tx2 - 15, ty1 + 45);
    draw_line(tx1 + 15, ty1 + 85, tx2 - 15, ty1 + 85);
    draw_line(tx1 + 15, ty1 + 125, tx2 - 15, ty1 + 125);

    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(col_ink_main);
    draw_text_ext(tx1 + 30, ty1 + 25, current_display_text, 32, (tx2 - tx1) - 60);

    if (state == 2) {
        var blink_alpha = 0.4 + sin(current_time / 200) * 0.4;
        draw_set_font(global.fonteLegenda);
        draw_set_halign(fa_right);
        draw_set_color(col_blood_pencil);
        draw_set_alpha(blink_alpha * text_alpha);
        draw_text(tx2 - 25, ty2 - 25, "Press Z >");
    }
}

if (state >= 4) {
    draw_set_font(global.fonteTitulo2);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(whisper_alpha);
    
    draw_set_color(col_ambient_shd);
    draw_text(base_x + 2, _gh / 2 + 2, whisper_text);
    
    draw_set_color(col_blood_pencil);
    draw_text(base_x, _gh / 2, whisper_text);

    if (state >= 5) {
        var prompt_pulse = 0.5 + sin(current_time / 300) * 0.3;
        draw_set_font(global.fonteLegenda);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_set_color(col_ink_sub);
        draw_set_alpha(whisper_btn_alpha * prompt_pulse);
        draw_text(base_x, _gh - 50, "PRESS Z TO CONTINUE");
    }
}

if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
}

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);