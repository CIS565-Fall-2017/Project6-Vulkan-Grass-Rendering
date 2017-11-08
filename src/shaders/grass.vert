
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

// Input from compute shader/CPU
layout (location = 0) in vec4 v0;
layout (location = 1) in vec4 v1;
layout (location = 2) in vec4 v2;
layout (location = 3) in vec4 up;

// Output from vert shader to tess. control shader
layout (location = 0) out vec4 v_v0;
layout (location = 1) out vec4 v_v1;
layout (location = 2) out vec4 v_v2;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs

	// Multiplying by model matrix brings from local/tangent space to world space

	//vec4 world_v0 = model * vec4(v0.xyz, 1.0);
	//v_v0 = vec4(world_v0.xyz, v0.w);
	//v_v1 = vec4((model * vec4(v1.xyz, 1.0)).xyz, v1.w);
	//v_v2 = vec4((model * vec4(v2.xyz, 1.0)).xyz, v2.w);

	// Send in v0 since that's the blade's position on the plane
	//gl_Position = world_v0;


	v_v0 = v0;
	v_v1 = v1;
	v_v2 = v2;
	gl_Position = vec4(v0.xyz, 1.0);
}
