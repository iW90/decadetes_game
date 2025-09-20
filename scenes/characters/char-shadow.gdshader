shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float scale_x : hint_range(0.1, 5.0) = 1.0;
uniform float scale_y : hint_range(0.1, 5.0) = 0.5;
uniform float alpha = 0.6;

void fragment() {
    // Normalize UV to -1..1
    vec2 uv = (UV - 0.5) * 2.0;

    // Scale ellipse axes
    float dist = (uv.x / scale_x) * (uv.x / scale_x) +
                 (uv.y / scale_y) * (uv.y / scale_y);

    // Inside ellipse = 1.0, outside = 0.0
    float shadow = smoothstep(1.0, 0.75, dist);

    COLOR = vec4(0.0, 0.0, 0.0, shadow * alpha);
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
