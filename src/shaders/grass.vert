
#version 450
#extension GL_ARB_separate_shader_objects : enable
#define PI_OVER_TWO 1.57079632679

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

layout(location = 0) in vec4 vs_v0;
layout(location = 1) in vec4 vs_v1;
layout(location = 2) in vec4 vs_v2;
layout(location = 3) in vec4 vs_up;
layout(location = 4) in vec4 vs_color;

layout(location = 0) out vec4 tesc_v1;
layout(location = 1) out vec4 tesc_v2;
layout(location = 2) out vec4 tesc_up;
layout(location = 3) out vec4 tesc_bitangent;
layout(location = 4) out vec4 tesc_color;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	// compute v0 in world space
	vec4 worldV0 = model * vec4(vs_v0.xyz, 1.0);
	gl_Position = worldV0;

	// compute v1 in world space
	vec4 worldV1 = model * vec4(vs_v1.xyz, 1.0);
	tesc_v1 = worldV1;

	// compute v2 in world space
	vec4 worldV2 = model * vec4(vs_v2.xyz, 1.0);
	tesc_v2 = worldV2;

	// compute up in world space
	vec4 worldUp = normalize(model * vec4(vs_up.xyz, 0.0));
	tesc_up = worldUp;

	// pass color along
	tesc_color = vs_color;

	// add pi / 2 to get direction along width	
	float orientation = vs_v0.w - PI_OVER_TWO;
	vec4 worldBitangent = normalize(model * vec4(cos(orientation), 0.0, sin(orientation), 0.0));
	//tesc_orientationAndWidth = vec4(worldOrientation.xyz, vs_v2.w);
	tesc_bitangent = vec4(worldBitangent.xyz, vs_v2.w); // store width in W
}
