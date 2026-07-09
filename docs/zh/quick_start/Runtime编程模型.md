# Runtime编程模型

## 主机、设备编程模式

**主机（或称Host）**：指X86服务器CPU、ARM服务器CPU，通过总线与一个或多个设备互联，利用设备提供的NN（Neural-Network）等计算能力完成业务。

**设备（或称Device、NPU）**：指安装了AI处理器的硬件，通过总线（例如PCIe、HCCS等）与主机相连，提供NN等计算能力。HCCS是Huawei Cache Coherence System，表示华为缓存一致性系统。

主机与设备的关系如下图所示：

![](figures/主机设备关系图.png)

总结如下：

1. **主机和设备各自拥有独立的内存空间**

   Runtime提供了主机侧和设备侧的内存申请接口，以及主机与设备之间的内存复制接口。在编程时，需要区分主机和设备的内存申请，并显式调用内存复制接口，将数据从主机侧复制到设备侧，以使设备硬件加速器在访问本地内存时达到最佳性能。

2. **主机与设备之间采用异步并行的执行方式**

   主机将任务（或称Task）下发到设备后，**不会等待设备任务执行完成**就立即返回；设备随即开始调度并执行下发的任务；主机侧的CPU可以与设备侧的加速器并行工作。异步任务下发的接口通常会带有Stream参数，表示将任务下发到对应的Stream中执行。

   当主机需要获取设备的计算结果时，必须发起显式的同步API调用，同步API会阻塞主机CPU，直到设备侧任务执行完成才返回。

   通过这种异步并行执行机制，可以有效隐藏主机处理时间或主机与设备间的数据传输延迟，提高吞吐量，缩短端到端的执行时间。

3. **异步任务下发到Stream中任务的执行方式**

   Stream中的任务保序执行，Stream间的任务并行执行。例如下图中主机侧顺序启动Kernel1、Kernel2和Kernel3任务，具体执行顺序如下：

   -   Kernel1和Kernel3位于同一个Stream中，因此Kernel3需要等待Kernel1执行完毕才能开始执行。
   -   Kernel2与Kernel1、Kernel3不在同一个Stream中，因此Kernel2可以与Kernel1、Kernel3并行执行。

   ![](figures/Stream中的异步任务执行.png)

## 同步与异步区分

Runtime API采用同步和异步两种执行模式，具有以下典型特征：

**同步执行**：
- 函数调用会阻塞主机CPU线程，直到操作完成才返回。
- 调用者必须等待操作执行完毕才能继续执行后续代码。
- 适用于需要立即获取操作结果的场景。

**异步执行**：
- 函数调用立即返回，不会阻塞主机CPU线程。
- 操作在设备侧异步执行，主机可以继续执行其他任务。
- 通过Stream参数指定任务执行的队列。
- 主机需要在合适的时机进行同步操作以获取结果。

**API区分规则**：
- **带Stream参数的API**：通常为异步接口，任务下发到指定Stream中异步执行。
- **不带Stream参数的API**：通常为同步接口，会阻塞等待操作完成。

典型示例：
- `aclrtMemcpy`（不带Stream）：同步内存拷贝，阻塞直到拷贝完成。
- `aclrtMemcpyAsync`（带Stream）：异步内存拷贝，立即返回，拷贝在指定Stream中执行。
- `aclrtLaunchKernel`（带Stream）：下发算子任务，立即返回，算子任务在指定Stream中执行。
- `aclrtSynchronizeStream`：同步接口，阻塞等待Stream中所有任务完成。


## 典型执行流程

基于Runtime编程的典型执行流程图如下所示：

![](figures/典型执行流程图.png)

流程图展示了Host侧和Device侧的任务调度与执行机制，主要包含以下环节：

1. Host通过Runtime将任务加入任务队列。
2. Device侧任务调度器从队列中取出任务进行调度。
3. 调度器根据任务类型，将任务分发到空闲的CPU执行器或AI Core等加速单元执行。
4. 加速单元执行完成后，通知调度器刷新任务状态。
5. 任务执行完成后，调度器将结果反馈给Runtime。
6. Runtime将任务执行结果返回给Host。

> **流程图与下方步骤的关系说明**：上方流程图描绘的是Host侧和Device侧任务调度与执行的内部机制，而下方步骤1~10从用户编程视角描述了完整的Runtime调用流程。两者处于不同抽象层次，其中**步骤5~8**涉及的内存拷贝与计算任务下发与同步，其内部执行机制正是上方流程图所描绘的内容。

1. Device初始化，以Device 0为例。

   ```
   int32_t devId=0;
   aclrtSetDevice(devId);
   ```

   接口内部涉及如下操作：
   1. 创建并初始化Device对象。
   2. 为Device创建默认Context。
   3. 为默认Context创建默认流。
   4. 启动Device侧的CPU执行器进程。

