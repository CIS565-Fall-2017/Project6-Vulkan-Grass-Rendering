#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs - normal?
layout(location = 0) in vec3 normal;

layout(location = 0) out vec4 outColor;


void main() {
    // TODO: Compute fragment color
	float diffuse = 0.33 + clamp(dot(normal, vec3(0, -1, 0)),0,0.67); //lambert at noon
	vec4 green = vec4(0.5, 0.7, 0.1, 1.0);
	outColor = diffuse * green;
}
