# 24. Other APIs

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-26T12:55:41.431Z pushedAt=2026-10-29T03:31:58.989Z -->

This topic describes other auxiliary APIs of CANN Runtime, including version query, data type conversion, and platform hardware information query.

- [`void aclAppLog(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, ...)`](#aclapplog): Records logs to a log file.
- [`size_t aclDataTypeSize(aclDataType dataType)`](#aclDataTypeSize): Obtains the size of data of the **aclDataType** type, in bytes.
- [`float aclFloat16ToFloat(aclFloat16 value)`](#aclFloat16ToFloat): Converts data of the [aclFloat16](25-05_Typedefs.md#aclFloat16) type to data of the float (float32) type.
- [`aclFloat16 aclFloatToFloat16(float value)`](#aclFloatToFloat16): Converts data of the float (float32) type to data of the [aclFloat16](25-05_Typedefs.md#aclFloat16) type.
- [`aclError aclrtGetVersion(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion)`](#aclrtGetVersion): Obtains the API version number. The acl API version number uses the A.B.C naming pattern, where A indicates incompatible modifications, B indicates newly added APIs, and C indicates bug fixes. (Deprecated API. Use the **aclsysGetVersionNum** or the **aclsysGetVersionStr** API instead.)
- [`aclError aclsysGetCANNVersion(aclCANNPackageName name, aclCANNPackageVersion *version)`](#aclsysGetCANNVersion): Obtains the CANN software package version number.
- [`aclError aclGetCannAttributeList(const aclCannAttr **cannAttrList, size_t *num)`](#aclGetCannAttributeList): Obtains the list of features supported by the CANN software and the corresponding AI processors in the runtime environment.
- [`aclError aclGetCannAttribute(aclCannAttr cannAttr, int32_t *value)`](#aclGetCannAttribute): Obtains whether the runtime environment supports the specified CANN feature.
- [`aclError aclGetDeviceCapability(uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t *value)`](#aclGetDeviceCapability): Obtains the hardware specification size of the corresponding device in the runtime environment.
- [`aclError aclrtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)`](#aclrtCacheLastTaskOpInfo): Caches the operator information in the specified memory to the last dispatched task in the current thread according to **infoSize** in the scenario of building a model running instance based on the capture method.
- [`aclError aclrtCacheLastTaskExtendInfo(const char* const extendInfoPtr, const size_t infoSize)`](#aclrtCacheLastTaskExtendInfo): Caches the custom extension information in the specified memory to the last dispatched task in the current thread according to **infoSize**.
- [`aclError aclrtProfTrace(void *userdata, int32_t length, aclrtStream stream)`](#aclrtProfTrace): Allows users to dispatch custom profiling markers at specified positions in the network. This is an asynchronous API.
- [`aclError aclsysGetVersionNum(char *pkgName, int32_t *versionNum)`](#aclsysGetVersionNum): Obtains the version number by package name. The version number is a numeric type, obtained by calculating the weights of the major, minor, patch, and other version information in the **version** field of the **version.info** file in the installation directory of each package.
- [`aclError aclsysGetVersionStr(char *pkgName, char *versionStr)`](#aclsysGetVersionStr): Obtains the version number by package name. The version number is a string type and remains consistent with the value of **version** in the **version.info** file in the installation directory of each package.
- [`aclError aclplatformGetDeviceInfo(aclplatformDevInfo infoType, char *value, uint32_t maxLen)`](#aclplatformGetDeviceInfo): Obtains the hardware information of the corresponding AI processor model.
- [`aclError aclplatformGetInstructionInfo(aclplatformCoreType type, const char *instruction, char *value, uint32_t maxLen)`](#aclplatformGetInstructionInfo): Obtains the related attribute information of the specified instruction based on the core type.
- [`aclError aclrtCreateStreamV2(aclrtStream *stream, const aclrtStreamConfigHandle *handle)`](#aclrtCreateStreamV2): Creates a stream and supports adding stream configuration when creating the stream.
- [`aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle, aclrtStreamConfigAttr attr, const void *attrValue, size_t valueSize)`](#aclrtSetStreamConfigOpt): Sets attributes in the stream configuration object.
- [`aclError aclrtSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)`](#aclrtSubscribeHostFunc): Subscribes to the thread that processes callback functions on the stream (the thread must be created by the user).
- [`aclError aclrtProcessHostFunc(int32_t timeout)`](#aclrtProcessHostFunc): Waits for specified time, after which callback processing is triggered. The callback is processed by the thread specified by the [aclrtSubscribeHostFunc](#aclrtSubscribeHostFunc) API.
- [`aclError aclrtUnSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)`](#aclrtUnSubscribeHostFunc): Unsubscribes from the thread after the model execution API is called. This API is used together with the [aclrtSubscribeHostFunc](#aclrtSubscribeHostFunc) API. In this way, the callback function on the stream is no longer processed by the specified thread.

## aclAppLog

```c
void aclAppLog(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, ...)
```

### Applicable Products

<!-- npu="950" id1730 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1730 -->
<!-- npu="A3" id1731 -->
- Atlas A3 products: Supported
<!-- end id1731 -->
<!-- npu="910b" id1732 -->
- Atlas A2 products: Supported
<!-- end id1732 -->
<!-- npu="310b" id1733 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1733 -->
<!-- npu="310p" id1734 -->
- Atlas inference products: Supported
<!-- end id1734 -->
<!-- npu="910" id1735 -->
- Atlas training products: Supported
<!-- end id1735 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id1 -->

### Description

Records logs to a log file.

The acl API also provides the **ACL\_APP\_LOG** macro, which encapsulates the **aclAppLog** API. Users are recommended to call the **ACL\_APP\_LOG** macro and pass the log level, log description, and variable parameters in **fmt**.

```c
#define ACL_APP_LOG(level, fmt, ...) \
    aclAppLog(level, __FUNCTION__, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
```

### Parameters

| Name | Input/Output | Description |
| --- | --- | --- |
| logLevel | Input | Log level.<br>typedef enum {<br>   ACL_DEBUG = 0,<br>   ACL_INFO = 1,<br>   ACL_WARNING = 2,<br>   ACL_ERROR = 3,<br>} aclLogLevel; |
| func | Input | API in which the user calls **aclAppLog**, which is fixed to **__FUNCTION__**. |
| file | Input | File in which the user calls **aclAppLog**, which is fixed to **__FILE__**. |
| line | Input | Line at which the user calls **aclAppLog**, which is fixed to **__LINE__**. |
| fmt | Input | Log description.<br>When a formatting function is called, the types and number of parameters in **fmt** must remain consistent with the actual parameter types and number. |
| ... | Input | Variable parameters in **fmt**, added based on the log content.<br>The maximum length of a single log is 1024 bytes. Logs exceeding this length are truncated. |

### Return Values

None

### Examples

```c
// If fmt contains variable parameters, define them in advance.
uint32_t modelId = 1;
ACL_APP_LOG(ACL_INFO, "load model success, modelId is %u", modelId);
```

<br>
<br>
<br>

<a class="method_anchor" id="aclDataTypeSize"></a>

## aclDataTypeSize

```c
size_t aclDataTypeSize(aclDataType dataType)
```

### Applicable Products

<!-- npu="950" id239 -->
- Ascend 950PR&950DT products: Supported
<!-- end id239 -->
<!-- npu="A3" id240 -->
- Atlas A3 products: Supported
<!-- end id240 -->
<!-- npu="910b" id241 -->
- Atlas A2 products: Supported
<!-- end id241 -->
<!-- npu="310b" id242 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id242 -->
<!-- npu="310p" id243 -->
- Atlas inference products: Supported
<!-- end id243 -->
<!-- npu="910" id244 -->
- Atlas training products: Supported
<!-- end id244 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id2 -->

### Description

Obtains the size of data of the **aclDataType** type, in bytes.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dataType | Input | Data of the **aclDataType** type whose size is to be obtained. For details about the type definition, see [aclDataType](25-02_Enumerations.md#aclDataType). |

### Return Values

Returns the size of data of the **aclDataType** type, in bytes.

<br>
<br>
<br>

<a class="method_anchor" id="aclFloat16ToFloat"></a>

## aclFloat16ToFloat

```c
float aclFloat16ToFloat(aclFloat16 value)
```

### Applicable Products

<!-- npu="950" id2507 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2507 -->
<!-- npu="A3" id2508 -->
- Atlas A3 products: Supported
<!-- end id2508 -->
<!-- npu="910b" id2509 -->
- Atlas A2 products: Supported
<!-- end id2509 -->
<!-- npu="310b" id2510 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2510 -->
<!-- npu="310p" id2511 -->
- Atlas inference products: Supported
<!-- end id2511 -->
<!-- npu="910" id2512 -->
- Atlas training products: Supported
<!-- end id2512 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id3 -->

### Description

Converts data of the [aclFloat16](25-05_Typedefs.md#aclFloat16) type to data of the float (float32) type.

For special values such as **NaN** and **Inf**, this API does not preserve their semantics, and the conversion result is an ordinary finite value: FP16 +Inf (0x7C00) is converted to 65536.0, FP16 -Inf (0xFC00) is converted to -65536.0, and FP16 NaN (0x7E00) is converted to 98304.0. This behavior is fixed and does not vary with the floating-point computation result output mode of the device (which can be queried through [aclrtGetDeviceSatMode](04_device_management.md#aclrtGetDeviceSatMode). For details about the mode, see [aclrtFloatOverflowMode](25-02_Enumerations.md#aclrtFloatOverflowMode)), and it applies to all forms. To preserve **NaN**/**Inf** semantics for precision debugging, you are advised to generate **NaN**/**Inf** directly in operator computation rather than constructing them through this API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| value | Input | Data to be converted. For details about the type definition, see [aclFloat16](25-05_Typedefs.md#aclFloat16). |

### Return Values

Returns the converted data.

<br>
<br>
<br>

<a class="method_anchor" id="aclFloatToFloat16"></a>

## aclFloatToFloat16

```c
aclFloat16 aclFloatToFloat16(float value)
```

### Applicable Products

<!-- npu="950" id3102 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3102 -->
<!-- npu="A3" id3103 -->
- Atlas A3 products: Supported
<!-- end id3103 -->
<!-- npu="910b" id3104 -->
- Atlas A2 products: Supported
<!-- end id3104 -->
<!-- npu="310b" id3105 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3105 -->
<!-- npu="310p" id3106 -->
- Atlas inference products: Supported
<!-- end id3106 -->
<!-- npu="910" id3107 -->
- Atlas training products: Supported
<!-- end id3107 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id4 -->

### Description

Converts data of the float (float32) type to data of the [aclFloat16](25-05_Typedefs.md#aclFloat16) type.

For special values such as **NaN** and **Inf**, this API processes them in saturation mode: both **NaN** and **Inf** are converted to the FP16 maximum value **65504.0** (0x7BFF), and negative **Inf** is converted to **-65504.0** (0xFBFF). This behavior is fixed and does not vary with the floating-point computation result output mode of the device (which can be queried through [aclrtGetDeviceSatMode](04_device_management.md#aclrtGetDeviceSatMode). For the mode description, see [aclrtFloatOverflowMode](25-02_Enumerations.md#aclrtFloatOverflowMode)), and it applies to all forms. To preserve **NaN**/**Inf** semantics for precision debugging, you are advised to generate **NaN**/**Inf** directly in operator computation rather than constructing them through this API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| value | Input | Data to be converted. |

### Return Values

Returns the converted data.

**Note**: Because the C language has no float16 type, the return value here uses uint16\_t to store the data. If users need to print it, they must interpret uint16\_t as float16 for printing, or convert it to float for printing.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetVersion"></a>

## aclrtGetVersion (Deprecated)

```c
aclError aclrtGetVersion(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion)
```

**Caution: This API will be deprecated in later versions. Use aclsysGetVersionNum or aclsysGetVersionStr instead.**

### Applicable Products

<!-- npu="950" id477 -->
- Ascend 950PR&950DT products: Supported
<!-- end id477 -->
<!-- npu="A3" id478 -->
- Atlas A3 products: Supported
<!-- end id478 -->
<!-- npu="910b" id479 -->
- Atlas A2 products: Supported
<!-- end id479 -->
<!-- npu="310b" id480 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id480 -->
<!-- npu="310p" id481 -->
- Atlas inference products: Supported
<!-- end id481 -->
<!-- npu="910" id482 -->
- Atlas training products: Supported
<!-- end id482 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id5 -->

### Description

Obtains the API version number. The acl API version number uses the A.B.C naming pattern, where A indicates incompatible modifications, B indicates newly added APIs, and C indicates bug fixes.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| majorVersion | Output | Pointer to the major version number, starting from 1. It increments by 1 when an incompatible modification occurs in the API. |
| minorVersion | Output | Pointer to the minor version number, starting from 0. It increments by 1 when a new API is added in an iteration cycle. |
| patchVersion | Output | Pointer to the patch version number, starting from 0, indicating that this version only resolves issues.<br>It increments by 1 when **majorVersion** and **minorVersion** remain unchanged; however, when **majorVersion** or **minorVersion** increases, **patchVersion** is generally 0. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclsysGetCANNVersion"></a>

## aclsysGetCANNVersion (Deprecated)

```c
aclError aclsysGetCANNVersion(aclCANNPackageName name, aclCANNPackageVersion *version)
```

**Caution: This API will be deprecated in later versions. Use [aclsysGetVersionStr](#aclsysGetVersionStr) or [aclsysGetVersionNum](#aclsysGetVersionNum) instead.**

### Applicable Products

<!-- npu="950" id3179 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3179 -->
<!-- npu="A3" id3180 -->
- Atlas A3 products: Supported
<!-- end id3180 -->
<!-- npu="910b" id3181 -->
- Atlas A2 products: Supported
<!-- end id3181 -->
<!-- npu="310b" id3182 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3182 -->
<!-- npu="310p" id3183 -->
- Atlas inference products: Supported
<!-- end id3183 -->
<!-- npu="910" id3184 -->
- Atlas training products: Supported
<!-- end id3184 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id6 -->

### Description

Obtains the CANN software package version number.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| name | Input | Package to query. For details about the type definition, see [aclCANNPackageName](25-02_Enumerations.md#aclCANNPackageName).<br>If the package to query is not installed, this API returns an error. |
| version | Output | CANN software package version number. For details about the type definition, see [aclCANNPackageVersion](25-04_Structs.md#aclCANNPackageVersion). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclGetCannAttributeList"></a>

## aclGetCannAttributeList

```c
aclError aclGetCannAttributeList(const aclCannAttr **cannAttrList, size_t *num)
```

### Applicable Products

<!-- npu="950" id141 -->
- Ascend 950PR&950DT products: Supported
<!-- end id141 -->
<!-- npu="A3" id142 -->
- Atlas A3 products: Supported
<!-- end id142 -->
<!-- npu="910b" id143 -->
- Atlas A2 products: Supported
<!-- end id143 -->
<!-- npu="310b" id144 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id144 -->
<!-- npu="310p" id145 -->
- Atlas inference products: Supported
<!-- end id145 -->
<!-- npu="910" id146 -->
- Atlas training products: Supported
<!-- end id146 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id7 -->

### Description

Obtains the list of features supported by the CANN software and the corresponding AI processors in the runtime environment.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| cannAttrList | Output | Array of feature enumerations supported by the runtime environment. For details about the type definition, see [aclCannAttr](25-02_Enumerations.md#aclCannAttr).<br>The user does not need to request memory in advance. The memory is automatically released when the application process exits. |
| num | Output | Number of supported features, which remains consistent with the length of the **cannAttrList** array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclGetCannAttribute"></a>

## aclGetCannAttribute

```c
aclError aclGetCannAttribute(aclCannAttr cannAttr, int32_t *value)
```

### Applicable Products

<!-- npu="950" id1149 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1149 -->
<!-- npu="A3" id1150 -->
- Atlas A3 products: Supported
<!-- end id1150 -->
<!-- npu="910b" id1151 -->
- Atlas A2 products: Supported
<!-- end id1151 -->
<!-- npu="310b" id1152 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1152 -->
<!-- npu="310p" id1153 -->
- Atlas inference products: Supported
<!-- end id1153 -->
<!-- npu="910" id1154 -->
- Atlas training products: Supported
<!-- end id1154 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id8 -->

### Description

Obtains whether the runtime environment supports the specified CANN feature.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| cannAttr | Input | Enumerated value of the feature list. Only one item can be specified per query. For details about the type definition, see [aclCannAttr](25-02_Enumerations.md#aclCannAttr). |
| value | Output | Whether the feature is supported:<br><br>  - **1**: supported<br>  - **0**: not supported |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclGetDeviceCapability"></a>

## aclGetDeviceCapability

```c
aclError aclGetDeviceCapability(uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t *value)
```

### Applicable Products

<!-- npu="950" id1373 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1373 -->
<!-- npu="A3" id1374 -->
- Atlas A3 products: Supported
<!-- end id1374 -->
<!-- npu="910b" id1375 -->
- Atlas A2 products: Supported
<!-- end id1375 -->
<!-- npu="310b" id1376 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1376 -->
<!-- npu="310p" id1377 -->
- Atlas inference products: Supported
<!-- end id1377 -->
<!-- npu="910" id1378 -->
- Atlas training products: Supported
<!-- end id1378 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id9 -->

### Description

Obtains the hardware specification size of the corresponding device in the runtime environment.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>After the user calls [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (Number of available devices - 1)]. |
| deviceInfo | Input | Hardware specification type on the specified device. For details about the type definition, see [aclDeviceInfo](25-02_Enumerations.md#aclDeviceInfo). |
| value | Output | Hardware specification value. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCacheLastTaskOpInfo"></a>

## aclrtCacheLastTaskOpInfo

```c
aclError aclrtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
```

### Applicable Products

<!-- npu="950" id1121 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1121 -->
<!-- npu="A3" id1122 -->
- Atlas A3 products: Supported
<!-- end id1122 -->
<!-- npu="910b" id1123 -->
- Atlas A2 products: Supported
<!-- end id1123 -->
<!-- npu="310b" id1124 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1124 -->
<!-- npu="310p" id1125 -->
- Atlas inference products: Supported
<!-- end id1125 -->
<!-- npu="910" id1126 -->
- Atlas training products: Not supported
<!-- end id1126 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id10 -->

### Description

Caches the operator information in the specified memory to the last dispatched task in the current thread according to **infoSize** in the scenario of building a model running instance based on the capture method.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **infoPtr** | Input | Memory address pointer of the cached information, which is host memory. |
| **infoSize** | Input | Memory size of the cached information. Value range: (0, 64KB], in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### API Call Flow

This API must be used together with the following other key APIs to control the attachment of operator information when performance data is collected later:

1. Call the [aclmdlRICaptureBegin](15_model_running_instance_management.md#aclmdlRICaptureBegin) API to start capturing a task.
2. Call the [aclrtSetStreamAttribute](06_stream_management.md#aclrtSetStreamAttribute) API to enable operator information cache.
3. Dispatch the operator execution task, for example, by calling the [aclrtLaunchKernelWithConfig](14_Kernel_loading_and_execution.md#aclrtLaunchKernelWithConfig) API.
4. Call the [aclrtGetStreamAttribute](06_stream_management.md#aclrtGetStreamAttribute) API to obtain whether operator information cache is enabled.

    Only in the capture state, and after operator information cache is enabled through the [aclrtSetStreamAttribute](06_stream_management.md#aclrtSetStreamAttribute) API, can the [aclrtGetStreamAttribute](06_stream_management.md#aclrtGetStreamAttribute) API here obtain the enabled state of operator information cache, so that operator information can be cached subsequently.

5. Call the [aclrtCacheLastTaskOpInfo](#aclrtCacheLastTaskOpInfo) API to cache the operator information.
6. Call the [aclrtSetStreamAttribute](06_stream_management.md#aclrtSetStreamAttribute) API again to disable operator information cache.
7. Call the [aclmdlRICaptureEnd](15_model_running_instance_management.md#aclmdlRICaptureEnd) API to end capturing the task.
8. After enabling performance data collection (see the APIs in the [Profiling APIs](19-01_data_profiling_apis.md) section), call [aclmdlRIExecuteAsync](15_model_running_instance_management.md#aclmdlRIExecuteAsync) to execute inference.

    During this process, the collected performance data carries operator information.

9. Finally, when [aclmdlRIDestroy](15_model_running_instance_management.md#aclmdlRIDestroy) is called to destroy the model running instance, the operator cache information is also released.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCacheLastTaskExtendInfo"></a>

## aclrtCacheLastTaskExtendInfo

```c
aclError aclrtCacheLastTaskExtendInfo(const char* const extendInfoPtr, const size_t infoSize)
```

### Applicable Products

<!-- npu="950" id1212 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1212 -->
<!-- npu="A3" id1213 -->
- Atlas A3 products: Supported
<!-- end id1213 -->
<!-- npu="910b" id1214 -->
- Atlas A2 products: Supported
<!-- end id1214 -->
<!-- npu="310b" id1215 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1215 -->
<!-- npu="310p" id1216 -->
- Atlas inference products: Supported
<!-- end id1216 -->
<!-- npu="910" id1217 -->
- Atlas training products: Not supported
<!-- end id1217 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id11 -->

### Description

Caches the custom extension information in the specified memory to the last dispatched task in the current thread according to **infoSize**. Subsequently, the custom extension information can be exported to a file in JSON format by calling the [aclmdlRIDebugJsonPrint](15_model_running_instance_management.md#aclmdlRIDebugJsonPrint) API, and then viewed through tracing (for example, **chrome://tracing/**). Currently, this API is supported only in the scenarios of capturing a model (see the [aclmdlRICaptureBegin](15_model_running_instance_management.md#aclmdlRICaptureBegin) API) or building a model running instance (see the [aclmdlRIBuildBegin](15_model_running_instance_management.md#aclmdlRIBuildBegin) API).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| extendInfoPtr | Input | Pointer to the memory address of the custom extension information, which is host memory. The content in the memory pointed to by `extendInfoPtr` must be a JSON format string encoded in UTF-8. A JSON format string that is not encoded in UTF-8 may cause undefined behavior when the [aclmdlRIDebugJsonPrint](15_model_running_instance_management.md#aclmdlRIDebugJsonPrint) API is subsequently called. |
| infoSize | Input | Size of the custom extension information memory, in bytes. Value range: (0, 4KB]. When the value of `infoSize` is greater than 4 KB, only the first 4 KB is cached. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtProfTrace"></a>

## aclrtProfTrace

```c
aclError aclrtProfTrace(void *userdata, int32_t length, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id106 -->
- Ascend 950PR&950DT products: Supported
<!-- end id106 -->
<!-- npu="A3" id107 -->
- Atlas A3 products: Supported
<!-- end id107 -->
<!-- npu="910b" id108 -->
- Atlas A2 products: Supported
<!-- end id108 -->
<!-- npu="310b" id109 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id109 -->
<!-- npu="310p" id110 -->
- Atlas inference products: Supported
<!-- end id110 -->
<!-- npu="910" id111 -->
- Atlas training products: Supported
<!-- end id111 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id12 -->

### Description

Allows users to dispatch custom profiling markers at specified positions in the network. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| userdata | Input | Custom information. |
| length | Input | Length of **userdata**, in bytes.<br>It is recommended to set **length** to 18 bytes. If it is less than 18 bytes, zeros are automatically padded to the end of the data to reach 18 bytes. If it exceeds 18 bytes, the API reports an error and returns. |
| stream | Input | Stream on which the marking task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclsysGetVersionNum"></a>

## aclsysGetVersionNum

```c
aclError aclsysGetVersionNum(char *pkgName, int32_t *versionNum)
```

### Applicable Products

<!-- npu="950" id764 -->
- Ascend 950PR&950DT products: Supported
<!-- end id764 -->
<!-- npu="A3" id765 -->
- Atlas A3 products: Supported
<!-- end id765 -->
<!-- npu="910b" id766 -->
- Atlas A2 products: Supported
<!-- end id766 -->
<!-- npu="310b" id767 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id767 -->
<!-- npu="310p" id768 -->
- Atlas inference products: Supported
<!-- end id768 -->
<!-- npu="910" id769 -->
- Atlas training products: Supported
<!-- end id769 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id13 -->

### Description

Obtains the version number by package name. The version number is a numeric type, obtained by calculating the weights of the major, minor, patch, and other version information in the **version** field of the **version.info** file in the installation directory of each package.

Obtains the numeric version number and compares it. A larger value indicates a more recent release time, which can be used to understand the release order of versions and to distinguish different API call logic in code based on the version.

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
Currently released versions include alpha internal test versions, beta public test versions, rc (Release Candidate) versions, and release versions. For the same base version number, the version number values increase in the following order: alpha version < beta version < rc version < commercial version. For example: 9.0.0-alpha.1 < 9.0.0-alpha.2 < 9.0.0-beta.1 < 9.0.0-beta.2 < 9.0.0-rc.1 < 9.0.0-rc.2 < 9.0.0 < 9.0.1.
<!-- end id1 -->

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| pkgName | Input | Package name.<br>The CANN package name remains consistent with the directory name under **\${INSTALL_DIR}/share/info**. Replace **${INSTALL_DIR}** with the file storage path after CANN software installation. Taking installation by **root** user as an example, the default file storage path after installation is **/usr/local/Ascend/cann**.<br>The driver package name is **driver**.<br>The firmware package name is **firmware**. |
| versionNum | Output | Numeric version number. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclsysGetVersionStr"></a>

## aclsysGetVersionStr

```c
aclError aclsysGetVersionStr(char *pkgName, char *versionStr)
```

### Applicable Products

<!-- npu="950" id1177 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1177 -->
<!-- npu="A3" id1178 -->
- Atlas A3 products: Supported
<!-- end id1178 -->
<!-- npu="910b" id1179 -->
- Atlas A2 products: Supported
<!-- end id1179 -->
<!-- npu="310b" id1180 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1180 -->
<!-- npu="310p" id1181 -->
- Atlas inference products: Supported
<!-- end id1181 -->
<!-- npu="910" id1182 -->
- Atlas training products: Supported
<!-- end id1182 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id14 -->

### Description

Obtains the version number by package name. The version number is a string type and remains consistent with the value of **version** in the **version.info** file in the installation directory of each package.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| pkgName | Input | Software package name.<br>The CANN package name remains consistent with the directory name under **\${INSTALL_DIR}/share/info**. Replace **${INSTALL_DIR}** with the file storage path after CANN software installation. Taking installation by the **root** user as an example, the default file storage path after installation is **/usr/local/Ascend/cann**.<br>The driver package name is **driver**.<br>The firmware package name is **firmware**. |
| versionStr | Output | Version number.<br>It is recommended that users declare a character array with a length of **ACL_PKG_VERSION_MAX_SIZE** to store the version number. For example: char versionStr[ACL_PKG_VERSION_MAX_SIZE] = {0};<br>The **ACL_PKG_VERSION_MAX_SIZE** macro is defined as follows:<br>#define ACL_PKG_VERSION_MAX_SIZE  128 |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclplatformGetDeviceInfo"></a>

## aclplatformGetDeviceInfo

```c
aclError aclplatformGetDeviceInfo(aclplatformDevInfo infoType, char *value, uint32_t maxLen);
```

### Applicable Products

<!-- npu="950" id1926 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1926 -->
<!-- npu="A3" id1927 -->
- Atlas A3 products: Supported
<!-- end id1927 -->
<!-- npu="910b" id1928 -->
- Atlas A2 products: Supported
<!-- end id1928 -->
<!-- npu="310b" id1929 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1929 -->
<!-- npu="310p" id1930 -->
- Atlas inference products: Supported
<!-- end id1930 -->
<!-- npu="910" id1931 -->
- Atlas training products: Supported
<!-- end id1931 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id15 -->

### Description

Obtains the hardware information of the corresponding AI processor model.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| infoType | Input | Type of device hardware information to query. For details about the type definition, see [aclplatformDevInfo](25-02_Enumerations.md#aclplatformDevInfo). |
| value | Output | Pointer to the character buffer used to receive the query result. The returned content is given as a string, and numeric information (such as size, quantity, and frequency) is represented as a decimal string. |
| maxLen | Input | Maximum memory length, in bytes, which the user requests for storing **value**.<br>If the actual result exceeds this length, the API returns an error. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclplatformGetInstructionInfo"></a>

## aclplatformGetInstructionInfo

```c
aclError aclplatformGetInstructionInfo(aclplatformCoreType type,
                                        const char *instruction,
                                        char *value,
                                        uint32_t maxLen);
```

### Applicable Products

<!-- npu="950" id3508 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3508 -->
<!-- npu="A3" id3509 -->
- Atlas A3 products: Supported
<!-- end id3509 -->
<!-- npu="910b" id3510 -->
- Atlas A2 products: Supported
<!-- end id3510 -->
<!-- npu="310b" id3511 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3511 -->
<!-- npu="310p" id3512 -->
- Atlas inference products: Supported
<!-- end id3512 -->
<!-- npu="910" id3513 -->
- Atlas training products: Supported
<!-- end id3513 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id16 -->

### Description

Obtains the related attribute information of the specified instruction based on the core type.

This API is used to query the support status of the current NPU architecture for a specific instruction, so that applications can select an appropriate algorithm path or feature based on the query result.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| type | Input | Core type to query. For details about the type definition, see [aclplatformCoreType](25-02_Enumerations.md#aclplatformCoreType). |
| instruction | Input | Name string of the instruction to query, such as "Intrinsic_vexp" and "Intrinsic_vln".<br>The instruction set can be found in the configuration file of the corresponding AI processor, in the **${INSTALL_DIR}/{arch-os}/data/platform_config/** directory.<br>Replace **${INSTALL_DIR}** with the file storage path after CANN software installation. Taking installation by **root** user as an example, the default file storage path after installation is **/usr/local/Ascend/cann**.<br>In **{arch-os}**, **arch** indicates the operating system architecture, and **os** indicates the operating system. |
| value | Output | Pointer to the character buffer used to receive the query result. The returned content is provided as a string. |
| maxLen | Input | Maximum memory length, in bytes, which the user requests for storing **value**.<br>If the actual result exceeds this length, the API returns an error. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateStreamV2"></a>

## aclrtCreateStreamV2

```c
aclError aclrtCreateStreamV2(aclrtStream *stream, const aclrtStreamConfigHandle *handle)
```

### Applicable Products

<!-- npu="950" id2304 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2304 -->
<!-- npu="A3" id2305 -->
- Atlas A3 products: Not supported
<!-- end id2305 -->
<!-- npu="910b" id2306 -->
- Atlas A2 products: Not supported
<!-- end id2306 -->
<!-- npu="310b" id2307 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2307 -->
<!-- npu="310p" id2308 -->
- Atlas inference products: Not supported
<!-- end id2308 -->
<!-- npu="910" id2309 -->
- Atlas training products: Not supported
<!-- end id2309 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id17 -->

### Description

Creates a stream and supports adding stream configuration when creating the stream.

This API must be used together with other APIs to create a stream. The API call sequence is as follows:

1. Call [aclrtCreateStreamConfigHandle](25-03_Operation_APIs.md#aclrtCreateStreamConfigHandle) to create a stream configuration object.
2. Call [aclrtSetStreamConfigOpt](#aclrtSetStreamConfigOpt) multiple times to set attributes in the configuration object.
3. Call **aclrtCreateStreamV2** to create a stream.
4. After the stream is no longer used, call [aclrtDestroyStreamConfigHandle](25-03_Operation_APIs.md#aclrtDestroyStreamConfigHandle) to destroy the stream configuration object, and call [aclrtDestroyStream](06_stream_management.md#aclrtDestroyStream) to destroy the stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Output | Pointer to the stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| handle | Input | Pointer to the stream configuration object. For details about the type definition, see [aclrtStreamConfigHandle](25-03_Operation_APIs.md#aclrtStreamConfigHandle).<br>It must be consistent with the handle in [aclrtSetStreamConfigOpt](#aclrtSetStreamConfigOpt). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetStreamConfigOpt"></a>

## aclrtSetStreamConfigOpt

```c
aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle, aclrtStreamConfigAttr attr, const void *attrValue, size_t valueSize)
```

### Applicable Products

<!-- npu="950" id120 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id120 -->
<!-- npu="A3" id121 -->
- Atlas A3 products: Not supported
<!-- end id121 -->
<!-- npu="910b" id122 -->
- Atlas A2 products: Not supported
<!-- end id122 -->
<!-- npu="310b" id123 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id123 -->
<!-- npu="310p" id124 -->
- Atlas inference products: Not supported
<!-- end id124 -->
<!-- npu="910" id125 -->
- Atlas training products: Not supported
<!-- end id125 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id18 -->

### Description

Sets attributes in the stream configuration object.

This API must be used together with other APIs to create a stream. The API call sequence is as follows:

1. Call [aclrtCreateStreamConfigHandle](25-03_Operation_APIs.md#aclrtCreateStreamConfigHandle) to create a stream configuration object.
2. Call **aclrtSetStreamConfigOpt** multiple times to set attributes in the configuration object.
3. Call [aclrtCreateStreamV2](#aclrtCreateStreamV2) to create a stream.
4. After the stream is used, call [aclrtDestroyStreamConfigHandle](25-03_Operation_APIs.md#aclrtDestroyStreamConfigHandle) to destroy the stream configuration object, and call [aclrtDestroyStream](06_stream_management.md#aclrtDestroyStream) to destroy the stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Pointer to the stream configuration object. For details about the type definition, see [aclrtStreamConfigHandle](25-03_Operation_APIs.md#aclrtStreamConfigHandle).<br>Call [aclrtCreateStreamConfigHandle](25-03_Operation_APIs.md#aclrtCreateStreamConfigHandle) in advance to create this object. |
| attr | Input | Attribute to be set. For details about the type definition, see [aclrtStreamConfigAttr](25-02_Enumerations.md#aclrtStreamConfigAttr). |
| attrValue | Input | Pointer to the attribute value, which is the value corresponding to **attr**.<br>If the attribute value itself is a pointer, pass the address of the pointer. |
| valueSize | Input | Length of the data in **attrValue**.<br>You can use the C/C++ standard library function **sizeof(\*attrValue)** to query the data length. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSubscribeHostFunc"></a>

## aclrtSubscribeHostFunc

```c
aclError aclrtSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)
```

### Applicable Products

<!-- npu="950" id2311 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2311 -->
<!-- npu="A3" id2312 -->
- Atlas A3 products: Not supported
<!-- end id2312 -->
<!-- npu="910b" id2313 -->
- Atlas A2 products: Not supported
<!-- end id2313 -->
<!-- npu="310b" id2314 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2314 -->
<!-- npu="310p" id2315 -->
- Atlas inference products: Not supported
<!-- end id2315 -->
<!-- npu="910" id2316 -->
- Atlas training products: Not supported
<!-- end id2316 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id19 -->

### Description

Subscribes to the thread that processes callback functions on the stream (the thread must be created by the user).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| hostFuncThreadId | Input | ID of the specified thread. |
| exeStream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>Passing **NULL** is not supported; otherwise, an error is returned. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- **aclrtSubscribeHostFunc** can be called multiple times to subscribe to the same thread that processes callback functions for multiple streams (only multiple streams within the same device are supported).
- To ensure that tasks in a stream are executed in the order in which they are called, calling **aclrtSubscribeHostFunc** to subscribe to multiple threads that process callback functions for the same stream is not supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtProcessHostFunc"></a>

## aclrtProcessHostFunc

```c
aclError aclrtProcessHostFunc(int32_t timeout)
```

### Applicable Products

<!-- npu="950" id2465 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2465 -->
<!-- npu="A3" id2466 -->
- Atlas A3 products: Not supported
<!-- end id2466 -->
<!-- npu="910b" id2467 -->
- Atlas A2 products: Not supported
<!-- end id2467 -->
<!-- npu="310b" id2468 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2468 -->
<!-- npu="310p" id2469 -->
- Atlas inference products: Not supported
<!-- end id2469 -->
<!-- npu="910" id2470 -->
- Atlas training products: Not supported
<!-- end id2470 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id20 -->

### Description

Waits for specified time, after which callback processing is triggered. The callback is processed by the thread specified by the [aclrtSubscribeHostFunc](#aclrtSubscribeHostFunc) API.

The thread must be created by the user in advance, with a custom thread function. Within the thread function, call this API to wait for the specified time, after which operator computation is performed internally by the system.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| timeout | Input | Timeout duration, in ms.<br>The value options are as follows:<br><br>  - **-1**: infinite waiting.<br>  - Greater than 0 (excluding 0): waiting time. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtUnSubscribeHostFunc"></a>

## aclrtUnSubscribeHostFunc

```c
aclError aclrtUnSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)
```

### Applicable Products

<!-- npu="950" id2283 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2283 -->
<!-- npu="A3" id2284 -->
- Atlas A3 products: Not supported
<!-- end id2284 -->
<!-- npu="910b" id2285 -->
- Atlas A2 products: Not supported
<!-- end id2285 -->
<!-- npu="310b" id2286 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2286 -->
<!-- npu="310p" id2287 -->
- Atlas inference products: Not supported
<!-- end id2287 -->
<!-- npu="910" id2288 -->
- Atlas training products: Not supported
<!-- end id2288 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id21 -->

### Description

Unsubscribes from the thread after the model execution API is called. This API is used together with the [aclrtSubscribeHostFunc](#aclrtSubscribeHostFunc) API. In this way, the callback function on the stream is no longer processed by the specified thread.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| hostFuncThreadId | Input | ID of the specified thread. |
| exeStream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>Passing **NULL** is not supported; otherwise, an error is returned. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
