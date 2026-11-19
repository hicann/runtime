# Cross-Stream Capture

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:20:43.335Z pushedAt=2026-11-16T02:46:31.134Z nl=2 -->

When tasks are captured on streams, the streams specified in the **aclmdlRICaptureBegin** and **aclmdlRICaptureEnd** APIs can only be the same stream, which is called the origin stream. To capture tasks across streams, you can call the **aclrtRecordEvent** API to dispatch an Event Record task on the origin stream and call the **aclrtStreamWaitEvent** API on a substream to dispatch an Event Wait task, thereby establishing an association between the origin stream and the substream and capturing the tasks on both streams into the same model. In this case, the event also enters the capture state. If other streams are waiting for this event, those streams also enter the capture state. As shown in the following figure, Stream2 and Stream3 are substreams. Stream2 waits for task1 on the origin stream to complete, and Stream3 waits for task2 on Stream2 to complete. In this case, Stream2 directly depends on the origin stream, while Stream3 indirectly depends on the origin stream. Therefore, both Stream2 and Stream3 are included in the capture state, and task2 on Stream2 and task3 on Stream3 are also captured into the model.

A substream that enters the capture state through an event must eventually return to the origin stream directly or indirectly through an event. Otherwise, an error is reported when the capture ends. As shown in the following figure, you can call the **aclrtRecordEvent** API to dispatch Event Record tasks on Stream2 and Stream3 and call the **aclrtStreamWaitEvent** API on the origin stream to dispatch Event Wait tasks, so that Stream2 and Stream3 return to the origin stream. In addition, for a stream such as Stream3 that indirectly depends on the origin stream, you can also dispatch an Event Record task on Stream3 and an Event Wait task on Stream2 to first return Stream3 to Stream2, and then dispatch an Event Record task on Stream2 and an Event Wait task on the origin stream to finally return to the origin stream. After the substreams are returned to the origin stream and before the capture ends, you must not dispatch tasks (for example, task5 in the following figure) on Stream2 or Stream3. Otherwise, an error is reported when the capture ends because an unassociated task is detected.

The cross-stream task capture process is shown in the following figure.

![](figures/ACL_Graph_multi_stream.png)

The following example uses two streams to demonstrate cross-stream capture, where stream1 is the origin stream and stream2 is the substream.

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
    // Call the aclCreateTensor API to create an aclTensor.
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
    aclrtStream stream1, stream2;
    aclrtEvent event1, event2;
    aclrtCreateStream(&stream1);
    aclrtCreateStream(&stream2);
    // In the capture scenario, create an event with the ACL_EVENT_SYNC flag through the aclrtCreateEventExWithFlag API.
    aclrtCreateEventExWithFlag(&event1, ACL_EVENT_SYNC);
    aclrtCreateEventExWithFlag(&event2, ACL_EVENT_SYNC);

    // ========Start capturing tasks========
    aclmdlRICaptureBegin(stream1, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
    // Asynchronously copy the data of the self input of the operator from the host side to the device side.
    aclrtMemcpyAsync(self_d, size * sizeof(float), self_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE, stream1);
    // Switch the capture mode to RELAXED to allow calling the aclrtMemcpy function.
    aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_RELAXED;
    aclmdlRICaptureThreadExchangeMode(&mode);
    // Synchronously copy the data of the other input of the operator from the host side to the device side. This is executed only once.
    aclrtMemcpy(other_d, size * sizeof(float), other_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE);
    // Switch the capture mode back to GLOBAL.
    aclmdlRICaptureThreadExchangeMode(&mode);
    // Add stream2 to the capture state through event1.
    aclrtRecordEvent(event1, stream1);
    aclrtStreamWaitEvent(stream2, event1);
    // Execute the aclnnAdd operator.
    aclnnAdd(workspaceAddr, workspaceSize, executor, stream2);
    // After the tasks on stream2 are complete, return stream2 to the origin stream1 through event2.
    aclrtRecordEvent(event2, stream2);
    aclrtStreamWaitEvent(stream1, event2);
    // Asynchronously copy the operator output data from the device side back to the host side.
    aclrtMemcpyAsync(self_h, size * sizeof(float), out_d, size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST, stream1);
    // ========End capturing tasks========
    aclmdlRICaptureEnd(stream1, &modelRI);

    // Execute the model multiple times.
    for (int i = 0; i < 8; i++) {
        aclmdlRIExecuteAsync(modelRI, stream1);
        aclrtSynchronizeStream(stream1);
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
    aclrtDestroyStream(stream1);
    aclrtDestroyStream(stream2);
    aclrtDestroyEvent(event1);
    aclrtDestroyEvent(event2);
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
    // Release the resources of the compute device.
    aclrtResetDevice(devID);
    // Perform deinitialization.
    aclFinalize();
}
```
