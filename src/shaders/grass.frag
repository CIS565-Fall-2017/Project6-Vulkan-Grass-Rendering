#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout (location = 0) in vec4 [] norm;
layout (location = 1) in vec4 [] world;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec4 color =  vec4(0.16, 0.64, 0.16, 0.0);
	vec4 light = vec4(0.0, 15.0, 0.0, 1.0);

	vec4 L = normalize(light - world[0]);
	outColor = color * clamp( dot(norm[0].xyz, L.xyz), 0.0, 1.0) + color * 0.2;
}
