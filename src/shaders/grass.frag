#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 f_pos_screenSpace;
layout(location = 1) in vec4 f_pos_world;

layout(location = 0) out vec4 outColor;

void main() 
{	
	vec3 fragColor = vec3(0.0, 1.0, 0.0);
    
	vec3 darkGreen = vec3(0.1647, 0.5882, 0.0);
    vec3 lightGreen = vec3(0.8078, 1.0, 0.3686);
    //vec3 color = mix(darkGreen, lightGreen, clamp(normal.w, 0.0, 1.0));

	vec3 lightPos = vec3(0.0, 10.0, 0.0);
	vec3 lightDir = lightPos - f_pos_world.xyz;
	//float lambert = clamp(dot(normal.xyz, normalize(lightDir)), 0.0, 1.0);
    float ambient = 0.2f;

    fragColor = vec3(ambient) + darkGreen;	
	outColor = vec4(fragColor, 1.0);
}
