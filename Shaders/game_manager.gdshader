shader_type canvas_item;

uniform float radius = 0.0;
uniform vec2 position = vec2(0.5, 0.5);

void fragment() {

    float dist = distance(UV, position);

    if (dist < radius) {
        COLOR.a = 0.0;
    }
}