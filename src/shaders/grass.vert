
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0_i;
layout(location = 1) in vec4 v1_i;
layout(location = 2) in vec4 v2_i;
//layout(location = 3) in vec4 up_i;

layout(location = 0) out vec4 v0_o;
layout(location = 1) out vec4 v1_o;
layout(location = 2) out vec4 v2_o;
//layout(location = 3) out vec4 up_o;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	v0_o = v0_i;
	v1_o = v1_i;
	v2_o = v2_i;
	//up_o = up_i;
	gl_Position = vec4(v0_i.xyz, 1.0);
}
