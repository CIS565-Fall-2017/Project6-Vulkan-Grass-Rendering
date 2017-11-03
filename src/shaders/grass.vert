
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0_in;
layout(location = 1) in vec4 v1_in;
layout(location = 2) in vec4 v2_in;
layout(location = 3) in vec4 v3_in;

layout(location = 0) out vec4 v0_tesc;
layout(location = 1) out vec4 v1_tesc;
layout(location = 2) out vec4 v2_tesc;
layout(location = 3) out vec4 v3_tesc;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	v0_tesc = v0_in;
	v1_tesc = v1_in;
	v2_tesc = v2_in;
	v3_tesc = v3_in;

	gl_Position = vec4(v0_in.x, v0_in.y, v0_in.z, 1.0);
}
