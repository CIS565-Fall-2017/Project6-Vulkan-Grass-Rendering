
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v0;
layout (location = 1) in vec4 v1;
layout (location = 2) in vec4 v2;
layout (location = 3) in vec4 up;

layout (location = 0) out vec4 tessellation_control_v1;
layout (location = 1) out vec4 tessellation_control_v2;
layout (location = 2) out vec4 tessellation_control_up;
layout (location = 3) out vec4 tessellation_control_forward;


out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs

	tessellation_control_v1 = model * vec4(v1.xyz, 1.0);
	tessellation_control_v1.w = v1.w; // keep original height

	tessellation_control_v2 = model * vec4(v2.xyz, 1.0);
	tessellation_control_v2.w = v2.w; // keep original width

	tessellation_control_up = vec4(normalize(up.xyz), 0.0);
	
	float direction = v0.w; // direction

	vec3 direction_vec = -normalize(vec3(sin(direction), 0.0, cos(direction)));

	//vec3 forward = normalize(cross(normalize(up.xyz), direction_vec));

	tessellation_control_forward = vec4(direction_vec, 0.0);

	// write gl_Position as usual
	gl_Position = model * vec4(v0.xyz, 1.0);

}
