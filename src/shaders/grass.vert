
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

layout (location = 0) in vec4 v0in;
layout (location = 1) in vec4 v1in;
layout (location = 2) in vec4 v2in;
layout (location = 3) in vec4 v3in;

layout (location = 0) out vec4 v0;
layout (location = 1) out vec4 v1;
layout (location = 2) out vec4 v2;
layout (location = 3) out vec4 v3;


// TODO: Declare vertex shader inputs and outputs

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	gl_Position = model * vec4(v0in);
	v0 = v0in;
	v1 = v1in;
	v2 = v2in;
	v3 = v3in;
}
