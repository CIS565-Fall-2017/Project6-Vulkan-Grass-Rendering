#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 f_pos;
layout(location = 1) in vec3 f_nor;
layout(location = 2) in float f_occ;

layout(location = 0) out vec4 outColor;

void main() {
    // simple blinn shading
	
	vec3 N = normalize(f_nor);
	vec3 V = normalize(-f_pos);
	N = faceforward(N, V, -N);
	vec3 lightDir = (camera.view * vec4(normalize(vec3(-1)), 0.0)).xyz;
	//vec3 lightDir = normalize(f_pos - (camera.view * vec4(0.0, 5.0, 0.0, 1.0)).xyz);
	vec3 H = normalize(V - lightDir);
	vec3 specColor = mix(vec3(0.3), vec3(0.05, 0.1, 0.05), 0.3 * f_occ); // faked occlusion
	vec3 diffColor = mix(vec3(0.35, 0.7, 0.2), vec3(0.05, 0.1, 0.05), 0.4 * f_occ); // faked occlusion
	vec3 backScatter = vec3(0.4, 0.9, 0.2);

	diffColor *= max(0.0, dot(N, -lightDir));
	specColor *= pow(max(0.0, dot(N, H)), 64.0);
	backScatter *= 0.3 * max(0.0, dot(N, V)) * pow(max(0.0, dot(-N, -lightDir)), 16.0) + 0.2 * max(0.0, dot(-N, -lightDir));

    outColor = vec4(specColor + diffColor + backScatter, 1.0);
	outColor.xyz = mix(outColor.xyz, vec3(0.05, 0.1, 0.05), 0.5 * f_occ);
	outColor.xyz *= vec3(1.0, 0.95, 0.9); // warm sunlight
}
