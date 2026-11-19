# Single-Stream Capture

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:20:08.424Z pushedAt=2026-11-16T02:42:16.591Z nl=2 -->

In the eager mode adopted by current mainstream frameworks (for example, PyTorch), each operation or task is dispatched and executed immediately without building a computation graph. This mode provides immediate execution results and convenient debugging, but it also introduces host dispatch overhead. As performance optimization progresses, this host overhead gradually becomes a bottleneck and an issue that cannot be ignored.

On AI processors, related tasks can be offloaded to devices for execution, thereby reducing host overhead. To achieve this, **acl APIs are provided to capture tasks on a stream into a model and then execute the model**. As shown in the following figure, between the **aclmdlRICaptureBegin** and **aclmdlRICaptureEnd** APIs, all tasks dispatched on the specified stream are not executed immediately. Instead, they are temporarily stored in the model running instance and are actually executed only when the **aclmdlRIExecuteAsync** API is called to execute the model. When tasks on a stream need to be executed multiple times, there is no need to dispatch the tasks again. You only need to call the **aclmdlRIExecuteAsync** API multiple times to execute the model, thereby reducing the task dispatch overhead on the host side. After the tasks are executed, if the model running instance is no longer needed, call the **aclmdlRIDestroy** API to destroy the resource in a timely manner.

The basic process of capturing tasks into a model and then executing them in the model is shown in the following figure.

![](figures/ACL_Graph_single_stream.png)

In the scenario of capturing tasks into a model and then executing them in the model, the following basic restrictions apply:

1. Before entering the capture state, tasks on the stream are still executed immediately.
2. When tasks are captured on a stream, the tasks are only offloaded to the device and are not executed immediately. Therefore, querying or synchronizing a stream or event is an illegal operation. Similarly, querying or synchronizing the device or context is also illegal because the device and context contain synchronization information of the stream. During capture, synchronizing or querying the stream, event, device, or context is illegal in any capture mode.
3. During capture, in the **ACL\_MODEL\_RI\_CAPTURE\_MODE\_GLOBAL** mode (globally prohibited, where no thread is allowed to call non-safe functions), calling memory synchronization operation functions (for example, **aclrtMemset**, **aclrtMemcpy**, and **aclrtMemcpy2d**) is illegal and causes a verification error, resulting in capture failure. If the service side determines that the execution of these functions does not affect task capture, it can call the **aclmdlRICaptureThreadExchangeMode** API to switch the capture mode of the current thread to **ACL\_MODEL\_RI\_CAPTURE\_MODE\_RELAXED** to remove the call restriction.

4. During capture, dispatching configuration tasks, such as profiling configuration, dump configuration, and overflow detection configuration, may return an error or may not take effect on the capture model.
5. If the captured asynchronous memory copy task involves host memory, only host page-locked memory can be requested by using an acl API (for example, **aclrtMallocHost**). Otherwise, an error is returned during capture.
6. In addition, operations on the default stream are illegal during capture.
7. Finally, note that after tasks are captured, you must ensure the validity of the resources used by the tasks in the model. The related resources can be destroyed only after the model is destroyed.

The following is the sample code for capturing the add operator computation in a single stream.