2. 在当前Context下创建Stream。

   ```
   aclrtStream stream1;
   aclrtCreateStream(&stream1);
   ```

   接口内部涉及如下操作：

   1. 调用驱动创建任务队列。
   2. Runtime侧创建Stream对象，Stream与任务队列关联。
   3. 将Stream纳入到当前Context中管理。

3. 申请主机内存。

   ```
   uint64_t size=1024;
   void *hostPtr=nullptr;
   aclrtMallocHost(&hostPtr, size);
   ```

4. 申请设备内存。

   ```
   void *devPtr=nullptr;
   aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
   ```

5. Host到Device的内存同步拷贝。

   ```
   aclrtMemcpy(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE);
   ```

   Host到Device的内存同步拷贝，主要包括以下操作：
   1. 根据源、目的地址构造DMA（Direct Memory Access）描述符后下发DMA任务。
   2. 等待DMA任务完成，接口返回。

6. 下发myKernel计算任务。

   ```
   myKernel<<<numBlocks,  nullptr, stream1>>>(devPtr);
   ```

   下发计算任务及任务调度的详细步骤如下：

   1. 向stream1下发myKernel计算任务，numBlocks用于指定计算任务的block数量，详细操作如下：

      (a) myKernel的二进制代码注册并加载至Device （仅首次）。

      (b) 将myKernel的执行参数拷贝至Device。

      (c) 分配任务管理资源，并创建任务描述符。

      (d) 下发任务到此流对应的任务队列。

      (e) 下发完任务即接口异步返回。

   2. 任务调度器开始调度，详细操作如下：
      (a) 调度器按任务队列的优先级采用绝对优先级（SP）方式调度。

      (b) 解析任务队列中下发的任务描述符。

      (c) 根据任务类型判断对应加速单元是否有空闲。

      (d) 有空闲且满足任务的核数量要求，则将任务调度给对应加速单元（例如，CPU算子会调度给CPU执行器）。

      (e) 加速单元执行任务。

      (f) 调度器等待加速单元执行完成，刷新任务状态和加速单元忙闲状态。当任务执行异常，调度器会处理异常。

      (g) 继续调度其他任务。

7. Stream同步。

   ```
   aclrtSynchronizeStream(stream1);
   ```

   Stream同步，详细操作如下：
   1. 接口会阻塞当前CPU线程。
   2. 通过轮询+中断机制同步流对应的任务队列执行状态。
   3. 流上任务全部完成，此接口返回。

8. Device到Host的内存同步拷贝，将结果复制回Host。

   ```
   aclrtMemcpy(hostPtr, size, devPtr, size, ACL_MEMCPY_DEVICE_TO_HOST);
   ```

   根据源、目的地址构造DMA描述符后下发DMA任务。等待DMA任务完成，接口返回。

9. 释放设备和主机内存。

   ```
   aclrtFree(devPtr);
   aclrtFreeHost(hostPtr);
   ```

10. 释放Device资源。

    ```
    aclrtResetDeviceForce(devId);
    ```

    


## Runtime主要编程概念

-   **Host**，是Runtime对主机的抽象。
-   **Device**，是对AI处理器所属设备的抽象，通常Host与Device关系为1：N。用户APP可以调用acl接口，例如aclrtSetDevice，指定当前用于运算的硬件设备。
-   **Context**，是Device的逻辑运行环境，Context与Device的关系为N：1，即每个Context必定隶属于一个唯一的Device。Context负责管理运行资源对象（包括Stream、Event和Notify，但不包括内存）的生命周期；不同Context中的对象是完全隔离的，例如，不同Context的Stream和Event是完全隔离的，无法建立同步等待关系；运行出错同样按Context隔离。
-   **Stream**，是Device提供的逻辑任务执行队列，可以异步地向Stream中添加任务，在同一个Stream中的任务会严格按FIFO方式执行。Stream与Context的关系是N：1，某条Stream一定属于唯一的Context。
-   **Task**，可被添加到Stream中的执行任务，可以分计算类任务、内存拷贝、事件同步类任务。Task与Stream的关系是N：1，某个Task会被加入到唯一的Stream。

Device、Context、Stream之间的关系如下图所示：

![](figures/Device_Context_Stream关系.png)

## 线程关联Context

Runtime的大多数API接口没有device id参数，因为这些API接口所作用的Device是从调用线程关联的Context中获取的。因此，当主机线程调用Runtime API时，要遵循如下要求：

