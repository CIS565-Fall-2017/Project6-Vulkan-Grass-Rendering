#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec2 uv; 

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    vec4 darkGreen = vec4(0.0, 0.361, 0.035, 1.0);
    vec4 lightGreen = vec4(0.0039, 0.651, 0.0667, 1.0);
    vec4 color = mix(darkGreen, lightGreen, uv.y);

    vec4 ambient = vec4(0.1, 0.1, 0.1, 1.0);
    vec3 lightDir = normalize(vec3(0.4, 3.0, -0.1));
    float lambert = clamp(dot(normal, lightDir), 0.0, 1.0);

    outColor = ambient + color * lambert;
}