```c
#include <stdio.h>
#include <vector>
#include "acl/acl.h"
#include "aclnnop/aclnn_add.h"

#define ACL_LOG(fmt, args...) fprintf(stdout, "[INFO]  " fmt "\n", ##args)

int64_t GetShapeSize(const std::vector<int64_t> &shape)
{
    int64_t shape_size = 1;
    for (auto i : shape) {
        shape_size *= i;
    }
    return shape_size;
}

int CreateAclTensor(const std::vector<int64_t> &shape, void **deviceAddr,
    aclDataType dataType, aclTensor **tensor)
{
    auto size = GetShapeSize(shape) * sizeof(float);
    // Request device memory.
    auto ret = aclrtMalloc(deviceAddr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    // Calculate the stride of consecutive tensors.
    std::vector<int64_t> strides(shape.size(), 1);
    for (int64_t i = shape.size() - 2; i >= 0; i--) {
        strides[i] = shape[i + 1] * strides[i + 1];
    }
    // Call aclCreateTensor to create an aclTensor.
    *tensor = aclCreateTensor(shape.data(),
        shape.size(),
        dataType,
        strides.data(),
        0,
        aclFormat::ACL_FORMAT_ND,
        shape.data(),
        shape.size(),
        *deviceAddr);
    return 0;
}

int main()
{
    int devID = 0;
    void *self_d = nullptr;
    void *other_d = nullptr;
    void *out_d = nullptr;
    aclTensor *self = nullptr;
    aclTensor *other = nullptr;
    aclScalar *alpha = nullptr;
    aclTensor *out = nullptr;
    /* aclnnAdd: out = self  +  other * alpha */
    float *self_h = nullptr;
    float *other_h = nullptr;
    std::vector<int64_t> shape = {4, 2};
    float alphaValue = 1.1f;
    uint64_t workspaceSize = 0;
    aclOpExecutor *executor;
    auto size = GetShapeSize(shape);

    // Perform initialization.
    aclInit(NULL);
    // Specify a compute device.
    aclrtSetDevice(devID);

    // Prepare the input and output parameters of the aclnnAdd operator.
    CreateAclTensor(shape, &self_d, aclDataType::ACL_FLOAT, &self);
    CreateAclTensor(shape, &other_d, aclDataType::ACL_FLOAT, &other);
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    CreateAclTensor(shape, &out_d, aclDataType::ACL_FLOAT, &out);

    // Obtain the workspace size required for operator computation and the executor that contains the operator computation process.
    aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor);
    void *workspaceAddr = nullptr;
    if (workspaceSize > 0) {
        aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST);
    }

    // Use aclrtMallocHost to request page-locked memory.
    aclrtMallocHost((void **)&self_h, size * sizeof(float));
    aclrtMallocHost((void **)&other_h, size * sizeof(float));
    for (int i = 0; i < 8; i++) {
        self_h[i] = static_cast<float>(0);
        other_h[i] = static_cast<float>(1);
    }

    aclmdlRI modelRI;
    aclrtStream stream;
    aclrtCreateStream(&stream);

    // ========Start capturing tasks========
    aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
    // Asynchronously copy the self input data of the operator from the host side to the device side.
    aclrtMemcpyAsync(self_d, size * sizeof(float), self_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE, stream);
    // Switch the capture mode to RELAXED to allow calling the aclrtMemcpy function.
    aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_RELAXED;
    aclmdlRICaptureThreadExchangeMode(&mode);
    // Synchronously copy the other input data of the operator from the host side to the device side. This is executed only once.
    aclrtMemcpy(other_d, size * sizeof(float), other_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE);
    // Switch the capture mode back to GLOBAL.
    aclmdlRICaptureThreadExchangeMode(&mode);
    // Execute the aclnnAdd operator.
    aclnnAdd(workspaceAddr, workspaceSize, executor, stream);
    // Asynchronously copy the operator output data from the device side back to the host side.
    aclrtMemcpyAsync(self_h, size * sizeof(float), out_d, size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST, stream);
    // ========End capturing tasks========
    aclmdlRICaptureEnd(stream, &modelRI);

    // Print model information, which is used in maintenance and testing scenarios.
    const char *jsonPath = "./modelRI.json";
    aclmdlRIDebugJsonPrint(modelRI, jsonPath, 0);

    // Execute the model multiple times.
    for (int i = 0; i < 8; i++) {
        aclmdlRIExecuteAsync(modelRI, stream);
        aclrtSynchronizeStream(stream);
    // Print the operator output data of each execution.
        ACL_LOG("%f %f %f %f %f %f %f %f\n",
            self_h[0],
            self_h[1],
            self_h[2],
            self_h[3],
            self_h[4],
            self_h[5],
            self_h[6],
            self_h[7]);
    }

    // Release resources.
    aclmdlRIDestroy(modelRI);
    aclrtDestroyStream(stream);
    aclDestroyTensor(self);
    aclDestroyTensor(other);
    aclDestroyTensor(out);
    aclDestroyScalar(alpha);
    aclrtFree(self_d);
    aclrtFree(other_d);
    aclrtFree(out_d);
    if (workspaceAddr != nullptr) {
        aclrtFree(workspaceAddr);
    }
    // Release resources on the compute device.
    aclrtResetDevice(devID);
    // Perform deinitialization.
    aclFinalize();
}
```
