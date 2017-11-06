#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) patch in vec4 tcV1;
layout(location = 1) patch in vec4 tcV2;
layout(location = 2) patch in vec3 tcBladeUp;
layout(location = 3) patch in vec3 tcBladeDir;

layout(location = 0) out vec4 tePosition;
layout(location = 1) out vec3 teNormal;
layout(location = 2) out vec3 teWindDir;
layout(location = 3) out vec2 teUV;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = tcV1.xyz;
	vec3 v2 = tcV2.xyz;
	vec3 t1 = tcBladeDir; // bitangent 
	float width = tcV2.w;
	
	vec3 a = v0 + v * (v1 - v0);
	vec3 b = v1 + v * (v2 - v1);
	vec3 c = a + v * (b - a);
	vec3 c0 = c - width * t1;
	vec3 c1 = c + width * t1;
	
	vec3 t0; // tangent
	if(dot(b - a, b - a) < 1e-3)
		t0 = tcBladeUp;
	else
		t0 = normalize(b - a);

	teNormal = normalize(cross(t0, t1));
	teUV = vec2(u,v);

	float t = u;

	//quad
	//t = u;

	//triangle
	t = u + 0.5f * v - u * v;

	//quadratic
	//t = u - u * v * v;

	//triangle-tip
	//float threshold = 0.5f; //----------------------
	//t = 0.5f + (u - 0.5f) * (1 - max(v - threshold, 0.0f) / (1 - threshold));

	vec3 position = mix(c0, c1, t);

	gl_Position = camera.proj * camera.view * vec4(position, 1.0f);
	tePosition = vec4(position, 1.0f);
	
}
