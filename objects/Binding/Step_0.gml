if (keyboard_check_pressed(vk_f4)) {
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
        global.fullscreen = false;
    } else {
        window_set_fullscreen(true);
        global.fullscreen = true;
    }
    
    ini_open("configuracoes.ini");
    ini_write_real("Video", "Fullscreen", global.fullscreen);
    ini_close();
}
if (!instance_exists(objGame)) {
	if (keyboard_check(vk_escape)) {
	    esc_hold_timer++;
	    if (esc_hold_timer >= esc_max_time) {
	        game_end();
	    }
	} else {
	    esc_hold_timer = 0;
	}
}

if (keyboard_check_pressed(vk_f6)) {
    global.crt_active = !global.crt_active;
}