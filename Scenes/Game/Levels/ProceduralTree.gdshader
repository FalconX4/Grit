shader_type canvas_item;

uniform vec2 leaf_size = vec2(100.0, 50.0); // Size of the leaf
uniform vec4 leaf_color = vec4(0.0, 0.8, 0.0, 1.0); // Color of the leaf
uniform float vein_width = 2.0; // Width of the veins
uniform vec4 vein_color = vec4(0.8, 0.5, 0.2, 1.0); // Color of the veins

float sdVesica(vec2 p, float r, float d)
{
    p = abs(p);
    float b = sqrt(r*r-d*d);
    return ((p.y-b)*d>p.x*b) ? length(p-vec2(0.0,b))
                             : length(p-vec2(-d,0.0))-r;
}

void fragment() {
	vec2 uv = UV * 2.0 - 1.0;

    // Elliptical shape for the leaf
    float ra1 = 0.39345839256421434343321275241163;
    float ra2 = 0.67290819113455928680029742767192;
    float wid = 0.5;
	float d = sdVesica(uv, wid, ra1 ) - ra2;

    vec4 col = (d>0.0) ? vec4(0) : leaf_color;
	//col *= 1.0 - exp(-6.0*abs(d));
	//col *= 0.8 + 0.2*cos(110.0*d);
	col = mix( col, vein_color, 1.0-smoothstep(0.0,0.1,abs(d)) );
    //col = mix( col, leaf_color, 1.0-smoothstep(0.0,0.005,abs(d)) );
/*
    // Main vein (center line)
    float main_vein = smoothstep(-vein_width / 2.0, vein_width / 2.0, abs(uv.x) - 0.02);

    // Side veins (pattern along the main vein)
    float side_veins = 0.0;
    for (float i = -leaf_size.y; i <= leaf_size.y; i += leaf_size.y / 10.0)
	{
        side_veins += smoothstep(-vein_width / 2.0, vein_width / 2.0, abs(uv.y - i) - 0.02);
    }

    // Combine main vein and side veins
    float veins = main_vein + side_veins;
    veins = clamp(veins, 0.0, 1.0);
    // Leaf color with veins
    vec3 color = mix(leaf_color, vein_color, veins);
*/
    COLOR = vec4(col);
}