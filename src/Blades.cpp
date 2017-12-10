#include <vector>
#include "Blades.h"
#include <math.h>
#include "BufferUtils.h"

float generateRandomFloat() {
    return rand() / (float)RAND_MAX;
}

bool bladesComparator(Blade i, Blade j) { return (i.v0.x + i.v0.z < j.v0.x + j.v0.z); }

Blades::Blades(Device* device, VkCommandPool commandPool, float planeDim, std::vector<Vertex>& verts, std::vector<uint32_t>& indices) : Model(device, commandPool, {}, {}) {
    std::vector<Blade> blades;
    blades.reserve(NUM_BLADES);
	int index = 0;

	int dim = (int)sqrt(NUM_BLADES);

    for (int i = 0; i < dim; i++) {
		for (int j = 0; j < dim; j++) {
			Blade currentBlade = Blade();

#if SPHERE

			float u = generateRandomFloat() * 2 - 1;
			float theta = generateRandomFloat() * 2 * M_PI;
			float x = sqrt(1 - u*u) * cos(theta);
			float y = sqrt(1 - u*u) * sin(theta) + 4;
			float z = u;
			glm::vec3 bladeUp = glm::normalize(glm::vec3(x, y, z) - glm::vec3(0, 4, 0));
#else
			float x = (i / sqrt(NUM_BLADES) - 0.5f) * planeDim;
			float z = (j / sqrt(NUM_BLADES) - 0.5f) * planeDim;
			float y = cos(z * 0.1) * 4 + cos((x + z)*0.1+M_PI) * 4;
			glm::vec3 bladeUp = glm::vec3(0, 1, 0);
#endif
			float direction = generateRandomFloat() * 2.f * M_PI;
			glm::vec3 bladePosition(x, y, z);
			currentBlade.v0 = glm::vec4(bladePosition, direction);

			// Bezier point and height (v1)
			float height = MIN_HEIGHT + (generateRandomFloat() * (MAX_HEIGHT - MIN_HEIGHT));
			currentBlade.v1 = glm::vec4(bladePosition + bladeUp * height, height);

			// Physical model guide and width (v2)
			float width = MIN_WIDTH + (generateRandomFloat() * (MAX_WIDTH - MIN_WIDTH));
			currentBlade.v2 = glm::vec4(bladePosition + bladeUp * height, width);

			// Up vector and stiffness coefficient (up)
			float stiffness = MIN_BEND + (generateRandomFloat() * (MAX_BEND - MIN_BEND));
			currentBlade.up = glm::vec4(bladeUp, stiffness);

			blades.push_back(currentBlade);
		}
    }

	//std::sort(blades.begin(), blades.end(), bladesComparator);

    BladeDrawIndirect indirectDraw;
    indirectDraw.vertexCount = NUM_BLADES;
    indirectDraw.instanceCount = 1;
    indirectDraw.firstVertex = 0;
    indirectDraw.firstInstance = 0;

    BufferUtils::CreateBufferFromData(device, commandPool, blades.data(), NUM_BLADES * sizeof(Blade), VK_BUFFER_USAGE_STORAGE_BUFFER_BIT, bladesBuffer, bladesBufferMemory);
    BufferUtils::CreateBuffer(device, NUM_BLADES * sizeof(Blade), VK_BUFFER_USAGE_STORAGE_BUFFER_BIT, VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT, culledBladesBuffer, culledBladesBufferMemory);
    BufferUtils::CreateBufferFromData(device, commandPool, &indirectDraw, sizeof(BladeDrawIndirect), VK_BUFFER_USAGE_STORAGE_BUFFER_BIT | VK_BUFFER_USAGE_INDIRECT_BUFFER_BIT, numBladesBuffer, numBladesBufferMemory);

	for (int i = 0; i < dim; i++) {
		for (int j = 0; j < dim; j++) {
			int index = i * dim + j;
			Vertex v = Vertex();
			v.pos = { blades[index].v0.x,blades[index].v0.y,blades[index].v0.z };
			v.color = { 0,0,0 };
			v.texCoord = { j*5/(float)dim, i*5/(float)dim };
			verts.push_back(v);

			if (i != 0 && j != 0) {
				indices.push_back(index - dim - 1);
				indices.push_back(index - dim);
				indices.push_back(index);
				indices.push_back(index);
				indices.push_back(index - 1);
				indices.push_back(index - dim - 1);
			}
		}
	}	
}

VkBuffer Blades::GetBladesBuffer() const {
    return bladesBuffer;
}

VkBuffer Blades::GetCulledBladesBuffer() const {
    return culledBladesBuffer;
}

VkBuffer Blades::GetNumBladesBuffer() const {
    return numBladesBuffer;
}

Blades::~Blades() {
    vkDestroyBuffer(device->GetVkDevice(), bladesBuffer, nullptr);
    vkFreeMemory(device->GetVkDevice(), bladesBufferMemory, nullptr);
    vkDestroyBuffer(device->GetVkDevice(), culledBladesBuffer, nullptr);
    vkFreeMemory(device->GetVkDevice(), culledBladesBufferMemory, nullptr);
    vkDestroyBuffer(device->GetVkDevice(), numBladesBuffer, nullptr);
    vkFreeMemory(device->GetVkDevice(), numBladesBufferMemory, nullptr);
}
