# 5. Context管理

本章节描述 CANN Runtime 的 Context 管理接口，用于 Context 的创建、销毁、切换及参数配置。

- [`aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)`](#aclrtCreateContext)：在当前线程中显式创建Context。
- [`aclError aclrtDestroyContext(aclrtContext context)`](#aclrtDestroyContext)：销毁Context，释放Context的资源。
- [`aclError aclrtSetCurrentContext(aclrtContext context)`](#aclrtSetCurrentContext)：设置线程的Context。
- [`aclError aclrtGetCurrentContext(aclrtContext *context)`](#aclrtGetCurrentContext)：获取线程的Context。
- [`aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)`](#aclrtCtxSetSysParamOpt)：设置当前Context中的系统参数值，多次调用本接口，以最后一次设置的值为准。
- [`aclError aclrtCtxGetSysParamOpt(aclSysParamOpt opt, int64_t *value)`](#aclrtCtxGetSysParamOpt)：获取当前Context中的系统参数值。
- [`aclError aclrtCtxGetCurrentDefaultStream(aclrtStream *stream)`](#aclrtCtxGetCurrentDefaultStream)：获取Context上的默认Stream。
- [`aclError aclrtGetPrimaryCtxState(int32_t deviceId, uint32_t *flags, int32_t *active)`](#aclrtGetPrimaryCtxState)：获取默认Context的状态。
- [`aclError aclrtCtxGetFloatOverflowAddr(void **overflowAddr)`](#aclrtCtxGetFloatOverflowAddr)：饱和模式下，获取保存溢出标记的Device内存地址，该内存地址后续需作为Workspace参数传递给AI Core算子。

<a id="aclrtCreateContext"></a>

## aclrtCreateContext

```c
aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)
```

### 产品支持情况

<!-- npu="950" id330 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id330 -->
<!-- npu="A3" id331 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id331 -->
<!-- npu="910b" id332 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id332 -->
<!-- npu="310b" id333 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id333 -->
<!-- npu="310p" id334 -->
- Atlas 推理系列产品：支持
<!-- end id334 -->
<!-- npu="910" id335 -->
- Atlas 训练系列产品：支持
<!-- end id335 -->
<!-- npu="IPV350" id336 -->
- IPV350：支持
<!-- end id336 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id1 -->

### 功能说明

在当前线程中显式创建Context，并将当前线程与新创建的Context相关联。

若不调用aclrtCreateContext接口显式创建Context，那系统会使用默认Context，该默认Context是在调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口时隐式创建的。默认Context适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。显式创建的Context适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| context | 输出 | Context的指针。类型定义请参见[aclrtContext](25-05_Typedefs.md#aclrtContext)。 |
| deviceId | 输入 | 在指定的Device下创建Context。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 在某一进程中指定Device，该进程内的多个线程可共用在此Device上显式创建的Context。
- 若在某一进程内创建多个Context，Context的数量与Stream相关，Stream数量有限制，请参见显式创建Stream的接口。当前线程在同一时刻内只能使用其中一个Context，建议通过[aclrtSetCurrentContext](#aclrtSetCurrentContext)接口明确指定当前线程的Context，增加程序的可维护性**。**
- 调用本接口创建的Context中包含一个默认Stream。

    <!-- npu="310p" id1 -->
    Atlas 推理系列产品的EP标准形态除外，其Context中包含两个Stream：一个默认Stream和一个执行内部同步的Stream。
    <!-- end id1 -->

    <!-- npu="IPV350" id2 -->
    IPV350上不支持默认Comtext和默认Stream。
    <!-- end id2 -->
- 如果在应用程序中没有调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口，那么在首次调用aclrtCreateContext接口时，系统内部会根据该接口传入的Device ID，为该Device绑定一个默认Stream（一个Device仅绑定一个默认Stream），因此在首次调用aclrtCreateContext接口时，占用的Stream数量 = Device上绑定的默认Stream + Context中包含的Stream。
    
    <!-- npu="IPV350" id3 -->
    IPV350上不支持默认Comtext和默认Stream。
    <!-- end id3 -->

<br>
<br>
<br>

<a id="aclrtDestroyContext"></a>

## aclrtDestroyContext

```c
aclError aclrtDestroyContext(aclrtContext context)
```

### 产品支持情况

<!-- npu="950" id1954 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1954 -->
<!-- npu="A3" id1955 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1955 -->
<!-- npu="910b" id1956 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1956 -->
<!-- npu="310b" id1957 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1957 -->
<!-- npu="310p" id1958 -->
- Atlas 推理系列产品：支持
<!-- end id1958 -->
<!-- npu="910" id1959 -->
- Atlas 训练系列产品：支持
<!-- end id1959 -->
<!-- npu="IPV350" id1960 -->
- IPV350：支持
<!-- end id1960 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id2 -->

### 功能说明

销毁Context，释放Context的资源。只能销毁通过[aclrtCreateContext](#aclrtCreateContext)接口创建的Context。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| context | 输入 | 需销毁的Context。类型定义请参见[aclrtContext](25-05_Typedefs.md#aclrtContext)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetCurrentContext"></a>

## aclrtSetCurrentContext

```c
aclError aclrtSetCurrentContext(aclrtContext context)
```

### 产品支持情况

<!-- npu="950" id785 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id785 -->
<!-- npu="A3" id786 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id786 -->
<!-- npu="910b" id787 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id787 -->
<!-- npu="310b" id788 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id788 -->
<!-- npu="310p" id789 -->
- Atlas 推理系列产品：支持
<!-- end id789 -->
<!-- npu="910" id790 -->
- Atlas 训练系列产品：支持
<!-- end id790 -->
<!-- npu="IPV350" id791 -->
- IPV350：支持
<!-- end id791 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id3 -->

### 功能说明

设置线程的Context。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| context | 输入 | 指定线程当前的Context。类型定义请参见[aclrtContext](25-05_Typedefs.md#aclrtContext)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 支持以下场景：
    - 如果在某线程（例如：thread1）中调用[aclrtCreateContext](#aclrtCreateContext)接口显式创建一个Context（例如：ctx1），则可以不调用aclrtSetCurrentContext接口指定该线程的Context，系统默认将ctx1作为thread1的Context。
    - 如果没有调用[aclrtCreateContext](#aclrtCreateContext)接口显式创建Context，则系统将默认Context作为线程的Context，此时，不能通过[aclrtDestroyContext](#aclrtDestroyContext)接口来释放默认Context。
    - 如果多次调用aclrtSetCurrentContext接口设置线程的Context，以最后一次为准。

- 若给线程设置的Context所对应的Device已经被复位，则不能将该Context设置为线程的Context，否则会导致业务异常。
- 推荐在某一线程中创建的Context，在该线程中使用。若在线程A中调用[aclrtCreateContext](#aclrtCreateContext)接口创建Context，在线程B中使用该Context，则需由用户自行保证两个线程中同一个Context下同一个Stream中任务执行的顺序。
- 调用aclrtSetCurrentContext接口通过切换Context时，如果新Context与当前Context所属的Device不同时，Device也会随之切换。

<br>
<br>
<br>

<a id="aclrtGetCurrentContext"></a>

## aclrtGetCurrentContext

```c
aclError aclrtGetCurrentContext(aclrtContext *context)
```

### 产品支持情况

<!-- npu="950" id2829 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2829 -->
<!-- npu="A3" id2830 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2830 -->
<!-- npu="910b" id2831 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2831 -->
<!-- npu="310b" id2832 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2832 -->
<!-- npu="310p" id2833 -->
- Atlas 推理系列产品：支持
<!-- end id2833 -->
<!-- npu="910" id2834 -->
- Atlas 训练系列产品：支持
<!-- end id2834 -->
<!-- npu="IPV350" id2835 -->
- IPV350：支持
<!-- end id2835 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id4 -->

### 功能说明

获取线程的Context。

如果用户多次调用[aclrtSetCurrentContext](#aclrtSetCurrentContext)接口设置当前线程的Context，则获取的是最后一次设置的Context。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| context | 输出 | 线程当前Context的指针。类型定义请参见[aclrtContext](25-05_Typedefs.md#aclrtContext)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCtxSetSysParamOpt"></a>

## aclrtCtxSetSysParamOpt

```c
aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)
```

### 产品支持情况

<!-- npu="950" id3053 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3053 -->
<!-- npu="A3" id3054 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3054 -->
<!-- npu="910b" id3055 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3055 -->
<!-- npu="310b" id3056 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3056 -->
<!-- npu="310p" id3057 -->
- Atlas 推理系列产品：支持
<!-- end id3057 -->
<!-- npu="910" id3058 -->
- Atlas 训练系列产品：支持
<!-- end id3058 -->
<!-- npu="IPV350" id3059 -->
- IPV350：不支持
<!-- end id3059 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id5 -->

### 功能说明

设置当前Context中的系统参数值，多次调用本接口，以最后一次设置的值为准。调用本接口设置运行时参数值后，若需获取参数值，需调用[aclrtCtxGetSysParamOpt](#aclrtCtxGetSysParamOpt)接口。

本接口与[aclrtSetSysParamOpt](03_runtime_configuration.md#aclrtSetSysParamOpt)接口的差别是，本接口作用域是Context，aclrtSetSysParamOpt的作用域是进程。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opt | 输入 | 系统参数。类型定义请参见[aclSysParamOpt](25-02_Enumerations.md#aclSysParamOpt)。 |
| value | 输入 | 系统参数值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCtxGetSysParamOpt"></a>

## aclrtCtxGetSysParamOpt

```c
aclError aclrtCtxGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
```

### 产品支持情况

<!-- npu="950" id2115 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2115 -->
<!-- npu="A3" id2116 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2116 -->
<!-- npu="910b" id2117 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2117 -->
<!-- npu="310b" id2118 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2118 -->
<!-- npu="310p" id2119 -->
- Atlas 推理系列产品：支持
<!-- end id2119 -->
<!-- npu="910" id2120 -->
- Atlas 训练系列产品：支持
<!-- end id2120 -->
<!-- npu="IPV350" id2121 -->
- IPV350：不支持
<!-- end id2121 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id6 -->

### 功能说明

获取当前Context中的系统参数值。

系统参数无默认值，如果不调用[aclrtCtxSetSysParamOpt](#aclrtCtxSetSysParamOpt)接口设置系统参数的值，直接调用本接口获取系统参数的值，接口会返回失败。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opt | 输入 | 系统参数。类型定义请参见[aclSysParamOpt](25-02_Enumerations.md#aclSysParamOpt)。 |
| value | 输出 | 存放系统参数值的内存的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCtxGetCurrentDefaultStream"></a>

## aclrtCtxGetCurrentDefaultStream

```c
aclError aclrtCtxGetCurrentDefaultStream(aclrtStream *stream)
```

### 产品支持情况

<!-- npu="950" id1499 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1499 -->
<!-- npu="A3" id1500 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1500 -->
<!-- npu="910b" id1501 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1501 -->
<!-- npu="310b" id1502 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1502 -->
<!-- npu="310p" id1503 -->
- Atlas 推理系列产品：支持
<!-- end id1503 -->
<!-- npu="910" id1504 -->
- Atlas 训练系列产品：支持
<!-- end id1504 -->
<!-- npu="IPV350" id1505 -->
- IPV350：不支持
<!-- end id1505 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id7 -->

### 功能说明

获取Context上的默认Stream。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输出 | 获取到的默认Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetPrimaryCtxState"></a>

## aclrtGetPrimaryCtxState

```c
aclError aclrtGetPrimaryCtxState(int32_t deviceId, uint32_t *flags, int32_t *active)
```

### 产品支持情况

<!-- npu="950" id2787 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2787 -->
<!-- npu="A3" id2788 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2788 -->
<!-- npu="910b" id2789 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2789 -->
<!-- npu="310b" id2790 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2790 -->
<!-- npu="310p" id2791 -->
- Atlas 推理系列产品：支持
<!-- end id2791 -->
<!-- npu="910" id2792 -->
- Atlas 训练系列产品：支持
<!-- end id2792 -->
<!-- npu="IPV350" id2793 -->
- IPV350：不支持
<!-- end id2793 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id8 -->

### 功能说明

获取默认Context的状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | 获取指定Device下的默认Context。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| flags | 输出 | 预留参数。当前固定传NULL。 |
| active | 输出 | 存放默认Context状态的指针。<br>状态值如下：<br><br>  - 0：未激活<br>  - 1：激活 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCtxGetFloatOverflowAddr"></a>

## aclrtCtxGetFloatOverflowAddr

```c
aclError aclrtCtxGetFloatOverflowAddr(void **overflowAddr)
```

### 产品支持情况

<!-- npu="950" id610 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id610 -->
<!-- npu="A3" id611 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id611 -->
<!-- npu="910b" id612 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id612 -->
<!-- npu="310b" id613 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id613 -->
<!-- npu="310p" id614 -->
- Atlas 推理系列产品：支持
<!-- end id614 -->
<!-- npu="910" id615 -->
- Atlas 训练系列产品：支持
<!-- end id615 -->
<!-- npu="IPV350" id616 -->
- IPV350：不支持
<!-- end id616 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id9 -->

### 功能说明

饱和模式下，获取保存溢出标记的Device内存地址，该内存地址后续需作为Workspace参数传递给AI Core算子。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| overflowAddr | 输出 | 保存溢出标记的Device内存地址。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
