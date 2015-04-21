#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cstring>
#include <iostream>
#include "CL/opencl.h"
#include "AOCL_Utils.h"

//OpenCV
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include "opencv2/imgproc/imgproc.hpp"

//ʱ�����
#include "time.h"
#include <sys/time.h>

using namespace std;
using namespace aocl_utils;
using namespace cv;

string in_img_name = "test.jpg";
unsigned int in_img_rows = NULL;
unsigned int in_img_cols = NULL;
unsigned int in_img_channels = NULL;
Mat in_img;


cl_uint num_platforms;
cl_platform_id platform;
cl_uint num_devices;
cl_device_id device;
cl_context context;
cl_command_queue queue;
cl_program program;
cl_kernel kernel;
cl_mem cl_img_in, cl_img_out;

string imageFilename;
string aocxFilename;
string deviceInfo;

struct timeval tstart,tend;//��������ʱ�����
unsigned int timeuse;

void teardown(int exit_status = 1);

void teardown(int exit_status)
{
    if (cl_img_in) clReleaseMemObject(cl_img_in);
    if (cl_img_out) clReleaseMemObject(cl_img_out);
    if (kernel) clReleaseKernel(kernel);
    if (program) clReleaseProgram(program);
    if (queue) clReleaseCommandQueue(queue);
    if (context) clReleaseContext(context);

    exit(exit_status);
}

// Free the resources allocated during initialization
void cleanup() {
  if(kernel) {
    clReleaseKernel(kernel);
  }
  if(program) {
    clReleaseProgram(program);
  }
  if(queue) {
    clReleaseCommandQueue(queue);
  }
  if(context) {
    clReleaseContext(context);
  }
}

//read image and get arguements
void img_init(string &str, Mat &img_buf, unsigned int &img_rows, unsigned int &img_cols, unsigned int &img_channels)
{
	img_buf = imread(str);
	img_rows = img_buf.rows;
	img_cols = img_buf.cols;
	img_channels = img_buf.channels();
}

void initCL(const unsigned int pixels_num)
{
    cl_int status;

    if (!setCwdToExeDir()) {
        teardown();
    }

    platform = findPlatform("Altera");
    if (platform == NULL) {
        teardown();
    }

    status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, 1, &device, NULL);
    checkError (status, "Error: could not query devices");
    num_devices = 1; // always only using one device

    char info[256];
    clGetDeviceInfo(device, CL_DEVICE_NAME, sizeof(info), info, NULL);
    deviceInfo = info;

    context = clCreateContext(0, num_devices, &device, NULL, NULL, &status);
    checkError(status, "Error: could not create OpenCL context");

    queue = clCreateCommandQueue(context, device, 0, &status);
    checkError(status, "Error: could not create command queue");

    std::string binary_file = getBoardBinaryFile("Gray_Processing", device);
    std::cout << "Using AOCX: " << binary_file << "\n";
    program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);

    status = clBuildProgram(program, num_devices, &device, "", NULL, NULL);
    checkError(status, "Error: could not build program");

    kernel = clCreateKernel(program, "graying", &status);
    checkError(status, "Error: could not create Gray_Processing kernel");

    cl_img_in = clCreateBuffer(context, CL_MEM_READ_ONLY, pixels_num, NULL, &status);
    checkError(status, "Error: could not create device buffer");

    cl_img_out = clCreateBuffer(context, CL_MEM_WRITE_ONLY, pixels_num, NULL, &status);
    checkError(status, "Error: could not create output buffer");

    status  = clSetKernelArg(kernel, 0, sizeof(cl_mem), &cl_img_in);
    status |= clSetKernelArg(kernel, 1, sizeof(cl_mem), &cl_img_out);
    status |= clSetKernelArg(kernel, 2, sizeof(unsigned int), &pixels_num);
    checkError(status, "Error: could not set sobel args");
}

void Graying(const unsigned int pixels_num, unsigned int rows, unsigned int cols)
{
    size_t GrayingSize = 1;
    cl_int status;

    Mat img = imread("test.jpg");

    uchar* pixel_in = img.data;
    status = clEnqueueWriteBuffer(queue, cl_img_in, CL_FALSE, 0, pixels_num, pixel_in, 0, NULL, NULL);
    checkError(status, "Error: could not copy data into device");

    status = clFinish(queue);
    checkError(status, "Error: could not finish successfully");

    status = clSetKernelArg(kernel, 2, sizeof(unsigned int), &pixels_num);
    checkError(status, "Error: could not set sobel threshold");

    cl_event event;
    status = clEnqueueNDRangeKernel(queue, kernel, 1, NULL, &GrayingSize, &GrayingSize, 0, NULL, &event);
    checkError(status, "Error: could not enqueue sobel filter");

    status  = clFinish(queue);
    checkError(status, "Error: could not finish successfully");
/*
    cl_ulong start, end;
    status  = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, sizeof(cl_ulong), &start, NULL);
    status |= clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, sizeof(cl_ulong), &end, NULL);
    checkError(status, "Error: could not get profile information");
    clReleaseEvent(event);
*/
    Mat out_img(rows, cols, CV_8UC3);//must define the arguements when define the Mat
	uchar* pixel_out = out_img.data;
    status = clEnqueueReadBuffer(queue, cl_img_out, CL_FALSE, 0, pixels_num, pixel_out, 0, NULL, NULL);
    checkError(status, "Error: could not copy data from device");

    status = clFinish(queue);
    checkError(status, "Error: could not successfully finish copy");

    imwrite("test_out.jpg", out_img);
}

