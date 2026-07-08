timer = 0;
state = 0; 
text_alpha = 1.0;
fade_alpha = 0;
intro_text_list = [
    "Since I was a little girl, my house never felt like a home. It was an exhibition of expectations I could never fulfill.",
    "My parents looked at me not as a child, but as a mirror for their own unaccomplished dreams. Every failure of mine was an unpardonable sin.",
    "I grew up surrounded by a heavy, judgmental silence. But the worst part wasn't the yelling... it was watching my father slowly lose his grip on reality.",
    "He used to stare into blank walls for hours, whispering about a maze inside his own mind. A dark place where he kept his deepest secrets buried.",
    "And then, he just vanished. No note, no tracks, no goodbyes. He disappeared into thin air, leaving us behind with nothing but his broken belongings and an unfinished diary.",
    "My mother blamed me. She said my failures pushed him over the edge, that his mind shattered because he couldn't bear the weight of our reality anymore.",
    "I thought moving to this new city would change things. I genuinely believed that leaving that haunted house behind meant leaving his ghost behind too. How naive.",
    "The rain outside doesn't stop. It washes the streets, but it can't clean the noise inside my head. The city didn't save me; it just gave my isolation a bigger stage.",
    "Every corner here feels like a trap. I keep looking at unfamiliar faces, terrified that I might see his eyes staring back at me from the crowd.",
    "I lock the door behind me, holding his old diary close to my chest, hoping these walls can contain the shattered pieces of my own mind before I catch the same sickness he had.",
    "The darkness here is different. It doesn't bring peace. It brings back his whispers, echoing through the corridors of my thoughts, calling me to enter the very same void that swallowed him.",
    "The shadows on the ceiling look like hands... reaching down from his past, waiting for me to finally slip and follow his footsteps into the deep."
];

current_line = 0;
drawn_chars = 0;
text_speed = 0.35;
current_display_text = "";
illustration_alpha = 0;
sketch_shake = 0;
whisper_text = "You can make it, ABBY.";
whisper_alpha = 0;
whisper_btn_alpha = 0;
col_bg_dark      = make_color_rgb(15, 15, 18);
col_paper        = make_color_rgb(245, 238, 222);
col_pencil_lead  = make_color_rgb(55, 52, 48);
col_blood_pencil = make_color_rgb(166, 45, 45);
col_ink_sub      = make_color_rgb(115, 108, 96);
col_ink_main     = make_color_rgb(35, 32, 28);
col_ambient_shd  = make_color_rgb(8, 5, 4); 