-   线程（主机侧的CPU线程）要关联Context后，才能正确调用Runtime API。
-   线程同一时刻只能关联一个Context。
-   应用程序可以显式创建Context来达成运行资源隔离的业务诉求。此场景中，同一进程内Context可被所有线程可见，线程可以通过aclrtGetCurrentContext查询当前Context，通过aclrtSetCurrentContext切换Context。

以下示例说明了线程在调用Context相关接口时，线程与Context之间的关联和切换过程，仅供参考，不可以直接拷贝编译运行。

```
// 初始时，线程未关联任何Context
aclInit(nullptr);
aclrtSetDevice(0);  // aclrtSetDevice会创建默认Context，同时将线程关联默认Context
// 线程关联的Context: 默认context

aclrtContext ctx1, ctx2, current_ctx;
aclrtCreateContext(&ctx1, 0); // Device 0显式创建ctx1, 会将线程关联ctx1
// 线程关联的Context: ctx1
aclrtGetCurrentContext(&current_ctx); // 获取当前线程关联的Context, 此时返回的current_ctx==ctx1
// 线程关联的Context: ctx1

aclrtCreateContext(&ctx2, 0); // Device 0又显式创建ctx2, 会将线程关联ctx2
// 线程关联的Context: ctx2

aclrtSetCurrentContext(current_ctx); // 切换Context，由于current_ctx=ctx1，线程关联ctx1
// 线程关联的context: ctx1

aclrtSetCurrentContext(ctx2); // 切换Context
// 线程关联的context: ctx2
.....

aclrtDestroyContext(ctx2);  // 当前线程正关联ctx2，销毁ctx2时会同时将线程与ctx2去关联
// 线程关联的context: NA

// ctx2已销毁，应该切换到其他ctx(如ctx1)
aclrtSetCurrentContext(ctx1);
// 线程关联的context: ctx1
.....

aclrtDestroyContext(ctx1);  // 当前线程正关联ctx1，销毁ctx1时会同时将线程与ctx1去关联
// 线程关联的context: NA
aclrtResetDeviceForce(0);
```

## 默认Context和默认Stream的使用场景

-   Device上执行操作下发前，必须有Context和Stream，这个Context、Stream可以显式创建，也可以隐式创建。**隐式创建**的Context、Stream就是默认Context、默认Stream。

    默认Stream作为接口入参时，直接传NULL。

-   **默认Context**不允许用户执行aclrtGetCurrentContext或aclrtSetCurrentContext操作，也不允许执行aclrtDestroyContext操作。
-   **默认Context、默认Stream**一般适用于简单应用，用户仅需要一个Device的计算场景下。多线程应用程序建议使用显式创建的Context和Stream。

示例代码如下，仅供参考，不可以直接拷贝编译运行：

```
// ......
uint32_t numBlocks = 32;
uint64_t size = 1024;
void *devPtr = nullptr;
aclInit(nullptr);
aclrtSetDevice(0); 
/* 已经创建了一个默认Context，在默认Context中创建了一个默认Stream，并且在当前线程可用 */

......
aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
myKernel<<<numBlocks, nullptr, nullptr>>>(devPtr);  // <<< >>>中第三参数nullptr表示在默认Stream上执行
aclrtSynchronizeStream(nullptr); 

/* 等待计算任务全部完成，用户根据需要获取计算任务的输出结果 */
......
aclrtResetDeviceForce(0);  // 释放Device 0，对应的默认Context及默认Stream生命周期也终止
```

## 编写高性能应用程序的建议

遵循如下基本原则：

1.  主机侧与Device侧异步执行。主机侧要能及时下发足够任务至Device，确保加速硬件始终处于计算状态。
2.  采用多Stream方式充分利用Device上不同种类硬件加速器实现并发执行。 如下图所示，CANN Runtime可以协同调度多种硬件加速器，不同代AI处理器支持的硬件加速器不同，需以实际硬件用户手册中的说明为准。

    ![](figures/多种硬件加速器.png)

推荐如下方式：

-   单线程中创建并使用多个Stream。如果单线程的性能足以满足向多个Stream下发任务，以充分利用Device的算力，建议采用单线程模式。
-   当单线程性能不足时，可以采用多线程模式来提升主机侧任务下发的性能。推荐每个线程创建并使用各自的Stream下发任务；不推荐多个线程并发向同一个Stream下发任务，这将引入锁操作，且多个线程间下发的任务是乱序的。
-   Stream上下发的单个任务占不满AI Core时，可以使用多Stream下发可并行执行的任务来充分利用AI Core资源。
-   AI处理器中包含多种硬件加速器，例如AI Core、AI CPU、DVPP（Digital Vision Pre-Processing）、Random（随机数生成器）等，这些硬件加速器对应不同类型的任务，建议多Stream的创建按照算子执行硬件划分。
