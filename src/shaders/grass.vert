
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 tesc_v1;
layout(location = 1) out vec4 tesc_v2;
layout(location = 2) out vec4 tesc_up;
layout(location = 3) out vec4 tesc_width_dir;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	vec4 world_v0 = model * v0;
	vec4 world_v1 = model * vec4(v1.xyz,1.0);
	world_v1 /= world_v1.w;
	vec4 world_v2 = model * vec4(v2.xyz,1.0);
	world_v2 /= world_v2.w;
	//v0.w is orientation, v1.w is height, v2.w is width, up.w is stiffness

	tesc_v1 = vec4(world_v1.xyz, v1.w);
	tesc_v2 = vec4(world_v2.xyz, v2.w);
	tesc_up.xyz = normalize(up.xyz);

	float sin_theta = sin(v0.w), cos_theta = cos(v0.w);
	tesc_width_dir.xyz = normalize(vec3(sin_theta, 0, cos_theta)); 
	tesc_width_dir.w = up.w;
	
	gl_Position = world_v0;
}
