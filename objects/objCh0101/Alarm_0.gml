var _color_sangue = make_color_rgb(166, 45, 45);
var _color_margem = make_color_rgb(225, 130, 130);

dialogue("Abby", "WHAT THE HELL IS THIS?! WHERE AM I?!", 0.3, c_white, global.fonteNormal, -1);
dialogue("", "The fresh air hits you first a quiet, unsettling stillness that fills this vibrant clearing in the middle of the woods.", 0.3, _color_margem, global.fonteNormal, -1);
dialogue("Abby", "This isn't my room in the city! Look at this place... Is that an old cabin? The noticeboard... No, wait, why does this look like my childhood backyard?!", 0.3, c_white, global.fonteNormal, -1);
dialogue("Abby", "This makes no sense! I just lay down to sleep! I can't breathe... I'm trapped in some sick nightmare!", 0.3, _color_sangue, global.fonteNormal, -1);
dialogue("", "Panicking won't wake you up. Perhaps that guy standing right beside the noticeboard has the answers you are looking for. Go talk to him.", 0.3, _color_margem, global.fonteNormal, -1);

global.current_objective = "Talk with the guy.";
started_story = true;