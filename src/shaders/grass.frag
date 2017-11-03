#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 f_pos_screenSpace;
layout(location = 1) in vec4 f_pos_world;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 fragColor = vec3(0.0, 1.0, 0.0);
    outColor = vec4(fragColor, 0.0);
}
