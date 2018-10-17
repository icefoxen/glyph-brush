#version 300 es

uniform mediump mat4 transform;

in mediump vec3 left_top;
in mediump vec2 right_bottom;
in mediump vec2 tex_left_top;
in mediump vec2 tex_right_bottom;
in mediump vec4 color;

out mediump vec2 f_tex_pos;
out mediump vec4 f_color;

// generate positional data based on vertex ID
void main() {
    mediump vec2 pos = vec2(0.0);
    mediump float left = left_top.x;
    mediump float right = right_bottom.x;
    mediump float top = left_top.y;
    mediump float bottom = right_bottom.y;

    switch (gl_VertexID) {
        case 0:
            pos = vec2(left, top);
            f_tex_pos = tex_left_top;
            break;
        case 1:
            pos = vec2(right, top);
            f_tex_pos = vec2(tex_right_bottom.x, tex_left_top.y);
            break;
        case 2:
            pos = vec2(left, bottom);
            f_tex_pos = vec2(tex_left_top.x, tex_right_bottom.y);
            break;
        case 3:
            pos = vec2(right, bottom);
            f_tex_pos = tex_right_bottom;
            break;
    }

    f_color = color;
    gl_Position = transform * vec4(pos, left_top.z, 1.0);
}
