#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec4 f_normal;
layout(location = 1) in vec3 f_pos_world;

layout(location = 0) out vec4 outColor;

void main() 
{	
	vec3 fragColor = vec3(0.0, 1.0, 0.0);
    
	vec3 darkGreen = vec3(0.0352, 0.4392, 0.0);
    vec3 lightGreen = vec3(0.1647, 0.5882, 0.0);
    vec3 color = mix(darkGreen, lightGreen, clamp(f_normal.w, 0.0, 1.0));

	vec3 lightPos = vec3(0.0, 10.0, 0.0);
	vec3 lightDir = lightPos - f_pos_world.xyz;
	float lambert = clamp(dot(f_normal.xyz, normalize(lightDir)), 0.0, 1.0);
    float ambient = 0.2f;

    fragColor = color*ambient + color;
	//fragColor = color*ambient + color*lambert;
	outColor = vec4(fragColor, 1.0);
}
