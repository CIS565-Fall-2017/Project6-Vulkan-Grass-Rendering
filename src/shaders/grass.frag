#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 greenBase = vec3(0.1,1.0,0.1);
	vec3 lightPos = vec3(0.0,5.0,0.0);
	vec3 lightDir = normalize(pos-lightPos);
	vec3 ambient = vec3(0.025);
	float lambert = clamp(dot(nor,lightDir),0.025,1.0);

    outColor = vec4(clamp(ambient+lambert*greenBase,0.0,1.0),1.0);
}
