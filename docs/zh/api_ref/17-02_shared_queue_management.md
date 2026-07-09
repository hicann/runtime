# 17-02 共享队列管理

本章节描述共享队列管理接口，用于队列的创建、销毁、入队、出队及路由管理。

- [`aclError acltdtCreateQueue(const acltdtQueueAttr *attr, uint32_t *qid)`](#acltdtCreateQueue)：创建队列。
- [`aclError acltdtDestroyQueue(uint32_t qid)`](#acltdtDestroyQueue)：销毁通过acltdtCreateQueue接口创建的队列。
- [`aclError acltdtEnqueueData(uint32_t qid, const void *data, size_t dataSize, const void *userData, size_t userDataSize, int32_t timeout, uint32_t rsv)`](#acltdtEnqueueData)：向队列中添加数据。
- [`aclError acltdtDequeueData(uint32_t qid, void *data, size_t dataSize, size_t *retDataSize, void *userData, size_t userDataSize, int32_t timeout)`](#acltdtDequeueData)：从队列中获取数据。
- [`aclError acltdtEnqueue(uint32_t qid, acltdtBuf buf, int32_t timeout)`](#acltdtEnqueue)：向队列中添加数据，存放数据的内存必须调用[acltdtAllocBuf](17-03_shared_buffer_management.md#acltdtAllocBuf)接口申请。
- [`aclError acltdtDequeue(uint32_t qid, acltdtBuf *buf, int32_t timeout)`](#acltdtDequeue)：从队列中获取数据。
- [`aclError acltdtBindQueueRoutes(acltdtQueueRouteList *qRouteList)`](#acltdtBindQueueRoutes)：当应用存在数据一对多分发时，通过本接口绑定队列间数据转发路由关系。
- [`aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *qRouteList)`](#acltdtUnbindQueueRoutes)：解绑定数据队列路由关系。
- [`aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *queryInfo, acltdtQueueRouteList *qRouteList)`](#acltdtQueryQueueRoutes)：根据指定条件查询数据队列路由关系。
- [`aclError acltdtGrantQueue(uint32_t qid, int32_t pid, uint32_t permission, int32_t timeout)`](#acltdtGrantQueue)：进程间需要共享队列信息时，可以调用本接口给其它进程授予队列相关的权限，例如Enqueue（指向队列中添加数据）权限、Dequeue（指从队列中获取数据）权限等。
- [`aclError acltdtAttachQueue(uint32_t qid, int32_t timeout, uint32_t *permission)`](#acltdtAttachQueue)：进程间需要共享队列信息时，在被授权的进程中调用本接口确认当前进程对队列有相应权限。

<a id="acltdtCreateQueue"></a>

## acltdtCreateQueue

```c
aclError acltdtCreateQueue(const acltdtQueueAttr *attr, uint32_t *qid)
```

### 产品支持情况

<!-- npu="950" id2815 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2815 -->
<!-- npu="A3" id2816 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2816 -->
<!-- npu="910b" id2817 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2817 -->
<!-- npu="310b" id2818 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2818 -->
<!-- npu="310p" id2819 -->
- Atlas 推理系列产品：支持
<!-- end id2819 -->
<!-- npu="910" id2820 -->
- Atlas 训练系列产品：支持
<!-- end id2820 -->
<!-- npu="IPV350" id2821 -->
- IPV350：不支持
<!-- end id2821 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id1 -->

### 功能说明

创建队列。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| attr | 输入 | 队列属性配置信息的指针。类型定义请参见[acltdtQueueAttr](25-03_Operation_APIs.md#acltdtQueueAttr)。<br>需提前调用[acltdtCreateQueueAttr](25-03_Operation_APIs.md#acltdtCreateQueueAttr)接口创建acltdtQueueAttr类型的数据，再调用[acltdtSetQueueAttr](25-03_Operation_APIs.md#acltdtSetQueueAttr)接口设置队列属性值（例如，队列名）。<br>若该参数为nullptr时，则使用队列属性默认值，即队列名系统自动分配，队列深度默认为8。 |
| qid | 输出 | 队列ID的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtDestroyQueue"></a>

## acltdtDestroyQueue

```c
aclError acltdtDestroyQueue(uint32_t qid)
```

### 产品支持情况

<!-- npu="950" id3249 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3249 -->
<!-- npu="A3" id3250 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3250 -->
<!-- npu="910b" id3251 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3251 -->
<!-- npu="310b" id3252 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3252 -->
<!-- npu="310p" id3253 -->
- Atlas 推理系列产品：支持
<!-- end id3253 -->
<!-- npu="910" id3254 -->
- Atlas 训练系列产品：支持
<!-- end id3254 -->
<!-- npu="IPV350" id3255 -->
- IPV350：不支持
<!-- end id3255 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id2 -->

### 功能说明

销毁通过acltdtCreateQueue接口创建的队列。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qid | 输入 | 指定需销毁的队列。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtEnqueueData"></a>

## acltdtEnqueueData

```c
aclError acltdtEnqueueData(uint32_t qid, const void *data, size_t dataSize, const void *userData, size_t userDataSize, int32_t timeout, uint32_t rsv)
```

### 产品支持情况

<!-- npu="950" id3151 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3151 -->
<!-- npu="A3" id3152 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3152 -->
<!-- npu="910b" id3153 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3153 -->
<!-- npu="310b" id3154 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3154 -->
<!-- npu="310p" id3155 -->
- Atlas 推理系列产品：支持
<!-- end id3155 -->
<!-- npu="910" id3156 -->
- Atlas 训练系列产品：支持
<!-- end id3156 -->
<!-- npu="IPV350" id3157 -->
- IPV350：不支持
<!-- end id3157 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id3 -->

### 功能说明

向队列中添加数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qid | 输入 | 需要添加数据的队列。<br>队列需提前调用[acltdtCreateQueue](#acltdtCreateQueue)接口创建。 |
| data | 输入 | 内存数据指针，支持Host侧或Device侧的内存。 |
| dataSize | 输入 | 内存数据大小，单位为Byte。 |
| userData | 输入 | 用户自定义数据指针。<br>若用户没有自定义数据，则传nullptr。 |
| userDataSize | 输入 | 用户自定义数据大小（<=96Byte）。<br>若用户没有自定义数据，则传0。 |
| timeout | 输入 | 等待超时时间。当队列满时，如果向队列中添加数据，系统内部会根据设置的等待超时时间来决定如何处理。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据成功加入队列。<br>  - 0：非阻塞方式（仅支持Device场景，Host场景无效），当队列满时，直接返回队列满这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。队列满时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |
| rsv | 输入 | 预留参数，暂不支持。当前可设置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtDequeueData"></a>

## acltdtDequeueData

```c
aclError acltdtDequeueData(uint32_t qid, void *data, size_t dataSize, size_t *retDataSize, void *userData, size_t userDataSize, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id2710 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2710 -->
<!-- npu="A3" id2711 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2711 -->
<!-- npu="910b" id2712 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2712 -->
<!-- npu="310b" id2713 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2713 -->
<!-- npu="310p" id2714 -->
- Atlas 推理系列产品：支持
<!-- end id2714 -->
<!-- npu="910" id2715 -->
- Atlas 训练系列产品：支持
<!-- end id2715 -->
<!-- npu="IPV350" id2716 -->
- IPV350：不支持
<!-- end id2716 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id4 -->

### 功能说明

从队列中获取数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qid | 输入 | 需要从哪个队列中获取数据。<br>队列需提前调用[acltdtCreateQueue](#acltdtCreateQueue)接口创建。 |
| data | 输入&输出 | 内存数据指针。<br>支持Host侧或Device侧的内存。 |
| dataSize | 输入 | 内存数据大小，单位为Byte。 |
| retDataSize | 输出 | 返回实际数据大小，单位为Byte。 |
| userData | 输入&输出 | 用户自定义数据指针。<br>若用户没有自定义数据，则传nullptr。 |
| userDataSize | 输入 | 用户自定义数据大小（<=96Byte）。<br>若用户没有自定义数据，则传0。 |
| timeout | 输入 | 等待超时时间。当队列空时，如果从队列中获取数据，系统内部会根据设置的等待超时时间来决定如何处理。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到队列有数据后返回。<br>  - 0：非阻塞方式（仅支持Device场景，Host场景无效），当队列空时，直接返回队列空这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。队列空时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtEnqueue"></a>

## acltdtEnqueue

```c
aclError acltdtEnqueue(uint32_t qid, acltdtBuf buf, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id2864 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2864 -->
<!-- npu="A3" id2865 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2865 -->
<!-- npu="910b" id2866 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2866 -->
<!-- npu="310b" id2867 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2867 -->
<!-- npu="310p" id2868 -->
- Atlas 推理系列产品：不支持
<!-- end id2868 -->
<!-- npu="910" id2869 -->
- Atlas 训练系列产品：不支持
<!-- end id2869 -->
<!-- npu="IPV350" id2870 -->
- IPV350：不支持
<!-- end id2870 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id5 -->

### 功能说明

向队列中添加数据，存放数据的内存必须调用[acltdtAllocBuf](17-03_shared_buffer_management.md#acltdtAllocBuf)接口申请。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qid | 输入 | 需要添加数据的队列。<br>队列需提前调用[acltdtCreateQueue](#acltdtCreateQueue)接口创建。 |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。<br>该内存必须提前调用[acltdtAllocBuf](17-03_shared_buffer_management.md#acltdtAllocBuf)接口申请。 |
| timeout | 输入 | 等待超时时间。当队列满时，如果向队列中添加数据，系统内部会根据设置的等待超时时间来决定如何处理。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据成功加入队列。<br>  - 0：非阻塞方式，当队列满时，直接返回队列满这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。队列满时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtDequeue"></a>

## acltdtDequeue

```c
aclError acltdtDequeue(uint32_t qid, acltdtBuf *buf, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id932 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id932 -->
<!-- npu="A3" id933 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id933 -->
<!-- npu="910b" id934 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id934 -->
<!-- npu="310b" id935 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id935 -->
<!-- npu="310p" id936 -->
- Atlas 推理系列产品：不支持
<!-- end id936 -->
<!-- npu="910" id937 -->
- Atlas 训练系列产品：不支持
<!-- end id937 -->
<!-- npu="IPV350" id938 -->
- IPV350：不支持
<!-- end id938 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id6 -->

### 功能说明

从队列中获取数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qid | 输入 | 需要从哪个队列中获取数据。<br>队列需提前调用[acltdtCreateQueue](#acltdtCreateQueue)接口创建。 |
| buf | 输出 | 共享Buffer指针。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。 |
| timeout | 输入 | 等待超时时间。当队列空时，如果从队列中获取数据，系统内部会根据设置的等待超时时间来决定如何处理。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到队列有数据后返回。<br>  - 0：非阻塞方式，当队列空时，直接返回队列空这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。队列空时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtBindQueueRoutes"></a>

## acltdtBindQueueRoutes

```c
aclError acltdtBindQueueRoutes(acltdtQueueRouteList *qRouteList)
```

### 产品支持情况

<!-- npu="950" id2801 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2801 -->
<!-- npu="A3" id2802 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2802 -->
<!-- npu="910b" id2803 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2803 -->
<!-- npu="310b" id2804 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2804 -->
<!-- npu="310p" id2805 -->
- Atlas 推理系列产品：支持
<!-- end id2805 -->
<!-- npu="910" id2806 -->
- Atlas 训练系列产品：支持
<!-- end id2806 -->
<!-- npu="IPV350" id2807 -->
- IPV350：不支持
<!-- end id2807 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id7 -->

### 功能说明

当应用存在数据一对多分发时，通过本接口绑定队列间数据转发路由关系。

如下图所示，可以建立两条路由关系Q1-\>Q2，Q1-\>Q3。数据一对多分发时，传递的共享Buffer数据是无锁的，消费者不能对数据进行inplace操作，如下图所示消费者1对共享数据的修改会导致消费者2访问的数据发生变化。

![](figures/data_producers_and_data_consumers.png)

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qRouteList | 输入/输出 | 路由关系数组的指针，接口调用完成后返回路由绑定结果。类型定义请参见[acltdtQueueRouteList](25-03_Operation_APIs.md#acltdtQueueRouteList)。<br>需提前调用[acltdtCreateQueueRouteList](25-03_Operation_APIs.md#acltdtCreateQueueRouteList)接口创建acltdtQueueRouteList类型的数据，再调用[acltdtAddQueueRoute](25-03_Operation_APIs.md#acltdtAddQueueRoute)接口添加路由关系。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

只有当所有队列关系绑定成功且路由状态正常时，本接口才会返回成功；任何一条绑定失败，本接口返回失败，如果您需要知道具体哪个路由关系绑定失败，您可以先调用[acltdtGetQueueRoute](25-03_Operation_APIs.md#acltdtGetQueueRoute)接口从路由关系数组中获取每一个路由关系，再调用[acltdtGetQueueRouteParam](25-03_Operation_APIs.md#acltdtGetQueueRouteParam)接口查询绑定关系状态。

### 约束说明

- 系统内部会对添加的队列路由关系的进行是否成环校验，不允许成环。
- 不支持多线程并发调用。

<br>
<br>
<br>

<a id="acltdtUnbindQueueRoutes"></a>

## acltdtUnbindQueueRoutes

```c
aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *qRouteList)
```

### 产品支持情况

<!-- npu="950" id1436 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1436 -->
<!-- npu="A3" id1437 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1437 -->
<!-- npu="910b" id1438 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1438 -->
<!-- npu="310b" id1439 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1439 -->
<!-- npu="310p" id1440 -->
- Atlas 推理系列产品：支持
<!-- end id1440 -->
<!-- npu="910" id1441 -->
- Atlas 训练系列产品：支持
<!-- end id1441 -->
<!-- npu="IPV350" id1442 -->
- IPV350：不支持
<!-- end id1442 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id8 -->

### 功能说明

解绑定数据队列路由关系。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qRouteList | 输入/输出 | 路由关系数组的指针，接口调用完成后返回路由去绑定结果。类型定义请参见[acltdtQueueRouteList](25-03_Operation_APIs.md#acltdtQueueRouteList)。<br>可先通过[acltdtQueryQueueRoutes](#acltdtQueryQueueRoutes)获取路由关系数组。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

只有当所有队列关系解绑定成功，本接口才会返回成功；任何一条解绑定失败，本接口返回失败，如果您需要知道具体哪个路由关系解绑定失败，您可以先调用[acltdtGetQueueRoute](25-03_Operation_APIs.md#acltdtGetQueueRoute)接口从路由关系数组中获取每一个路由关系，再调用[acltdtGetQueueRouteParam](25-03_Operation_APIs.md#acltdtGetQueueRouteParam)接口查询绑定关系状态。

<br>
<br>
<br>

<a id="acltdtQueryQueueRoutes"></a>

## acltdtQueryQueueRoutes

```c
aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *queryInfo, acltdtQueueRouteList *qRouteList)
```

### 产品支持情况

<!-- npu="950" id3025 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3025 -->
<!-- npu="A3" id3026 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3026 -->
<!-- npu="910b" id3027 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3027 -->
<!-- npu="310b" id3028 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3028 -->
<!-- npu="310p" id3029 -->
- Atlas 推理系列产品：支持
<!-- end id3029 -->
<!-- npu="910" id3030 -->
- Atlas 训练系列产品：支持
<!-- end id3030 -->
<!-- npu="IPV350" id3031 -->
- IPV350：不支持
<!-- end id3031 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id9 -->

### 功能说明

根据指定条件查询数据队列路由关系。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| queryInfo | 输入 | 查询条件的指针。类型定义请参见[acltdtQueueRouteQueryInfo](25-03_Operation_APIs.md#acltdtQueueRouteQueryInfo)。<br>需提前调用[acltdtCreateQueueRouteQueryInfo](25-03_Operation_APIs.md#acltdtCreateQueueRouteQueryInfo)接口创建acltdtQueueRouteQueryInfo类型的数据。 |
| qRouteList | 输入&输出 | 路由关系数组的指针。类型定义请参见[acltdtQueueRouteList](25-03_Operation_APIs.md#acltdtQueueRouteList)。<br>需提前调用[acltdtCreateQueueRouteList](25-03_Operation_APIs.md#acltdtCreateQueueRouteList)接口创建acltdtQueueRouteList类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtGrantQueue"></a>

## acltdtGrantQueue

```c
aclError acltdtGrantQueue(uint32_t qid, int32_t pid, uint32_t permission, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id183 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id183 -->
<!-- npu="A3" id184 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id184 -->
<!-- npu="910b" id185 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id185 -->
<!-- npu="310b" id186 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id186 -->
<!-- npu="310p" id187 -->
- Atlas 推理系列产品：不支持
<!-- end id187 -->
<!-- npu="910" id188 -->
- Atlas 训练系列产品：不支持
<!-- end id188 -->
<!-- npu="IPV350" id189 -->
- IPV350：不支持
<!-- end id189 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id10 -->

### 功能说明

进程间需要共享队列信息时，可以调用本接口给其它进程授予队列相关的权限，例如Enqueue（指向队列中添加数据）权限、Dequeue（指从队列中获取数据）权限等。

进程间传递队列相关信息时，安全性由用户保证。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qid | 输入 | 队列ID。 |
| pid | 输入 | 被授权进程的ID。 |
| permission | 输入 | 权限标识（队列生产者/消费者）。<br>用户选择如下多个宏进行逻辑或（例如：ACL_TDT_QUEUE_PERMISSION_DEQUEUE \| ACL_TDT_QUEUE_PERMISSION_ENQUEUE），作为permission参数值。每个宏表示某一权限，详细说明如下：<br>  - ACL_TDT_QUEUE_PERMISSION_MANAGE：表示队列的管理权限。<br>  - ACL_TDT_QUEUE_PERMISSION_DEQUEUE：表示Dequeue权限。<br>  - ACL_TDT_QUEUE_PERMISSION_ENQUEUE：表示Enqueue权限。 |
| timeout | 输入 | 等待超时时间，取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据成功加入队列。<br>  - 0：非阻塞方式，立即返回。<br>  - >0：配置具体的超时时间，单位为毫秒，等达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtAttachQueue"></a>

## acltdtAttachQueue

```c
aclError acltdtAttachQueue(uint32_t qid, int32_t timeout, uint32_t *permission)
```

### 产品支持情况

<!-- npu="950" id3445 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id3445 -->
<!-- npu="A3" id3446 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3446 -->
<!-- npu="910b" id3447 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id3447 -->
<!-- npu="310b" id3448 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3448 -->
<!-- npu="310p" id3449 -->
- Atlas 推理系列产品：不支持
<!-- end id3449 -->
<!-- npu="910" id3450 -->
- Atlas 训练系列产品：不支持
<!-- end id3450 -->
<!-- npu="IPV350" id3451 -->
- IPV350：不支持
<!-- end id3451 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-02_shared_queue_management_res.md#id11 -->

### 功能说明

进程间需要共享队列信息时，在被授权的进程中调用本接口确认当前进程对队列有相应权限。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| qid | 输入 | 队列ID。 |
| timeout | 输入 | 等待超时时间，取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据成功加入队列。<br>  - 0：非阻塞方式，立即返回。<br>  - >0：配置具体的超时时间，单位为毫秒，等达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |
| permission | 输出 | 权限标识。<br><br>  - 根据输出参数值的最后一个bit位判断是否有管理权限，0就是没有，1就是有。<br>  - 根据输出参数值的倒数第二个bit位判断是否有从队列中获取数据的权限，0就是没有，1就是有。<br>  - 根据输出参数值的倒数第三个bit位判断是否有向队列中添加数据的权限，0就是没有，1就是有。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
