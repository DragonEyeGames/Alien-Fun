shader_type canvas_item;

uniform float whiteness : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    vec3 target = vec3(1.0);

    vec3 final_rgb = mix(tex.rgb, target, whiteness);

    COLOR = vec4(final_rgb, tex.a);
}