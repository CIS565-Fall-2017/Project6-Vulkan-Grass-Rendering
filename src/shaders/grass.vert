
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
layout(location = 3) out vec4 tesc_windDir;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	vec4 V0 = model * vec4(v0.xyz, 1.0);
	tesc_v1 = vec4((model * vec4(v1.xyz, 1.0)).xyz, v1.w);
	tesc_v2 = vec4((model * vec4(v2.xyz, 1.0)).xyz, v2.w);
	tesc_up.xyz = normalize(up.xyz);
	
	vec3 orientation = vec3(sin(v0.w), 0, cos(v0.w));
	vec3 faceDir = normalize(cross(tesc_up.xyz, orientation));
	tesc_windDir.xyz = normalize(cross(faceDir, tesc_up.xyz));
	tesc_windDir.w = v1.w * 0.4;
	gl_Position = V0;
}
