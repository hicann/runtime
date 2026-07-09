# 跨流捕获

**须知：**本功能为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。

在捕获Stream上的任务时，aclmdlRICaptureBegin和aclmdlRICaptureEnd接口中指定的Stream只能是同一个Stream（我们将其称为“主流”），若要实现跨Stream的捕获任务，可调用aclrtRecordEvent接口在主流上下发Event Record任务、在其他Stream上调用aclrtStreamWaitEvent接口下发Event Wait任务，以建立主流与其他Stream的关联关系，从而将主流以及其他Stream上的任务捕获到同一个模型中。这时，该Event也会进入捕获状态，如果还有其他Stream等待该Event，那么，相应的Stream也会进入捕获状态。如下图所示，Stream2需等待主流上的task1任务完成，Stream3需等待Stream2上的task2任务完成，这种情况下，Stream2直接依赖主流，而Stream3相当于间接依赖主流，因此，Stream2、Stream3均会被纳入捕获状态，Stream2上的task2任务、Stream3上的task3任务也会被捕获到模型中。

通过Event加入捕获状态的Stream，最终还需要直接或间接地再通过Event返回到主流，否则会在结束捕获时触发报错。如下图所示，可调用aclrtRecordEvent接口在Stream2、Stream3上下发Event Record任务、在主流上调用aclrtStreamWaitEvent接口下发Event Wait任务，以实现Stream2、Stream3返回主流。另外，对于像Stream3这种间接依赖主流的情况，也可以在Stream3上下发Event Record任务、在Stream2上下发Event Wait任务，先将Stream3返回Stream2，然后再在Stream2上下发Event Record任务、在主流上下发Event Wait任务，最终返回到主流。返回主流之后，结束捕获前，不能再在Stream2、Stream3上下发task（例如下图中的task5），否则在结束捕获时会因为校验到有未被关联的task而触发报错。

跨Stream的任务捕获流程如下图所示：

![](figures/ACL_Graph跨流捕获.png)

以下示例用两个stream为例演示跨流捕获，其中stream1是主流。

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
	
    // 初始化
    aclInit(NULL);
    // 指定计算设备
    aclrtSetDevice(devID);

    // 准备aclnnAdd算子的输入、输出参数
    CreateAclTensor(shape, &self_d, aclDataType::ACL_FLOAT, &self);
    CreateAclTensor(shape, &other_d, aclDataType::ACL_FLOAT, &other);
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    CreateAclTensor(shape, &out_d, aclDataType::ACL_FLOAT, &out);

    // 获取算子计算所需的workspace大小以及包含了算子计算流程的执行器
    aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor);
    void *workspaceAddr = nullptr;
    if (workspaceSize > 0) {
        aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST);
    }

    // 使用aclrtMallocHost申请锁页内存
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
    aclrtCreateEvent(&event1);
    aclrtCreateEvent(&event2);

    // ========开始捕获任务========
    aclmdlRICaptureBegin(stream1, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
    // 异步拷贝，将算子self输入的数据从Host侧传到Device侧
    aclrtMemcpyAsync(self_d, size * sizeof(float), self_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE, stream1);
    // 切换捕获模式为RELAXED，允许调用aclrtMemcpy函数
    aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_RELAXED;
    aclmdlRICaptureThreadExchangeMode(&mode);
    // 同步拷贝，将算子other输入的数据从Host侧传到Device侧，仅执行一次 
    aclrtMemcpy(other_d, size * sizeof(float), other_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE);
    // 将捕获模式切换回GLOBAL
    aclmdlRICaptureThreadExchangeMode(&mode);
    // 通过event1，将stream2加入捕获状态
    aclrtRecordEvent(event1, stream1);
    aclrtStreamWaitEvent(stream2, event1);
    // 执行aclnnAdd算子
    aclnnAdd(workspaceAddr, workspaceSize, executor, stream2);
    // stream2上的任务执行完成后，通过event2，让stream2返回主流stream1
    aclrtRecordEvent(event2, stream2);
    aclrtStreamWaitEvent(stream1, event2);
    // 异步拷贝，将算子输出数据从Device侧传回Host侧
    aclrtMemcpyAsync(self_h, size * sizeof(float), out_d, size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST, stream1);
    // ========结束捕获任务========
    aclmdlRICaptureEnd(stream1, &modelRI);

    // 多次执行模型
    for (int i = 0; i < 8; i++) {
        aclmdlRIExecuteAsync(modelRI, stream1);
        aclrtSynchronizeStream(stream1);
	// 打印每一次的算子输出数据
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

    // 释放资源
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
    // 释放计算设备的资源
    aclrtResetDevice(devID);
    // 去初始化
    aclFinalize();
}
```

