#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation evaluation shader inputs and outputs

layout (location = 0) in vec4[] v1Array;
layout (location = 1) in vec4[] v2Array;

layout (location = 0) out vec3 fs_nor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec4 v0 = gl_in[0].gl_Position;
    vec4 v1 = v1Array[0];
    vec4 v2 = v2Array[0];

    float width = v2.w;

    // Do deCasteljau's algorithm to get the point on the Bezier curve and then use the tesselation weights
    // Formulas are actually taken directly from the paper itself
    vec3 a = v0.xyz + v * (v1.xyz - v0.xyz);
    vec3 b = v1.xyz + v * (v2.xyz - v1.xyz);
    vec3 c = a + v * (b - a);

    // Account for the rotation of this blade of grass
    vec3 bit = normalize(vec3(cos(v1.w), 0, sin(v1.w))); // in the xz-plane

    vec3 tan = b - a;
    vec3 normal = normalize(cross(tan, bit));

    fs_nor = normal;
    
    u *= 1.0 - v;
    u = 2.0 * u - 1.0;
    vec3 offset = u * width * bit;

    gl_Position = camera.proj * camera.view * (vec4(c.x, c.yz, 1.0) + vec4(offset, 0.0));
}
