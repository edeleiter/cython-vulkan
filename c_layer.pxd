#define GLFW_INCLUDE_VULKAN
from libc.stdint cimport uint32_t 

cdef extern from "./include/glfw3.h" nogil:

    # Functions
    int glfwInit()
    void glfwTerminate()
    GLFWwindow* glfwCreateWindow(int width, int height, const char* title, GLFWmonitor* monitor, GLFWwindow* share)
    void glfwMakeContextCurrent(GLFWwindow* window)
    int glfwWindowShouldClose(GLFWwindow* window)
    void glfwSwapBuffers(GLFWwindow* window)
    void glfwPollEvents()
    void glfwDestroyWindow(GLFWwindow* window)
    const char** glfwGetRequiredInstanceExtensions(uint32_t* count);
    VkResult glfwCreateWindowSurface(VkInstance instance, GLFWwindow* window, const VkAllocationCallbacks* allocator, VkSurfaceKHR* surface); 

    # Types
    ctypedef struct GLFWwindow
    ctypedef struct GLFWmonitor

    # Constants
    # Example constants (often defined as macros in C, but can be represented as static const int or similar in Cython for direct access if you want specific values, or simply mapped directly to Python integers as pyGLFW does)
    # The actual numerical values would be defined in glfw3.h
    int GLFW_TRUE
    int GLFW_FALSE
    int GLFW_KEY_ESCAPE

cdef extern from "./include/vulkan/vulkan.h" nogil:

     #Enums
    ctypedef enum VkResult:
        VK_SUCCESS = 0
        VK_NOT_READY = 1
        VK_TIMEOUT = 2
        VK_EVENT_SET = 3
        VK_EVENT_RESET = 4
        VK_INCOMPLETE = 5
        VK_ERROR_OUT_OF_HOST_MEMORY = -1
        VK_ERROR_OUT_OF_DEVICE_MEMORY = -2
        VK_ERROR_INITIALIZATION_FAILED = -3
        VK_ERROR_DEVICE_LOST = -4
        VK_ERROR_MEMORY_MAP_FAILED = -5
        VK_ERROR_LAYER_NOT_PRESENT = -6
        VK_ERROR_EXTENSION_NOT_PRESENT = -7
        VK_ERROR_FEATURE_NOT_PRESENT = -8
        VK_ERROR_INCOMPATIBLE_DRIVER = -9
        VK_ERROR_TOO_MANY_OBJECTS = -10
        VK_ERROR_FORMAT_NOT_SUPPORTED = -11
        VK_ERROR_FRAGMENTED_POOL = -12
        VK_ERROR_UNKNOWN = -13
        VK_ERROR_OUT_OF_POOL_MEMORY = -1000069000
        VK_ERROR_INVALID_EXTERNAL_HANDLE = -1000072003
        VK_ERROR_FRAGMENTATION = -1000161000
        VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS = -1000257000
        VK_PIPELINE_COMPILE_REQUIRED = 1000297000
        VK_ERROR_NOT_PERMITTED = -1000174001
        VK_ERROR_SURFACE_LOST_KHR = -1000000000
        VK_ERROR_NATIVE_WINDOW_IN_USE_KHR = -1000000001
        VK_SUBOPTIMAL_KHR = 1000001003
        VK_ERROR_OUT_OF_DATE_KHR = -1000001004
        VK_ERROR_INCOMPATIBLE_DISPLAY_KHR = -1000003001
        VK_ERROR_VALIDATION_FAILED_EXT = -1000011001
        VK_ERROR_INVALID_SHADER_NV = -1000012000
        VK_ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR = -1000023000
        VK_ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR = -1000023001
        VK_ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR = -1000023002
        VK_ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR = -1000023003
        VK_ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR = -1000023004
        VK_ERROR_VIDEO_STD_VERSION_NOT_SUPPORTED_KHR = -1000023005
        VK_ERROR_INVALID_DRM_FORMAT_MODIFIER_PLANE_LAYOUT_EXT = -1000158000
        VK_ERROR_FULL_SCREEN_EXCLUSIVE_MODE_LOST_EXT = -1000255000
        VK_THREAD_IDLE_KHR = 1000268000
        VK_THREAD_DONE_KHR = 1000268001
        VK_OPERATION_DEFERRED_KHR = 1000268002
        VK_OPERATION_NOT_DEFERRED_KHR = 1000268003
        VK_ERROR_INVALID_VIDEO_STD_PARAMETERS_KHR = -1000299000
        VK_ERROR_COMPRESSION_EXHAUSTED_EXT = -1000338000
        VK_INCOMPATIBLE_SHADER_BINARY_EXT = 1000482000
        VK_PIPELINE_BINARY_MISSING_KHR = 1000483000
        VK_ERROR_NOT_ENOUGH_SPACE_KHR = -1000483000
        VK_ERROR_OUT_OF_POOL_MEMORY_KHR = VK_ERROR_OUT_OF_POOL_MEMORY
        VK_ERROR_INVALID_EXTERNAL_HANDLE_KHR = VK_ERROR_INVALID_EXTERNAL_HANDLE
        VK_ERROR_FRAGMENTATION_EXT = VK_ERROR_FRAGMENTATION
        VK_ERROR_NOT_PERMITTED_EXT = VK_ERROR_NOT_PERMITTED
        VK_ERROR_NOT_PERMITTED_KHR = VK_ERROR_NOT_PERMITTED
        VK_ERROR_INVALID_DEVICE_ADDRESS_EXT = VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS
        VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS_KHR = VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS
        VK_PIPELINE_COMPILE_REQUIRED_EXT = VK_PIPELINE_COMPILE_REQUIRED
        VK_ERROR_PIPELINE_COMPILE_REQUIRED_EXT = VK_PIPELINE_COMPILE_REQUIRED
        # VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT is a deprecated alias
        VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT = VK_INCOMPATIBLE_SHADER_BINARY_EXT
        VK_RESULT_MAX_ENUM = 0x7FFFFFFF

    cdef enum VkStructureType:
        VK_STRUCTURE_TYPE_APPLICATION_INFO
        VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO

    # Types
    cdef cppclass VkInstance:
        VkInstance() except +
    
    cdef cppclass VkSurfaceKHR:
        VkSurfaceKHR() except +

    ctypedef struct VkApplicationInfo:        
        VkStructureType sType
        void* pNext
        char* pApplicationName
        uint32_t  applicationVersion
        char* pEngineName
        uint32_t  engineVersion
        uint32_t  apiVersion

    ctypedef struct VkInstanceCreateInfo:
        VkStructureType sType
        VkApplicationInfo* pApplicationInfo
        uint32_t enabledExtensionCount
        const char** ppEnabledExtensionNames
        uint32_t enabledLayerCount

    ctypedef struct VkAllocationCallbacks
    ctypedef struct VkPhysicalDevice
    ctypedef struct VkPhysicalDeviceProperties

    # Functions
    VkResult vkCreateInstance(VkInstanceCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkInstance* pInstance)
    VkResult vkEnumeratePhysicalDevices(VkInstance instance, int* pPhysicalDeviceCount, VkPhysicalDevice* pPhysicalDevices);
    void vkGetPhysicalDeviceProperties(VkPhysicalDevice physicalDevice, VkPhysicalDeviceProperties* pProperties);
    void VkDestroyInstance(VkInstance instance, VkAllocationCallbacks* pAllocator);
    
    # Macros
    int VK_MAKE_API_VERSION(int, int, int, int)
