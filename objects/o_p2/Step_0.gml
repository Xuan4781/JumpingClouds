if (keyboard_check(left_key)) {
    x_vel -= accel;
}
if (keyboard_check(right_key)) {
    x_vel += accel;
}

event_inherited();