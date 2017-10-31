#include "Model.h"
#include "BufferUtils.h"
#include "Image.h"



char * ConvertWCtoC(const wchar_t* str)
{
	char* pStr;
	int strSize = WideCharToMultiByte(CP_ACP, 0, str, -1, NULL, 0, NULL, NULL);
	pStr = new char[strSize];
	WideCharToMultiByte(CP_ACP, 0, str, -1, pStr, strSize, 0, 0);
	return pStr;
}

Model::Model(Device* device, VkCommandPool commandPool, const std::vector<Vertex> &vertices, const std::vector<uint32_t> &indices)
  : device(device), vertices(vertices), indices(indices) {

    if (vertices.size() > 0) {
        BufferUtils::CreateBufferFromData(device, commandPool, this->vertices.data(), vertices.size() * sizeof(Vertex), VK_BUFFER_USAGE_VERTEX_BUFFER_BIT, vertexBuffer, vertexBufferMemory);
    }

    if (indices.size() > 0) {
        BufferUtils::CreateBufferFromData(device, commandPool, this->indices.data(), indices.size() * sizeof(uint32_t), VK_BUFFER_USAGE_INDEX_BUFFER_BIT, indexBuffer, indexBufferMemory);
    }

    modelBufferObject.modelMatrix = glm::mat4(1.0f);
    BufferUtils::CreateBufferFromData(device, commandPool, &modelBufferObject, sizeof(ModelBufferObject), VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT, modelBuffer, modelBufferMemory);
}

Model* Model::loadModel(Device* device, VkCommandPool commandPool, std::string path)
{
	std::vector<tinyobj::shape_t> shapes;
	std::vector<tinyobj::material_t> _materials;
	//tinyobj::attrib_t att;

	DWORD DW = 1024;
	WCHAR FilePath[MAX_PATH];

	GetModuleFileNameW(NULL, FilePath, DW);
	std::wstring source(FilePath);

	size_t lastposition;
	UINT i = 0;
	while (i < 3)
	{
		lastposition = source.rfind(L"\\", source.length());
		source = source.substr(0, lastposition);
		i++;
	}

	char * tempPath = ConvertWCtoC(source.c_str());
	char * newPath = new char[MAX_PATH];
	strcpy(newPath, tempPath);

	delete[] tempPath;

	strcat(newPath, path.c_str());

	std::string errors = tinyobj::LoadObj(shapes, _materials, newPath);
	std::cout << errors << std::endl;
	if (errors.size() == 0)
	{
		int min_idx = 0;
		//Read the information from the vector of shape_ts
		for (unsigned int i = 0; i < shapes.size(); i++)
		{
			std::vector<unsigned int> indices = shapes[i].mesh.indices;

			std::vector<glm::vec3> Vpositions;
			std::vector<glm::vec3> Vnormals;
			std::vector<glm::vec2> Vuvs;
			std::vector<Vertex> vertices;

			std::vector<float> &positions = shapes[i].mesh.positions;
			std::vector<float> &normals = shapes[i].mesh.normals;
			std::vector<float> &uvs = shapes[i].mesh.texcoords;			

			for (unsigned int j = 0; j < positions.size() / 3; j++)
			{
				Vpositions.push_back(glm::vec3(positions[j * 3], positions[j * 3 + 1], positions[j * 3 + 2]));
			}

			for (unsigned int j = 0; j < normals.size() / 3; j++)
			{
				Vnormals.push_back(glm::vec3(normals[j * 3], normals[j * 3 + 1], normals[j * 3 + 2]));
			}

			for (unsigned int j = 0; j < uvs.size() / 2; j++)
			{
				Vuvs.push_back(glm::vec2(uvs[j * 2], 1.0 - uvs[j * 2 + 1]));
			}


			for (unsigned int j = 0; j < positions.size() / 3; j++)
			{
				Vertex temp;
				temp.pos = Vpositions[j];
				temp.color = glm::vec3(1.0f);
				temp.texCoord = Vuvs[j];
				
				vertices.push_back(temp);
			}

			return new Model(device, commandPool, vertices, indices);
		}
	}

	return NULL;
}

Model::~Model() {
    if (indices.size() > 0) {
        vkDestroyBuffer(device->GetVkDevice(), indexBuffer, nullptr);
        vkFreeMemory(device->GetVkDevice(), indexBufferMemory, nullptr);
    }

    if (vertices.size() > 0) {
        vkDestroyBuffer(device->GetVkDevice(), vertexBuffer, nullptr);
        vkFreeMemory(device->GetVkDevice(), vertexBufferMemory, nullptr);
    }

    vkDestroyBuffer(device->GetVkDevice(), modelBuffer, nullptr);
    vkFreeMemory(device->GetVkDevice(), modelBufferMemory, nullptr);

    if (textureView != VK_NULL_HANDLE) {
        vkDestroyImageView(device->GetVkDevice(), textureView, nullptr);
    }

    if (textureSampler != VK_NULL_HANDLE) {
        vkDestroySampler(device->GetVkDevice(), textureSampler, nullptr);
    }
}

void Model::SetTexture(VkImage texture) {
    this->texture = texture;
    this->textureView = Image::CreateView(device, texture, VK_FORMAT_R8G8B8A8_UNORM, VK_IMAGE_ASPECT_COLOR_BIT);

    // --- Specify all filters and transformations ---
    VkSamplerCreateInfo samplerInfo = {};
    samplerInfo.sType = VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO;

    // Interpolation of texels that are magnified or minified
    samplerInfo.magFilter = VK_FILTER_LINEAR;
    samplerInfo.minFilter = VK_FILTER_LINEAR;

    // Addressing mode
	samplerInfo.addressModeU = VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_EDGE;// VK_SAMPLER_ADDRESS_MODE_REPEAT;
    samplerInfo.addressModeV = VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_EDGE;// VK_SAMPLER_ADDRESS_MODE_REPEAT;
    samplerInfo.addressModeW = VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_EDGE;// VK_SAMPLER_ADDRESS_MODE_REPEAT;

    // Anisotropic filtering
    samplerInfo.anisotropyEnable = VK_TRUE;
    samplerInfo.maxAnisotropy = 16;

    // Border color
    samplerInfo.borderColor = VK_BORDER_COLOR_INT_OPAQUE_BLACK;

    // Choose coordinate system for addressing texels --> [0, 1) here
    samplerInfo.unnormalizedCoordinates = VK_FALSE;

    // Comparison function used for filtering operations
    samplerInfo.compareEnable = VK_FALSE;
    samplerInfo.compareOp = VK_COMPARE_OP_ALWAYS;

    // Mipmapping
    samplerInfo.mipmapMode = VK_SAMPLER_MIPMAP_MODE_LINEAR;
    samplerInfo.mipLodBias = 0.0f;
    samplerInfo.minLod = 0.0f;
    samplerInfo.maxLod = 0.0f;

    if (vkCreateSampler(device->GetVkDevice(), &samplerInfo, nullptr, &textureSampler) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create texture sampler");
    }
}

const std::vector<Vertex>& Model::getVertices() const {
    return vertices;
}

VkBuffer Model::getVertexBuffer() const {
    return vertexBuffer;
}

const std::vector<uint32_t>& Model::getIndices() const {
    return indices;
}

VkBuffer Model::getIndexBuffer() const {
    return indexBuffer;
}

const ModelBufferObject& Model::getModelBufferObject() const {
    return modelBufferObject;
}

VkBuffer Model::GetModelBuffer() const {
    return modelBuffer;
}

VkImageView Model::GetTextureView() const {
    return textureView;
}

VkSampler Model::GetTextureSampler() const {
    return textureSampler;
}
