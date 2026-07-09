# 单流捕获

**须知：**本功能为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。

在当前主流框架（例如PyTorch）采用的Eager模式下，每个操作或任务都是边下发边执行，无需构建计算图，这种模式带来了即时可见的执行效果和便捷的调试功能，但同时也带来了Host的下发开销。随着性能优化的不断深入，这些Host开销逐渐成为瓶颈，变成不可忽视的问题。

在AI处理器上可以将相关任务下沉到Device上并执行，从而减少Host的开销。为了达到此效果，**当前提供了“捕获Stream任务到模型中、再执行模型”的acl接口**，如下图所示，在aclmdlRICaptureBegin和aclmdlRICaptureEnd接口之间，所有在指定Stream上下发的任务不会立即执行，而是被暂存在模型的运行实例中，只有在调用aclmdlRIExecuteAsync接口执行模型时这些任务才会被真正执行。当Stream上的任务需要被多次执行时，无需再下发任务，只需多次调用aclmdlRIExecuteAsync接口执行模型即可，达到减少Host侧的任务下发开销的效果。任务执行完毕后，若无需再使用模型的运行实例，可调用aclmdlRIDestroy接口及时销毁该资源。

捕获任务到模型中再执行模型的基本流程如下图所示：

![](figures/ACL_Graph单流捕获.png)

捕获任务到模型中、再执行模型的场景下，存在如下基本限制：

1.  在进入捕获状态前，Stream上的任务依然是立即执行的。
2.  在Stream上捕获任务时，只会将任务下沉到Device上，并不会立即执行，因此，对Stream或Event的查询或同步均为非法操作。同样，对Device或Context的查询或同步也是非法的，因为Device和Context中包含了Stream的同步信息。捕获过程中，对Stream、Event、Device、Context的同步或查询，在任何捕获模式下都是非法的。
3.  在捕获过程中，在ACL\_MODEL\_RI\_CAPTURE\_MODE\_GLOBAL模式（全局禁止，所有线程都不可以调用非安全函数）下，调用内存同步操作类函数（例如aclrtMemset、aclrtMemcpy、aclrtMemcpy2d）是非法的，会校验报错导致捕获失败。若业务侧确定这些函数的执行不会影响任务捕获，此时，可以通过调用aclmdlRICaptureThreadExchangeMode接口切换当前线程的捕获模式为ACL\_MODEL\_RI\_CAPTURE\_MODE\_RELAXED，解除调用限制。

4.  在捕获过程中，下发配置类的任务，例如Profiling配置、Dump配置、溢出检测配置等，可能会返回报错或者对捕获模型不生效。
5.  若捕获的异步内存复制任务涉及Host内存，则只支持使用acl接口（例如aclrtMallocHost）申请Host锁页内存，否则在捕获过程中将返回报错。
6.  另外，在捕获过程中，对默认Stream的操作是非法的。
7.  最后还需要注意的是，任务被捕获后，需要使用者保证模型中任务使用资源的有效性，直至模型被销毁后才能销毁相关资源。

以下是单流捕获add算子计算的示例代码。

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
    aclrtStream stream;
    aclrtCreateStream(&stream);

    // ========开始捕获任务========
    aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
    // 异步拷贝，将算子self输入的数据从Host侧传到Device侧
    aclrtMemcpyAsync(self_d, size * sizeof(float), self_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE, stream);
    // 切换捕获模式为RELAXED，允许调用aclrtMemcpy函数
    aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_RELAXED;   
    aclmdlRICaptureThreadExchangeMode(&mode);
    // 同步拷贝，将算子other输入的数据从Host侧传到Device侧，仅执行一次 
    aclrtMemcpy(other_d, size * sizeof(float), other_h, size * sizeof(float), ACL_MEMCPY_HOST_TO_DEVICE);
    // 将捕获模式切换回GLOBAL
    aclmdlRICaptureThreadExchangeMode(&mode);
    // 执行aclnnAdd算子
    aclnnAdd(workspaceAddr, workspaceSize, executor, stream);    
    // 异步拷贝，将算子输出数据从Device侧传回Host侧
    aclrtMemcpyAsync(self_h, size * sizeof(float), out_d, size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST, stream);
    // ========结束捕获任务========
    aclmdlRICaptureEnd(stream, &modelRI);
	
    // 打印模型信息，维测场景下使用
    const char *jsonPath = "./modelRI.json";
    aclmdlRIDebugJsonPrint(modelRI, jsonPath, 0);

    // 多次执行模型
    for (int i = 0; i < 8; i++) {
        aclmdlRIExecuteAsync(modelRI, stream);
        aclrtSynchronizeStream(stream);
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
    // 释放计算设备的资源
    aclrtResetDevice(devID);
    // 去初始化
    aclFinalize();
}
```

