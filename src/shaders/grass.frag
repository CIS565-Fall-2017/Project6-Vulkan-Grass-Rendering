#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 bladeNormal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	float lambertTerm = dot(normalize(vec3(-1,-1,0)), bladeNormal);
	if(lambertTerm<0){
		lambertTerm = 0.2;
	}
	if(lambertTerm>1){
		lambertTerm = 1;
	}
	vec3 baseColor = vec3(0.18, 0.48, 0.04);
	//vec3 baseColor = bladeNormal;
    outColor = vec4(baseColor*lambertTerm,1);
}
