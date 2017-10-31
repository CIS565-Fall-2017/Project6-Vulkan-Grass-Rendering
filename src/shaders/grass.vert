
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
layout(location = 3) out vec4 tesc_widthDir;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	vec4 V0 = model * vec4(v0.xyz, 1.0);
	tesc_v1 = vec4((model * vec4(v1.xyz, 1.0)).xyz, v1.w);
	tesc_v2 = vec4((model * vec4(v2.xyz, 1.0)).xyz, v2.w);

	//tesc_up.xyz = normalize(tesc_v1.xyz - tesc_v2.xyz);
	
	tesc_up.xyz = normalize(up.xyz);

	//v0.w holds orientation, v1.w holds height, v2.w holds width, and up.w holds the stiffness coefficient.

	float theta = v0.w;
	float sinTheta = sin(theta);
	float cosTheta = cos(theta);

	vec3 faceDir = normalize(cross(tesc_up.xyz, vec3(sinTheta, 0, cosTheta)));

	tesc_widthDir.xyz = normalize( cross(faceDir, tesc_up.xyz));

	//For debug
	tesc_widthDir.w = v1.w * 0.4;//1.0 - dot(tesc_up.xyz, tesc_v2.xyz - V0.xyz);

	gl_Position = V0;
}
