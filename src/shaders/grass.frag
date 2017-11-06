#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec2 fs_uv;
layout(location = 1) in vec3 fs_normal;
layout(location = 2) in vec4 fs_color;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	// TODO: lambert
	const vec3 lightDir = vec3(0.577350269, -0.577350269, -0.577350269);
	float lambert = clamp(dot(fs_normal, lightDir), 0.5, 1.0);
	vec3 color = vec3(0.1, 0.9, 0.2) * lambert;
    outColor = fs_color;//vec4(color, 1.0);
}
