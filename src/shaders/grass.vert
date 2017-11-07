
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

layout(location = 0) out vec4 control_v1;
layout(location = 1) out vec4 control_v2;
layout(location = 2) out vec4 control_up;
layout(location = 3) out vec4 control_width;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	vec4 V0 = model * vec4(v0.xyz, 1.0);
	control_v1 = vec4((model * vec4(v1.xyz, 1.0)).xyz, v1.w);
	control_v2 = vec4((model * vec4(v2.xyz, 1.0)).xyz, v2.w);

	
	control_up.xyz = normalize(up.xyz);

	//v0.w holds orientation, v1.w holds height, v2.w holds width, and up.w holds the stiffness coefficient.

	float theta = v0.w;
	float sinTheta = sin(theta);
	float cosTheta = cos(theta);

	vec3 faceDir = normalize(cross(control_up.xyz, vec3(sinTheta, 0, cosTheta)));

	control_width.xyz = normalize( cross(faceDir, control_up.xyz));

	//For debug
	control_width.w = v1.w * 0.4;//1.0 - dot(control_up.xyz, control_v2.xyz - V0.xyz);

	gl_Position = V0;
}
