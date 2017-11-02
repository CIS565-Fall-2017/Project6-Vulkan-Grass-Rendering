
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 color;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(location = 0) out vec3 fragColor;


void main() {
	// TODO: Write gl_Position and any other shader outputs
	gl_Position = model * vec4(position, 1.0);
    fragColor = color;
}
