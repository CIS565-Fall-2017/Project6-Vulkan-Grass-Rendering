#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 f_pos;
layout(location = 1) in vec3 f_nor;

layout(location = 0) out vec4 outColor;

void main() {
    // simple blinn shading
	vec3 N = normalize(f_nor);
	vec3 lightDir = normalize(vec3(-1.0));
	vec3 H = normalize(normalize(-f_pos) - lightDir); // view space
	vec3 specColor = vec3(0.2);
	vec3 diffColor = vec3(0.5, 0.8, 0.4);
	diffColor *= max(0.0, dot(N, -lightDir));
	specColor *= pow(max(0.0, dot(N, H)), 32.0);

    outColor = vec4(specColor + diffColor, 1.0);
	outColor.xyz = pow(outColor.xyz, vec3(0.4545));
}
