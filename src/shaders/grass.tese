#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) patch in vec4 inV0;
layout(location = 1) patch in vec4 inV1;
layout(location = 2) patch in vec4 inV2;
layout(location = 3) patch in vec4 inUP;

layout(location = 0) out vec4 outPosition;
layout(location = 1) out vec4 outNormal;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	
	// Get the center position using bi-linear kind of interpolation
	vec3 interpPosA = mix(inV0.xyz, inV1.xyz, v);
	vec3 interpPosB = mix(inV1.xyz, inV2.xyz, v);
	vec3 interpCenter = mix(interpPosA, interpPosB, v);

	// Compute the tangent and bi-tangent and compute the output normal
	float W = inV2.w;
	float theta = inV0.w;
	vec3 bitangent = normalize(cross(inUP.xyz, vec3(sin(theta), 0.0, cos(theta))));
	vec3 c0 = interpCenter - W * bitangent;
	vec3 c1 = interpCenter + W * bitangent;

	vec3 tangent = normalize(interpPosB - interpPosA);
	outNormal = vec4(normalize(cross(bitangent, tangent)), v);

	float t = u - u * v * v;
	vec3 outPos = mix(c0, c1 , t);
	outPosition = vec4(outPos, u);

	// Send the projected position
	gl_Position = camera.proj * camera.view * vec4(outPos.xyz, 1.0);

}
