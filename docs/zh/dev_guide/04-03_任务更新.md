# 任务更新

**须知：**本功能为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。
当Stream上的任务已经被捕获，并暂存到模型中之后，若要更新任务（包含任务本身以及任务的参数信息），当前支持两种方式：

1.  **方式一**：以需要更新的任务为分界点，在aclmdlRICaptureBegin和aclmdlRICaptureEnd接口之间分别捕获该任务前后的任务、并暂存到不同的模型中，分开执行。

    **该方式适用于大量任务需要更新的场景**（例如一个模型有两种不同Shape的input输入场景）**，接口调用逻辑比较简单，但导致暂存捕获任务的模型数量增多，若模型数量超出硬件资源限制，则会触发报错。**

    **该方式的基本使用流程如下图所示：**

    ![](figures/ACL_Graph任务更新流程1.png)

2.  **方式二**：在aclmdlRICaptureBegin、aclmdlRICaptureEnd接口之间下发主流上需捕获的任务，通过aclmdlRICaptureTaskGrpBegin、aclmdlRICaptureTaskGrpEnd接口将待更新的任务标记为在一个任务组中，并返回任务组的handle，在aclmdlRICaptureTaskUpdateBegin、aclmdlRICaptureTaskUpdateEnd接口之间更新任务。

    **该方式适用于少量单算子调用任务需要更新的场景，支持先更新任务再依次执行模型实例中的任务，也支持更新任务与模型实例中其他任务的并发执行。但更新任务比单独下发任务更耗时，另外，还存在一些使用限制**：aclmdlRICaptureTaskGrpBegin、aclmdlRICaptureTaskGrpEnd接口之间的任务数量、任务类型，要与aclmdlRICaptureTaskUpdateBegin、aclmdlRICaptureTaskUpdateEnd接口之间的任务数量、任务类型一致；跨Stream捕获任务的场景下，在aclmdlRICaptureTaskGrpBegin、aclmdlRICaptureTaskGrpEnd接口之间，其它捕获状态的Stream上不允许同时下发任务；任务组类似一个临界资源，不支持多线程多Stream并发更新，否则会导致更新结果非预期。

    -   **对于“先更新任务，再依次执行aclmdlRI实例中的任务”的场景，使用流程如下图所示：**

        ![](figures/ACL_Graph任务更新流程2.png)

    -   **对于“更新任务与其他任务的并发执行”的场景，使用流程如下图所示：**

        若模型的运行实例中存在大量任务，为了提升性能，可使用external类型的Event实现更新任务与其他任务的并发执行，并且需再单独创建一个用于更新任务的Stream（下文称之为UpdateStream）。这里的external类型的Event，是指调用aclrtCreateEventWithFlag接口并设置flag为ACL\_EVENT\_EXTERNAL的Event，该类型的Event规格有限，且无法实现跨Stream的任务捕获，需要考虑合理复用。创建external类型的Event之后，在UpdateStream上下发更新任务，接着调用aclrtRecordEvent接口下发一个Event Record任务。然后，在主流中，在待更新的任务之前，调用aclrtStreamWaitEvent接口下发一个Event Wait任务，用于等待UpdateStream中的任务更新完成。最后，在主流中，调用aclrtStreamWaitEvent接口之后，再调用aclrtResetEvent接口重置external类型的Event。

        ![](figures/ACL_Graph任务更新流程3.png)

        以任务并发执行的场景为例，以下是更新aclnnAdd算子输入参数的关键代码示例。

        ```
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
            // 申请Device侧内存
            auto ret = aclrtMalloc(deviceAddr, size, ACL_MEM_MALLOC_HUGE_FIRST);
            // 计算连续tensor的stride
            std::vector<int64_t> strides(shape.size(), 1);
            for (int64_t i = shape.size() - 2; i >= 0; i--) {
                strides[i] = shape[i + 1] * strides[i + 1];
            }
            // 调用aclCreateTensor接口创建aclTensor
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
            /* aclnnAdd: self = self  +  other * alpha */
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
        
            // 初始化
            aclInit(NULL);
            // 指定计算设备
            aclrtSetDevice(devID);
        
            // 准备aclnnAdd算子的输入、输出参数
            CreateAclTensor(shape, &self_d, aclDataType::ACL_FLOAT, &self);
            CreateAclTensor(shape, &other_d, aclDataType::ACL_FLOAT, &other);
            alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
            updatealpha = aclCreateScalar(&updatealphaValue, aclDataType::ACL_FLOAT);
            CreateAclTensor(shape, &out_d, aclDataType::ACL_FLOAT, &out);
            CreateAclTensor(shape, &outtmp_d, aclDataType::ACL_FLOAT, &outtmp);
        
            // 调用aclnnAdd算子的第一段接口，获取算子计算所需的workspace大小以及包含了算子计算流程的执行器
            // 后续涉及多次调用aclnnAdd算子，此处需调用多次第一段接口，获取不同的aclOpExecutor	
            // outtmp = self + alpha * other
            // 更新前：out = outtmp + alpha * other  更新后：out = outtmp + updatealpha * other
            aclnnAddGetWorkspaceSize(self, other, alpha, outtmp, &workspaceSize, &executor);
        	void *workspaceAddr = nullptr;
            if (workspaceSize > 0) {
                aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST);
            }
            // 更新前：out = outtmp + alpha * other
            aclnnAddGetWorkspaceSize(outtmp, other, alpha, out, &workspaceSize1, &executor1);
        	void *workspaceAddr1 = nullptr;
            if (workspaceSize1 > 0) {
                aclrtMalloc(&workspaceAddr1, workspaceSize1, ACL_MEM_MALLOC_HUGE_FIRST);
            }
            // 更新后：out = outtmp + updatealpha * other	
            aclnnAddGetWorkspaceSize(outtmp, other, updatealpha, out, &workspaceSize2, &executor2);
        	void *workspaceAddr2 = nullptr;
            if (workspaceSize2 > 0) {
                aclrtMalloc(&workspaceAddr2, workspaceSize2, ACL_MEM_MALLOC_HUGE_FIRST);
            }
        	
            // 使用aclrtMallocHost申请锁页内存
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
        
            // 创建external类型的event
            aclrtCreateEventWithFlag(&event, ACL_EVENT_EXTERNAL);
        
            // ========开始捕获任务========
            aclmdlRICaptureBegin(stream1, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
            // 异步拷贝，将aclnnAdd算子self输入的数据从Host侧传到Device侧
            aclrtMemcpyAsync(self_d, size * sizeof(float), self_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE, stream1);
            // 异步拷贝，将aclnnAdd算子other输入的数据从Host侧传到Device侧
            aclrtMemcpyAsync(other_d, size * sizeof(float), other_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE, stream1);
            // 执行aclnnAdd算子
            aclnnAdd(workspaceAddr, workspaceSize, executor, stream1);
            // 在主流stream1上，下发一个Event Wait任务，等待更新任务完成
            aclrtStreamWaitEvent(stream1, event);
            aclrtResetEvent(event, stream1);
            aclrtTaskGrp handle;
            // 标记要更新的任务
            aclmdlRICaptureTaskGrpBegin(stream1);
            aclnnAdd(workspaceAddr1, workspaceSize1, executor1, stream1);
            aclmdlRICaptureTaskGrpEnd(stream1, &handle);
            // 异步拷贝，将算子输出数据从Device侧传回Host侧
            aclrtMemcpyAsync(out_h, size * sizeof(float), out_d, size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST, stream1);
            // ========结束捕获任务========
            aclmdlRICaptureEnd(stream1, &modelRI);
        
            aclrtStream updateStream;
            aclrtCreateStream(&updateStream);
        
            for (int i = 0; i < 2; i++) {
                ACL_LOG("execute model, loop: %d", i);
                aclmdlRIExecuteAsync(modelRI, stream1);
                // 开始更新任务，将aclnnAdd算子的alpha参数更新为updatealpha
                aclmdlRICaptureTaskUpdateBegin(updateStream, handle);
                if (i == 1) {
                    aclnnAdd(workspaceAddr2, workspaceSize2, executor2, updateStream);
                    ACL_LOG("update alpha value of aclnnAdd");
                }
                aclmdlRICaptureTaskUpdateEnd(updateStream);
                // 更新任务之后，在updateStream上，下发Event Record任务，用于通知主流stream1继续执行Event Wait之后的任务
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
        
            // 释放资源
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
            // 释放计算设备的资源
            aclrtResetDevice(devID);
            // 去初始化
            aclFinalize();
        }
        
        ```

