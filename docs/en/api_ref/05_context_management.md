# 5. Context Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:14:03.987Z pushedAt=2026-11-09T07:49:33.114Z nl=2 -->

This section describes the context management APIs of CANN Runtime, used for creating, destroying, and switching contexts and configuring parameters.

- [`aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)`](#aclrtCreateContext): Explicitly creates a context in the current thread.
- [`aclError aclrtDestroyContext(aclrtContext context)`](#aclrtDestroyContext): Destroys a context and releases its resources.
- [`aclError aclrtSetCurrentContext(aclrtContext context)`](#aclrtSetCurrentContext): Sets the context of a thread.
- [`aclError aclrtGetCurrentContext(aclrtContext *context)`](#aclrtGetCurrentContext): Obtains the context of a thread.
- [`aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)`](#aclrtCtxSetSysParamOpt): Sets the value of a system parameter in the current context. If this API is called multiple times, the last set value takes effect.
- [`aclError aclrtCtxGetSysParamOpt(aclSysParamOpt opt, int64_t *value)`](#aclrtCtxGetSysParamOpt): Obtains the value of a system parameter in the current context.
- [`aclError aclrtCtxGetCurrentDefaultStream(aclrtStream *stream)`](#aclrtCtxGetCurrentDefaultStream): Obtains the default stream on a context.
- [`aclError aclrtGetPrimaryCtxState(int32_t deviceId, uint32_t *flags, int32_t *active)`](#aclrtGetPrimaryCtxState): Obtains the status of the default context.
- [`aclError aclrtCtxGetFloatOverflowAddr(void **overflowAddr)`](#aclrtCtxGetFloatOverflowAddr): In saturation mode, obtains the device memory address that stores the overflow flag. The address must later be passed to the AI Core operator as the workspace parameter.

<a class="method_anchor" id="aclrtCreateContext"></a>

## aclrtCreateContext

```c
aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)
```

### Applicable Products

<!-- npu="950" id330 -->
- Ascend 950PR&950DT products: Supported
<!-- end id330 -->
<!-- npu="A3" id331 -->
- Atlas A3 products: Supported
<!-- end id331 -->
<!-- npu="910b" id332 -->
- Atlas A2 products: Supported
<!-- end id332 -->
<!-- npu="310b" id333 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id333 -->
<!-- npu="310p" id334 -->
- Atlas inference products: Supported
<!-- end id334 -->
<!-- npu="910" id335 -->
- Atlas training products: Supported
<!-- end id335 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id1 -->

### Description

Explicitly creates a context in the current thread and associates the current thread with the newly created context.

If aclrtCreateContext is not explicitly called to create a context, the system uses the default context, which is implicitly created when [aclrtSetDevice](04_device_management.md#aclrtSetDevice) is called. The default context is suitable for simple applications with no complex interaction logic. However, in multi-thread programming, execution results depend on the thread scheduling sequence. A context created explicitly is suitable for large applications with complex interaction logic and improves program readability and maintainability.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| context | Output | Points to the context. See [aclrtContext](25-05_Typedefs.md#aclrtContext) for the type definition. |
| deviceId | Input | Creates a context on the specified device.<br>The value range is [0, (Available device count – 1)] after the available device count is obtained by calling [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- After a device is specified in a process, multiple threads in the process can share the context explicitly created on the device.
- If multiple contexts are created in a process, the quantity of contexts is related to streams, while streams have a limited count. For details, see the API for explicitly creating streams. The current thread can use only one of the contexts at a time. You are advised to explicitly specify the context of the current thread by using [aclrtSetCurrentContext](#aclrtSetCurrentContext) to improve program maintainability.
- A context created by calling this API contains a default stream.

    <!-- npu="310p" id1 -->
    Except for the EP standard form of Atlas inference products, the context contains two streams: a default stream and a stream for internal synchronization.
    <!-- end id1 -->

- If [aclrtSetDevice](04_device_management.md#aclrtSetDevice) is not called in an application, when aclrtCreateContext is called for the first time, the system internally binds a default stream to the device based on the device ID passed to this API (only one default stream is bound to a device). Therefore, when aclrtCreateContext is called for the first time, the quantity of occupied streams equals the number of the default stream bound to the device plus the number of streams contained in the context.
    
<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyContext"></a>

## aclrtDestroyContext

```c
aclError aclrtDestroyContext(aclrtContext context)
```

### Applicable Products

<!-- npu="950" id1954 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1954 -->
<!-- npu="A3" id1955 -->
- Atlas A3 products: Supported
<!-- end id1955 -->
<!-- npu="910b" id1956 -->
- Atlas A2 products: Supported
<!-- end id1956 -->
<!-- npu="310b" id1957 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1957 -->
<!-- npu="310p" id1958 -->
- Atlas inference products: Supported
<!-- end id1958 -->
<!-- npu="910" id1959 -->
- Atlas training products: Supported
<!-- end id1959 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id2 -->

### Description

Destroys a context and releases its resources. Only a context created by calling [aclrtCreateContext](#aclrtCreateContext) can be destroyed.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| context | Input | Context to be destroyed. For the type definition, see [aclrtContext](25-05_Typedefs.md#aclrtContext). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetCurrentContext"></a>

## aclrtSetCurrentContext

```c
aclError aclrtSetCurrentContext(aclrtContext context)
```

### Applicable Products

<!-- npu="950" id785 -->
- Ascend 950PR&950DT products: Supported
<!-- end id785 -->
<!-- npu="A3" id786 -->
- Atlas A3 products: Supported
<!-- end id786 -->
<!-- npu="910b" id787 -->
- Atlas A2 products: Supported
<!-- end id787 -->
<!-- npu="310b" id788 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id788 -->
<!-- npu="310p" id789 -->
- Atlas inference products: Supported
<!-- end id789 -->
<!-- npu="910" id790 -->
- Atlas training products: Supported
<!-- end id790 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id3 -->

### Description

Sets the context of a thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| context | Input | Context to be set as the current context of a thread. For the type definition, see [aclrtContext](25-05_Typedefs.md#aclrtContext). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The following use cases are supported:
    - If a context (e.g. ctx1) is explicitly created by calling [aclrtCreateContext](#aclrtCreateContext) in a thread (e.g. thread1), you do not need to call aclrtSetCurrentContext to specify the context of the thread. By default, ctx1 is used as the context of thread1.
    - If no context is explicitly created by calling [aclrtCreateContext](#aclrtCreateContext), the system uses the default context as the context of the thread. In this case, the default context cannot be released by calling [aclrtDestroyContext](#aclrtDestroyContext).
    - If aclrtSetCurrentContext is called multiple times to set the context of a thread, the last call takes effect.

- If the device corresponding to the context set for a thread has been reset, the context cannot be set as the context of the thread. Otherwise, services may become abnormal.
- It is recommended that a context created in a thread be used in that thread. If a context is created by calling [aclrtCreateContext](#aclrtCreateContext) in thread A and used in thread B, you need to ensure the execution order of tasks in the same stream under the same context in the two threads.
- When the context is switched by calling aclrtSetCurrentContext, if the device of the new context is different from that of the current context, the device is also switched.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetCurrentContext"></a>

## aclrtGetCurrentContext

```c
aclError aclrtGetCurrentContext(aclrtContext *context)
```

### Applicable Products

<!-- npu="950" id2829 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2829 -->
<!-- npu="A3" id2830 -->
- Atlas A3 products: Supported
<!-- end id2830 -->
<!-- npu="910b" id2831 -->
- Atlas A2 products: Supported
<!-- end id2831 -->
<!-- npu="310b" id2832 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2832 -->
<!-- npu="310p" id2833 -->
- Atlas inference products: Supported
<!-- end id2833 -->
<!-- npu="910" id2834 -->
- Atlas training products: Supported
<!-- end id2834 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id4 -->

### Description

Obtains the context of a thread.

If [aclrtSetCurrentContext](#aclrtSetCurrentContext) is called multiple times to set the context of the current thread, the context set in the last call is obtained.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| context | Output | Pointer to the current context of the thread. For details about the type definition, see [aclrtContext](25-05_Typedefs.md#aclrtContext). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCtxSetSysParamOpt"></a>

## aclrtCtxSetSysParamOpt

```c
aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)
```

### Applicable Products

<!-- npu="950" id3053 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3053 -->
<!-- npu="A3" id3054 -->
- Atlas A3 products: Supported
<!-- end id3054 -->
<!-- npu="910b" id3055 -->
- Atlas A2 products: Supported
<!-- end id3055 -->
<!-- npu="310b" id3056 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3056 -->
<!-- npu="310p" id3057 -->
- Atlas inference products: Supported
<!-- end id3057 -->
<!-- npu="910" id3058 -->
- Atlas training products: Supported
<!-- end id3058 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id5 -->

### Description

Sets the system parameter in the current context. If this API is called multiple times, the value set in the last call takes effect. After using this API to set the runtime parameter, call [aclrtCtxGetSysParamOpt](#aclrtCtxGetSysParamOpt) to obtain the value.

This API differs from [aclrtSetSysParamOpt](03_runtime_configuration.md#aclrtSetSysParamOpt) in that this API takes effect on a context, while aclrtSetSysParamOpt takes effect on a process.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opt | Input | System parameter. For the type definition, see [aclSysParamOpt](25-02_Enumerations.md#aclSysParamOpt). |
| value | Input | System parameter value. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCtxGetSysParamOpt"></a>

## aclrtCtxGetSysParamOpt

```c
aclError aclrtCtxGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
```

### Applicable Products

<!-- npu="950" id2115 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2115 -->
<!-- npu="A3" id2116 -->
- Atlas A3 products: Supported
<!-- end id2116 -->
<!-- npu="910b" id2117 -->
- Atlas A2 products: Supported
<!-- end id2117 -->
<!-- npu="310b" id2118 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2118 -->
<!-- npu="310p" id2119 -->
- Atlas inference products: Supported
<!-- end id2119 -->
<!-- npu="910" id2120 -->
- Atlas training products: Supported
<!-- end id2120 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id6 -->

### Description

Obtains the system parameter value in the current context.

A system parameter has no default value. If [aclrtCtxSetSysParamOpt](#aclrtCtxSetSysParamOpt) is not called to set the system parameter value, calling this API to obtain the value fails.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opt | Input | System parameter. For the type definition, see [aclSysParamOpt](25-02_Enumerations.md#aclSysParamOpt). |
| value | Output | Pointer to the memory that stores the system parameter value. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCtxGetCurrentDefaultStream"></a>

## aclrtCtxGetCurrentDefaultStream

```c
aclError aclrtCtxGetCurrentDefaultStream(aclrtStream *stream)
```

### Applicable Products

<!-- npu="950" id1499 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1499 -->
<!-- npu="A3" id1500 -->
- Atlas A3 products: Supported
<!-- end id1500 -->
<!-- npu="910b" id1501 -->
- Atlas A2 products: Supported
<!-- end id1501 -->
<!-- npu="310b" id1502 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1502 -->
<!-- npu="310p" id1503 -->
- Atlas inference products: Supported
<!-- end id1503 -->
<!-- npu="910" id1504 -->
- Atlas training products: Supported
<!-- end id1504 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id7 -->

### Description

Obtains the default stream on the context.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Output | Default stream obtained. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

0: success; others: failure. See [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetPrimaryCtxState"></a>

## aclrtGetPrimaryCtxState

```c
aclError aclrtGetPrimaryCtxState(int32_t deviceId, uint32_t *flags, int32_t *active)
```

### Applicable Products

<!-- npu="950" id2787 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2787 -->
<!-- npu="A3" id2788 -->
- Atlas A3 products: Supported
<!-- end id2788 -->
<!-- npu="910b" id2789 -->
- Atlas A2 products: Supported
<!-- end id2789 -->
<!-- npu="310b" id2790 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2790 -->
<!-- npu="310p" id2791 -->
- Atlas inference products: Supported
<!-- end id2791 -->
<!-- npu="910" id2792 -->
- Atlas training products: Supported
<!-- end id2792 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id8 -->

### Description

Obtains the state of the default context.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Obtains the default context on the specified device.<br>After calling [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (Available device count – 1)]. |
| flags | Output | Reserved parameter. Currently fixed to NULL. |
| active | Output | Pointer to the state of the default context.<br>Options:<br><br>  - `0`: inactive<br>  - `1`: active |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCtxGetFloatOverflowAddr"></a>

## aclrtCtxGetFloatOverflowAddr

```c
aclError aclrtCtxGetFloatOverflowAddr(void **overflowAddr)
```

### Applicable Products

<!-- npu="950" id610 -->
- Ascend 950PR&950DT products: Supported
<!-- end id610 -->
<!-- npu="A3" id611 -->
- Atlas A3 products: Supported
<!-- end id611 -->
<!-- npu="910b" id612 -->
- Atlas A2 products: Supported
<!-- end id612 -->
<!-- npu="310b" id613 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id613 -->
<!-- npu="310p" id614 -->
- Atlas inference products: Supported
<!-- end id614 -->
<!-- npu="910" id615 -->
- Atlas training products: Supported
<!-- end id615 -->
<!-- @ref: runtime/res/docs/zh/api_ref/05_context_management_res.md#id9 -->

### Description

Obtains the device memory address that stores the overflow flag in the saturation mode. The memory address must then be passed to the AI Core operator as a workspace parameter.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| overflowAddr | Output | Device memory address that stores the overflow flag. |

### Return Values

0: success; others: failure. See Also [aclError](25-01_aclError.md#aclError).