int main(int argc, char **argv)
{
	img_init(in_img_name, in_img, in_img_rows, in_img_cols, in_img_channels);

	const unsigned int IN_IMG_SIZE =  in_img_rows * in_img_cols * in_img_channels;

	gettimeofday(&tstart, NULL);//��������ʱ�俪ʼ

    initCL(IN_IMG_SIZE);

    Graying(IN_IMG_SIZE, in_img_rows, in_img_cols);

    gettimeofday(&tend, NULL);//��������
    timeuse = (unsigned int) (1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec)); //����Ϊ΢��

    cout << "OpenCL Used Time = " << timeuse << "uS" << endl;

    gettimeofday(&tstart, NULL);//��������ʱ�俪ʼ
	//opencv comparison
	cvtColor(in_img, in_img, CV_BGR2GRAY);
	gettimeofday(&tend, NULL);//��������
	timeuse = (unsigned int) (1000000*(tend.tv_sec-tstart.tv_sec)+(tend.tv_usec-tstart.tv_usec)); //����Ϊ΢��
	cout << "OpenCV Used Time = " << timeuse << "uS" << endl;

    teardown(0);
}



/*

#define STRING_BUFFER_LEN 1024

// Runtime constants
// Used to define the work set over which this kernel will execute.
static const size_t work_group_size = 8;  // 8 threads in the demo workgroup
// Defines kernel argument value, which is the workitem ID that will
// execute a printf call
static const int thread_id_to_output = 2;

// OpenCL runtime configuration
static cl_platform_id platform = NULL;
static cl_device_id device = NULL;
static cl_context context = NULL;
static cl_command_queue queue = NULL;
static cl_kernel kernel = NULL;
static cl_program program = NULL;

// Function prototypes
bool init();
void cleanup();
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );

// Entry point.
int main() {
  cl_int status;

  if(!init()) {
    return -1;
  }

  // Set the kernel argument (argument 0)
  status = clSetKernelArg(kernel, 0, sizeof(cl_int), (void*)&thread_id_to_output);
  checkError(status, "Failed to set kernel arg 0");

  printf("\nKernel initialization is complete.\n");
  printf("Launching the kernel...\n\n");

  // Configure work set over which the kernel will execute
  size_t wgSize[3] = {work_group_size, 1, 1};
  size_t gSize[3] = {work_group_size, 1, 1};

  // Launch the kernel
  status = clEnqueueNDRangeKernel(queue, kernel, 1, NULL, gSize, wgSize, 0, NULL, NULL);
  checkError(status, "Failed to launch kernel");

  // Wait for command queue to complete pending events
  status = clFinish(queue);
  checkError(status, "Failed to finish");

  printf("\nKernel execution is complete.\n");

  // Free the resources allocated
  cleanup();

  return 0;
}

/////// HELPER FUNCTIONS ///////

bool init() {
  cl_int status;

  if(!setCwdToExeDir()) {
    return false;
  }

  // Get the OpenCL platform.
  platform = findPlatform("Altera");
  if(platform == NULL) {
    printf("ERROR: Unable to find Altera OpenCL platform.\n");
    return false;
  }

  // User-visible output - Platform information
  {
    char char_buffer[STRING_BUFFER_LEN]; 
    printf("Querying platform for info:\n");
    printf("==========================\n");
    clGetPlatformInfo(platform, CL_PLATFORM_NAME, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n", "CL_PLATFORM_NAME", char_buffer);
    clGetPlatformInfo(platform, CL_PLATFORM_VENDOR, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n", "CL_PLATFORM_VENDOR ", char_buffer);
    clGetPlatformInfo(platform, CL_PLATFORM_VERSION, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n\n", "CL_PLATFORM_VERSION ", char_buffer);
  }

  // Query the available OpenCL devices.
  scoped_array<cl_device_id> devices;
  cl_uint num_devices;

  devices.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));

  // We'll just use the first device.
  device = devices[0];

  // Display some device information.
  display_device_info(device);

  // Create the context.
  context = clCreateContext(NULL, 1, &device, NULL, NULL, &status);
  checkError(status, "Failed to create context");

  // Create the command queue.
  queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue");

  // Create the program.
  std::string binary_file = getBoardBinaryFile("hello_world", device);
  printf("Using AOCX: %s\n", binary_file.c_str());
  program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);

  // Build the program that was just created.
  status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
  checkError(status, "Failed to build program");

  // Create the kernel - name passed in here must match kernel name in the
  // original CL file, that was compiled into an AOCX file using the AOC tool
  const char *kernel_name = "hello_world";  // Kernel name, as defined in the CL file
  kernel = clCreateKernel(program, kernel_name, &status);
  checkError(status, "Failed to create kernel");

  return true;
}

// Free the resources allocated during initialization
void cleanup() {
  if(kernel) {
    clReleaseKernel(kernel);  
  }
  if(program) {
    clReleaseProgram(program);
  }
  if(queue) {
    clReleaseCommandQueue(queue);
  }
  if(context) {
    clReleaseContext(context);
  }
}

// Helper functions to display parameters returned by OpenCL queries
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name) {
   cl_ulong a;
   clGetDeviceInfo(device, param, sizeof(cl_ulong), &a, NULL);
   printf("%-40s = %lu\n", name, a);
}
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name) {
   cl_uint a;
   clGetDeviceInfo(device, param, sizeof(cl_uint), &a, NULL);
   printf("%-40s = %u\n", name, a);
}
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name) {
   cl_bool a;
   clGetDeviceInfo(device, param, sizeof(cl_bool), &a, NULL);
   printf("%-40s = %s\n", name, (a?"true":"false"));
}
static void device_info_string( cl_device_id device, cl_device_info param, const char* name) {
   char a[STRING_BUFFER_LEN]; 
   clGetDeviceInfo(device, param, STRING_BUFFER_LEN, &a, NULL);
   printf("%-40s = %s\n", name, a);
}

// Query and display OpenCL information on device and runtime environment
static void display_device_info( cl_device_id device ) {

   printf("Querying device for info:\n");
   printf("========================\n");
   device_info_string(device, CL_DEVICE_NAME, "CL_DEVICE_NAME");
   device_info_string(device, CL_DEVICE_VENDOR, "CL_DEVICE_VENDOR");
   device_info_uint(device, CL_DEVICE_VENDOR_ID, "CL_DEVICE_VENDOR_ID");
   device_info_string(device, CL_DEVICE_VERSION, "CL_DEVICE_VERSION");
   device_info_string(device, CL_DRIVER_VERSION, "CL_DRIVER_VERSION");
   device_info_uint(device, CL_DEVICE_ADDRESS_BITS, "CL_DEVICE_ADDRESS_BITS");
   device_info_bool(device, CL_DEVICE_AVAILABLE, "CL_DEVICE_AVAILABLE");
   device_info_bool(device, CL_DEVICE_ENDIAN_LITTLE, "CL_DEVICE_ENDIAN_LITTLE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, "CL_DEVICE_GLOBAL_MEM_CACHE_SIZE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE, "CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_SIZE, "CL_DEVICE_GLOBAL_MEM_SIZE");
   device_info_bool(device, CL_DEVICE_IMAGE_SUPPORT, "CL_DEVICE_IMAGE_SUPPORT");
   device_info_ulong(device, CL_DEVICE_LOCAL_MEM_SIZE, "CL_DEVICE_LOCAL_MEM_SIZE");
   device_info_ulong(device, CL_DEVICE_MAX_CLOCK_FREQUENCY, "CL_DEVICE_MAX_CLOCK_FREQUENCY");
   device_info_ulong(device, CL_DEVICE_MAX_COMPUTE_UNITS, "CL_DEVICE_MAX_COMPUTE_UNITS");
   device_info_ulong(device, CL_DEVICE_MAX_CONSTANT_ARGS, "CL_DEVICE_MAX_CONSTANT_ARGS");
   device_info_ulong(device, CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE, "CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE");
   device_info_uint(device, CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS, "CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS");
   device_info_uint(device, CL_DEVICE_MEM_BASE_ADDR_ALIGN, "CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS");
   device_info_uint(device, CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE, "CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE");

   {
      cl_command_queue_properties ccp;
      clGetDeviceInfo(device, CL_DEVICE_QUEUE_PROPERTIES, sizeof(cl_command_queue_properties), &ccp, NULL);
      printf("%-40s = %s\n", "Command queue out of order? ", ((ccp & CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE)?"true":"false"));
      printf("%-40s = %s\n", "Command queue profiling enabled? ", ((ccp & CL_QUEUE_PROFILING_ENABLE)?"true":"false"));
   }
}
*/
