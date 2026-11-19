# Task Update

<!-- md-trans-meta sourceCommit=f4a547131b444975d01ec9f73e0d3d131ea8553a translatedAt=2026-11-11T06:21:06.845Z pushedAt=2026-11-16T02:56:59.240Z nl=2 -->

After tasks on a stream have been captured and stored in models, two methods are currently supported for updating tasks (including the tasks themselves and their parameter information):

1. **Method 1**: Use the task to be updated as the boundary point. Capture the tasks before and after this task between the **aclmdlRICaptureBegin** and **aclmdlRICaptureEnd** APIs, store them in different models, and execute them separately.

    **This method is suitable for scenarios where a large number of tasks need to be updated** (for example, a model with two different input shapes). **The API call logic is relatively simple, but it increases the number of models that store the captured tasks. If the number of models exceeds the hardware resource limit, an error is reported.**

    **The basic usage process of this method is shown in the following figure.**

    ![](figures/ACL_Graph_task_update_1.png)

2. **Method 2**: Dispatch the tasks to be captured on the origin stream between the **aclmdlRICaptureBegin** and **aclmdlRICaptureEnd** APIs. Mark the tasks to be updated as being in a task group through the **aclmdlRICaptureTaskGrpBegin** and **aclmdlRICaptureTaskGrpEnd** APIs, which return the handle of the task group. Then update the tasks between the **aclmdlRICaptureTaskUpdateBegin** and **aclmdlRICaptureTaskUpdateEnd** APIs.

    **This method is suitable for scenarios where a small number of single-operator call tasks need to be updated. It supports updating tasks first and then executing the tasks in the model instance in sequence, and also supports concurrent execution of the task update and other tasks in the model instance. However, updating tasks is more time-consuming than dispatching tasks separately. In addition, the following usage restrictions apply**: The number and types of tasks between the **aclmdlRICaptureTaskGrpBegin** and **aclmdlRICaptureTaskGrpEnd** APIs must be consistent with those between the **aclmdlRICaptureTaskUpdateBegin** and **aclmdlRICaptureTaskUpdateEnd** APIs. In the scenario of capturing tasks across streams, tasks cannot be dispatched simultaneously on other streams in the capture state between the **aclmdlRICaptureTaskGrpBegin** and **aclmdlRICaptureTaskGrpEnd** APIs. A task group is similar to a critical resource and does not support concurrent updates by multiple threads and streams; otherwise, the update result may be unexpected.

    - **For the scenario of "updating tasks first and then executing the tasks in the aclmdlRI instance in sequence", the usage process is shown in the following figure.**

        ![](figures/ACL_Graph_task_update_2.png)

    - **For the scenario of "concurrent execution of the task update and other tasks", the process is as follows.**

        If a model running instance contains a large number of tasks, to improve performance, you can use a reusable synchronization event to implement concurrent execution of the update task and other tasks, and you need to create a separate stream for the update task (hereinafter referred to as **UpdateStream**). First, call the **aclrtCreateEventExWithFlag** API and set **flag** to **ACL\_EVENT\_SYNC** to create a reusable synchronization event. Then, dispatch the update task on **UpdateStream**, and call the **aclrtRecordEvent** API to dispatch an Event Record task. In the task capture phase of the origin stream, before the task to be updated, call the **aclrtStreamWaitEventWithFlag** API and set **flag** to **ACL\_EVENT\_WAIT\_EXTERNAL** to dispatch an Event Wait task, which waits for the task update on **UpdateStream** to complete. The event created by the **aclrtCreateEventExWithFlag** API is naturally reusable, so you do not need to call the **aclrtResetEvent** API.

        ![](figures/ACL_Graph_task_update_3.png)

        Taking the scenario of concurrent task execution as an example, the following is a key code example for updating the input parameters of the aclnnAdd operator.

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
            // Calculate the stride of contiguous tensors.
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
            void *outtmp_d = nullptr;
            aclTensor *self = nullptr;
            aclTensor *other = nullptr;
            aclScalar *alpha = nullptr;
            aclScalar *updatealpha = nullptr;
            aclTensor *out = nullptr;
            aclTensor *outtmp = nullptr;
            /* aclnnAdd: outtmp = self  +  other * alpha */
            float *self_h = nullptr;
            float *other_h = nullptr;
            std::vector<int64_t> shape = {4, 2};
            float *out_h = nullptr;
            float alphaValue = 1.1f;
            float updatealphaValue = 5.5f;
            uint64_t workspaceSize = 0;
            uint64_t workspaceSize1 = 0;
            uint64_t workspaceSize2 = 0;
            aclOpExecutor *executor2;
            aclOpExecutor *executor;
            aclOpExecutor *executor1;
            auto size = GetShapeSize(shape);

            // Perform initialization.
            aclInit(NULL);
            // Specify a compute device.
            aclrtSetDevice(devID);

            // Prepare the input and output parameters of the aclnnAdd operator.
            CreateAclTensor(shape, &self_d, aclDataType::ACL_FLOAT, &self);
            CreateAclTensor(shape, &other_d, aclDataType::ACL_FLOAT, &other);
            alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
            updatealpha = aclCreateScalar(&updatealphaValue, aclDataType::ACL_FLOAT);
            CreateAclTensor(shape, &out_d, aclDataType::ACL_FLOAT, &out);
            CreateAclTensor(shape, &outtmp_d, aclDataType::ACL_FLOAT, &outtmp);

            // Call the first-stage API of the aclnnAdd operator to obtain the workspace size required for operator computation and the executor that contains the operator computation process.
            // Since the aclnnAdd operator is called multiple times later, call the first-stage API multiple times here to obtain different aclOpExecutors.
            // outtmp = self + alpha * other
            // Before update: out = outtmp + alpha * other  After update: out = outtmp + updatealpha * other
            aclnnAddGetWorkspaceSize(self, other, alpha, outtmp, &workspaceSize, &executor);
            void *workspaceAddr = nullptr;
            if (workspaceSize > 0) {
                aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST);
            }
            // Before update: out = outtmp + alpha * other
            aclnnAddGetWorkspaceSize(outtmp, other, alpha, out, &workspaceSize1, &executor1);
            void *workspaceAddr1 = nullptr;
            if (workspaceSize1 > 0) {
                aclrtMalloc(&workspaceAddr1, workspaceSize1, ACL_MEM_MALLOC_HUGE_FIRST);
            }
            // After update: out = outtmp + updatealpha * other
            aclnnAddGetWorkspaceSize(outtmp, other, updatealpha, out, &workspaceSize2, &executor2);
            void *workspaceAddr2 = nullptr;
            if (workspaceSize2 > 0) {
                aclrtMalloc(&workspaceAddr2, workspaceSize2, ACL_MEM_MALLOC_HUGE_FIRST);
            }

            // Use aclrtMallocHost to request page-locked memory.
            aclrtMallocHost((void **)&self_h, size * sizeof(float));
            aclrtMallocHost((void **)&other_h, size * sizeof(float));
            aclrtMallocHost((void **)&out_h, size * sizeof(float));
            for (int i = 0; i < 8; i++) {
                self_h[i] = static_cast<float>(0);
                other_h[i] = static_cast<float>(1);
                out_h[i] = static_cast<float>(0);
            }

            aclmdlRI modelRI;
            aclrtStream stream1;
            aclrtCreateStream(&stream1);
            aclrtEvent event;

            // Create a reusable synchronization event.
            aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);

            // ========Start capturing tasks========
            aclmdlRICaptureBegin(stream1, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
            // Asynchronously copy the self input data of the aclnnAdd operator from the host side to the device side.
            aclrtMemcpyAsync(self_d, size * sizeof(float), self_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE, stream1);
            // Asynchronously copy the other input data of the aclnnAdd operator from the host side to the device side.
            aclrtMemcpyAsync(other_d, size * sizeof(float), other_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE, stream1);
            // Execute the aclnnAdd operator.
            aclnnAdd(workspaceAddr, workspaceSize, executor, stream1);
            // On the origin stream stream1, dispatch an Event Wait task to wait for the task update to complete.
            aclrtStreamWaitEventWithFlag(stream1, event, 0U, ACL_EVENT_WAIT_EXTERNAL);
            aclrtTaskGrp handle;
            // Mark the task to be updated.
            aclmdlRICaptureTaskGrpBegin(stream1);
            aclnnAdd(workspaceAddr1, workspaceSize1, executor1, stream1);
            aclmdlRICaptureTaskGrpEnd(stream1, &handle);
            // Asynchronously copy the operator output data from the device side back to the host side.
            aclrtMemcpyAsync(out_h, size * sizeof(float), out_d, size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST, stream1);
            // ========End capturing tasks========
            aclmdlRICaptureEnd(stream1, &modelRI);

            aclrtStream updateStream;
            aclrtCreateStream(&updateStream);

            for (int i = 0; i < 2; i++) {
                ACL_LOG("execute model, loop: %d", i);
                aclmdlRIExecuteAsync(modelRI, stream1);
                // Start updating the task, and update the alpha parameter of the aclnnAdd operator to updatealpha.
                aclmdlRICaptureTaskUpdateBegin(updateStream, handle);
                if (i == 1) {
                    aclnnAdd(workspaceAddr2, workspaceSize2, executor2, updateStream);
                    ACL_LOG("update alpha value of aclnnAdd");
                }
                aclmdlRICaptureTaskUpdateEnd(updateStream);
                // After the task is updated, dispatch an Event Record task on updateStream to notify the origin stream stream1 to continue executing the tasks after Event Wait.
                aclrtRecordEvent(event, updateStream);
                aclrtSynchronizeStream(updateStream);
                aclrtSynchronizeStream(stream1);
                ACL_LOG("%f %f %f %f %f %f %f %f\n",
                    out_h[0],
                    out_h[1],
                    out_h[2],
                    out_h[3],
                    out_h[4],
                    out_h[5],
                    out_h[6],
                    out_h[7]);
            }

            // Release resources.
            aclmdlRIDestroy(modelRI);
            aclDestroyTensor(self);
            aclDestroyTensor(other);
            aclDestroyTensor(out);
            aclDestroyTensor(outtmp);
            aclDestroyScalar(alpha);
            aclDestroyScalar(updatealpha);
            aclrtFree(self_d);
            aclrtFree(other_d);
            aclrtFree(out_d);
            aclrtFree(outtmp_d);
            aclrtDestroyStream(stream1);
            aclrtDestroyStream(updateStream);
            aclrtDestroyEvent(event);
            if (workspaceAddr != nullptr) {
                aclrtFree(workspaceAddr);
            }
            if (workspaceAddr1 != nullptr) {
                aclrtFree(workspaceAddr1);
            }
            if (workspaceAddr2 != nullptr) {
                aclrtFree(workspaceAddr2);
            }
            // Release the resources of the compute device.
            aclrtResetDevice(devID);
            // Perform deinitialization.
            aclFinalize();
        }

        ```
