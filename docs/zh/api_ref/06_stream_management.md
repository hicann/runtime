# 6. Stream管理

本章节描述 CANN Runtime 的 Stream 管理接口，用于 Stream 的创建、销毁、同步、查询及属性配置。

- [`aclError aclrtCreateStream(aclrtStream *stream)`](#aclrtCreateStream)：创建Stream。
- [`aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)`](#aclrtCreateStreamWithConfig)：在当前进程或线程中创建Stream。
- [`aclError aclrtDestroyStream(aclrtStream stream)`](#aclrtDestroyStream)：销毁Stream，销毁通过[aclrtCreateStream](#aclrtCreateStream)或[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口创建的Stream，若Stream上有未完成的任务，会等待任务完成后再销毁Stream。
- [`aclError aclrtDestroyStreamForce(aclrtStream stream)`](#aclrtDestroyStreamForce)：销毁Stream，销毁通过[aclrtCreateStream](#aclrtCreateStream)或[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口创建的Stream，若Stream上有未完成的任务，不会等待任务完成，直接强制销毁Stream。
- [`aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)`](#aclrtSetStreamOverflowSwitch)：饱和模式下，对接上层训练框架时（例如PyTorch），针对指定Stream，打开或关闭溢出检测开关，关闭后无法通过溢出检测算子获取任务是否溢出。
- [`aclError aclrtGetStreamOverflowSwitch(aclrtStream stream, uint32_t *flag)`](#aclrtGetStreamOverflowSwitch)：针对指定Stream，获取其当前溢出检测开关是否打开。
- [`aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)`](#aclrtSetStreamFailureMode)：当一个Stream上下发了多个任务时，可通过本接口指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。
- [`aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)`](#aclrtStreamQuery)：查询指定Stream上的所有任务的执行状态。
- [`aclError aclrtSynchronizeStream(aclrtStream stream)`](#aclrtSynchronizeStream)：阻塞Host侧当前线程直到指定Stream中的所有任务都完成。
- [`aclError aclrtSynchronizeStreamWithTimeout(aclrtStream stream, int32_t timeout)`](#aclrtSynchronizeStreamWithTimeout)：阻塞Host侧当前线程直到指定Stream中的所有任务都完成，该接口是在[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口基础上进行了增强，支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出。
- [`aclError aclrtStreamAbort(aclrtStream stream)`](#aclrtStreamAbort)：停止指定Stream上正在执行的任务、丢弃指定Stream上已下发但未执行的任务。本接口执行期间，指定Stream上新下发的任务不再生效。
- [`aclError aclrtStreamGetId(aclrtStream stream, int32_t *streamId)`](#aclrtStreamGetId)：获取指定Stream的ID。
- [`aclError aclrtGetStreamAvailableNum(uint32_t *streamCount)`](#aclrtGetStreamAvailableNum_deprecated)：获取当前Device上剩余可用的Stream数量。（废弃接口）
- [`aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)`](#aclrtSetStreamAttribute)：设置Stream属性值。
- [`aclError aclrtGetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)`](#aclrtGetStreamAttribute)：获取Stream属性值。
- [`aclError aclrtActiveStream(aclrtStream activeStream, aclrtStream stream)`](#aclrtActiveStream)：激活Stream。异步接口。
- [`aclError aclrtSwitchStream(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)`](#aclrtSwitchStream)：根据条件在Stream之间跳转。异步接口。
- [`aclError aclrtRegStreamStateCallback(const char *regName, aclrtStreamStateCallback callback, void *args)`](#aclrtRegStreamStateCallback)：注册Stream状态回调函数，不支持重复注册。
- [`aclError aclrtStreamStop(aclrtStream stream)`](#aclrtStreamStop)：仅停止指定Stream上的正在执行的任务，不清理任务。
- [`aclError aclrtPersistentTaskClean(aclrtStream stream)`](#aclrtPersistentTaskClean)：清理ACL\_STREAM\_PERSISTENT类型的Stream上的任务，适用于在不删除该类型Stream的情况下重新下发任务的场景。
- [`aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)`](#aclrtStreamGetPriority)：查询指定Stream的优先级。
- [`aclError aclrtStreamGetFlags(aclrtStream stream, uint32_t *flags)`](#aclrtStreamGetFlags)：查询创建Stream时设置的flag标志。

<a id="aclrtCreateStream"></a>

## aclrtCreateStream

```c
aclError aclrtCreateStream(aclrtStream *stream)
```

### 产品支持情况

<!-- npu="950" id2591 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2591 -->
<!-- npu="A3" id2592 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2592 -->
<!-- npu="910b" id2593 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2593 -->
<!-- npu="310b" id2594 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2594 -->
<!-- npu="310p" id2595 -->
- Atlas 推理系列产品：支持
<!-- end id2595 -->
<!-- npu="910" id2596 -->
- Atlas 训练系列产品：支持
<!-- end id2596 -->
<!-- npu="IPV350" id2597 -->
- IPV350：不支持
<!-- end id2597 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id1 -->

### 功能说明

创建Stream。

该接口不支持设置Stream的优先级；若不设置，Stream的优先级默认为最高。如需在创建Stream时设置优先级，请参见[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口。

若不显式调用Stream创建接口，那么每个Context对应一个默认Stream，该默认Stream是调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口或[aclrtCreateContext](05_context_management.md#aclrtCreateContext)接口隐式创建的，默认Stream的优先级不支持设置，为最高优先级。默认Stream适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。显式创建的Stream适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性，**推荐显式**。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输出 | Stream的指针。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

不同型号的硬件支持的Stream最大数不同，如果已存在多个Stream（包含默认Stream），则只能显式创建N个Stream，N = Stream最大数 - 已存在的Stream数。例如，Stream最大数为1024，已存在2个Stream，则只能调用本接口显式创建1022个Stream。

<!-- npu="950,A3,910b" id1 -->
- 对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，Stream最大数为1984。
<!-- end id1 -->
<!-- npu="310b" id2 -->
- 对于Atlas 200I/500 A2 推理产品，Stream最大数为512。
<!-- end id2 -->
<!-- npu="310p" id3 -->
- 对于Atlas 推理系列产品，Stream最大数为1024。
<!-- end id3 -->
<!-- npu="910" id4 -->
- Atlas 训练系列产品，Stream最大数为2048。

    多进程场景下，若一次性创建的Stream数量总和接近2048，可能会出现创建Stream失败的情况，此时，建议：

    （1）清理冗余Stream，减少不必要的Stream；

    （2）调整代码逻辑，分批创建Stream，例如第一批创建部分Stream，然后第二批再创建部分Stream，以此类推，直到Stream总数接近2048。
<!-- end id4 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id23 -->

<br>
<br>
<br>

<a id="aclrtCreateStreamWithConfig"></a>

## aclrtCreateStreamWithConfig

```c
aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id3137 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3137 -->
<!-- npu="A3" id3138 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3138 -->
<!-- npu="910b" id3139 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3139 -->
<!-- npu="310b" id3140 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3140 -->
<!-- npu="310p" id3141 -->
- Atlas 推理系列产品：支持
<!-- end id3141 -->
<!-- npu="910" id3142 -->
- Atlas 训练系列产品：支持
<!-- end id3142 -->
<!-- npu="IPV350" id3143 -->
- IPV350：不支持
<!-- end id3143 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id2 -->

### 功能说明

在当前进程或线程中创建Stream。

相比[aclrtCreateStream](#aclrtCreateStream)接口，使用本接口可以创建一个快速下发任务的Stream，但会增加内存消耗或CPU的性能消耗。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输出 | Stream的指针。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| priority | 输入 | 优先级。<br>该参数为预留参数，暂不使用。 |
| flag | 输入 | Stream指针的flag。<br>flag既支持配置单个宏，也支持配置多个宏位或。对于不支持位或的宏，本接口会返回报错。配置其他值创建出来的Stream等同于通过aclrtCreateStream接口创建出来的Stream。<br>flag参数值请参见“flag取值说明”。 |

### flag取值说明

- **ACL\_STREAM\_FAST\_LAUNCH**：使用该flag创建出来的Stream，在使用Stream时，下发任务的速度更快。

    相比[aclrtCreateStream](#aclrtCreateStream)接口创建出来的Stream，在使用Stream时才会申请系统内部资源，导致下发任务的时长增加，使用本接口的**ACL\_STREAM\_FAST\_LAUNCH**模式创建Stream时，会在创建Stream时预申请系统内部资源，因此创建Stream的时长增加，下发任务的时长缩短，总体来说，创建一次Stream，使用多次的场景下，总时长缩短，但创建Stream时预申请内部资源会增加内存消耗。

    宏定义：`#define ACL_STREAM_FAST_LAUNCH 0x00000001U`

- **ACL\_STREAM\_FAST\_SYNC**：使用该flag创建出来的Stream，在调用[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口时，会阻塞当前线程，主动查询任务的执行状态，一旦任务完成，立即返回。

    相比[aclrtCreateStream](#aclrtCreateStream)接口创建出来的Stream，在调用[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口时，会一直被动等待Device上任务执行完成的通知，等待时间长，使用本接口的**ACL\_STREAM\_FAST\_SYNC**模式创建的Stream，没有被动等待，总时长缩短，但主动查询的操作会增加CPU的性能消耗。

    宏定义：`#define ACL_STREAM_FAST_SYNC 0x00000002U`

- **ACL\_STREAM\_PERSISTENT**：使用该flag创建出来的Stream，在该Stream上下发的任务不会立即执行、任务执行完成后也不会立即销毁，在销毁Stream时才会销毁任务相关的资源。该方式下创建的Stream用于与模型绑定，适用于模型构建场景，模型构建相关接口的说明请参见[aclmdlRIBindStream](15_model_running_instance__management.md#aclmdlRIBindStream)。

    宏定义：`#define ACL_STREAM_PERSISTENT 0x00000004U`

- **ACL\_STREAM\_HUGE**：相比其他flag，使用该flag创建出来的Stream所能容纳的Task最大数量更大。

    <!-- npu="950,A3,910b,910,310p,310b" id5 -->
    当前版本设置该flag不生效。
    <!-- end id5 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id24 -->

    宏定义：`#define ACL_STREAM_HUGE 0x00000008U`

- **ACL\_STREAM\_CPU\_SCHEDULE**：使用该flag创建出来的Stream用于队列方式模型推理场景下承载AI CPU调度的相关任务。预留功能。

    宏定义：`#define ACL_STREAM_CPU_SCHEDULE 0x00000010U`

    <!-- npu="950,A3,910b,310p" id6 -->
- **ACL\_STREAM\_DEVICE\_USE\_ONLY**：表示该Stream仅在Device上调用。

    宏定义：`#define ACL_STREAM_DEVICE_USE_ONLY 0x00000020U`

    仅如下型号支持ACL\_STREAM\_DEVICE\_USE\_ONLY：

    <!-- npu="950" id7 -->
    Ascend 950PR/Ascend 950DT
    <!-- end id7 -->

    <!-- npu="A3" id8 -->
    Atlas A3 训练系列产品/Atlas A3 推理系列产品
    <!-- end id8 -->

    <!-- npu="910b" id9 -->
    Atlas A2 训练系列产品/Atlas A2 推理系列产品
    <!-- end id9 -->

    <!-- npu="310p" id10 -->
    Atlas 推理系列产品
    <!-- end id10 -->
    <!-- end id6 -->

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtDestroyStream"></a>

## aclrtDestroyStream

```c
aclError aclrtDestroyStream(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3347 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3347 -->
<!-- npu="A3" id3348 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3348 -->
<!-- npu="910b" id3349 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3349 -->
<!-- npu="310b" id3350 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3350 -->
<!-- npu="310p" id3351 -->
- Atlas 推理系列产品：支持
<!-- end id3351 -->
<!-- npu="910" id3352 -->
- Atlas 训练系列产品：支持
<!-- end id3352 -->
<!-- npu="IPV350" id3353 -->
- IPV350：支持
<!-- end id3353 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id3 -->

### 功能说明

销毁Stream，若Stream上有未完成的任务，会等待任务完成后再销毁Stream。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待销毁的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 在调用aclrtDestroyStream接口销毁指定Stream前，需要先调用[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口确保Stream中的任务都已完成。
- 调用aclrtDestroyStream接口销毁指定Stream时，需确保该Stream在当前Context下。
- 在调用aclrtDestroyStream接口销毁指定Stream时，需确保其它接口没有正在使用该Stream。

<br>
<br>
<br>

<a id="aclrtDestroyStreamForce"></a>

## aclrtDestroyStreamForce

```c
aclError aclrtDestroyStreamForce(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3522 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3522 -->
<!-- npu="A3" id3523 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3523 -->
<!-- npu="910b" id3524 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3524 -->
<!-- npu="310b" id3525 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3525 -->
<!-- npu="310p" id3526 -->
- Atlas 推理系列产品：支持
<!-- end id3526 -->
<!-- npu="910" id3527 -->
- Atlas 训练系列产品：支持
<!-- end id3527 -->
<!-- npu="IPV350" id3528 -->
- IPV350：不支持
<!-- end id3528 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id4 -->

### 功能说明

销毁Stream，销毁通过[aclrtCreateStream](#aclrtCreateStream)或[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口创建的Stream，若Stream上有未完成的任务，不会等待任务完成，直接强制销毁Stream。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待销毁的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

调用本接口销毁指定Stream时，需确保该Stream在当前Context下。

<br>
<br>
<br>

<a id="aclrtSetStreamOverflowSwitch"></a>

## aclrtSetStreamOverflowSwitch

```c
aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id2227 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2227 -->
<!-- npu="A3" id2228 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2228 -->
<!-- npu="910b" id2229 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2229 -->
<!-- npu="310b" id2230 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2230 -->
<!-- npu="310p" id2231 -->
- Atlas 推理系列产品：不支持
<!-- end id2231 -->
<!-- npu="910" id2232 -->
- Atlas 训练系列产品：不支持
<!-- end id2232 -->
<!-- npu="IPV350" id2233 -->
- IPV350：不支持
<!-- end id2233 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id5 -->

### 功能说明

对接上层训练框架时（例如PyTorch），针对指定Stream，打开或关闭溢出检测开关，关闭后无法通过溢出检测算子获取任务是否溢出。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待操作Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| flag | 输入 | 溢出检测开关，取值范围如下：<br><br>  - 0：关闭<br>  - 1：打开 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 调用该接口打开或关闭溢出检测开关后，仅对后续新下发的任务生效，已下发的任务仍维持原样。

<br>
<br>
<br>

<a id="aclrtGetStreamOverflowSwitch"></a>

## aclrtGetStreamOverflowSwitch

```c
aclError aclrtGetStreamOverflowSwitch(aclrtStream stream, uint32_t *flag)
```

### 产品支持情况

<!-- npu="950" id309 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id309 -->
<!-- npu="A3" id310 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id310 -->
<!-- npu="910b" id311 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id311 -->
<!-- npu="310b" id312 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id312 -->
<!-- npu="310p" id313 -->
- Atlas 推理系列产品：不支持
<!-- end id313 -->
<!-- npu="910" id314 -->
- Atlas 训练系列产品：不支持
<!-- end id314 -->
<!-- npu="IPV350" id315 -->
- IPV350：不支持
<!-- end id315 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id6 -->

### 功能说明

针对指定Stream，获取其当前溢出检测开关是否打开。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待操作Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| flag | 输出 | 溢出检测开关，取值范围如下：<br><br>  - 0：关闭<br>  - 1：打开 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetStreamFailureMode"></a>

## aclrtSetStreamFailureMode

```c
aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)
```

### 产品支持情况

<!-- npu="950" id1107 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1107 -->
<!-- npu="A3" id1108 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1108 -->
<!-- npu="910b" id1109 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1109 -->
<!-- npu="310b" id1110 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1110 -->
<!-- npu="310p" id1111 -->
- Atlas 推理系列产品：支持
<!-- end id1111 -->
<!-- npu="910" id1112 -->
- Atlas 训练系列产品：支持
<!-- end id1112 -->
<!-- npu="IPV350" id1113 -->
- IPV350：不支持
<!-- end id1113 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id7 -->

### 功能说明

当一个Stream上下发了多个任务时，可通过本接口指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待操作Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| mode | 输入 | 当一个Stream上下发了多个任务时，可通过本参数指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。<br>取值范围如下：<br><br>  - ACL_CONTINUE_ON_FAILURE：默认值，某个任务失败后，继续执行下一个任务；<br>  - ACL_STOP_ON_FAILURE：某个任务失败后，停止执行后续任务，通常称作遇错即停。触发遇错即停之后，不支持再下发新任务。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

## 约束说明

- 针对指定Stream只能调用一次本接口设置任务调度模式。
<!-- npu="950,A3,910b,910,310p,310b" id13 -->
- 当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停 。
<!-- end id13 -->
<!-- npu="950,A3,910b" id11 -->
- 对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持指定默认Stream（即stream参数传入NULL）。
<!-- end id11 -->
<!-- npu="910,310p,310b" id12 -->
- 对于Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，不支持指定默认Stream（即stream参数传入NULL）。
<!-- end id12 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id25 -->

<br>
<br>
<br>

<a id="aclrtStreamQuery"></a>

## aclrtStreamQuery

```c
aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)
```

### 产品支持情况

<!-- npu="950" id1310 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1310 -->
<!-- npu="A3" id1311 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1311 -->
<!-- npu="910b" id1312 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1312 -->
<!-- npu="310b" id1313 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1313 -->
<!-- npu="310p" id1314 -->
- Atlas 推理系列产品：支持
<!-- end id1314 -->
<!-- npu="910" id1315 -->
- Atlas 训练系列产品：支持
<!-- end id1315 -->
<!-- npu="IPV350" id1316 -->
- IPV350：不支持
<!-- end id1316 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id8 -->

### 功能说明

查询指定Stream上的所有任务的执行状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | Stream的指针。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| status | 输出 | Stream上的任务状态。类型定义请参见[aclrtStreamStatus](25-02_Enumerations.md#aclrtStreamStatus)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSynchronizeStream"></a>

## aclrtSynchronizeStream

```c
aclError aclrtSynchronizeStream(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2612 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2612 -->
<!-- npu="A3" id2613 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2613 -->
<!-- npu="910b" id2614 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2614 -->
<!-- npu="310b" id2615 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2615 -->
<!-- npu="310p" id2616 -->
- Atlas 推理系列产品：支持
<!-- end id2616 -->
<!-- npu="910" id2617 -->
- Atlas 训练系列产品：支持
<!-- end id2617 -->
<!-- npu="IPV350" id2618 -->
- IPV350：支持
<!-- end id2618 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id9 -->

### 功能说明

阻塞Host侧当前线程直到指定Stream中的所有任务都完成。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定需要完成所有任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSynchronizeStreamWithTimeout"></a>

## aclrtSynchronizeStreamWithTimeout

```c
aclError aclrtSynchronizeStreamWithTimeout(aclrtStream stream, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id1982 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1982 -->
<!-- npu="A3" id1983 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1983 -->
<!-- npu="910b" id1984 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1984 -->
<!-- npu="310b" id1985 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1985 -->
<!-- npu="310p" id1986 -->
- Atlas 推理系列产品：支持
<!-- end id1986 -->
<!-- npu="910" id1987 -->
- Atlas 训练系列产品：支持
<!-- end id1987 -->
<!-- npu="IPV350" id1988 -->
- IPV350：不支持
<!-- end id1988 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id10 -->

### 功能说明

阻塞Host侧当前线程直到指定Stream中的所有任务都完成，该接口是在[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口基础上进行了增强，支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定需要完成所有任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br><br>  - -1：表示永久等待，和接口[aclrtSynchronizeStream](#aclrtSynchronizeStream)功能一样；<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtStreamAbort"></a>

## aclrtStreamAbort

```c
aclError aclrtStreamAbort(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id946 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id946 -->
<!-- npu="A3" id947 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id947 -->
<!-- npu="910b" id948 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id948 -->
<!-- npu="310b" id949 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id949 -->
<!-- npu="310p" id950 -->
- Atlas 推理系列产品：不支持
<!-- end id950 -->
<!-- npu="910" id951 -->
- Atlas 训练系列产品：不支持
<!-- end id951 -->
<!-- npu="IPV350" id952 -->
- IPV350：不支持
<!-- end id952 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id11 -->

### 功能说明

停止指定Stream上正在执行的任务、丢弃指定Stream上已下发但未执行的任务。本接口执行期间，指定Stream上新下发的任务不再生效。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定待停止任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 不支持使用[aclmdlRIBindStream](15_model_running_instance__management.md#aclmdlRIBindStream)接口来绑定模型运行实例的Stream。
- 如果有其它Stream依赖本接口中指定的Stream（例如通过[aclrtRecordEvent](07_event_management.md#aclrtRecordEvent)、[aclrtStreamWaitEvent](07_event_management.md#aclrtStreamWaitEvent)等接口实现两个Stream间同步等待），则其它Stream执行可能会卡住，此时您需要显式调用本接口清除其它Stream上的任务。
- 如果调用本接口清除指定Stream上的任务时，再调用同步等待接口（例如[aclrtSynchronizeStream](#aclrtSynchronizeStream)、[aclrtSynchronizeEvent](07_event_management.md#aclrtSynchronizeEvent)等），同步等待接口会退出并返回ACL\_ERROR\_RT\_STREAM\_ABORT的报错。
<!-- npu="950" id14 -->
- 对于Ascend 950PR/Ascend 950DT，不支持如下方式创建的Stream：调用aclrtCreateStreamWithConfig，将flag设置为ACL_STREAM_PERSISTENT。
<!-- end id14 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id26 -->

<br>
<br>
<br>

<a id="aclrtStreamGetId"></a>

## aclrtStreamGetId

```c
aclError aclrtStreamGetId(aclrtStream stream, int32_t *streamId)
```

### 产品支持情况

<!-- npu="950" id1933 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1933 -->
<!-- npu="A3" id1934 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1934 -->
<!-- npu="910b" id1935 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1935 -->
<!-- npu="310b" id1936 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1936 -->
<!-- npu="310p" id1937 -->
- Atlas 推理系列产品：支持
<!-- end id1937 -->
<!-- npu="910" id1938 -->
- Atlas 训练系列产品：支持
<!-- end id1938 -->
<!-- npu="IPV350" id1939 -->
- IPV350：不支持
<!-- end id1939 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id12 -->

### 功能说明

获取指定Stream的ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定要查询的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>若此处传入NULL，则获取的是默认Stream的ID。 |
| streamId | 输出 | Stream ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetStreamAvailableNum_deprecated"></a>

## aclrtGetStreamAvailableNum（废弃）

```c
aclError aclrtGetStreamAvailableNum(uint32_t *streamCount)
```

**须知：此接口后续版本会废弃。**

### 产品支持情况

<!-- npu="950" id960 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id960 -->
<!-- npu="A3" id961 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id961 -->
<!-- npu="910b" id962 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id962 -->
<!-- npu="310b" id963 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id963 -->
<!-- npu="310p" id964 -->
- Atlas 推理系列产品：支持
<!-- end id964 -->
<!-- npu="910" id965 -->
- Atlas 训练系列产品：支持
<!-- end id965 -->
<!-- npu="IPV350" id966 -->
- IPV350：不支持
<!-- end id966 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id13 -->

### 功能说明

获取当前Device上剩余可用的Stream数量。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| streamCount | 输出 | Stream数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetStreamAttribute"></a>

## aclrtSetStreamAttribute

```c
aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
```

### 产品支持情况

<!-- npu="950" id1065 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1065 -->
<!-- npu="A3" id1066 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1066 -->
<!-- npu="910b" id1067 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1067 -->
<!-- npu="310b" id1068 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1068 -->
<!-- npu="310p" id1069 -->
- Atlas 推理系列产品：支持
<!-- end id1069 -->
<!-- npu="910" id1070 -->
- Atlas 训练系列产品：支持
<!-- end id1070 -->
<!-- npu="IPV350" id1071 -->
- IPV350：不支持
<!-- end id1071 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id14 -->

### 功能说明

设置Stream属性值。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| stmAttrType | 输入 | 属性类型。类型定义请参见[aclrtStreamAttr](25-02_Enumerations.md#aclrtStreamAttr)。 |
| value | 输入 | 属性值。类型定义请参见[aclrtStreamAttrValue](25-04_Structs.md#aclrtStreamAttrValue)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

## 约束说明

- 溢出检测属性：调用该接口打开或关闭溢出检测开关后，仅对后续新下发的任务生效，已下发的任务仍维持原样。
- Failure Mode：不支持对Context中的默认Stream设置Failure Mode。
<!-- npu="950,A3,910b,910,310p,310b" id15 -->
- 当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停。
<!-- end id15 -->
<!-- npu="950,A3,910b" id16 -->
- 对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持指定默认Stream（即stream参数传入NULL）。
<!-- end id16 -->
<!-- npu="910,310p,310b" id17 -->
- 对于Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，不支持指定默认Stream（即stream参数传入NULL）。
<!-- end id17 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id27 -->

<br>
<br>
<br>

<a id="aclrtGetStreamAttribute"></a>

## aclrtGetStreamAttribute

```c
aclError aclrtGetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
```

### 产品支持情况

<!-- npu="950" id2976 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2976 -->
<!-- npu="A3" id2977 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2977 -->
<!-- npu="910b" id2978 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2978 -->
<!-- npu="310b" id2979 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2979 -->
<!-- npu="310p" id2980 -->
- Atlas 推理系列产品：支持
<!-- end id2980 -->
<!-- npu="910" id2981 -->
- Atlas 训练系列产品：支持
<!-- end id2981 -->
<!-- npu="IPV350" id2982 -->
- IPV350：不支持
<!-- end id2982 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id15 -->

### 功能说明

获取Stream属性值。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| stmAttrType | 输入 | 属性类型。类型定义请参见[aclrtStreamAttr](25-02_Enumerations.md#aclrtStreamAttr)。 |
| value | 输出 | 属性值。类型定义请参见[aclrtStreamAttrValue](25-04_Structs.md#aclrtStreamAttrValue)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="950,A3,910b,910,310p,310b" id18 -->
## 约束说明

<!-- npu="950,A3,910b" id19 -->
对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持指定默认Stream（即stream参数传入NULL）。
<!-- end id19 -->

<!-- npu="910,310p,310b" id20 -->
对于Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，不支持指定默认Stream（即stream参数传入NULL）。
<!-- end id20 -->
<!-- end id18 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id28 -->

<br>
<br>
<br>

<a id="aclrtActiveStream"></a>

## aclrtActiveStream

```c
aclError aclrtActiveStream(aclrtStream activeStream, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id337 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id337 -->
<!-- npu="A3" id338 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id338 -->
<!-- npu="910b" id339 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id339 -->
<!-- npu="310b" id340 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id340 -->
<!-- npu="310p" id341 -->
- Atlas 推理系列产品：支持
<!-- end id341 -->
<!-- npu="910" id342 -->
- Atlas 训练系列产品：支持
<!-- end id342 -->
<!-- npu="IPV350" id343 -->
- IPV350：不支持
<!-- end id343 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id16 -->

### 功能说明

激活Stream。异步接口。

被激活的Stream上的任务与当前Stream上的任务并行执行。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| activeStream | 输入 | 待激活的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](15_model_running_instance__management.md#aclmdlRIBindStream)接口。 |
| stream | 输入 | 执行激活任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](15_model_running_instance__management.md#aclmdlRIBindStream)接口。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSwitchStream"></a>

## aclrtSwitchStream

```c
aclError aclrtSwitchStream(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2213 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2213 -->
<!-- npu="A3" id2214 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2214 -->
<!-- npu="910b" id2215 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2215 -->
<!-- npu="310b" id2216 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2216 -->
<!-- npu="310p" id2217 -->
- Atlas 推理系列产品：支持
<!-- end id2217 -->
<!-- npu="910" id2218 -->
- Atlas 训练系列产品：支持
<!-- end id2218 -->
<!-- npu="IPV350" id2219 -->
- IPV350：不支持
<!-- end id2219 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id17 -->

### 功能说明

根据条件在Stream之间跳转。异步接口。

跳转成功后，只执行所跳转的Stream上的任务，当前Stream上的任务停止执行。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| leftValue | 输入 | 左值数据的Device内存地址。 |
| cond | 输入 | 左值数据与右值数据的比较条件。类型定义请参见[aclrtCondition](25-02_Enumerations.md#aclrtCondition)。 |
| rightValue | 输入 | 右值数据的Device内存地址。 |
| dataType | 输入 | 左值数据、右值数据的数据类型。类型定义请参见[aclrtCompareDataType](25-02_Enumerations.md#aclrtCompareDataType)。 |
| trueStream | 输入 | 根据cond处指定的条件，条件成立时，则执行trueStream上的任务。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| falseStream | 输入 | 预留参数，当前固定传NULL。<br>取值详见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| stream | 输入 | 执行跳转任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtRegStreamStateCallback"></a>

## aclrtRegStreamStateCallback

```c
aclError aclrtRegStreamStateCallback(const char *regName, aclrtStreamStateCallback callback, void *args)
```

### 产品支持情况

<!-- npu="950" id1919 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1919 -->
<!-- npu="A3" id1920 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1920 -->
<!-- npu="910b" id1921 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1921 -->
<!-- npu="310b" id1922 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1922 -->
<!-- npu="310p" id1923 -->
- Atlas 推理系列产品：支持
<!-- end id1923 -->
<!-- npu="910" id1924 -->
- Atlas 训练系列产品：支持
<!-- end id1924 -->
<!-- npu="IPV350" id1925 -->
- IPV350：不支持
<!-- end id1925 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id18 -->

### 功能说明

注册Stream状态回调函数，不支持重复注册。

当Stream状态发生变化时（例如调用[aclrtCreateStream](#aclrtCreateStream)、[aclrtDestroyStream](#aclrtDestroyStream)等接口），Runtime模块会触发该回调函数的调用。此处的Stream包含显式创建的Stream以及默认Stream。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| regName | 输入 | 注册唯一名称，不能为空，输入保证字符串以\0结尾。 |
| callback | 输入 | 回调函数。若callback不为NULL，则表示注册回调函数；若为NULL，则表示取消注册回调函数。 |
| args | 输入 | 待传递给回调函数的用户数据的指针。 |

<br>
回调函数的函数原型为：

```c
typedef enum {
    ACL_RT_STREAM_STATE_CREATE_POST = 1,  // 调用create接口（例如aclrtCreateStream）之后
    ACL_RT_STREAM_STATE_DESTROY_PRE,  // 调用destroy接口（例如aclrtDestroyStream）之前
} aclrtStreamState;
typedef void (*aclrtStreamStateCallback)(aclrtStream stm, aclrtStreamState state, void *args);
```

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
<br>
<br>
<br>

<a id="aclrtStreamStop"></a>

## aclrtStreamStop

```c
aclError aclrtStreamStop(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2500 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2500 -->
<!-- npu="A3" id2501 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2501 -->
<!-- npu="910b" id2502 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2502 -->
<!-- npu="310b" id2503 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2503 -->
<!-- npu="310p" id2504 -->
- Atlas 推理系列产品：不支持
<!-- end id2504 -->
<!-- npu="910" id2505 -->
- Atlas 训练系列产品：不支持
<!-- end id2505 -->
<!-- npu="IPV350" id2506 -->
- IPV350：不支持
<!-- end id2506 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id19 -->

### 功能说明

仅停止指定Stream上的正在执行的任务，不清理任务。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定待停止任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 不支持使用[aclmdlRIBindStream](15_model_running_instance__management.md#aclmdlRIBindStream)接口来绑定模型运行实例的Stream。
- 不支持默认Stream（即stream参数传入NULL）。

<br>
<br>
<br>

<a id="aclrtPersistentTaskClean"></a>

## aclrtPersistentTaskClean

```c
aclError aclrtPersistentTaskClean(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id428 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id428 -->
<!-- npu="A3" id429 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id429 -->
<!-- npu="910b" id430 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id430 -->
<!-- npu="310b" id431 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id431 -->
<!-- npu="310p" id432 -->
- Atlas 推理系列产品：不支持
<!-- end id432 -->
<!-- npu="910" id433 -->
- Atlas 训练系列产品：不支持
<!-- end id433 -->
<!-- npu="IPV350" id434 -->
- IPV350：不支持
<!-- end id434 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id20 -->

### 功能说明

清理ACL\_STREAM\_PERSISTENT类型的Stream上的任务，适用于在不删除该类型Stream的情况下重新下发任务的场景。

ACL\_STREAM\_PERSISTENT类型的Stream需调用[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口创建。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtStreamGetPriority"></a>

## aclrtStreamGetPriority

```c
aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)
```

### 产品支持情况

<!-- npu="950" id3088 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3088 -->
<!-- npu="A3" id3089 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3089 -->
<!-- npu="910b" id3090 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3090 -->
<!-- npu="310b" id3091 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3091 -->
<!-- npu="310p" id3092 -->
- Atlas 推理系列产品：支持
<!-- end id3092 -->
<!-- npu="910" id3093 -->
- Atlas 训练系列产品：支持
<!-- end id3093 -->
<!-- npu="IPV350" id3094 -->
- IPV350：不支持
<!-- end id3094 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id21 -->

### 功能说明

查询指定Stream的优先级。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>若此处传入NULL，则获取的是默认Stream的优先级。 |
| priority | 输出 | 优先级，数字越小代表优先级越高。<br>关于优先级的取值范围请参见[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口中的priority参数说明。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtStreamGetFlags"></a>

## aclrtStreamGetFlags

```c
aclError aclrtStreamGetFlags(aclrtStream stream, uint32_t *flags)
```

### 产品支持情况

<!-- npu="950" id1562 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1562 -->
<!-- npu="A3" id1563 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1563 -->
<!-- npu="910b" id1564 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1564 -->
<!-- npu="310b" id1565 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1565 -->
<!-- npu="310p" id1566 -->
- Atlas 推理系列产品：支持
<!-- end id1566 -->
<!-- npu="910" id1567 -->
- Atlas 训练系列产品：支持
<!-- end id1567 -->
<!-- npu="IPV350" id1568 -->
- IPV350：不支持
<!-- end id1568 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id22 -->

### 功能说明

查询创建Stream时设置的flag标志。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>若此处传入NULL，则获取的是默认Stream的flag。 |
| flags | 输出 | 指向查询到的flag值的指针。<br>关于flag值的说明请参见[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口中的flag参数说明。若创建Stream时配置了多个flag，返回值为各flag按位或运算后的结果，例如配置了0x01U和0x02U，则返回0x03U；若创建Stream时没有配置flag，则返回0。<br>对于默认Stream，不同产品型号的flag值可能存在差异，应以本接口查询到的值为准。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
