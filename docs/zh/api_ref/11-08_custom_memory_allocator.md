# 11-08 自定义内存分配器

本章节描述自定义 Allocator 接口，用于注册、查询和注销用户自定义的内存分配器。

- [`aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)`](#aclrtAllocatorRegister)：调用该接口注册用户提供的Allocator以及Allocator对应的回调函数，以便后续使用用户提供的Allocator。
- [`aclError aclrtAllocatorGetByStream(aclrtStream stream, aclrtAllocatorDesc *allocatorDesc, aclrtAllocator *allocator, aclrtAllocatorAllocFunc *allocFunc, aclrtAllocatorFreeFunc *freeFunc, aclrtAllocatorAllocAdviseFunc *allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)`](#aclrtAllocatorGetByStream)：根据Stream查询用户注册的Allocator信息。
- [`aclError aclrtAllocatorUnregister(aclrtStream stream)`](#aclrtAllocatorUnregister)：用户销毁Allocator前，需调用本接口取消注册用户提供的Allocator以及Allocator对应的回调函数。

<a id="aclrtAllocatorRegister"></a>

## aclrtAllocatorRegister

```c
aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)
```

### 产品支持情况

<!-- npu="950" id2297 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2297 -->
<!-- npu="A3" id2298 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2298 -->
<!-- npu="910b" id2299 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2299 -->
<!-- npu="310b" id2300 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2300 -->
<!-- npu="310p" id2301 -->
- Atlas 推理系列产品：支持
<!-- end id2301 -->
<!-- npu="910" id2302 -->
- Atlas 训练系列产品：支持
<!-- end id2302 -->
<!-- npu="IPV350" id2303 -->
- IPV350：不支持
<!-- end id2303 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-08_custom_memory_allocator_res.md#id1 -->

### 功能说明

调用该接口注册用户提供的Allocator以及Allocator对应的回调函数，以便后续使用用户提供的Allocator。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 该Allocator需要注册的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>传入的stream参数值不能为NULL，否则返回报错。 |
| allocatorDesc | 输入 | Allocator描述符指针。类型定义请参见[aclrtAllocatorDesc](25-03_Operation_APIs.md#aclrtAllocatorDesc)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 当前仅支持在单算子模型执行、动态shape模型推理场景下使用本接口。

    单算子模型场景下，需在算子执行接口（例如aclopExecuteV2）之前调用本接口。

    动态shape模型推理场景，本接口需配合aclmdlExecuteAsync接口一起使用，且需在aclmdlExecuteAsync接口之前调用本接口。

- 调用本接口前，需要先调用[aclrtAllocatorCreateDesc](25-03_Operation_APIs.md#aclrtAllocatorCreateDesc)创建Allocator描述符，再分别调用[aclrtAllocatorSetObjToDesc](25-03_Operation_APIs.md#aclrtAllocatorSetObjToDesc)、[aclrtAllocatorSetAllocFuncToDesc](25-03_Operation_APIs.md#aclrtAllocatorSetAllocFuncToDesc)、[aclrtAllocatorSetGetAddrFromBlockFuncToDesc](25-03_Operation_APIs.md#aclrtAllocatorSetGetAddrFromBlockFuncToDesc)、[aclrtAllocatorSetFreeFuncToDesc](25-03_Operation_APIs.md#aclrtAllocatorSetFreeFuncToDesc)设置Allocator对象及回调函数。Allocator描述符使用完成后，可调用[aclrtAllocatorDestroyDesc](25-03_Operation_APIs.md#aclrtAllocatorDestroyDesc)接口销毁Allocator描述符。
- 对于同一条流，多次调用本接口，以最后一次注册为准。
- 对于不同流，如果用户使用同一个Allocator，不可以多条流并发执行，在执行下一条Stream前，需要对上一Stream做流同步。
- 将Allocator中的内存释放给操作系统前，需要先调用[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)接口执行流同步，确保Stream中的任务已执行完成。

<br>
<br>
<br>

<a id="aclrtAllocatorGetByStream"></a>

## aclrtAllocatorGetByStream

```c
aclError aclrtAllocatorGetByStream(aclrtStream stream, aclrtAllocatorDesc *allocatorDesc, aclrtAllocator *allocator, aclrtAllocatorAllocFunc *allocFunc, aclrtAllocatorFreeFunc *freeFunc, aclrtAllocatorAllocAdviseFunc *allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)
```

### 产品支持情况

<!-- npu="950" id372 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id372 -->
<!-- npu="A3" id373 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id373 -->
<!-- npu="910b" id374 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id374 -->
<!-- npu="310b" id375 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id375 -->
<!-- npu="310p" id376 -->
- Atlas 推理系列产品：支持
<!-- end id376 -->
<!-- npu="910" id377 -->
- Atlas 训练系列产品：支持
<!-- end id377 -->
<!-- npu="IPV350" id378 -->
- IPV350：不支持
<!-- end id378 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-08_custom_memory_allocator_res.md#id2 -->

### 功能说明

根据Stream查询用户注册的Allocator信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 注册的类型，按照不同的子模块区分。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| allocatorDesc | 输出 | Allocator描述符指针。类型定义请参见[aclrtAllocatorDesc](25-03_Operation_APIs.md#aclrtAllocatorDesc)。 |
| allocator | 输出 | 用户提供的Allocator对象指针。类型定义请参见[aclrtAllocator](25-05_Typedefs.md#aclrtAllocator)。 |
| allocFunc | 输出 | 申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, size_t size); |
| freeFunc | 输出 | 释放内存block的回调函数。<br>回调函数定义如下：<br>typedef void (*aclrtAllocatorFreeFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, [aclrtAllocatorBlock](25-05_Typedefs.md#aclrtAllocatorBlock) block); |
| allocAdviseFunc | 输出 | 根据建议地址申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocAdviseFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, size_t size, [aclrtAllocatorAddr](25-05_Typedefs.md#aclrtAllocatorAddr) addr); |
| getAddrFromBlockFunc | 输出 | 根据申请来的block获取device内存地址的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorGetAddrFromBlockFunc)([aclrtAllocatorBlock](25-05_Typedefs.md#aclrtAllocatorBlock) block); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtAllocatorUnregister"></a>

## aclrtAllocatorUnregister

```c
aclError aclrtAllocatorUnregister(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3186 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3186 -->
<!-- npu="A3" id3187 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3187 -->
<!-- npu="910b" id3188 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3188 -->
<!-- npu="310b" id3189 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3189 -->
<!-- npu="310p" id3190 -->
- Atlas 推理系列产品：支持
<!-- end id3190 -->
<!-- npu="910" id3191 -->
- Atlas 训练系列产品：支持
<!-- end id3191 -->
<!-- npu="IPV350" id3192 -->
- IPV350：不支持
<!-- end id3192 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-08_custom_memory_allocator_res.md#id3 -->

### 功能说明

用户销毁Allocator前，需调用本接口取消注册用户提供的Allocator以及Allocator对应的回调函数。

待取消注册的Stream不存在，或多次调用本接口取消注册，本接口内部不做任何操作，返回成功。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 该Allocator对应的stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
