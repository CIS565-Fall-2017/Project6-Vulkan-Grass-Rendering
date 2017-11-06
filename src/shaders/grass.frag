#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec4 tePosition;
layout(location = 1) in vec3 teNormal;
layout(location = 2) in vec3 teWindDir;
layout(location = 3) in vec2 teUV;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

	vec3 color_green = vec3(0.1f, 0.9f, 0.1f);

	//lambert
	vec3 lightPos = vec3(-5.0f, 10.0f, -5.0f);
	vec3 lightDir = normalize(tePosition.xyz - lightPos);
	float lambert = clamp(dot(teNormal, lightDir), 0.1, 1.0);

    outColor = vec4(0.1) + vec4(lambert * color_green ,1.0);
	
	//outColor = vec4(1.0);

}
