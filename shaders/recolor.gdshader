shader_type canvas_item;

uniform int color_count = 1; // how many recolors are active
uniform vec4 from_colors[16] : source_color; // original colors to match
uniform vec4 to_colors[16] : source_color;   // up to 16 replacement colors

uniform float threshold = 0.1;
uniform float strength = 0.5;  // 0 = no change, 1 = full recolor

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec3 final_rgb = tex_color.rgb;

    for (int i = 0; i < color_count; i++) {
        float diff = distance(tex_color.rgb, from_colors[i].rgb);
        if (diff < threshold) {
            // remap distance to [0,1] for smooth transition
            float t = 1.0 - (diff / threshold); // closer colors recolor more
            t *= strength; // apply overall strength
            final_rgb = mix(final_rgb, to_colors[i].rgb, t);
        }
    }

    COLOR = vec4(final_rgb, tex_color.a);
}