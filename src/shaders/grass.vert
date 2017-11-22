
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

layout(location = 0) out vec4 tcV1;
layout(location = 1) out vec4 tcV2;
layout(location = 2) out vec3 tcBladeUp;
layout(location = 3) out vec3 tcBladeDir;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	
	gl_Position = model * vec4(v0.xyz, 1.0);
	
	float orientation = v0.w;
	//float height = v1.w;
	//float width = v2.w;
	//float stiffness = up.w;

	tcV1 = model * vec4(v1.xyz, 1.0);
	tcV1.w = v1.w;
	tcV2 = model * vec4(v2.xyz, 1.0);
	tcV2.w = v2.w;
	tcBladeUp = normalize(up.xyz);

	//============ Calculate the direction of the blade ============
    float sd = sin(orientation);
    float cd = cos(orientation);
    vec3 tmp = normalize(vec3(sd, sd + cd, cd)); //arbitrary vector for finding normal vector
    tcBladeDir = normalize(cross(tcBladeUp, tmp));

}
