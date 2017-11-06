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
	if (fs_color.w > 0.0) {
		// use custom color in fs_color
		outColor = vec4(fs_color.xyz, 1.0);
	}
	else {
		// use green + lambert shading
		const vec3 lightDir = vec3(0.577350269, -0.577350269, -0.577350269);
		float lambert = max(dot(fs_normal, lightDir), dot(-fs_normal, lightDir));
		lambert = clamp(lambert, 0.25, 1.0);
		vec3 color = vec3(0.1, 0.9, 0.2) * lambert;
		outColor = vec4(color, 1.0);
	}
}
