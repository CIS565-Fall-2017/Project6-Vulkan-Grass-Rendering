
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

// TODO: Declare vertex shader inputs and outputs

out gl_PerVertex {
    vec4 gl_Position;
};

layout (location = 0) out vec2 dimensions;
layout (location = 1) out vec3 v2Pos;
layout (location = 2) out vec3 orientation;

void main() {
	// TODO: Write gl_Position and any other shader outputs
	gl_Position = vec4(vec3(v0), 1.0);
	dimensions.x = v2.w;
	dimensions.y = v1.w;
	v2Pos = vec3(v2);

	orientation = vec3(sin(v0.w), 0.0, cos(v0.w));
}
