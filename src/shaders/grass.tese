#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_out[];
layout(location = 1) in vec4 v1_out[];
layout(location = 2) in vec4 v2_out[];
layout(location = 3) in vec4 up_out[];

layout(location = 0) out vec4 position;
layout(location = 1) out vec4 normal;
layout(location = 2) out float colorScale;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions 
	// for each vertex of the grass blade
	// Get vector information from the blade of grass.
	vec3 v0 = v0_out[0].xyz;
	vec3 v1 = v1_out[0].xyz;
	vec3 v2 = v2_out[0].xyz;
	vec3 up = up_out[0].xyz;
	
	// Get further grass attributes.
	float angle  = v0_out[0].w;
	float height = v1_out[0].w;
	float width  = v2_out[0].w;
	float stiff  = up_out[0].w;

	// De Castelajau's Algorithm.
	vec3 a = v0 + v * (v1 - v0);
	vec3 b = v1 + v * (v2 - v1);
	vec3 c = a + v * (b - a);
	float angleX = cos(angle);
	float angleY = sin(angle);
	vec3 t1 = vec3(angleX, 0, angleY);
	vec3 c0 = c - (width * t1);
	vec3 c1 = c + (width * t1);

	// Process positions for a given shape.
	// 0 - quad, 1 - triangle, 2 - quadratic, 3 - triangle-tip.
	uint SHAPE = 1;
	float t = 0;
	if (SHAPE == 0) {
		t = u;
	} else if (SHAPE == 1) {
		t = u + (0.5 * v) - (u * v);
	} else if (SHAPE == 2) {
		t = u - (u * v * v);
	} else if (SHAPE == 3) {
		float TAU = 0.5;
		t = 0.5 + (u - 0.5) * (1 - (max(v - TAU, 0) / (1 - TAU)));
	}

	vec3 p = (1 - t) * c0 + (t * c1);

	// Output the normal.
	vec3 t0 = normalize(b - a);
	vec4 n = vec4(normalize(cross(t0.xyz, t1.xyz)), 1);
	normal = n;

	// Output the color scale to make the tips of the grass darker.
	colorScale = v;

	// Output the position.
	mat4 viewSpace = camera.proj * camera.view;
	position = viewSpace * vec4(p.x, p.y, p.z, 1);
	gl_Position = position;
}
