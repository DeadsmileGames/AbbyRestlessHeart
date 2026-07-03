selected_option = 0;
options = ["BEGIN GAME", "CREDITS"];
controls_list = [
    "[ARROWS] - Move",
    "[Z] - Confirm",
    "[X] - Cancel",
    "[C] - Menu (In-game)",
    "[F4] - Fullscreen",
    "[Hold ESC] - QUIT TO DESKTOP",
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

title_text = "INSOMNIA v0.12b (C) SOMIARI GAMES";
target_menu_room = rm_Intro;



if (!audio_is_playing(StartMenu)) {
    global.music_id = audio_play_sound(StartMenu, 10, true);
    audio_sound_gain(global.music_id, global.vol_bgm, 0);
}