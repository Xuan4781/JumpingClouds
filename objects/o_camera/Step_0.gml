var target_y;
var has_target = false;

if (instance_exists(o_p1) && instance_exists(o_p2)) {
    // avg y
    target_y = (o_p1.y + o_p2.y) / 2;
    has_target = true;
}
else if (instance_exists(o_p1)) {
    // if p1 is the only alive, follow it
    target_y = o_p1.y;
    has_target = true;
}
else if (instance_exists(o_p2)) {
    // else follow p2
    target_y = o_p2.y;
    has_target = true;
}

if (has_target) {
    var current_cam_y = camera_get_view_y(cam);
    var final_target_y = target_y - 200;
    var new_y = lerp(current_cam_y, final_target_y, cam_speed);
    camera_set_view_pos(cam, camera_get_view_x(cam), new_y);
}

var cam_y = camera_get_view_y(cam);
var cam_height = camera_get_view_height(cam);
var room_top = 0;
var room_bottom = room_height - cam_height;

var clamped_y = clamp(cam_y, room_top, room_bottom);

camera_set_view_pos(cam, camera_get_view_x(cam), clamped_y);