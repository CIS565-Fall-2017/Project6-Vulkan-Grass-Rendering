
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// DONE: Declare vertex shader inputs and outputs

//coming out of getAttributeDescriptions
layout(location = 0) in vec4 v0_in;
layout(location = 1) in vec4 v1_in;
layout(location = 2) in vec4 v2_in;
layout(location = 3) in vec4 vUp_in;

//for tesc
layout(location = 0) out vec4 v0_out;
layout(location = 1) out vec4 v1_out;
layout(location = 2) out vec4 v2_out;
layout(location = 3) out vec4 vUp_out;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// DONE: Write gl_Position and any other shader outputs
	gl_Position = v0_in;
	//to .tesc
	v0_out = v0_in;
	v1_out = v1_in;
	v2_out = v2_in;
	vUp_out = vUp_in;
}
