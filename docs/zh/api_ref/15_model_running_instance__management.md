# 15. 模型运行实例管理

本章节描述 CANN Runtime 的模型运行实例（RI）管理接口，用于 RI 的捕获、构建、执行及任务管理。

- [`aclError aclmdlRICaptureBegin(aclrtStream stream, aclmdlRICaptureMode mode)`](#aclmdlRICaptureBegin)：开始捕获Stream上下发的任务。
- [`aclError aclmdlRICaptureGetInfo(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI)`](#aclmdlRICaptureGetInfo)：获取Stream的捕获信息，包括捕获状态、模型运行实例。
- [`aclError aclmdlRICaptureThreadExchangeMode(aclmdlRICaptureMode *mode)`](#aclmdlRICaptureThreadExchangeMode)：切换当前线程的捕获模式。
- [`aclError aclmdlRICaptureEnd(aclrtStream stream, aclmdlRI *modelRI)`](#aclmdlRICaptureEnd)：结束Stream的捕获动作，并获取模型运行实例，该模型用于暂存所捕获的任务。
- [`aclError aclmdlRICaptureTaskGrpBegin(aclrtStream stream)`](#aclmdlRICaptureTaskGrpBegin)：标记任务组的开始。
- [`aclError aclmdlRICaptureTaskGrpEnd(aclrtStream stream, aclrtTaskGrp *handle)`](#aclmdlRICaptureTaskGrpEnd)：标记任务组的结束。
- [`aclError aclmdlRICaptureTaskUpdateBegin(aclrtStream stream, aclrtTaskGrp handle)`](#aclmdlRICaptureTaskUpdateBegin)：标记待更新任务的开始。
- [`aclError aclmdlRICaptureTaskUpdateEnd(aclrtStream stream)`](#aclmdlRICaptureTaskUpdateEnd)：标记待更新任务的结束。
- [`aclError aclmdlRIDebugJsonPrint(aclmdlRI modelRI, const char *path, uint32_t flags)`](#aclmdlRIDebugJsonPrint)：维测场景下，使用本接口将模型运行实例信息以JSON格式导出到文件中，包括Model ID、Stream ID、Task ID、Task Type等信息。
- [`aclError aclmdlRIDebugPrint(aclmdlRI modelRI)`](#aclmdlRIDebugPrint)：维测场景下使用本接口打印内部模型信息，包括Device ID、Stream ID、Task ID等信息。
- [`aclError aclmdlRIBuildBegin(aclmdlRI *modelRI, uint32_t flag)`](#aclmdlRIBuildBegin)：开始构建一个模型运行实例。
- [`aclError aclmdlRIBindStream(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)`](#aclmdlRIBindStream)：将模型运行实例与Stream绑定。
- [`aclError aclmdlRIEndTask(aclmdlRI modelRI, aclrtStream stream)`](#aclmdlRIEndTask)：在Stream上标记下发任务结束。
- [`aclError aclmdlRIBuildEnd(aclmdlRI modelRI, void *reserve)`](#aclmdlRIBuildEnd)：结束构建模型运行实例。
- [`aclError aclmdlRIUnbindStream(aclmdlRI modelRI, aclrtStream stream)`](#aclmdlRIUnbindStream)：解除模型运行实例与Stream的绑定。
- [`aclError aclmdlRIExecute(aclmdlRI modelRI, int32_t timeout)`](#aclmdlRIExecute)：执行模型。
- [`aclError aclmdlRIExecuteAsync(aclmdlRI modelRI, aclrtStream stream)`](#aclmdlRIExecuteAsync)：执行模型。异步接口。
- [`aclError aclmdlRIDestroy(aclmdlRI modelRI)`](#aclmdlRIDestroy)：销毁模型运行实例。
- [`aclError aclmdlRISetName(aclmdlRI modelRI, const char *name)`](#aclmdlRISetName)：设置模型运行实例的名称。若针对同一个模型运行实例设置多次，以最后一次为准。
- [`aclError aclmdlRIGetName(aclmdlRI modelRI, uint32_t maxLen, char *name)`](#aclmdlRIGetName)：获取模型运行实例的名称。如果没有调用aclmdlRISetName接口，调用本接口获取到的为空字符串。
- [`aclError aclmdlRIGetId(aclmdlRI modelRI, uint32_t *modelRIId)`](#aclmdlRIGetId)：获取模型运行实例的ID。
- [`aclError aclrtCheckArchCompatibility(const char *socVersion, int32_t *canCompatible)`](#aclrtCheckArchCompatibility)：根据AI处理器版本判断算子指令是否兼容。
- [`aclError aclmdlRIAbort(aclmdlRI modelRI)`](#aclmdlRIAbort)：停止正在执行的模型运行实例。
- [`aclError aclmdlRIGetStreams(aclmdlRI modelRI, aclrtStream *streams, uint32_t *numStreams)`](#aclmdlRIGetStreams)：获取模型运行实例关联的Stream。
- [`aclError aclmdlRIGetTasksByStream(aclrtStream stream, aclmdlRITask *tasks, uint32_t *numTasks)`](#aclmdlRIGetTasksByStream)：获取指定Stream中的所有任务。
- [`aclError aclmdlRITaskGetSeqId(aclmdlRITask task, uint32_t *id)`](#aclmdlRITaskGetSeqId)：获取任务序列ID。
- [`aclError aclmdlRITaskGetParams(aclmdlRITask task, aclmdlRITaskParams* params)`](#aclmdlRITaskGetParams)：获取任务的参数信息。
- [`aclError aclmdlRITaskSetParams(aclmdlRITask task, aclmdlRITaskParams* params)`](#aclmdlRITaskSetParams)：设置任务的参数信息。
- [`aclError aclmdlRIKernelTaskGetAttribute(aclmdlRITask task, aclrtLaunchKernelAttrId attrId, aclrtLaunchKernelAttrValue *attrValue)`](#aclmdlRIKernelTaskGetAttribute)：查询KernelTask的属性配置。

- [`aclError aclmdlRITaskDisable(aclmdlRITask task)`](#aclmdlRITaskDisable)：将指定任务设置为disable状态，表示该任务不再参与调度。
- [`aclError aclmdlRIUpdate(aclmdlRI modelRI)`](#aclmdlRIUpdate)：更新指定的模型。
- [`aclError aclmdlRITaskGetType(aclmdlRITask task, aclmdlRITaskType *type)`](#aclmdlRITaskGetType)：获取任务类型。
- [`aclError aclmdlRIDestroyRegisterCallback(aclmdlRI modelRI, aclrtCallback func, void *userData)`](#aclmdlRIDestroyRegisterCallback)：注册一个回调函数，该回调函数将在销毁模型运行实例时被调用。
- [`aclError aclmdlRIDestroyUnregisterCallback(aclmdlRI modelRI, aclrtCallback func)`](#aclmdlRIDestroyUnregisterCallback)：取消通过[aclmdlRIDestroyRegisterCallback](#aclmdlRIDestroyRegisterCallback)接口注册的回调函数。
- [`aclError aclmdlRICondHandleCreate(aclmdlRI modelRI, uint32_t defaultLaunchValue, aclmdlRICondHandleFlag flag, aclmdlRICondHandle *handle)`](#aclmdlRICondHandleCreate)：在指定模型运行实例上创建条件句柄，用于后续的条件任务执行。
- [`aclError aclmdlRICondHandleGetCondPtr(aclmdlRICondHandle handle, uint64_t **ptr)`](#aclmdlRICondHandleGetCondPtr)：获取条件句柄的Device内存指针，存储条件值，用于条件任务执行时选择执行模型运行实例。
- [`aclError aclmdlRIAddCondTask(aclmdlRICondTaskParams params, aclrtStream stream, uint32_t flags)`](#aclmdlRIAddCondTask)：在Stream上下发条件任务。
- [`aclError aclmdlRICaptureToModelRIBegin(aclrtStream stream, aclmdlRI modelRI, aclmdlRICaptureMode mode)`](#aclmdlRICaptureToModelRIBegin)：开始捕获Stream上下发的任务到指定的模型运行实例中。

<a id="aclmdlRICaptureBegin"></a>

## aclmdlRICaptureBegin

```c
aclError aclmdlRICaptureBegin(aclrtStream stream, aclmdlRICaptureMode mode)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1009 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1009 -->
<!-- npu="A3" id1010 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1010 -->
<!-- npu="910b" id1011 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1011 -->
<!-- npu="310b" id1012 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1012 -->
<!-- npu="310p" id1013 -->
- Atlas 推理系列产品：支持
<!-- end id1013 -->
<!-- npu="910" id1014 -->
- Atlas 训练系列产品：不支持
<!-- end id1014 -->
<!-- npu="IPV350" id1015 -->
- IPV350：不支持
<!-- end id1015 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id1 -->

### 功能说明

开始捕获Stream上下发的任务。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之间，所有在指定Stream上下发的任务不会立即执行，而是被暂存在系统内部模型运行实例中，只有在调用[aclmdlRIExecuteAsync](#aclmdlRIExecuteAsync)接口执行模型时，这些任务才会被真正执行，以此减少Host侧的任务下发开销。所有任务执行完毕后，若无需再使用内部模型，可调用[aclmdlRIDestroy](#aclmdlRIDestroy)接口及时销毁该资源。

aclmdlRICaptureBegin和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口要成对使用，且两个接口中的Stream应相同。在这两个接口之间，可以调用[aclmdlRICaptureGetInfo](#aclmdlRICaptureGetInfo)接口获取捕获信息，调用[aclmdlRICaptureThreadExchangeMode](#aclmdlRICaptureThreadExchangeMode)接口切换当前线程的捕获模式。此外，在调用[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之后，还可以调用[aclmdlRIDebugPrint](#aclmdlRIDebugPrint)接口打印模型信息，这在维护和测试场景下有助于问题定位。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之间捕获的任务，若要更新任务（包含任务本身以及任务的参数信息），则需在[aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin)、[aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd)接口之间下发后续可能更新的任务，给任务打上任务组的标记，然后在[aclmdlRICaptureTaskUpdateBegin](#aclmdlRICaptureTaskUpdateBegin)、[aclmdlRICaptureTaskUpdateEnd](#aclmdlRICaptureTaskUpdateEnd)接口之间更新任务的输入信息。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之间捕获到的任务会暂存在系统内部模型运行实例中，随着任务数量的增加，以及通过Event推导、内部任务的操作，导致更多的Stream进入捕获状态，Stream资源被不断消耗，最终可能会导致并发的调度资源不足，因此需提前规划好调度资源的使用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| mode | 输入 | 捕获模式，用于限制非安全函数（包括aclrtMemset、aclrtMemcpy、aclrtMemcpy2d以及使用非Host锁页内存进行异步内存复制操作的接口，如aclrtMemcpyAsync接口）的作用范围。<br>类型定义请参见[aclmdlRICaptureMode](25-02_Enumerations.md#aclmdlRICaptureMode)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICaptureGetInfo"></a>

## aclmdlRICaptureGetInfo

```c
aclError aclmdlRICaptureGetInfo(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id750 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id750 -->
<!-- npu="A3" id751 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id751 -->
<!-- npu="910b" id752 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id752 -->
<!-- npu="310b" id753 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id753 -->
<!-- npu="310p" id754 -->
- Atlas 推理系列产品：支持
<!-- end id754 -->
<!-- npu="910" id755 -->
- Atlas 训练系列产品：不支持
<!-- end id755 -->
<!-- npu="IPV350" id756 -->
- IPV350：不支持
<!-- end id756 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id2 -->

### 功能说明

获取Stream的捕获信息，包括捕获状态、模型运行实例。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| status | 输出 | Stream上任务的捕获状态。类型定义请参见[aclmdlRICaptureStatus](25-02_Enumerations.md#aclmdlRICaptureStatus)。 |
| modelRI | 输出 | 模型运行实例，该模型用于暂存所捕获的任务。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>若本接口指定的Stream不在捕获状态，则此处返回的modelRI无效。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICaptureThreadExchangeMode"></a>

## aclmdlRICaptureThreadExchangeMode

```c
aclError aclmdlRICaptureThreadExchangeMode(aclmdlRICaptureMode *mode)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2388 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2388 -->
<!-- npu="A3" id2389 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2389 -->
<!-- npu="910b" id2390 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2390 -->
<!-- npu="310b" id2391 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2391 -->
<!-- npu="310p" id2392 -->
- Atlas 推理系列产品：支持
<!-- end id2392 -->
<!-- npu="910" id2393 -->
- Atlas 训练系列产品：不支持
<!-- end id2393 -->
<!-- npu="IPV350" id2394 -->
- IPV350：不支持
<!-- end id2394 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id3 -->

### 功能说明

切换当前线程的捕获模式。

调用本接口会将调用线程的捕获模式设置为\*mode中包含的值，并通过\*mode返回该线程之前设置的模式。

建议在[aclmdlRICaptureBegin](#aclmdlRICaptureBegin)和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之间调用本接口切换当前线程的模式。各捕获模式的配置说明如下，说明中的其它线程指“没有调用aclmdlRICaptureBegin接口、不在捕获状态”的线程。

- 若aclmdlRICaptureBegin接口将捕获模式设置为ACL\_MODEL\_RI\_CAPTURE\_MODE\_RELAXED（下文简称RELAXED模式），表示所有线程都可以调用非安全函数，这时即使在其它线程（指不在捕获状态的线程）中调用本接口将捕获模式设置为其它值也不会生效，其它线程还是按照RELAXED模式。
- 若aclmdlRICaptureBegin接口将捕获模式设置为ACL\_MODEL\_RI\_CAPTURE\_MODE\_THREAD\_LOCAL（下文简称THREAD\_LOCAL模式），表示当前线程禁止调用非安全函数，但其它线程可以调用非安全函数。如果本线程要调用非安全函数，需调用本接口将当前线程模式切换为RELAXED模式。
- 若aclmdlRICaptureBegin接口将捕获模式设置为ACL\_MODEL\_RI\_CAPTURE\_MODE\_GLOBAL（下文简称GLOBAL模式），表示所有线程都不可以调用非安全函数。本线程若要调用非安全函数，需调用本接口切换为RELAXED模式，其它线程若要调用非安全函数，需调用本接口切换为RELAXED模式或THREAD\_LOCAL模式。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| mode | 输入&输出 | 捕获模式，用于限制非安全函数（包括aclrtMemset、aclrtMemcpy、aclrtMemcpy2d以及使用非Host锁页内存进行异步内存复制操作的接口，如aclrtMemcpyAsync接口）的作用范围。<br>类型定义请参见[aclmdlRICaptureMode](25-02_Enumerations.md#aclmdlRICaptureMode)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICaptureEnd"></a>

## aclmdlRICaptureEnd

```c
aclError aclmdlRICaptureEnd(aclrtStream stream, aclmdlRI *modelRI)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id3067 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3067 -->
<!-- npu="A3" id3068 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3068 -->
<!-- npu="910b" id3069 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3069 -->
<!-- npu="310b" id3070 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3070 -->
<!-- npu="310p" id3071 -->
- Atlas 推理系列产品：支持
<!-- end id3071 -->
<!-- npu="910" id3072 -->
- Atlas 训练系列产品：不支持
<!-- end id3072 -->
<!-- npu="IPV350" id3073 -->
- IPV350：不支持
<!-- end id3073 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id4 -->

### 功能说明

结束Stream的捕获动作，并获取模型运行实例，该模型用于暂存所捕获的任务。

本接口需与其它接口配合使用，以便捕获Stream上下发的任务，暂存在内部创建的模型中，用于后续的任务执行，以此减少Host侧的任务下发开销，配合使用流程请参见[aclmdlRICaptureBegin](#aclmdlRICaptureBegin)接口处的说明。

在[aclmdlRICaptureBegin](#aclmdlRICaptureBegin)接口中，如果将mode设置为非ACL\_MODEL\_RI\_CAPTURE\_MODE\_RELAXED的值，则本接口和[aclmdlRICaptureBegin](#aclmdlRICaptureBegin)接口必须位于同一线程中。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| modelRI | 输出 | 模型运行实例，该模型用于暂存所捕获的任务。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICaptureTaskGrpBegin"></a>

## aclmdlRICaptureTaskGrpBegin

```c
aclError aclmdlRICaptureTaskGrpBegin(aclrtStream stream)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id344 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id344 -->
<!-- npu="A3" id345 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id345 -->
<!-- npu="910b" id346 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id346 -->
<!-- npu="310b" id347 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id347 -->
<!-- npu="310p" id348 -->
- Atlas 推理系列产品：支持
<!-- end id348 -->
<!-- npu="910" id349 -->
- Atlas 训练系列产品：不支持
<!-- end id349 -->
<!-- npu="IPV350" id350 -->
- IPV350：不支持
<!-- end id350 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id5 -->

### 功能说明

标记任务组的开始。

本接口与[aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd)接口成对使用，位于这两个接口之间的任务构成一组任务，当前仅支持在这两个接口之间下发单算子调用的任务。

若下发任务时返回ACL\_ERROR\_RT\_TASK\_TYPE\_NOT\_SUPPORT，则表示不支持该单算子任务，可通过应用类日志查看详细的报错信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处的Stream必须是在捕获状态的Stream。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICaptureTaskGrpEnd"></a>

## aclmdlRICaptureTaskGrpEnd

```c
aclError aclmdlRICaptureTaskGrpEnd(aclrtStream stream, aclrtTaskGrp *handle)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1037 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1037 -->
<!-- npu="A3" id1038 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1038 -->
<!-- npu="910b" id1039 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1039 -->
<!-- npu="310b" id1040 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1040 -->
<!-- npu="310p" id1041 -->
- Atlas 推理系列产品：支持
<!-- end id1041 -->
<!-- npu="910" id1042 -->
- Atlas 训练系列产品：不支持
<!-- end id1042 -->
<!-- npu="IPV350" id1043 -->
- IPV350：不支持
<!-- end id1043 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id6 -->

### 功能说明

标记任务组的结束。

[aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin)接口与本接口成对使用，位于这两个接口之间的任务构成一组任务，当前仅支持在这两个接口之间下发单算子调用的任务。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处的Stream需与[aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin)接口中指定的Stream保持一致。 |
| handle | 输出 | 标识任务组的句柄。类型定义请参见[aclrtTaskGrp](25-05_Typedefs.md#aclrtTaskGrp)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICaptureTaskUpdateBegin"></a>

## aclmdlRICaptureTaskUpdateBegin

```c
aclError aclmdlRICaptureTaskUpdateBegin(aclrtStream stream, aclrtTaskGrp handle)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1429 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1429 -->
<!-- npu="A3" id1430 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1430 -->
<!-- npu="910b" id1431 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1431 -->
<!-- npu="310b" id1432 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1432 -->
<!-- npu="310p" id1433 -->
- Atlas 推理系列产品：支持
<!-- end id1433 -->
<!-- npu="910" id1434 -->
- Atlas 训练系列产品：不支持
<!-- end id1434 -->
<!-- npu="IPV350" id1435 -->
- IPV350：不支持
<!-- end id1435 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id7 -->

### 功能说明

标记待更新任务的开始。

本接口与[aclmdlRICaptureTaskUpdateEnd](#aclmdlRICaptureTaskUpdateEnd)接口成对使用，位于这两个接口之间的任务需更新。

aclmdlRICaptureTaskUpdateBegin、[aclmdlRICaptureTaskUpdateEnd](#aclmdlRICaptureTaskUpdateEnd)接口之间的任务数量、任务类型必须与[aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin)、[aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd)接口之间任务数量、任务类型保持一致。

若任务更新时返回ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT，这表示底层驱动不支持该特性，需升级驱动包。您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers/commercial)，在“固件与驱动”页面下载对应版本的驱动安装包，并参照其文档进行安装和升级。

<!-- npu="A3,910b" id1 -->
- 针对Atlas A2 训练系列产品/Atlas A2 推理系列产品、Atlas A3 训练系列产品/Atlas A3 推理系列产品，需将驱动包升级到25.0.RC1或更高版本。
<!-- end id1 -->
<!-- npu="310p" id2 -->
- 针对Atlas 推理系列产品，需将驱动包升级到26.0.RC1或更高版本。
<!-- end id2 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处的Stream必须是不在捕获状态的Stream。 |
| handle | 输入 | 标识任务组的句柄。类型定义请参见[aclrtTaskGrp](25-05_Typedefs.md#aclrtTaskGrp)。<br>提前调用[aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin)、[aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd)接口标记任务组，并通过aclmdlRICaptureTaskGrpEnd接口获取任务组句柄，再作为入参传入此处。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="A3,910b" id3 -->
### 约束说明

对于Atlas A2 训练系列产品/Atlas A2 推理系列产品、Atlas A3 训练系列产品/Atlas A3 推理系列产品，如果CANN配套的Ascend HDK的版本为25.5.X之前（不包含该版本），那么单个Device可支持同时更新的最大任务数是1024\*1024个，超出该规格，任务会在执行阶段报错。
<!-- end id3 -->

<br>
<br>
<br>

<a id="aclmdlRICaptureTaskUpdateEnd"></a>

## aclmdlRICaptureTaskUpdateEnd

```c
aclError aclmdlRICaptureTaskUpdateEnd(aclrtStream stream)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id15 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id15 -->
<!-- npu="A3" id16 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id16 -->
<!-- npu="910b" id17 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id17 -->
<!-- npu="310b" id18 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id18 -->
<!-- npu="310p" id19 -->
- Atlas 推理系列产品：支持
<!-- end id19 -->
<!-- npu="910" id20 -->
- Atlas 训练系列产品：不支持
<!-- end id20 -->
<!-- npu="IPV350" id21 -->
- IPV350：不支持
<!-- end id21 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id8 -->

### 功能说明

标记待更新任务的结束。

[aclmdlRICaptureTaskUpdateBegin](#aclmdlRICaptureTaskUpdateBegin)接口与本接口成对使用，位于这两个接口之间的任务需更新。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处的Stream需与[aclmdlRICaptureTaskUpdateBegin](#aclmdlRICaptureTaskUpdateBegin)接口中指定的Stream保持一致。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

待更新的任务是异步接口，本接口返回成功，并不代表任务更新完成。

### 约束说明

单个Device可支持同时更新的最大任务数是1024\*1024个，超出该规格，任务会在执行阶段报错。

<br>
<br>
<br>

<a id="aclmdlRIDebugJsonPrint"></a>

## aclmdlRIDebugJsonPrint

```c
aclError aclmdlRIDebugJsonPrint(aclmdlRI modelRI, const char *path, uint32_t flags)
```

### 产品支持情况

<!-- npu="950" id302 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id302 -->
<!-- npu="A3" id303 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id303 -->
<!-- npu="910b" id304 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id304 -->
<!-- npu="310b" id305 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id305 -->
<!-- npu="310p" id306 -->
- Atlas 推理系列产品：支持
<!-- end id306 -->
<!-- npu="910" id307 -->
- Atlas 训练系列产品：不支持
<!-- end id307 -->
<!-- npu="IPV350" id308 -->
- IPV350：不支持
<!-- end id308 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id9 -->

### 功能说明

维测场景下，使用本接口将模型运行实例信息以JSON格式导出到文件中，包括Model ID、Stream ID、Task ID、Task Type等信息。然后，通过tracing方式（例如chrome://tracing/）查看模型的可视化信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例，该模型用于暂存所捕获的任务。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>需确保modelRI是有效的。 |
| path | 输入 | 需要导出的文件路径，包含文件名。<br>该文件路径需存在，且有可读可写权限，否则本接口返回失败。 |
| flags | 输入 | 配置选项。<br>取值为如下宏：<br><br>  - ACL_MDLRI_DEBUG_JSON_PRINT_SUMMARY：打印modelRI的基础信息，例如Model ID、Stream ID、Task ID等。<br>  - ACL_MDLRI_DEBUG_JSON_PRINT_VERBOSE：在基础信息上，增加打印modelRI中AI Core算子的核函数参数信息。<br><br><br>宏的定义如下：<br>#define ACL_MDLRI_DEBUG_JSON_PRINT_SUMMARY 0x0UL<br>#define ACL_MDLRI_DEBUG_JSON_PRINT_VERBOSE 0x1UL |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIDebugPrint"></a>

## aclmdlRIDebugPrint

```c
aclError aclmdlRIDebugPrint(aclmdlRI modelRI)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id3515 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3515 -->
<!-- npu="A3" id3516 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3516 -->
<!-- npu="910b" id3517 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3517 -->
<!-- npu="310b" id3518 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3518 -->
<!-- npu="310p" id3519 -->
- Atlas 推理系列产品：支持
<!-- end id3519 -->
<!-- npu="910" id3520 -->
- Atlas 训练系列产品：不支持
<!-- end id3520 -->
<!-- npu="IPV350" id3521 -->
- IPV350：不支持
<!-- end id3521 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id10 -->

### 功能说明

维测场景下使用本接口打印内部模型信息，包括Device ID、Stream ID、Task ID等信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例，该模型用于暂存所捕获的任务。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>仅支持在[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之后打印模型信息，将[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口输出的模型运行实例作为入参传入本接口，但需确保modelRI是有效的。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIBuildBegin"></a>

## aclmdlRIBuildBegin

```c
aclError aclmdlRIBuildBegin(aclmdlRI *modelRI, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id2402 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2402 -->
<!-- npu="A3" id2403 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2403 -->
<!-- npu="910b" id2404 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2404 -->
<!-- npu="310b" id2405 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2405 -->
<!-- npu="310p" id2406 -->
- Atlas 推理系列产品：支持
<!-- end id2406 -->
<!-- npu="910" id2407 -->
- Atlas 训练系列产品：支持
<!-- end id2407 -->
<!-- npu="IPV350" id2408 -->
- IPV350：不支持
<!-- end id2408 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id11 -->

### 功能说明

开始构建一个模型运行实例。

在[aclmdlRIBuildBegin](#aclmdlRIBuildBegin)接口之后，先调用[aclmdlRIBindStream](#aclmdlRIBindStream)接口将模型运行实例与Stream绑定，接着在指定的Stream上下发任务，所有任务下发完成后，调用[aclmdlRIEndTask](#aclmdlRIEndTask)接口在Stream上标记任务下发结束，随后调用[aclmdlRIBuildEnd](#aclmdlRIBuildEnd)接口结束模型构建。此时，所有在指定Stream上下发的任务不会立即执行，只有在调用[aclmdlRIExecute](#aclmdlRIExecute)或[aclmdlRIExecuteAsync](#aclmdlRIExecuteAsync)接口执行模型推理时，这些任务才会被真正执行。

所有任务执行完毕后，如果不再使用模型运行实例，可调用[aclmdlRIUnbindStream](#aclmdlRIUnbindStream)接口解除模型运行实例与Stream的绑定关系。可调用[aclmdlRIDestroy](#aclmdlRIDestroy)接口及时销毁该资源。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例，该模型用于暂存所编译的任务。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |
| flag | 输入 | 预留参数。当前固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIBindStream"></a>

## aclmdlRIBindStream

```c
aclError aclmdlRIBindStream(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id1625 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1625 -->
<!-- npu="A3" id1626 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1626 -->
<!-- npu="910b" id1627 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1627 -->
<!-- npu="310b" id1628 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1628 -->
<!-- npu="310p" id1629 -->
- Atlas 推理系列产品：支持
<!-- end id1629 -->
<!-- npu="910" id1630 -->
- Atlas 训练系列产品：支持
<!-- end id1630 -->
<!-- npu="IPV350" id1631 -->
- IPV350：不支持
<!-- end id1631 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id12 -->

### 功能说明

将模型运行实例与Stream绑定。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>此处的modelRI需与[aclmdlRIBuildBegin](#aclmdlRIBuildBegin)接口中的modelRI保持一致。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处的Stream需通过[aclrtCreateStreamWithConfig](06_stream_management.md#aclrtCreateStreamWithConfig)接口创建ACL_STREAM_PERSISTENT类型的Stream。<br>不支持传NULL，不支持一个Stream绑定多个modelRI的场景。 |
| flag | 输入 | 标记该Stream是否从模型执行开始时就运行。<br><br>  - ACL_MODEL_STREAM_FLAG_HEAD：首Stream，模型执行开始时就运行的Stream。<br>  - ACL_MODEL_STREAM_FLAG_DEFAULT：模型执行过程中，根据分支算子或循环算子激活的Stream，后续可调用[aclrtActiveStream](06_stream_management.md#aclrtActiveStream)接口激活Stream<br><br>宏定义如下：<br>#define ACL_MODEL_STREAM_FLAG_HEAD  0x00000000U <br>#define ACL_MODEL_STREAM_FLAG_DEFAULT 0x7FFFFFFFU |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIEndTask"></a>

## aclmdlRIEndTask

```c
aclError aclmdlRIEndTask(aclmdlRI modelRI, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2899 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2899 -->
<!-- npu="A3" id2900 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2900 -->
<!-- npu="910b" id2901 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2901 -->
<!-- npu="310b" id2902 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2902 -->
<!-- npu="310p" id2903 -->
- Atlas 推理系列产品：支持
<!-- end id2903 -->
<!-- npu="910" id2904 -->
- Atlas 训练系列产品：支持
<!-- end id2904 -->
<!-- npu="IPV350" id2905 -->
- IPV350：不支持
<!-- end id2905 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id13 -->

### 功能说明

在Stream上标记下发任务结束。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>此处的modelRI需与[aclmdlRIBuildBegin](#aclmdlRIBuildBegin)接口中的modelRI保持一致。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIBuildEnd"></a>

## aclmdlRIBuildEnd

```c
aclError aclmdlRIBuildEnd(aclmdlRI modelRI, void *reserve)
```

### 产品支持情况

<!-- npu="950" id29 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id29 -->
<!-- npu="A3" id30 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id30 -->
<!-- npu="910b" id31 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id31 -->
<!-- npu="310b" id32 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id32 -->
<!-- npu="310p" id33 -->
- Atlas 推理系列产品：支持
<!-- end id33 -->
<!-- npu="910" id34 -->
- Atlas 训练系列产品：支持
<!-- end id34 -->
<!-- npu="IPV350" id35 -->
- IPV350：不支持
<!-- end id35 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id14 -->

### 功能说明

结束构建模型运行实例。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>此处的modelRI需与[aclmdlRIBuildBegin](#aclmdlRIBuildBegin)接口中的modelRI保持一致。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIUnbindStream"></a>

## aclmdlRIUnbindStream

```c
aclError aclmdlRIUnbindStream(aclmdlRI modelRI, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id722 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id722 -->
<!-- npu="A3" id723 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id723 -->
<!-- npu="910b" id724 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id724 -->
<!-- npu="310b" id725 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id725 -->
<!-- npu="310p" id726 -->
- Atlas 推理系列产品：支持
<!-- end id726 -->
<!-- npu="910" id727 -->
- Atlas 训练系列产品：支持
<!-- end id727 -->
<!-- npu="IPV350" id728 -->
- IPV350：不支持
<!-- end id728 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id15 -->

### 功能说明

解除模型运行实例与Stream的绑定。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>此处的modelRI需与[aclmdlRIBuildBegin](#aclmdlRIBuildBegin)接口中的modelRI保持一致。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIExecute"></a>

## aclmdlRIExecute

```c
aclError aclmdlRIExecute(aclmdlRI modelRI, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id582 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id582 -->
<!-- npu="A3" id583 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id583 -->
<!-- npu="910b" id584 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id584 -->
<!-- npu="310b" id585 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id585 -->
<!-- npu="310p" id586 -->
- Atlas 推理系列产品：支持
<!-- end id586 -->
<!-- npu="910" id587 -->
- Atlas 训练系列产品：支持
<!-- end id587 -->
<!-- npu="IPV350" id588 -->
- IPV350：不支持
<!-- end id588 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id16 -->

### 功能说明

执行模型。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>modelRI支持通过以下方式获取：<br><br>  - 调用[aclmdlRIBuildBegin](#aclmdlRIBuildBegin)、[aclmdlRIBuildEnd](#aclmdlRIBuildEnd)等接口构建模型运行实例，再传入本接口。 |
| timeout | 输入 | 超时时间。<br>取值说明如下：<br><br>  - -1：表示永久等待；<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIExecuteAsync"></a>

## aclmdlRIExecuteAsync

```c
aclError aclmdlRIExecuteAsync(aclmdlRI modelRI, aclrtStream stream)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2906 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2906 -->
<!-- npu="A3" id2907 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2907 -->
<!-- npu="910b" id2908 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2908 -->
<!-- npu="310b" id2909 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2909 -->
<!-- npu="310p" id2910 -->
- Atlas 推理系列产品：支持
<!-- end id2910 -->
<!-- npu="910" id2911 -->
- Atlas 训练系列产品：不支持
<!-- end id2911 -->
<!-- npu="IPV350" id2912 -->
- IPV350：不支持
<!-- end id2912 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id17 -->

### 功能说明

执行模型。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>modelRI支持通过以下方式获取：<br><br>  - 调用[aclmdlRICaptureBegin](#aclmdlRICaptureBegin)接口捕获Stream上下发的任务后，可通过[aclmdlRICaptureGetInfo](#aclmdlRICaptureGetInfo)接口获取模型运行实例，再传入本接口。<br>  - 调用[aclmdlRIBuildBegin](#aclmdlRIBuildBegin)、[aclmdlRIBuildEnd](#aclmdlRIBuildEnd)等接口构建模型运行实例，再传入本接口。 |
| stream | 输入 | 指定Stream，用于执行模型推理任务。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIDestroy"></a>

## aclmdlRIDestroy

```c
aclError aclmdlRIDestroy(aclmdlRI modelRI)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id99 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id99 -->
<!-- npu="A3" id100 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id100 -->
<!-- npu="910b" id101 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id101 -->
<!-- npu="310b" id102 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id102 -->
<!-- npu="310p" id103 -->
- Atlas 推理系列产品：支持
<!-- end id103 -->
<!-- npu="910" id104 -->
- Atlas 训练系列产品：支持
<!-- end id104 -->
<!-- npu="IPV350" id105 -->
- IPV350：不支持
<!-- end id105 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id18 -->

### 功能说明

销毁模型运行实例。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRISetName"></a>

## aclmdlRISetName

```c
aclError aclmdlRISetName(aclmdlRI modelRI, const char *name)
```

### 产品支持情况

<!-- npu="950" id2171 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2171 -->
<!-- npu="A3" id2172 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2172 -->
<!-- npu="910b" id2173 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2173 -->
<!-- npu="310b" id2174 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2174 -->
<!-- npu="310p" id2175 -->
- Atlas 推理系列产品：支持
<!-- end id2175 -->
<!-- npu="910" id2176 -->
- Atlas 训练系列产品：支持
<!-- end id2176 -->
<!-- npu="IPV350" id2177 -->
- IPV350：不支持
<!-- end id2177 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id19 -->

### 功能说明

设置模型运行实例的名称。若针对同一个模型运行实例设置多次，以最后一次为准。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。<br>modelRI支持通过以下方式获取：<br><br>  - 调用[aclmdlRICaptureBegin](#aclmdlRICaptureBegin)接口捕获Stream上下发的任务后，可通过[aclmdlRICaptureGetInfo](#aclmdlRICaptureGetInfo)接口获取模型运行实例，再传入本接口。<br>  - 调用[aclmdlRIBuildBegin](#aclmdlRIBuildBegin)、[aclmdlRIBuildEnd](#aclmdlRIBuildEnd)等接口构建模型运行实例，再传入本接口。 |
| name | 输入 | 名称。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIGetName"></a>

## aclmdlRIGetName

```c
aclError aclmdlRIGetName(aclmdlRI modelRI, uint32_t maxLen, char *name)
```

### 产品支持情况

<!-- npu="950" id2759 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2759 -->
<!-- npu="A3" id2760 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2760 -->
<!-- npu="910b" id2761 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2761 -->
<!-- npu="310b" id2762 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2762 -->
<!-- npu="310p" id2763 -->
- Atlas 推理系列产品：支持
<!-- end id2763 -->
<!-- npu="910" id2764 -->
- Atlas 训练系列产品：支持
<!-- end id2764 -->
<!-- npu="IPV350" id2765 -->
- IPV350：不支持
<!-- end id2765 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id20 -->

### 功能说明

获取模型运行实例的名称。如果没有调用aclmdlRISetName接口，调用本接口获取到的为空字符串。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |
| maxLen | 输入 | 用户申请的用于存放name的最大内存长度，单位Byte。 |
| name | 输出 | 模型运行实例的名称。<br>name的最大长度为512Byte，超过512Byte的部分将被截断并返回。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIGetId"></a>

## aclmdlRIGetId

```c
aclError aclmdlRIGetId(aclmdlRI modelRI, uint32_t *modelRIId)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id869 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id869 -->
<!-- npu="A3" id870 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id870 -->
<!-- npu="910b" id871 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id871 -->
<!-- npu="310b" id872 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id872 -->
<!-- npu="310p" id873 -->
- Atlas 推理系列产品：支持
<!-- end id873 -->
<!-- npu="910" id874 -->
- Atlas 训练系列产品：不支持
<!-- end id874 -->
<!-- npu="IPV350" id875 -->
- IPV350：不支持
<!-- end id875 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id21 -->

### 功能说明

获取模型运行实例的ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |
| modelRIId | 输出 | 模型运行实例的ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCheckArchCompatibility"></a>

## aclrtCheckArchCompatibility

```c
aclError aclrtCheckArchCompatibility(const char *socVersion, int32_t *canCompatible)
```

### 产品支持情况

<!-- npu="950" id2927 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2927 -->
<!-- npu="A3" id2928 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2928 -->
<!-- npu="910b" id2929 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2929 -->
<!-- npu="310b" id2930 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2930 -->
<!-- npu="310p" id2931 -->
- Atlas 推理系列产品：支持
<!-- end id2931 -->
<!-- npu="910" id2932 -->
- Atlas 训练系列产品：支持
<!-- end id2932 -->
<!-- npu="IPV350" id2933 -->
- IPV350：不支持
<!-- end id2933 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id22 -->

### 功能说明

根据AI处理器版本判断算子指令是否兼容。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| socVersion | 输入 | AI处理器版本。 |
| canCompatible | 输出 | 是否兼容，1表示兼容，0表示不兼容。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIAbort"></a>

## aclmdlRIAbort

```c
aclError aclmdlRIAbort(aclmdlRI modelRI)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2024 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2024 -->
<!-- npu="A3" id2025 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2025 -->
<!-- npu="910b" id2026 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2026 -->
<!-- npu="310b" id2027 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2027 -->
<!-- npu="310p" id2028 -->
- Atlas 推理系列产品：支持
<!-- end id2028 -->
<!-- npu="910" id2029 -->
- Atlas 训练系列产品：支持
<!-- end id2029 -->
<!-- npu="IPV350" id2030 -->
- IPV350：不支持
<!-- end id2030 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id23 -->

### 功能说明

停止正在执行的模型运行实例。

如需重新执行模型运行实例，需重新调用[aclmdlRIExecute](#aclmdlRIExecute)或[aclmdlRIExecuteAsync](#aclmdlRIExecuteAsync)接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIGetStreams"></a>

## aclmdlRIGetStreams

```c
aclError aclmdlRIGetStreams(aclmdlRI modelRI, aclrtStream *streams, uint32_t *numStreams)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2598 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2598 -->
<!-- npu="A3" id2599 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2599 -->
<!-- npu="910b" id2600 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2600 -->
<!-- npu="310b" id2601 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2601 -->
<!-- npu="310p" id2602 -->
- Atlas 推理系列产品：不支持
<!-- end id2602 -->
<!-- npu="910" id2603 -->
- Atlas 训练系列产品：不支持
<!-- end id2603 -->
<!-- npu="IPV350" id2604 -->
- IPV350：不支持
<!-- end id2604 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id24 -->

### 功能说明

获取模型运行实例关联的Stream。

通过两次调用本接口可以获取模型运行实例关联的所有Stream：

1. 第一次调用aclmdlRIGetStreams接口：streams参数处传入空指针，numStreams传入任意非负整数，调用aclmdlRIGetStreams接口获取模型运行实例关联的Stream的数量numStreams。
2. 第二次调用aclmdlRIGetStreams接口：为streams申请数组空间，大小为前一步中获取的numStreams，再将streams、numStreams作为输入传入aclmdlRIGetStreams接口，获取模型运行实例关联的所有Stream。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |
| streams | 输入&输出 | 若streams传入空指针，表示获取模型运行实例关联的Stream数量，该数量通过numStreams参数返回。<br>若streams是一个数组，其大小为numStreams，则表示用于存放模型运行实例关联的所有Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| numStreams | 输入&输出 | 作为输入时，表示streams数组大小。<br>作为输出时，表示模型运行实例关联的Stream的数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIGetTasksByStream"></a>

## aclmdlRIGetTasksByStream

```c
aclError aclmdlRIGetTasksByStream(aclrtStream stream, aclmdlRITask *tasks, uint32_t *numTasks)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1716 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1716 -->
<!-- npu="A3" id1717 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1717 -->
<!-- npu="910b" id1718 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1718 -->
<!-- npu="310b" id1719 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1719 -->
<!-- npu="310p" id1720 -->
- Atlas 推理系列产品：不支持
<!-- end id1720 -->
<!-- npu="910" id1721 -->
- Atlas 训练系列产品：不支持
<!-- end id1721 -->
<!-- npu="IPV350" id1722 -->
- IPV350：不支持
<!-- end id1722 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id25 -->

### 功能说明

获取指定Stream中的所有任务。

调用本接口之前，先调用[aclmdlRIGetStreams](#aclmdlRIGetStreams)接口获取模型运行实例关联的所有Stream，再根据指定Stream获取其中的所有任务。

通过两次调用本接口可以获取指定Stream中的所有任务：

1. 第一次调用aclmdlRIGetTasksByStream接口：tasks参数处传入空指针，numTasks传入任意非负整数，调用aclmdlRIGetTasksByStream接口获取指定Stream中的所有任务数量numTasks。
2. 第二次调用aclmdlRIGetTasksByStream接口：为tasks申请数组空间，大小为前一步中获取的numTasks，再将tasks、numTasks作为输入传入aclmdlRIGetTasksByStream接口，获取指定Stream中的所有任务。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>需传入与模型运行实例有关联的Stream。 |
| tasks | 输入&输出 | 若tasks传入空指针，表示获取指定Stream中的所有任务数量，该数量通过numTasks参数返回。<br>若tasks是一个数组，其大小为numTasks，则表示用于存放指定Stream中的所有任务。类型定义请参见[aclmdlRITask](25-05_Typedefs.md#aclmdlRITask)。 |
| numTasks | 输入&输出 | 作为输入时，表示tasks数组大小。<br>作为输出时，表示指定Stream中的所有任务数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRITaskGetSeqId"></a>

## aclmdlRITaskGetSeqId

```c
aclError aclmdlRITaskGetSeqId(aclmdlRITask task, uint32_t *id)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id771 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id771 -->
<!-- npu="A3" id772 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id772 -->
<!-- npu="910b" id773 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id773 -->
<!-- npu="310b" id774 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id774 -->
<!-- npu="310p" id775 -->
- Atlas 推理系列产品：不支持
<!-- end id775 -->
<!-- npu="910" id776 -->
- Atlas 训练系列产品：不支持
<!-- end id776 -->
<!-- npu="IPV350" id777 -->
- IPV350：不支持
<!-- end id777 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id26 -->

### 功能说明

获取任务序列ID。

调用本接口之前，先调用[aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream)接口获取指定Stream中的所有任务，再根据指定任务获取其序列ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| tasks | 输入 | 指定任务。类型定义请参见[aclmdlRITask](25-05_Typedefs.md#aclmdlRITask)。 |
| id | 输出 | 任务序列ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

对于同一个模型运行实例，本接口不支持并发调用。

<br>
<br>
<br>

<a id="aclmdlRITaskGetParams"></a>

## aclmdlRITaskGetParams

```c
aclError aclmdlRITaskGetParams(aclmdlRITask task, aclmdlRITaskParams* params)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2360 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2360 -->
<!-- npu="A3" id2361 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2361 -->
<!-- npu="910b" id2362 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2362 -->
<!-- npu="310b" id2363 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2363 -->
<!-- npu="310p" id2364 -->
- Atlas 推理系列产品：不支持
<!-- end id2364 -->
<!-- npu="910" id2365 -->
- Atlas 训练系列产品：不支持
<!-- end id2365 -->
<!-- npu="IPV350" id2366 -->
- IPV350：不支持
<!-- end id2366 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id27 -->

### 功能说明

获取任务的参数信息。

调用本接口之前，先调用[aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream)接口获取指定Stream中的所有任务，再根据指定任务获取其参数信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| tasks | 输入 | 指定任务。类型定义请参见[aclmdlRITask](25-05_Typedefs.md#aclmdlRITask)。 |
| params | 输出 | 参数信息。类型定义请参见[aclmdlRITaskParams](25-04_Structs.md#aclmdlRITaskParams)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

对于同一个模型运行实例，本接口不支持并发调用。

<br>
<br>
<br>

<a id="aclmdlRITaskSetParams"></a>

## aclmdlRITaskSetParams

```c
aclError aclmdlRITaskSetParams(aclmdlRITask task, aclmdlRITaskParams* params)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id148 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id148 -->
<!-- npu="A3" id149 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id149 -->
<!-- npu="910b" id150 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id150 -->
<!-- npu="310b" id151 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id151 -->
<!-- npu="310p" id152 -->
- Atlas 推理系列产品：不支持
<!-- end id152 -->
<!-- npu="910" id153 -->
- Atlas 训练系列产品：不支持
<!-- end id153 -->
<!-- npu="IPV350" id154 -->
- IPV350：不支持
<!-- end id154 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id28 -->

### 功能说明

设置任务的参数信息。

在调用本接口之前，请先使用[aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream)接口获取指定Stream中的所有任务，然后使用[aclmdlRITaskGetParams](#aclmdlRITaskGetParams)接口获取指定任务的参数信息。如果需要更新参数信息，再调用aclmdlRITaskSetParams接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| tasks | 输入 | 指定任务。类型定义请参见[aclmdlRITask](25-05_Typedefs.md#aclmdlRITask)。 |
| params | 输入 | 参数信息。类型定义请参见[aclmdlRITaskParams](25-04_Structs.md#aclmdlRITaskParams)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

对于同一个模型运行实例，本接口不支持并发调用。

<br>
<br>
<br>

<a id="aclmdlRIKernelTaskGetAttribute"></a>

## aclmdlRIKernelTaskGetAttribute

```c
aclError aclmdlRIKernelTaskGetAttribute(aclmdlRITask task, aclrtLaunchKernelAttrId attrId, aclrtLaunchKernelAttrValue *attrValue)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1016 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1016 -->
<!-- npu="A3" id1017 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1017 -->
<!-- npu="910b" id1018 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1018 -->
<!-- npu="310b" id1019 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1019 -->
<!-- npu="310p" id1020 -->
- Atlas 推理系列产品：不支持
<!-- end id1020 -->
<!-- npu="910" id1021 -->
- Atlas 训练系列产品：不支持
<!-- end id1021 -->
<!-- npu="IPV350" id1022 -->
- IPV350：不支持
<!-- end id1022 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id29 -->

### 功能说明

查询Cube Core或Vector Core上计算任务的属性配置。

在调用本接口之前，请先使用[aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream)接口获取指定Stream中的所有任务，然后使用[aclmdlRITaskGetType](#aclmdlRITaskGetType)接口确认当前的任务是Cube Core或Vector Core上的计算任务，再调用本接口查询具体的属性配置。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| tasks | 输入 | 指定任务。类型定义请参见[aclmdlRITask](25-05_Typedefs.md#aclmdlRITask)。 |
| attrId | 输入 | 要查询的属性ID。类型定义请参见[aclrtLaunchKernelAttrId](25-02_Enumerations.md#aclrtLaunchKernelAttrId)。<br>不支持查询：<br>ACL_RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE(表示算子执行引擎);<br>ACL_RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET(表示numBlocks偏移量)；<br>ACL_RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH(表示任务下发时是否阻止硬件预取本任务的信息)。 |
| attrValue | 输出 | 查询出的属性值。类型定义请参见[aclrtLaunchKernelAttrValue](25-04_Structs.md#aclrtLaunchKernelAttrValue)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

对于同一个模型运行实例，本接口不支持并发调用。

<br>
<br>
<br>

<a id="aclmdlRITaskDisable"></a>

## aclmdlRITaskDisable

```c
aclError aclmdlRITaskDisable(aclmdlRITask task)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id505 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id505 -->
<!-- npu="A3" id506 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id506 -->
<!-- npu="910b" id507 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id507 -->
<!-- npu="310b" id508 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id508 -->
<!-- npu="310p" id509 -->
- Atlas 推理系列产品：不支持
<!-- end id509 -->
<!-- npu="910" id510 -->
- Atlas 训练系列产品：不支持
<!-- end id510 -->
<!-- npu="IPV350" id511 -->
- IPV350：不支持
<!-- end id511 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id30 -->

### 功能说明

将指定任务设置为disable状态，表示该任务不再参与调度。

调用本接口前，先调用[aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream)接口获取指定Stream中的所有任务。调用本接口后，需调用[aclmdlRIUpdate](#aclmdlRIUpdate)接口更新模型。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| tasks | 输入 | 指定任务。类型定义请参见[aclmdlRITask](25-05_Typedefs.md#aclmdlRITask)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

对于同一个模型运行实例，本接口不支持并发调用。

<br>
<br>
<br>

<a id="aclmdlRIUpdate"></a>

## aclmdlRIUpdate

```c
aclError aclmdlRIUpdate(aclmdlRI modelRI)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1184 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1184 -->
<!-- npu="A3" id1185 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1185 -->
<!-- npu="910b" id1186 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1186 -->
<!-- npu="310b" id1187 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1187 -->
<!-- npu="310p" id1188 -->
- Atlas 推理系列产品：不支持
<!-- end id1188 -->
<!-- npu="910" id1189 -->
- Atlas 训练系列产品：不支持
<!-- end id1189 -->
<!-- npu="IPV350" id1190 -->
- IPV350：不支持
<!-- end id1190 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id31 -->

### 功能说明

更新指定的模型。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 指定任务。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

由于Profiling不支持在模型执行过程中动态更新上报的算子参数，因此若需分析Profiling数据，必须在模型首次执行前完成所有参数的更新。

<br>
<br>
<br>

<a id="aclmdlRITaskGetType"></a>

## aclmdlRITaskGetType

```c
aclError aclmdlRITaskGetType(aclmdlRITask task, aclmdlRITaskType *type)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1219 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1219 -->
<!-- npu="A3" id1220 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1220 -->
<!-- npu="910b" id1221 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1221 -->
<!-- npu="310b" id1222 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1222 -->
<!-- npu="310p" id1223 -->
- Atlas 推理系列产品：不支持
<!-- end id1223 -->
<!-- npu="910" id1224 -->
- Atlas 训练系列产品：不支持
<!-- end id1224 -->
<!-- npu="IPV350" id1225 -->
- IPV350：不支持
<!-- end id1225 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id32 -->

### 功能说明

获取任务类型。

调用本接口之前，先调用[aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream)接口获取指定Stream中的所有任务，再根据指定任务获取其类型。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| tasks | 输入 | 指定任务。类型定义请参见[aclmdlRITask](25-05_Typedefs.md#aclmdlRITask)。 |
| type | 输出 | 任务类型。类型定义请参见[aclmdlRITaskType](25-02_Enumerations.md#aclmdlRITaskType)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIDestroyRegisterCallback"></a>

## aclmdlRIDestroyRegisterCallback

```c
aclError aclmdlRIDestroyRegisterCallback(aclmdlRI modelRI, aclrtCallback func, void *userData)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1870 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1870 -->
<!-- npu="A3" id1871 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1871 -->
<!-- npu="910b" id1872 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1872 -->
<!-- npu="310b" id1873 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1873 -->
<!-- npu="310p" id1874 -->
- Atlas 推理系列产品：支持
<!-- end id1874 -->
<!-- npu="910" id1875 -->
- Atlas 训练系列产品：支持
<!-- end id1875 -->
<!-- npu="IPV350" id1876 -->
- IPV350：不支持
<!-- end id1876 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id33 -->

### 功能说明

注册一个回调函数，该回调函数将在销毁模型运行实例时被调用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |
| func | 输入 | 回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtCallback)(void*userData); |
| userData | 输入 | 待传递给回调函数的用户数据的指针。<br>可以为NULL，表示不需要额外传递数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIDestroyUnregisterCallback"></a>

## aclmdlRIDestroyUnregisterCallback

```c
aclError aclmdlRIDestroyUnregisterCallback(aclmdlRI modelRI, aclrtCallback func)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2878 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2878 -->
<!-- npu="A3" id2879 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2879 -->
<!-- npu="910b" id2880 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2880 -->
<!-- npu="310b" id2881 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2881 -->
<!-- npu="310p" id2882 -->
- Atlas 推理系列产品：支持
<!-- end id2882 -->
<!-- npu="910" id2883 -->
- Atlas 训练系列产品：支持
<!-- end id2883 -->
<!-- npu="IPV350" id2884 -->
- IPV350：不支持
<!-- end id2884 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id34 -->

### 功能说明

取消通过[aclmdlRIDestroyRegisterCallback](#aclmdlRIDestroyRegisterCallback)接口注册的回调函数。取消注册之后，销毁模型运行实例时不再调用该回调函数。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |
| func | 输入 | 回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtCallback)(void*userData); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICondHandleCreate"></a>

## aclmdlRICondHandleCreate

```c
aclError aclmdlRICondHandleCreate(aclmdlRI modelRI, uint32_t defaultLaunchValue, aclmdlRICondHandleFlag flag, aclmdlRICondHandle *handle)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id134 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id134 -->
<!-- npu="A3" id135 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id135 -->
<!-- npu="910b" id136 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id136 -->
<!-- npu="310b" id137 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id137 -->
<!-- npu="310p" id138 -->
- Atlas 推理系列产品：不支持
<!-- end id138 -->
<!-- npu="910" id139 -->
- Atlas 训练系列产品：不支持
<!-- end id139 -->
<!-- npu="IPV350" id140 -->
- IPV350：不支持
<!-- end id140 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id35 -->

### 功能说明

创建条件句柄。

当flag设置为ACL\_MODEL\_RI\_COND\_HANDLE\_ASSIGN\_DEFAULT时，条件变量在每次模型执行开始时会被初始化为defaultLaunchValue的值。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例，用于创建条件句柄。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |
| defaultLaunchValue | 输入 | 条件变量的初始值。 |
| flag | 输入 | 条件句柄标志。类型定义请参见[aclmdlRICondHandleFlag](25-02_Enumerations.md#aclmdlRICondHandleFlag)。<br>当前仅支持如下值：<br><br>  - ACL_MODEL_RI_COND_HANDLE_ASSIGN_DEFAULT：条件变量在每次模型执行开始前被初始化为defaultLaunchValue参数值。<br>  - 0：条件变量不会在模型执行开始前被初始化为defaultLaunchValue参数值，而由用户自行管理条件变量值。这时，需先调用aclmdlRICondHandleGetCondPtr接口获取存储条件变量值的Device内存地址指针，再向该Device内存写入条件变量值。 |
| handle | 输出 | 条件句柄。类型定义请参见[aclmdlRICondHandle](25-05_Typedefs.md#aclmdlRICondHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICondHandleGetCondPtr"></a>

## aclmdlRICondHandleGetCondPtr

```c
aclError aclmdlRICondHandleGetCondPtr(aclmdlRICondHandle handle, uint64_t **ptr)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id736 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id736 -->
<!-- npu="A3" id737 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id737 -->
<!-- npu="910b" id738 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id738 -->
<!-- npu="310b" id739 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id739 -->
<!-- npu="310p" id740 -->
- Atlas 推理系列产品：不支持
<!-- end id740 -->
<!-- npu="910" id741 -->
- Atlas 训练系列产品：不支持
<!-- end id741 -->
<!-- npu="IPV350" id742 -->
- IPV350：不支持
<!-- end id742 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id36 -->

### 功能说明

获取Runtime内部存储条件变量值的Device内存地址指针。

如需自行管理条件值，可调用本接口获取该指针，并向Device内存写入条件值。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 条件句柄。类型定义请参见[aclmdlRICondHandle](25-05_Typedefs.md#aclmdlRICondHandle)。 |
| ptr | 输出 | Device内存地址指针，用于存储条件值。<br>该段内存大小为8字节，无需用户释放，内存将在modelRI销毁或应用进程退出时，由Runtime自动释放。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRIAddCondTask"></a>

## aclmdlRIAddCondTask

```c
aclError aclmdlRIAddCondTask(aclmdlRICondTaskParams params, aclrtStream stream, uint32_t flags)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2689 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2689 -->
<!-- npu="A3" id2690 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2690 -->
<!-- npu="910b" id2691 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2691 -->
<!-- npu="310b" id2692 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2692 -->
<!-- npu="310p" id2693 -->
- Atlas 推理系列产品：不支持
<!-- end id2693 -->
<!-- npu="910" id2694 -->
- Atlas 训练系列产品：不支持
<!-- end id2694 -->
<!-- npu="IPV350" id2695 -->
- IPV350：不支持
<!-- end id2695 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id37 -->

### 功能说明

在Stream上添加条件任务。

条件任务参数包括条件句柄（条件值、默认值等）、条件类型、分支数量、子图等信息。执行条件任务的Stream必须处于捕获状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| params | 输入 | 条件任务参数，包含条件句柄、条件类型、分支数量、子图等信息。类型定义请参见[aclmdlRICondTaskParams](25-04_Structs.md#aclmdlRICondTaskParams)。调用本接口前，需调用[aclmdlRICondHandleCreate](#aclmdlRICondHandleCreate)接口创建条件句柄。 |
| stream | 输入 | 执行条件任务的Stream，该Stream必须处于捕获状态。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| flags | 输入 | 预留参数。当前固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclmdlRICaptureToModelRIBegin"></a>

## aclmdlRICaptureToModelRIBegin

```c
aclError aclmdlRICaptureToModelRIBegin(aclrtStream stream, aclmdlRI modelRI, aclmdlRICaptureMode mode)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id3312 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3312 -->
<!-- npu="A3" id3313 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3313 -->
<!-- npu="910b" id3314 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3314 -->
<!-- npu="310b" id3315 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3315 -->
<!-- npu="310p" id3316 -->
- Atlas 推理系列产品：不支持
<!-- end id3316 -->
<!-- npu="910" id3317 -->
- Atlas 训练系列产品：不支持
<!-- end id3317 -->
<!-- npu="IPV350" id3318 -->
- IPV350：不支持
<!-- end id3318 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance__management_res.md#id38 -->

### 功能说明

开始捕获Stream上下发的任务到指定的模型运行实例中。

在aclmdlRICaptureToModelRIBegin和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之间，所有在指定Stream上下发的任务不会立即执行，而是被暂存在系统内部模型运行实例中，只有在根模型调用[aclmdlRIExecuteAsync](#aclmdlRIExecuteAsync)接口执行模型时，这些任务才会被真正执行，以此减少Host侧的任务下发开销。该模型运行实例不支持aclmdlRIDestroy。

aclmdlRICaptureToModelRIBegin和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口要成对使用，且两个接口中的Stream应相同。在这两个接口之间，可以调用[aclmdlRICaptureGetInfo](#aclmdlRICaptureGetInfo)接口获取捕获信息，调用[aclmdlRICaptureThreadExchangeMode](#aclmdlRICaptureThreadExchangeMode)接口切换当前线程的捕获模式。此外，在调用[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之后，还可以调用[aclmdlRIDebugPrint](#aclmdlRIDebugPrint)接口打印模型信息，这在维护和测试场景下有助于问题定位。

在aclmdlRICaptureToModelRIBegin和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之间捕获的任务，若要更新任务（包含任务本身以及任务的参数信息），则需在[aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin)、[aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd)接口之间下发后续可能更新的任务，给任务打上任务组的标记，然后在[aclmdlRICaptureTaskUpdateBegin](#aclmdlRICaptureTaskUpdateBegin)、[aclmdlRICaptureTaskUpdateEnd](#aclmdlRICaptureTaskUpdateEnd)接口之间更新任务的输入信息。

在aclmdlRICaptureToModelRIBegin和[aclmdlRICaptureEnd](#aclmdlRICaptureEnd)接口之间捕获到的任务会暂存在系统内部模型运行实例中，随着任务数量的增加，以及通过Event推导、内部任务的操作，导致更多的Stream进入捕获状态，Stream资源被不断消耗，最终可能会导致并发的调度资源不足，因此需提前规划好调度资源的使用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| modelRI | 输入 | 模型运行实例。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |
| mode | 输入 |  捕获模式，用于限制非安全函数（包括aclrtMemset、aclrtMemcpy、aclrtMemcpy2d以及使用非Host锁页内存进行异步内存复制操作的接口，如aclrtMemcpyAsync接口）的作用范围。<br>类型定义请参见[aclmdlRICaptureMode](25-02_Enumerations.md#aclmdlRICaptureMode)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
