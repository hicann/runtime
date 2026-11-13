# 14. Kernel Loading and Execution

<!-- md-trans-meta sourceCommit=592d153befca8bbb9089ee4e63722c39aabe7552 translatedAt=2026-11-06T11:25:29.673Z pushedAt=2026-11-09T09:15:24.729Z nl=2 -->

This topic describes the kernel loading and execution APIs of CANN Runtime, including binary loading, function obtaining, argument assembly, and kernel launch.

---

- [Concept and Usage](#concept-and-usage)
- [`aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)`](#aclrtBinaryLoadFromFile): Loads and parses an operator binary file from a file, and outputs **binHandle** pointing to the operator binary.
- [`aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)`](#aclrtBinaryLoadFromData): Loads and parses operator binary data from memory, and outputs **binHandle** pointing to the operator binary.
- [`aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)`](#aclrtBinaryGetFunction): Obtains the kernel function based on its name, and expresses it using **funcHandle**.
- [`aclError aclrtBinaryGetFunctionByEntry(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)`](#aclrtBinaryGetFunctionByEntry): Obtains the kernel function handle based on the Function Entry.
- [`aclError aclrtBinaryGetFunctionCount(const aclrtBinHandle binHandle, uint32_t *count)`](#aclrtBinaryGetFunctionCount): Obtains the total number of kernel functions in the operator binary.
- [`aclError aclrtBinaryGetDevAddress(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)`](#aclrtBinaryGetDevAddress): Obtains the memory address and memory size of the operator binary data on the device.
- [`aclError aclrtBinaryGetGlobal(aclrtBinHandle binHandle, const char *name, void **dptr, size_t *size)`](#aclrtBinaryGetGlobal): Obtains the address and size of the device-side global variable based on the global variable name.
- [`aclError aclrtBinarySetExceptionCallback(aclrtBinHandle binHandle, aclrtOpExceptionCallback callback, void *userData)`](#aclrtBinarySetExceptionCallback): Registers a callback function. If the callback function is set multiple times, the last setting takes effect.
- [`aclError aclrtGetArgsFromExceptionInfo(const aclrtExceptionInfo *info, void **devArgsPtr, uint32_t *devArgsLen)`](#aclrtGetArgsFromExceptionInfo): Obtains the arguments used when the user dispatches an operator execution task from the **aclrtExceptionInfo** exception information.
- [`aclError aclrtGetFuncHandleFromExceptionInfo(const aclrtExceptionInfo *info, aclrtFuncHandle *func)`](#aclrtGetFuncHandleFromExceptionInfo): Obtains the kernel function handle from the **aclrtExceptionInfo** exception information.
- [`aclError aclrtGetFunctionAddr(const void *func, void **aicAddr, void **aivAddr)`](#aclrtGetFunctionAddr): Obtains the start address of the operator on the device side of the kernel function.
- [`aclError aclrtGetFunctionSize(const void *func, size_t *aicSize, size_t *aivSize)`](#aclrtGetFunctionSize): Obtains the size of the kernel function code segment.
- [`aclError aclrtGetFunctionName(const void *func, uint32_t maxLen, char *name)`](#aclrtGetFunctionName): Obtains the kernel function name.
- [`aclError aclrtGetFunctionAttribute(const void *func, aclrtFuncAttribute attrType, int64_t *attrValue)`](#aclrtGetFunctionAttribute): Obtains the kernel function attribute information.
- [`aclError aclrtGetHardwareSyncAddr(void **addr)`](#aclrtGetHardwareSyncAddr): Obtains the synchronization address between the Cube Core and the Vector Core.
- [`aclError aclrtRegisterCpuFunc(const aclrtBinHandle handle, const char *funcName, const char *kernelName, aclrtFuncHandle *funcHandle)`](#aclrtRegisterCpuFunc): Registers AI CPU operator information to obtain the corresponding **funcHandle** if the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API is used to load AI CPU operator binary data.
- [`aclError aclrtKernelArgsInit(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)`](#aclrtKernelArgsInit): Initializes the argument list based on the kernel function handle and obtains the handle that identifies the argument list.
- [`aclError aclrtKernelArgsInitByUserMem(aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, void *userHostMem, size_t actualArgsSize)`](#aclrtKernelArgsInitByUserMem): Initializes the argument list based on the kernel function handle and obtains the handle that identifies the argument list.
- [`aclError aclrtKernelArgsGetMemSize(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)`](#aclrtKernelArgsGetMemSize): Obtains the actual memory size required by the argument list during kernel launch.
- [`aclError aclrtKernelArgsGetHandleMemSize(aclrtFuncHandle funcHandle, size_t *memSize)`](#aclrtKernelArgsGetHandleMemSize): Obtains the memory size occupied by the argument list handle.
- [`aclError aclrtKernelArgsAppend(aclrtArgsHandle argsHandle, void *param, size_t paramSize, aclrtParamHandle *paramHandle)`](#aclrtKernelArgsAppend): Appends the argument values set by the user to the argument data area pointed to by **argsHandle**. If the argument list contains multiple arguments, append the arguments in sequence.
- [`aclError aclrtKernelArgsAppendPlaceHolder(aclrtArgsHandle argsHandle, aclrtParamHandle *paramHandle)`](#aclrtKernelArgsAppendPlaceHolder): Appends a placeholder for placeholder arguments. The return value is the **paramHandle** placeholder.
- [`aclError aclrtKernelArgsGetPlaceHolderBuffer(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, size_t dataSize, void **bufferAddr)`](#aclrtKernelArgsGetPlaceHolderBuffer): Obtains the memory address pointed to by the **paramHandle** placeholder based on the memory size specified by the user.
- [`aclError aclrtKernelArgsParaUpdate(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param, size_t paramSize)`](#aclrtKernelArgsParaUpdate): Updates values for arguments appended through the **aclrtKernelArgsAppend** API.
- [`aclError aclrtKernelArgsFinalize(aclrtArgsHandle argsHandle)`](#aclrtKernelArgsFinalize): Finalizes argument assembly after all arguments are appended.
- [`aclError aclrtLaunchKernel(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtStream stream)`](#aclrtLaunchKernel): Launches the computation task of the corresponding operator. This is an asynchronous API. The operator here is a custom operator developed using Ascend C.
- [`aclError aclrtLaunchKernelV2(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtLaunchKernelCfg *cfg, aclrtStream stream)`](#aclrtLaunchKernelV2): Specifies the configuration information for task dispatch and launches the computation task of the corresponding operator. This is an asynchronous API.
- [`aclError aclrtLaunchKernelWithConfig(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)`](#aclrtLaunchKernelWithConfig): Specifies the configuration information for task dispatch and launches the computation task of the corresponding operator. This is an asynchronous API.
- [`aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)`](#aclrtLaunchKernelWithHostArgs): Specifies the configuration information for task dispatch and launches the computation task of the corresponding operator. This is an asynchronous API.
- [`aclError aclrtLaunchKernelWithArgsArray(void *func, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void **args)`](#aclrtLaunchKernelWithArgsArray): Launches the kernel function computation task using an argument array. This is an asynchronous API.
- [`aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)`](#aclrtCreateBinary): Creates data of the **aclrtBinary** type, which is used to describe operator binary information. The operator here is a custom operator developed using Ascend C.
- [`aclError aclrtDestroyBinary(aclrtBinary binary)`](#aclrtDestroyBinary): Destroys data of the **aclrtBinary** type created through the [aclrtCreateBinary](#aclrtCreateBinary) API.
- [`aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)`](#aclrtBinaryLoad): Parses and loads the operator binary file, outputs the **binHandle** pointing to the operator binary, and copies the operator binary file data to the device corresponding to the current context.
- [`aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)`](#aclrtBinaryUnLoad): Deletes the operator binary data pointed to by **binHandle**, and also deletes the operator binary data copied to the device when loading the operator binary file.
- [`aclError aclrtFunctionGetBinary(const void *func, aclrtBinHandle *binHandle)`](#aclrtFunctionGetBinary): Obtains the operator binary handle.
- [`aclError aclrtFunctionGetParamCount(const void *func, size_t *paramCount)`](#aclrtFunctionGetParamCount): Obtains the number of kernel function parameters.
- [`aclError aclrtFunctionGetParamInfo(const void *func, size_t paramIndex, size_t *paramOffset, size_t *paramSize)`](#aclrtFunctionGetParamInfo): Obtains kernel function parameter information.
- [`aclError aclrtFunctionGetAvailDynUbufPerBlock(const void *func, uint32_t flags, size_t *dynamicUbufSize)`](#aclrtFunctionGetAvailDynUbufPerBlock): Obtains the size of the dynamic UB buffer available for each block.
- [`aclError aclrtGetFuncBySymbol(const void *symbol, aclrtFuncHandle *funcHandle)`](#aclrtGetFuncBySymbol): Obtains the kernel function handle based on the kernel function name.
- [`aclError aclrtLaunchSIMTKernelWithArgsArray(void *func, dim3 gridDim, dim3 blockDim, size_t dynUbufSize, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void **args)`](#aclrtLaunchSIMTKernelWithArgsArray): Launches a SIMT kernel function computation task using an argument array. This is an asynchronous API.
- [`aclError aclrtLaunchSIMTKernelWithHostArgs(void *func, dim3 gridDim, dim3 blockDim, size_t dynUbufSize, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)`](#aclrtLaunchSIMTKernelWithHostArgs): Launches a SIMT kernel function computation task using host arguments. This is an asynchronous API.
- [`aclError aclrtBinaryEnumerateFunctions(const aclrtBinHandle binHandle, aclrtFuncHandle *funcHandles, uint32_t numFunctions)`](#aclrtBinaryEnumerateFunctions): Obtains a specified number of kernel function handles from the operator binary.

## Concept and Usage

### Concepts

The APIs in this topic involve operations on the operator binary, kernel function, kernel function argument list, and parameters of an operator. For easier understanding, you can first refer to the following figure to see the relationships among them.

![](figures/operator_binary_and_kernel_function_relationship.png)

- **Operator binary**: Compile the operator source code to obtain the operator binary file **\*.o**. For CANN built-in operators, you can obtain the operator binary file from the operator binary package (package name: **Ascend-cann-\*-ops-\*.run**). For custom operators, you can obtain the operator binary file after compiling the operator and publishing the binary.

  <!-- npu="950,A3,910b,910,310p,310b" id3 -->
  For the development and compilation of custom operators, see [Ascend C Operator Development Guide](https://gitcode.com/cann/asc-devkit/blob/9.2.0/docs/en/guide/index.md).
  <!-- end id3 -->

- **Kernel function**: an entry function of the device-side implementation of an operator. Currently, the syntax extension of C/C++ functions is allowed for writing device-side execution code. Users perform data access and computation operations in the kernel function, thereby implementing all features of the operator.

### Kernel Loading and Execution API Call Flow

![](figures/kernel_loading_and_execution_process.png)

The key process is described as follows:

1. Call the [aclInit](02_initialization_and_deinitialization.md#aclInit) API for initialization.
2. Apply for runtime resources, including calling the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API to specify the device used for computation and calling the [aclrtCreateStream](06_stream_management.md#aclrtCreateStream) API to create a stream.
3. Call the [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) API to load the operator binary file.

    AI CPU operators also support loading operator binary data from memory (by calling the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API). However, after loading the operator binary data, you also need to use the [aclrtRegisterCpuFunc](#aclrtRegisterCpuFunc) API to register the AI CPU operator information.

4. Call the [aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry) or [aclrtBinaryGetFunction](#aclrtBinaryGetFunction) API to obtain the kernel function handle.
5. **(Optional)** Operate the argument list based on the kernel function handle. The operations include:
    1. **Initialize the argument list**

        Currently, two methods are supported: memory managed by the system (by calling the [aclrtKernelArgsInit](#aclrtKernelArgsInit) API) and memory managed by the user (by calling the [aclrtKernelArgsInitByUserMem](#aclrtKernelArgsInitByUserMem) API).

    2. **Append arguments and update the values**

        The kernel function argument list contains arguments of different types, such as pointer-type arguments, placeholders, and uint8\_t-type arguments, where:

        - Pointer-type argument: Its value is a device memory address. Generally, the inputs and outputs of an operator are arguments of this type. The user needs to call a device memory request API (for example, the [aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc) API) in advance to request memory and copy data to the device side.
        - Placeholder: This is also a pointer-type argument, but the difference is that the user does not need to manually copy the argument data to the device; this operation is completed by Runtime. When appending arguments, Runtime does not fill in the actual device address. Instead, the actual device address is refreshed only when the kernel is launched, hence the name "placeholder". For non-input and non-output arguments of an operator, the placeholder can be used to merge the host-\>device copy of small blocks of data (recommended to be less than 2 KB) into a single copy operation at kernel launch, reducing the number of copies and improving performance.

        ![](figures/kernel_function_parameter_list_diagram.png)

        **Call different argument appending APIs for different types of arguments.**

        - For placeholder arguments, because the associated memory must be placed after all arguments, when appending arguments, first call the [aclrtKernelArgsAppendPlaceHolder](#aclrtKernelArgsAppendPlaceHolder) API to reserve a placeholder. After all arguments have been appended, call the [aclrtKernelArgsGetPlaceHolderBuffer](#aclrtKernelArgsGetPlaceHolderBuffer) API to obtain the memory address pointed to by the corresponding placeholder. The user can manage the data in that memory based on the obtained memory address.
        - For non-placeholder arguments (for example, pointer-type arguments and uint8\_t-type arguments), call the [aclrtKernelArgsAppend](#aclrtKernelArgsAppend) API to append the argument values set by the user to the argument data area pointed to by **argsHandle**. To update argument values, call the [aclrtKernelArgsParaUpdate](#aclrtKernelArgsParaUpdate) API.

        **Note:** The kernel function argument list may actually contain multiple arguments, and arguments of different types may appear interleaved. Therefore, arguments must be appended from left to right in the order in which they appear in the argument list, and a maximum of 128 arguments can be appended.

    3. **End appending to the argument list and update argument values**

        After all arguments are appended, call [aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize) to finalize the argument assembly. However, after [aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize), argument values can still be updated. After the update, call [aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize) once again.

6. Call the kernel launch API to launch the computation task of the corresponding operator.

    If the **aclrtArgsHandle** argument list handle is used to assemble the input argument data of the kernel function, call [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) to launch the computation task of the corresponding operator. In this mode, you only need to append arguments to the argument list in sequence, without paying attention to the assembly details in memory or the internal arguments.

    If the input argument data of the kernel function is all stored in host or device memory, call [aclrtLaunchKernel](#aclrtLaunchKernel), [aclrtLaunchKernelV2](#aclrtLaunchKernelV2), or [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) to launch the computation task of the corresponding operator.

7. Call [aclrtBinaryUnLoad](#aclrtBinaryUnLoad) to unload the operator binary file.
8. Release runtime resources, including calling [aclrtDestroyStream](06_stream_management.md#aclrtDestroyStream) to release the stream and calling [aclrtResetDevice](04_device_management.md#aclrtResetDevice) to release resources on the device.
9. Call [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize) for deinitialization.

<a class="method_anchor" id="aclrtBinaryLoadFromFile"></a>

## aclrtBinaryLoadFromFile

```c
aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
```

### Applicable Products

<!-- npu="950" id2997 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2997 -->
<!-- npu="A3" id2998 -->
- Atlas A3 products: Supported
<!-- end id2998 -->
<!-- npu="910b" id2999 -->
- Atlas A2 products: Supported
<!-- end id2999 -->
<!-- npu="310b" id3000 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3000 -->
<!-- npu="310p" id3001 -->
- Atlas inference products: Supported
<!-- end id3001 -->
<!-- npu="910" id3002 -->
- Atlas training products: Supported
<!-- end id3002 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id1 -->

### Description

Loads and parses an operator binary file from a file, and outputs **binHandle** pointing to the operator binary.

For AI Core operators, if this API is used to load and parse an operator binary file, it must be used together with [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig), [aclrtLaunchKernelV2](#aclrtLaunchKernelV2), or [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) to dispatch a computation task.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binPath | Input | Path of the operator binary file (.o file), which must be an absolute path.<br>For AI CPU operators, this parameter supports passing the operator information library file (*.json). |
| options | Input | Optional parameters for loading the operator binary file. For details about the type definition, see [aclrtBinaryLoadOptions](25-04_Structs.md#aclrtBinaryLoadOptions).  |
| binHandle | Output | Handle that identifies the operator binary. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

An operator binary compiled for a specific product model must be used on a product of the same model.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinaryLoadFromData"></a>

## aclrtBinaryLoadFromData

```c
aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
```

### Applicable Products

<!-- npu="950" id71 -->
- Ascend 950PR&950DT products: Supported
<!-- end id71 -->
<!-- npu="A3" id72 -->
- Atlas A3 products: Supported
<!-- end id72 -->
<!-- npu="910b" id73 -->
- Atlas A2 products: Supported
<!-- end id73 -->
<!-- npu="310b" id74 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id74 -->
<!-- npu="310p" id75 -->
- Atlas inference products: Supported
<!-- end id75 -->
<!-- npu="910" id76 -->
- Atlas training products: Supported
<!-- end id76 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id2 -->

### Description

Loads and parses operator binary data from memory, and outputs **binHandle** pointing to the operator binary.

When this API is used to load AI CPU operator information ([aclrtBinaryLoadOption](25-04_Structs.md#aclrtBinaryLoadOption).type contains **ACL\_RT\_BINARY\_LOAD\_OPT\_CPU\_KERNEL\_MODE**), it also needs to cooperate with the [aclrtRegisterCpuFunc](#aclrtRegisterCpuFunc) API to register the AI CPU operator.

Note that the system only loads the operator to the device corresponding to the current context. Therefore, when calling the [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) API to launch the operator computation task, the device must be the same as the device on which the operator is loaded.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| data | Input | Host memory address that stores the operator binary data. It cannot be empty. |
| length | Input | Memory size of the operator binary data. It must be greater than 0, in bytes. |
| options | Input | Optional parameters for loading the operator binary file. For details about the type definition, see [aclrtBinaryLoadOptions](25-04_Structs.md#aclrtBinaryLoadOptions).  |
| binHandle | Output | Handle that identifies the operator binary. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinaryGetFunction"></a>

## aclrtBinaryGetFunction

```c
aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)
```

### Applicable Products

<!-- npu="950" id3389 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3389 -->
<!-- npu="A3" id3390 -->
- Atlas A3 products: Supported
<!-- end id3390 -->
<!-- npu="910b" id3391 -->
- Atlas A2 products: Supported
<!-- end id3391 -->
<!-- npu="310b" id3392 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3392 -->
<!-- npu="310p" id3393 -->
- Atlas inference products: Supported
<!-- end id3393 -->
<!-- npu="910" id3394 -->
- Atlas training products: Supported
<!-- end id3394 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id3 -->

### Description

Obtains the kernel function based on its name, and expresses it using **funcHandle**.

For the same **binHandle**, when the **aclrtBinaryGetFunction** API is called for the first time, the operator binary data associated with **binHandle** is copied to the device corresponding to the current context by default.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binHandle | Input | Operator binary handle. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle).<br>Call the [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) API or the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API to obtain the operator binary handle, and then pass it as an input parameter to this API. |
| kernelName | Input | Kernel function name. |
| funcHandle | Output | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinaryGetFunctionByEntry"></a>

## aclrtBinaryGetFunctionByEntry

```c
aclError aclrtBinaryGetFunctionByEntry(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)
```

**Caution: This API is reserved and not supported yet.**

### Description

Obtains the kernel function handle based on the Function Entry.

For the same **binHandle**, when the **aclrtBinaryGetFunctionByEntry** API is called for the first time, the operator binary data associated with **binHandle** is copied to the device corresponding to the current context by default.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binHandle | Input | Operator binary handle. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle).<br>Call the [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) API or the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API to obtain the operator binary handle, and then pass it as an input parameter to this API. |
| funcEntry | Input | Keyword that identifies the kernel function. |
| funcHandle | Output | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinaryGetDevAddress"></a>

## aclrtBinaryGetDevAddress

```c
aclError aclrtBinaryGetDevAddress(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)
```

### Applicable Products

<!-- npu="950" id2794 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2794 -->
<!-- npu="A3" id2795 -->
- Atlas A3 products: Supported
<!-- end id2795 -->
<!-- npu="910b" id2796 -->
- Atlas A2 products: Supported
<!-- end id2796 -->
<!-- npu="310b" id2797 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2797 -->
<!-- npu="310p" id2798 -->
- Atlas inference products: Supported
<!-- end id2798 -->
<!-- npu="910" id2799 -->
- Atlas training products: Supported
<!-- end id2799 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id4 -->

### Description

Obtains the memory address and memory size of the operator binary data on the device.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binHandle | Input | Operator binary handle. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle).<br>Call the [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) API or the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API to obtain the operator binary handle, and then pass it as an input parameter to this API. |
| binAddr | Output | Memory address of the operator binary data on the device.<br>If the lazy loading flag is set when loading the operator binary (set aclrtBinaryLoadOptions.aclrtBinaryLoadOption.[aclrtBinaryLoadOptionValue](25-04_Structs.md#aclrtBinaryLoadOptionValue).isLazyLoad to **1**), the **binAddr** obtained by calling this API is a null pointer. |
| binSize | Output | Size of the operator binary data, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinaryGetGlobal"></a>

## aclrtBinaryGetGlobal

```c
aclError aclrtBinaryGetGlobal(aclrtBinHandle binHandle, const char *name, void **dptr, size_t *size)
```

### Applicable Products

<!-- npu="950" id1723 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1723 -->
<!-- npu="A3" id1724 -->
- Atlas A3 products: Supported
<!-- end id1724 -->
<!-- npu="910b" id1725 -->
- Atlas A2 products: Supported
<!-- end id1725 -->
<!-- npu="310b" id1726 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1726 -->
<!-- npu="310p" id1727 -->
- Atlas inference products: Supported
<!-- end id1727 -->
<!-- npu="910" id1728 -->
- Atlas training products: Supported
<!-- end id1728 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id5 -->

### Description

Obtains the memory address and size of the device-side global variable in the operator binary based on the global variable name.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binHandle | Input | Operator binary handle. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle).<br>Call the [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) API or the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API to obtain the operator binary handle, and then pass it as an input parameter to this API. |
| name | Input | Global variable name. It must be consistent with the global variable name defined in the operator binary.                                                                                                                                                                               |
| dptr | Output | Pointer to the address of the global variable on the device side.<br/>If **nullptr** is passed here, the address is not obtained.                                                                                                                                                              |
| size | Output | Size of the global variable on the device side, in bytes.<br/>If **nullptr** is passed here, the size is not obtained.<br>**dptr** and **size** cannot both be **nullptr**.                                                                                                                              |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinarySetExceptionCallback"></a>

## aclrtBinarySetExceptionCallback

```c
aclError aclrtBinarySetExceptionCallback(aclrtBinHandle binHandle, aclrtOpExceptionCallback callback, void *userData)
```

### Applicable Products

<!-- npu="950" id274 -->
- Ascend 950PR&950DT products: Supported
<!-- end id274 -->
<!-- npu="A3" id275 -->
- Atlas A3 products: Supported
<!-- end id275 -->
<!-- npu="910b" id276 -->
- Atlas A2 products: Supported
<!-- end id276 -->
<!-- npu="310b" id277 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id277 -->
<!-- npu="310p" id278 -->
- Atlas inference products: Supported
<!-- end id278 -->
<!-- npu="910" id279 -->
- Atlas training products: Supported
<!-- end id279 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id6 -->

### Description

Registers a callback function. If the callback function is set multiple times, the last setting takes effect.

Before executing an operator, call this API to register a callback function. If an exception occurs during operator execution, the callback function is triggered, and the exception information is stored in the **aclrtExceptionInfo** struct. Then, you can call [aclrtGetArgsFromExceptionInfo](#aclrtGetArgsFromExceptionInfo) and [aclrtGetFuncHandleFromExceptionInfo](#aclrtGetFuncHandleFromExceptionInfo) to obtain, from the exception information, the arguments and the kernel function handle used when the user dispatches the operator execution task. Currently, exception information can be obtained for AI Core operators or AI CPU operators.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| binHandle | Input | Operator binary handle.<br>Call [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) or [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) to obtain the operator binary handle, and then pass it as an input parameter to this API.<br>For details about the value, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle). |
| callback | Input | Callback function to be registered.<br>The prototype of the callback function is:<br>typedef void (*aclrtOpExceptionCallback)(aclrtExceptionInfo*exceptionInfo, void *userData); |
| userData | Input | Pointer to the user data to be passed to the callback function. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetArgsFromExceptionInfo"></a>

## aclrtGetArgsFromExceptionInfo

```c
aclError aclrtGetArgsFromExceptionInfo(const aclrtExceptionInfo *info, void **devArgsPtr, uint32_t *devArgsLen)
```

### Applicable Products

<!-- npu="950" id253 -->
- Ascend 950PR&950DT products: Supported
<!-- end id253 -->
<!-- npu="A3" id254 -->
- Atlas A3 products: Supported
<!-- end id254 -->
<!-- npu="910b" id255 -->
- Atlas A2 products: Supported
<!-- end id255 -->
<!-- npu="310b" id256 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id256 -->
<!-- npu="310p" id257 -->
- Atlas inference products: Supported
<!-- end id257 -->
<!-- npu="910" id258 -->
- Atlas training products: Supported
<!-- end id258 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id7 -->

### Description

Obtains the arguments used when the user dispatches an operator execution task from the **aclrtExceptionInfo** exception information. This API is used together with the [aclrtBinarySetExceptionCallback](#aclrtBinarySetExceptionCallback) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| info | Input | Pointer to exception information. |
| devArgsPtr | Output | Arguments used when the user dispatches an operator execution task. |
| devArgsLen | Output | Number of arguments. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

Returns **ACL_ERROR_INVALID_EXCEPTION_INFO** when **info** is a null pointer.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetFuncHandleFromExceptionInfo"></a>

## aclrtGetFuncHandleFromExceptionInfo

```c
aclError aclrtGetFuncHandleFromExceptionInfo(const aclrtExceptionInfo *info, aclrtFuncHandle *func)
```

### Applicable Products

<!-- npu="950" id2458 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2458 -->
<!-- npu="A3" id2459 -->
- Atlas A3 products: Supported
<!-- end id2459 -->
<!-- npu="910b" id2460 -->
- Atlas A2 products: Supported
<!-- end id2460 -->
<!-- npu="310b" id2461 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2461 -->
<!-- npu="310p" id2462 -->
- Atlas inference products: Supported
<!-- end id2462 -->
<!-- npu="910" id2463 -->
- Atlas training products: Supported
<!-- end id2463 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id8 -->

### Description

Obtains the kernel function handle from the **aclrtExceptionInfo** exception information. This API is used together with the [aclrtBinarySetExceptionCallback](#aclrtBinarySetExceptionCallback) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| info | Input | Pointer to exception information. |
| func | Output | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

Returns **ACL_ERROR_INVALID_EXCEPTION_INFO** when **info** is a null pointer.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetFunctionAddr"></a>

## aclrtGetFunctionAddr

```c
aclError aclrtGetFunctionAddr(const void *func, void **aicAddr, void **aivAddr)
```

### Applicable Products

<!-- npu="950" id1072 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1072 -->
<!-- npu="A3" id1073 -->
- Atlas A3 products: Supported
<!-- end id1073 -->
<!-- npu="910b" id1074 -->
- Atlas A2 products: Supported
<!-- end id1074 -->
<!-- npu="310b" id1075 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1075 -->
<!-- npu="310p" id1076 -->
- Atlas inference products: Supported
<!-- end id1076 -->
<!-- npu="910" id1077 -->
- Atlas training products: Supported
<!-- end id1077 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id9 -->

### Description

Obtains the start address of the operator on the device side of the kernel function.

The AI data processing core units vary across products. For the definition and details of Core, see [aclrtDevAttr](25-02_Enumerations.md#aclrtDevAttr).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| aicAddr | Output | Start address of the operator on the AI Core or Cube Core.<br><br>  - For the following products, the start address of the operator on the Cube Core is returned here: Ascend 950PR/Ascend 950DT<br>Atlas A3 training products/Atlas A3 inference products<br>Atlas A2 training products/Atlas A2 inference products |
| aivAddr | Output | Start address of the operator on the Vector Core.<br>If the **aivAddr** obtained through this API is empty, the operator is not executed on the Vector Core. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetFunctionSize"></a>

## aclrtGetFunctionSize

```c
aclError aclrtGetFunctionSize(const void *func, size_t *aicSize, size_t *aivSize)
```

### Applicable Products

<!-- npu="950" id673 -->
- Ascend 950PR&950DT products: Supported
<!-- end id673 -->
<!-- npu="A3" id674 -->
- Atlas A3 products: Supported
<!-- end id674 -->
<!-- npu="910b" id675 -->
- Atlas A2 products: Supported
<!-- end id675 -->
<!-- npu="310b" id676 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id676 -->
<!-- npu="310p" id677 -->
- Atlas inference products: Supported
<!-- end id677 -->
<!-- npu="910" id678 -->
- Atlas training products: Not supported
<!-- end id678 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id10 -->

### Description

Obtains the size of the kernel function code segment.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| aicSize | Output | Size of the code segment for executing the operator on the AI Core or Cube Core, in bytes.<br>If the operator is executed only on the Vector Core, this value is **0**. |
| aivSize | Output | Size of the code segment for executing the operator on the Vector Core, in bytes.<br>If the operator is executed only on the AI Core or Cube Core, this value is **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetFunctionName"></a>

## aclrtGetFunctionName

```c
aclError aclrtGetFunctionName(const void *func, uint32_t maxLen, char *name)
```

### Applicable Products

<!-- npu="950" id162 -->
- Ascend 950PR&950DT products: Supported
<!-- end id162 -->
<!-- npu="A3" id163 -->
- Atlas A3 products: Supported
<!-- end id163 -->
<!-- npu="910b" id164 -->
- Atlas A2 products: Supported
<!-- end id164 -->
<!-- npu="310b" id165 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id165 -->
<!-- npu="310p" id166 -->
- Atlas inference products: Supported
<!-- end id166 -->
<!-- npu="910" id167 -->
- Atlas training products: Supported
<!-- end id167 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id11 -->

### Description

Obtains the kernel function name.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| maxLen | Input | Buffer capacity, in bytes, that the user requests to store the kernel function name. The value of **maxLen** must be greater than or equal to the byte length of the kernel function name plus 1 to accommodate the trailing null character `\0`. If the capacity is insufficient, the API returns a parameter error. |
| name | Output | Kernel function name. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetFunctionAttribute"></a>

## aclrtGetFunctionAttribute

```c
aclError aclrtGetFunctionAttribute(const void *func, aclrtFuncAttribute attrType, int64_t *attrValue)
```

### Applicable Products

<!-- npu="950" id57 -->
- Ascend 950PR&950DT products: Supported
<!-- end id57 -->
<!-- npu="A3" id58 -->
- Atlas A3 products: Supported
<!-- end id58 -->
<!-- npu="910b" id59 -->
- Atlas A2 products: Supported
<!-- end id59 -->
<!-- npu="310b" id60 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id60 -->
<!-- npu="310p" id61 -->
- Atlas inference products: Supported
<!-- end id61 -->
<!-- npu="910" id62 -->
- Atlas training products: Supported
<!-- end id62 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id12 -->

### Description

Obtains the kernel function attribute information in the operator binary file.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| attrType | Input | Attribute. For details about the type definition, see [aclrtFuncAttribute](25-02_Enumerations.md#aclrtFuncAttribute). |
| attrValue | Output | Attribute value. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetHardwareSyncAddr"></a>

## aclrtGetHardwareSyncAddr

```c
aclError aclrtGetHardwareSyncAddr(void **addr)
```

### Applicable Products

<!-- npu="950" id22 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id22 -->
<!-- npu="A3" id23 -->
- Atlas A3 products: Supported
<!-- end id23 -->
<!-- npu="910b" id24 -->
- Atlas A2 products: Supported
<!-- end id24 -->
<!-- npu="310b" id25 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id25 -->
<!-- npu="310p" id26 -->
- Atlas inference products: Not supported
<!-- end id26 -->
<!-- npu="910" id27 -->
- Atlas training products: Not supported
<!-- end id27 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id13 -->

### Description

Obtains the synchronization address between the Cube Core and the Vector Core.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **addr** | Output | Synchronization address. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtRegisterCpuFunc"></a>

## aclrtRegisterCpuFunc

```c
aclError aclrtRegisterCpuFunc(const aclrtBinHandle handle, const char *funcName, const char *kernelName, aclrtFuncHandle *funcHandle)
```

### Applicable Products

<!-- npu="950" id407 -->
- Ascend 950PR&950DT products: Supported
<!-- end id407 -->
<!-- npu="A3" id408 -->
- Atlas A3 products: Supported
<!-- end id408 -->
<!-- npu="910b" id409 -->
- Atlas A2 products: Supported
<!-- end id409 -->
<!-- npu="310b" id410 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id410 -->
<!-- npu="310p" id411 -->
- Atlas inference products: Supported
<!-- end id411 -->
<!-- npu="910" id412 -->
- Atlas training products: Supported
<!-- end id412 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id14 -->

### Description

Registers AI CPU operator information to obtain the corresponding **funcHandle** if the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API is used to load AI CPU operator binary data.

This API is used only for AI CPU operators. For other operators, error **ACL\_ERROR\_RT\_PARAM\_INVALID** is returned.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Operator binary handle. For the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)<br>Call the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API to obtain the operator binary handle, and then pass it as an input parameter to this API. |
| funcName | Input | Entry function for executing the AI CPU operator. It cannot be empty. |
| kernelName | Input | **opType** of the AI CPU operator. It cannot be empty. |
| funcHandle | Output | Function handle. For the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsInit"></a>

## aclrtKernelArgsInit

```c
aclError aclrtKernelArgsInit(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)
```

### Applicable Products

<!-- npu="950" id939 -->
- Ascend 950PR&950DT products: Supported
<!-- end id939 -->
<!-- npu="A3" id940 -->
- Atlas A3 products: Supported
<!-- end id940 -->
<!-- npu="910b" id941 -->
- Atlas A2 products: Supported
<!-- end id941 -->
<!-- npu="310b" id942 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id942 -->
<!-- npu="310p" id943 -->
- Atlas inference products: Supported
<!-- end id943 -->
<!-- npu="910" id944 -->
- Atlas training products: Supported
<!-- end id944 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id15 -->

### Description

Initializes the argument list based on the kernel function handle and obtains the handle that identifies the argument list.

The difference from the [aclrtKernelArgsInitByUserMem](#aclrtKernelArgsInitByUserMem) API is that calling this API indicates that the memory is managed by the system.

After the argument list is initialized, when arguments are appended through APIs such as [aclrtKernelArgsAppend](#aclrtKernelArgsAppend) and [aclrtKernelArgsAppendPlaceHolder](#aclrtKernelArgsAppendPlaceHolder), it is recommended that the number of appended arguments be consistent with the number of arguments required by the kernel function. For compatibility with operator kernel functions in earlier versions, the upper limit of the number of arguments checked by Runtime is 128. If the number of appended arguments exceeds this upper limit, the API returns an error.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| funcHandle | Input | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle).<br>Call [aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry) or [aclrtBinaryGetFunction](#aclrtBinaryGetFunction) to obtain the kernel function handle, and then pass it as an input parameter to this API. |
| argsHandle | Output | Argument list handle. For details about the type definition, see [aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsInitByUserMem"></a>

## aclrtKernelArgsInitByUserMem

```c
aclError aclrtKernelArgsInitByUserMem(aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, void *userHostMem, size_t actualArgsSize)
```

### Applicable Products

<!-- npu="950" id631 -->
- Ascend 950PR&950DT products: Supported
<!-- end id631 -->
<!-- npu="A3" id632 -->
- Atlas A3 products: Supported
<!-- end id632 -->
<!-- npu="910b" id633 -->
- Atlas A2 products: Supported
<!-- end id633 -->
<!-- npu="310b" id634 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id634 -->
<!-- npu="310p" id635 -->
- Atlas inference products: Supported
<!-- end id635 -->
<!-- npu="910" id636 -->
- Atlas training products: Supported
<!-- end id636 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id16 -->

### Description

Initializes the argument list based on the kernel function handle and obtains the handle that identifies the argument list.

The difference from the [aclrtKernelArgsInit](#aclrtKernelArgsInit) API is that calling this API indicates that the memory is managed by the user.

After the argument list is initialized, when arguments are appended through APIs such as [aclrtKernelArgsAppend](#aclrtKernelArgsAppend) and [aclrtKernelArgsAppendPlaceHolder](#aclrtKernelArgsAppendPlaceHolder), it is recommended that the number of appended arguments be consistent with the number of arguments required by the kernel function. For compatibility with operator kernel functions in earlier versions, the upper limit of the number of arguments checked by Runtime is 128. If the number of appended arguments exceeds this upper limit, the API returns an error.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| funcHandle | Input | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle).<br>Call [aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry) or [aclrtBinaryGetFunction](#aclrtBinaryGetFunction) to obtain the kernel function handle, and then pass it as an input parameter to this API. |
| argsHandle | Output | Argument list handle. For details about the type definition, see [aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle).<br>Call the [aclrtKernelArgsGetHandleMemSize](#aclrtKernelArgsGetHandleMemSize) API in advance to obtain the memory size, request host memory, and then pass the host memory address as an input parameter here. |
| userHostMem | Input | Host memory address.<br>Call the [aclrtKernelArgsGetMemSize](#aclrtKernelArgsGetMemSize) API in advance to obtain the memory size, request host memory, and then pass the host memory address as an input parameter here. |
| actualArgsSize | Input | Memory size.<br>Call the [aclrtKernelArgsGetMemSize](#aclrtKernelArgsGetMemSize) API in advance to obtain the memory size, and then pass it as an input parameter here. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsGetMemSize"></a>

## aclrtKernelArgsGetMemSize

```c
aclError aclrtKernelArgsGetMemSize(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
```

### Applicable Products

<!-- npu="950" id1527 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1527 -->
<!-- npu="A3" id1528 -->
- Atlas A3 products: Supported
<!-- end id1528 -->
<!-- npu="910b" id1529 -->
- Atlas A2 products: Supported
<!-- end id1529 -->
<!-- npu="310b" id1530 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1530 -->
<!-- npu="310p" id1531 -->
- Atlas inference products: Supported
<!-- end id1531 -->
<!-- npu="910" id1532 -->
- Atlas training products: Supported
<!-- end id1532 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id17 -->

### Description

Obtains the actual memory size required by the argument list during kernel launch.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| funcHandle | Input | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |
| userArgsSize | Input | Size required to store the argument list data in memory, in bytes.<br>The memory size of each argument data must be 8-byte aligned. **userArgsSize** here is the sum of the memory sizes of these aligned argument data. |
| actualArgsSize | Output | Actual memory size required by the argument list during kernel launch, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsGetHandleMemSize"></a>

## aclrtKernelArgsGetHandleMemSize

```c
aclError aclrtKernelArgsGetHandleMemSize(aclrtFuncHandle funcHandle, size_t *memSize)
```

### Applicable Products

<!-- npu="950" id1464 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1464 -->
<!-- npu="A3" id1465 -->
- Atlas A3 products: Supported
<!-- end id1465 -->
<!-- npu="910b" id1466 -->
- Atlas A2 products: Supported
<!-- end id1466 -->
<!-- npu="310b" id1467 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1467 -->
<!-- npu="310p" id1468 -->
- Atlas inference products: Supported
<!-- end id1468 -->
<!-- npu="910" id1469 -->
- Atlas training products: Supported
<!-- end id1469 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id18 -->

### Description

Obtains the memory size occupied by the argument list handle.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| funcHandle | Input | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |
| memSize | Output | Memory size occupied by the argument list handle, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsAppend"></a>

## aclrtKernelArgsAppend

```c
aclError aclrtKernelArgsAppend(aclrtArgsHandle argsHandle, void *param, size_t paramSize, aclrtParamHandle *paramHandle)
```

### Applicable Products

<!-- npu="950" id1198 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1198 -->
<!-- npu="A3" id1199 -->
- Atlas A3 products: Supported
<!-- end id1199 -->
<!-- npu="910b" id1200 -->
- Atlas A2 products: Supported
<!-- end id1200 -->
<!-- npu="310b" id1201 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1201 -->
<!-- npu="310p" id1202 -->
- Atlas inference products: Supported
<!-- end id1202 -->
<!-- npu="910" id1203 -->
- Atlas training products: Supported
<!-- end id1203 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id19 -->

### Description

Appends the argument values set by the user to the argument data area pointed to by **argsHandle**. If the argument list contains multiple arguments, append the arguments in sequence.

To update an argument value, call [aclrtKernelArgsParaUpdate](#aclrtKernelArgsParaUpdate).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| argsHandle | Input | Argument list handle. For details about the type definition, see [aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle). |
| param | Input | Memory address of the argument value to be appended.<br>This is a host memory address. |
| paramSize | Input | Memory size, in bytes. |
| paramHandle | Output | Parameter handle. For details about the type definition, see [aclrtParamHandle](25-05_Typedefs.md#aclrtParamHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsAppendPlaceHolder"></a>

## aclrtKernelArgsAppendPlaceHolder

```c
aclError aclrtKernelArgsAppendPlaceHolder(aclrtArgsHandle argsHandle, aclrtParamHandle *paramHandle)
```

### Applicable Products

<!-- npu="950" id2836 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2836 -->
<!-- npu="A3" id2837 -->
- Atlas A3 products: Supported
<!-- end id2837 -->
<!-- npu="910b" id2838 -->
- Atlas A2 products: Supported
<!-- end id2838 -->
<!-- npu="310b" id2839 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2839 -->
<!-- npu="310p" id2840 -->
- Atlas inference products: Supported
<!-- end id2840 -->
<!-- npu="910" id2841 -->
- Atlas training products: Supported
<!-- end id2841 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id20 -->

### Description

Appends a placeholder for placeholder arguments. The return value is the **paramHandle** placeholder.

If the argument list contains multiple arguments, append them in sequence. After all arguments are appended, call [aclrtKernelArgsGetPlaceHolderBuffer](#aclrtKernelArgsGetPlaceHolderBuffer) to obtain the memory address pointed to by the **paramHandle** placeholder.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| argsHandle | Input | Argument list handle. For details about the type definition, see [aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle). |
| paramHandle | Output | Parameter handle. For details about the type definition, see [aclrtParamHandle](25-05_Typedefs.md#aclrtParamHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsGetPlaceHolderBuffer"></a>

## aclrtKernelArgsGetPlaceHolderBuffer

```c
aclError aclrtKernelArgsGetPlaceHolderBuffer(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, size_t dataSize, void **bufferAddr)
```

### Applicable Products

<!-- npu="950" id197 -->
- Ascend 950PR&950DT products: Supported
<!-- end id197 -->
<!-- npu="A3" id198 -->
- Atlas A3 products: Supported
<!-- end id198 -->
<!-- npu="910b" id199 -->
- Atlas A2 products: Supported
<!-- end id199 -->
<!-- npu="310b" id200 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id200 -->
<!-- npu="310p" id201 -->
- Atlas inference products: Supported
<!-- end id201 -->
<!-- npu="910" id202 -->
- Atlas training products: Supported
<!-- end id202 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id21 -->

### Description

Obtains the memory address pointed to by the **paramHandle** placeholder based on the memory size specified by the user.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| argsHandle | Input | Argument list handle. For details about the type definition, see [aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle). |
| paramHandle | Input | Parameter handle. For details about the type definition, see [aclrtParamHandle](25-05_Typedefs.md#aclrtParamHandle).<br>The **paramHandle** here must be consistent with the **paramHandle** in the [aclrtKernelArgsAppendPlaceHolder](#aclrtKernelArgsAppendPlaceHolder) API. |
| dataSize | Input | Memory size. |
| bufferAddr | Output | Memory address pointed to by the **paramHandle** placeholder.<br>The data in this memory is subsequently managed by the user, but the user does not need to manage the lifecycle of this memory. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsParaUpdate"></a>

## aclrtKernelArgsParaUpdate

```c
aclError aclrtKernelArgsParaUpdate(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param, size_t paramSize)
```

### Applicable Products

<!-- npu="950" id3410 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3410 -->
<!-- npu="A3" id3411 -->
- Atlas A3 products: Supported
<!-- end id3411 -->
<!-- npu="910b" id3412 -->
- Atlas A2 products: Supported
<!-- end id3412 -->
<!-- npu="310b" id3413 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3413 -->
<!-- npu="310p" id3414 -->
- Atlas inference products: Supported
<!-- end id3414 -->
<!-- npu="910" id3415 -->
- Atlas training products: Supported
<!-- end id3415 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id22 -->

### Description

Updates values for arguments appended through the **aclrtKernelArgsAppend** API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| argsHandle | Input | Argument list handle. For details about the type definition, see [aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle). |
| paramHandle | Input | Parameter handle. For details about the type definition, see [aclrtParamHandle](25-05_Typedefs.md#aclrtParamHandle). |
| param | Input | Memory address of the argument value to be updated.<br>This is a host memory address. |
| paramSize | Input | Memory size, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtKernelArgsFinalize"></a>

## aclrtKernelArgsFinalize

```c
aclError aclrtKernelArgsFinalize(aclrtArgsHandle argsHandle)
```

### Applicable Products

<!-- npu="950" id3431 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3431 -->
<!-- npu="A3" id3432 -->
- Atlas A3 products: Supported
<!-- end id3432 -->
<!-- npu="910b" id3433 -->
- Atlas A2 products: Supported
<!-- end id3433 -->
<!-- npu="310b" id3434 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3434 -->
<!-- npu="310p" id3435 -->
- Atlas inference products: Supported
<!-- end id3435 -->
<!-- npu="910" id3436 -->
- Atlas training products: Supported
<!-- end id3436 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id23 -->

### Description

Finalizes argument assembly after all arguments are appended.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| argsHandle | Input | Argument list handle. For details about the type definition, see [aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtLaunchKernel"></a>

## aclrtLaunchKernel

```c
aclError aclrtLaunchKernel(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3487 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3487 -->
<!-- npu="A3" id3488 -->
- Atlas A3 products: Supported
<!-- end id3488 -->
<!-- npu="910b" id3489 -->
- Atlas A2 products: Supported
<!-- end id3489 -->
<!-- npu="310b" id3490 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3490 -->
<!-- npu="310p" id3491 -->
- Atlas inference products: Supported
<!-- end id3491 -->
<!-- npu="910" id3492 -->
- Atlas training products: Supported
<!-- end id3492 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id24 -->

### Description

Launches the computation task of the corresponding operator. This is an asynchronous API. The operator here is a custom operator developed using the Ascend C language.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| funcHandle | Input | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle).<br>Call [aclrtBinaryGetFunction](#aclrtBinaryGetFunction) to obtain **funcHandle** based on **kernelName**. |
| numBlocks | Input | Number of cores on which the kernel function will be executed. |
| argsData | Input | Pointer to the device memory address that stores all input argument data of the kernel function.<br>For details about the memory request API, see [Memory Management](11_memory_management.md).<br>Note that the device that executes the task dispatched by this API must be the same device as the one whose memory is used in **argsData**. |
| argsSize | Input | Size of the **argsData** argument value, in bytes. |
| stream | Input | Stream on which the task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Reference Resources

<a class="method_anchor" id="launch_kernel_comparison"></a>

The following APIs are all used to launch the computation task of the corresponding operator, but they differ in functionality and usage.

| API | Method of Passing Kernel Function Argument Values | Position of Storing Kernel Function Argument Values | Whether Task Dispatch Configuration Can Be Specified |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | Specifies the device memory address pointer that stores all input argument data of the kernel function in the API. | Device memory | No |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | Specifies the device memory address pointer that stores all input parameter data of the kernel function in the API. | Device memory | Yes |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | Specifies the argument list handle **aclrtArgsHandle** in the API. | Host memory | Yes |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | Specifies the host memory address pointer that stores all input argument data of the kernel function in the API. | Host memory | Yes |
| [aclrtLaunchKernelWithArgsArray](#aclrtLaunchKernelWithArgsArray) | Specifies an argument array pointer in the API, where each element points to a parameter data record. | Host memory | Yes |
| [aclrtLaunchSIMTKernelWithArgsArray](#aclrtLaunchSIMTKernelWithArgsArray) | Used for SIMT kernel functions to specify an argument array pointer in the API, where each element points to a parameter data record. | Host memory | Yes |
| [aclrtLaunchSIMTKernelWithHostArgs](#aclrtLaunchSIMTKernelWithHostArgs) | Used for SIMT kernel functions to specify the host memory address pointer that stores all input argument data of the kernel function in the API. | Host memory | Yes |

<br>
<br>
<br>

<a class="method_anchor" id="aclrtLaunchKernelV2"></a>

## aclrtLaunchKernelV2

```c
aclError aclrtLaunchKernelV2(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtLaunchKernelCfg *cfg, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2969 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2969 -->
<!-- npu="A3" id2970 -->
- Atlas A3 products: Supported
<!-- end id2970 -->
<!-- npu="910b" id2971 -->
- Atlas A2 products: Supported
<!-- end id2971 -->
<!-- npu="310b" id2972 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2972 -->
<!-- npu="310p" id2973 -->
- Atlas inference products: Supported
<!-- end id2973 -->
<!-- npu="910" id2974 -->
- Atlas training products: Supported
<!-- end id2974 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id25 -->

### Description

Specifies the configuration information for task dispatch and launches the computation task of the corresponding operator. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| funcHandle | Input | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |
| numBlocks | Input | Number of cores on which the kernel function will be executed. |
| argsData | Input | Device memory address pointer that stores all input argument data of the kernel function.<br>For details about the memory request API, see [Memory Management](11_memory_management.md).<br>Note that the device that executes the task dispatched by this API must be the same device as the one whose memory is used in **argsData**. |
| argsSize | Input | Size of the **argsData** argument value, in bytes. |
| cfg | Input | Configuration information for task dispatch. For details about the type definition, see [aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg).<br>If no configuration is specified, **NULL** can be passed here. |
| stream | Input | Stream on which the task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Reference Resources

For a comparison of the features and usage of each launch API, see the [launch API comparison table](#launch_kernel_comparison).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtLaunchKernelWithConfig"></a>

## aclrtLaunchKernelWithConfig

```c
aclError aclrtLaunchKernelWithConfig(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)
```

### Applicable Products

<!-- npu="950" id2563 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2563 -->
<!-- npu="A3" id2564 -->
- Atlas A3 products: Supported
<!-- end id2564 -->
<!-- npu="910b" id2565 -->
- Atlas A2 products: Supported
<!-- end id2565 -->
<!-- npu="310b" id2566 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2566 -->
<!-- npu="310p" id2567 -->
- Atlas inference products: Supported
<!-- end id2567 -->
<!-- npu="910" id2568 -->
- Atlas training products: Supported
<!-- end id2568 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id26 -->

### Description

Specifies the configuration information for task dispatch and launches the computation task of the corresponding operator. This is an asynchronous API.

If this API is used to dispatch the computation task of an AI Core operator, it must be used together with the [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) API to load and parse the operator binary file.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| funcHandle | Input | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |
| numBlocks | Input | Number of cores on which the kernel function will be executed. |
| stream | Input | Stream on which the task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| cfg | Input | Configuration information for task dispatch. For details about the type definition, see [aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg).<br>If no configuration is specified, **NULL** can be passed here. |
| argsHandle | Input | Argument list handle. For details about the type definition, see [aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle). |
| reserve | Input | Reserved parameter. Currently, **NULL** must be passed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Reference Resources

For a comparison of the features and usage of each launch API, see the [launch API comparison table](#launch_kernel_comparison).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtLaunchKernelWithHostArgs"></a>

## aclrtLaunchKernelWithHostArgs

```c
aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
```

### Applicable Products

<!-- npu="950" id841 -->
- Ascend 950PR&950DT products: Supported
<!-- end id841 -->
<!-- npu="A3" id842 -->
- Atlas A3 products: Supported
<!-- end id842 -->
<!-- npu="910b" id843 -->
- Atlas A2 products: Supported
<!-- end id843 -->
<!-- npu="310b" id844 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id844 -->
<!-- npu="310p" id845 -->
- Atlas inference products: Supported
<!-- end id845 -->
<!-- npu="910" id846 -->
- Atlas training products: Supported
<!-- end id846 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id27 -->

### Description

Specifies the configuration information for task dispatch and launches the computation task of the corresponding operator. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| funcHandle | Input | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |
| numBlocks | Input | Number of cores on which the kernel function will be executed. |
| stream | Input | Stream on which the task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| cfg | Input | Configuration information for task dispatch. For details about the type definition, see [aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg).<br>If no configuration is specified, **NULL** can be passed here. |
| hostArgs | Input | Host memory address pointer that stores all input argument data of the kernel function. |
| argsSize | Input | Size of the **hostArgs** parameter value, in bytes. |
| placeHolderArray | Input | Placeholder parameter array. For details about the type definition, see [aclrtPlaceHolderInfo](25-04_Structs.md#aclrtPlaceHolderInfo). |
| placeHolderNum | Input | Size of the placeholder parameter array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Reference Resources

For a comparison of the features and usage of each launch API, see the [launch API comparison table](#launch_kernel_comparison).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtLaunchKernelWithArgsArray"></a>

## aclrtLaunchKernelWithArgsArray

```c
aclError aclrtLaunchKernelWithArgsArray(void *func, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void **args)
```

### Applicable Products

<!-- npu="950" id701 -->
- Ascend 950PR&950DT products: Supported
<!-- end id701 -->
<!-- npu="A3" id702 -->
- Atlas A3 products: Supported
<!-- end id702 -->
<!-- npu="910b" id703 -->
- Atlas A2 products: Supported
<!-- end id703 -->
<!-- npu="310b" id704 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id704 -->
<!-- npu="310p" id705 -->
- Atlas inference products: Supported
<!-- end id705 -->
<!-- npu="910" id706 -->
- Atlas training products: Supported
<!-- end id706 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id28 -->

### Description

Passes kernel function input arguments in the form of an argument array and launches the computation task of the corresponding operator. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| numBlocks | Input | Number of cores on which the kernel function will be executed.                                                                                     |
| stream | Input | Stream on which the task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).                                   |
| cfg | Input | Configuration information for task dispatch. For details about the type definition, see [aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg).<br>If no configuration is specified, **NULL** can be passed here. |
| args | Input | Argument array pointer.<br/>Each element in the argument array points to the memory address of the kernel function argument data on the host side.                                                        |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API does not support dispatching AI CPU operators; otherwise, **ACL_ERROR_RT_FEATURE_NOT_SUPPORT** is returned.
- The order of elements in the argument array must be consistent with the order of kernel function arguments, and the size of the argument array must be consistent with the number of kernel function arguments; otherwise, undefined behavior occurs.

### Reference Resources

For a comparison of the features and usage of each launch API, see the [launch API comparison table](#launch_kernel_comparison).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateBinary"></a>

## aclrtCreateBinary

```c
aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)
```

### Applicable Products

<!-- npu="950" id3403 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3403 -->
<!-- npu="A3" id3404 -->
- Atlas A3 products: Supported
<!-- end id3404 -->
<!-- npu="910b" id3405 -->
- Atlas A2 products: Supported
<!-- end id3405 -->
<!-- npu="310b" id3406 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3406 -->
<!-- npu="310p" id3407 -->
- Atlas inference products: Supported
<!-- end id3407 -->
<!-- npu="910" id3408 -->
- Atlas training products: Supported
<!-- end id3408 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id29 -->

### Description

Creates data of the **aclrtBinary** type, which is used to describe operator binary information. The operator here refers to a custom operator developed using the Ascend C language.

To destroy data of the **aclrtBinary** type, see [aclrtDestroyBinary](#aclrtDestroyBinary).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| data | Input | Memory address pointer that stores the operator binary file (*.o file) data.<br>In the Ascend EP standard form, memory on the host must be requested here; in the Ascend RC form or the control CPU open form, memory on the device must be requested here. |
| dataLen | Input | Memory size, in bytes. |

### Return Values

Returns a pointer of the **aclrtBinary** type.

## Constraints

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
In the Ascend EP standard form, the **data** parameter requires memory requested on the host.
<!-- end id1 -->

<!-- npu="310p,310b" id2 -->
In the Ascend RC form or control CPU open form, the **data** parameter requires memory requested on the device.
<!-- end id2 -->

<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id38 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyBinary"></a>

## aclrtDestroyBinary

```c
aclError aclrtDestroyBinary(aclrtBinary binary)
```

### Applicable Products

<!-- npu="950" id2241 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2241 -->
<!-- npu="A3" id2242 -->
- Atlas A3 products: Supported
<!-- end id2242 -->
<!-- npu="910b" id2243 -->
- Atlas A2 products: Supported
<!-- end id2243 -->
<!-- npu="310b" id2244 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2244 -->
<!-- npu="310p" id2245 -->
- Atlas inference products: Supported
<!-- end id2245 -->
<!-- npu="910" id2246 -->
- Atlas training products: Supported
<!-- end id2246 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id30 -->

### Description

Destroys data of the **aclrtBinary** type created by the [aclrtCreateBinary](#aclrtCreateBinary) API. The operator here is a custom operator developed using Ascend C.

Note that this API only destroys the **aclrtBinary** data. The **data** memory passed in when calling the [aclrtCreateBinary](#aclrtCreateBinary) API must be released by the user in a timely manner; otherwise, memory exceptions may occur.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| binary | Input | **aclrtBinary** data to be destroyed. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinaryLoad"></a>

## aclrtBinaryLoad

```c
aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)
```

### Applicable Products

<!-- npu="950" id533 -->
- Ascend 950PR&950DT products: Supported
<!-- end id533 -->
<!-- npu="A3" id534 -->
- Atlas A3 products: Supported
<!-- end id534 -->
<!-- npu="910b" id535 -->
- Atlas A2 products: Supported
<!-- end id535 -->
<!-- npu="310b" id536 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id536 -->
<!-- npu="310p" id537 -->
- Atlas inference products: Supported
<!-- end id537 -->
<!-- npu="910" id538 -->
- Atlas training products: Supported
<!-- end id538 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id31 -->

### Description

Loads and parses the operator binary file, outputs the **binHandle** pointing to the operator binary, and copies the operator binary file data to the device corresponding to the current context. The operator here is a custom operator developed using the Ascend C language.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binary | Input | Operator binary information.<br>Before calling this API, call [aclrtCreateBinary](#aclrtCreateBinary) to obtain the pointer to the data of the **aclrtBinary** type. |
| binHandle | Output | Handle pointing to the binary. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinaryUnLoad"></a>

## aclrtBinaryUnLoad

```c
aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)
```

### Applicable Products

<!-- npu="950" id2514 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2514 -->
<!-- npu="A3" id2515 -->
- Atlas A3 products: Supported
<!-- end id2515 -->
<!-- npu="910b" id2516 -->
- Atlas A2 products: Supported
<!-- end id2516 -->
<!-- npu="310b" id2517 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2517 -->
<!-- npu="310p" id2518 -->
- Atlas inference products: Supported
<!-- end id2518 -->
<!-- npu="910" id2519 -->
- Atlas training products: Supported
<!-- end id2519 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id32 -->

### Description

Deletes the operator binary data pointed to by **binHandle**, and also deletes the operator binary data copied to the device when the operator binary file is loaded.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binHandle | Input | Operator binary handle. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle).<br>This handle is generated when calling [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile), [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData), or [aclrtBinaryLoad](#aclrtBinaryLoad). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- When calling this API to delete operator binary data, it must be used in the same context as [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile), [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData), or [aclrtBinaryLoad](#aclrtBinaryLoad), so that the operator binary data copied to the device when loading the operator binary file can be deleted together. Otherwise, the operator binary data on the device may be deleted abnormally.
- If operator binary data is loaded and unloaded frequently, the Program Counter (PC) virtual addresses within the same process may be reused and hit the cache, which may cause operator execution exceptions or precision issues. Therefore, it is not recommended to call this API frequently. Call this API to unload the operator binary data only after all operator-related tasks have been completed.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFunctionGetBinary"></a>

## aclrtFunctionGetBinary

```c
aclError aclrtFunctionGetBinary(const void *func, aclrtBinHandle *binHandle)
```

### Applicable Products

<!-- npu="950" id2843 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2843 -->
<!-- npu="A3" id2844 -->
- Atlas A3 products: Supported
<!-- end id2844 -->
<!-- npu="910b" id2845 -->
- Atlas A2 products: Supported
<!-- end id2845 -->
<!-- npu="310b" id2846 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2846 -->
<!-- npu="310p" id2847 -->
- Atlas inference products: Supported
<!-- end id2847 -->
<!-- npu="910" id2848 -->
- Atlas training products: Supported
<!-- end id2848 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id33 -->

### Description

Obtains the operator binary handle.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| binHandle | Output | Operator binary handle. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFunctionGetParamCount"></a>

## aclrtFunctionGetParamCount

```c
aclError aclrtFunctionGetParamCount(const void *func, size_t *paramCount)
```

### Applicable Products

<!-- npu="950" id260 -->
- Ascend 950PR&950DT products: Supported
<!-- end id260 -->
<!-- npu="A3" id261 -->
- Atlas A3 products: Supported
<!-- end id261 -->
<!-- npu="910b" id262 -->
- Atlas A2 products: Supported
<!-- end id262 -->
<!-- npu="310b" id263 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id263 -->
<!-- npu="310p" id264 -->
- Atlas inference products: Supported
<!-- end id264 -->
<!-- npu="910" id265 -->
- Atlas training products: Supported
<!-- end id265 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id34 -->

### Description

Obtains the number of parameters contained in the kernel function argument list.

After using this API to query the number of parameters contained in the kernel function argument list, use it together with the [aclrtFunctionGetParamInfo](#aclrtFunctionGetParamInfo) API to traverse and obtain the detailed information (offset and size) of each parameter.

### Parameters

| Name | Input/Output | Description                                                                |
| --- | :---: |-------------------------------------------------------------------|
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| paramCount | Output | Number of parameters contained in the kernel function argument list.                                                 |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFunctionGetParamInfo"></a>

## aclrtFunctionGetParamInfo

```c
aclError aclrtFunctionGetParamInfo(const void *func, size_t paramIndex, size_t *paramOffset, size_t *paramSize)
```

### Applicable Products

<!-- npu="950" id2248 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2248 -->
<!-- npu="A3" id2249 -->
- Atlas A3 products: Supported
<!-- end id2249 -->
<!-- npu="910b" id2250 -->
- Atlas A2 products: Supported
<!-- end id2250 -->
<!-- npu="310b" id2251 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2251 -->
<!-- npu="310p" id2252 -->
- Atlas inference products: Supported
<!-- end id2252 -->
<!-- npu="910" id2253 -->
- Atlas training products: Supported
<!-- end id2253 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id35 -->

### Description

Obtains the kernel function parameter information (offset and size) based on the index.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| paramIndex | Input | Parameter index.<br/> After calling [aclrtFunctionGetParamCount](#aclrtFunctionGetParamCount) to obtain the number of available parameters, the value range of **paramIndex** is [0, (Number of parameters - 1)]. |
| paramOffset | Output | Offset of the parameter in the argument data area, in bytes. |
| paramSize | Output | Size of the parameter, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFunctionGetAvailDynUbufPerBlock"></a>

## aclrtFunctionGetAvailDynUbufPerBlock

```c
aclError aclrtFunctionGetAvailDynUbufPerBlock(const void *func, uint32_t flags, size_t *dynamicUbufSize)
```

### Applicable Products

<!-- npu="950" id3263 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3263 -->
<!-- npu="A3" id3264 -->
- Atlas A3 products: Supported
<!-- end id3264 -->
<!-- npu="910b" id3265 -->
- Atlas A2 products: Supported
<!-- end id3265 -->
<!-- npu="310b" id3266 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3266 -->
<!-- npu="310p" id3267 -->
- Atlas inference products: Supported
<!-- end id3267 -->
<!-- npu="910" id3268 -->
- Atlas training products: Supported
<!-- end id3268 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id36 -->

### Description

Outputs the maximum dynamic UB buffer size that can be set before kernel launch through **dynamicUbufSize** for Single Instruction Multiple Thread (SIMT) kernel functions.

For non-SIMT kernel functions, this API returns success, and `dynamicUbufSize` is fixed to **0**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| flags | Input | Reserved parameter, currently fixed to **0**. |
| dynamicUbufSize | Output | Dynamic UB buffer size available for each block, in bytes. It cannot be empty. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetFuncBySymbol"></a>

## aclrtGetFuncBySymbol

```c
aclError aclrtGetFuncBySymbol(const void *symbol, aclrtFuncHandle *funcHandle)
```

### Applicable Products

<!-- npu="950" id603 -->
- Ascend 950PR&950DT products: Supported
<!-- end id603 -->
<!-- npu="A3" id604 -->
- Atlas A3 products: Supported
<!-- end id604 -->
<!-- npu="910b" id605 -->
- Atlas A2 products: Supported
<!-- end id605 -->
<!-- npu="310b" id606 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id606 -->
<!-- npu="310p" id607 -->
- Atlas inference products: Supported
<!-- end id607 -->
<!-- npu="910" id608 -->
- Atlas training products: Not supported
<!-- end id608 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id37 -->

### Description

Obtains the kernel function handle based on the kernel function name (the function name declared with `__global__`, for example, **myKernel**).

This API applies only to the scenario where custom operators are developed using the Ascend C language and host and device code are compiled together based on the BiSheng compiler. It does not apply to the scenario of directly loading operator binary files.
After a user defines a device-side kernel function, this API can be used to find the corresponding kernel function in the internal symbol table based on the kernel function name, and express it with **funcHandle** for subsequent kernel launch.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Kernel function name. |
| funcHandle | Output | Kernel function handle. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API can be used only in static operator shape scenarios and supports only AI Core operators.
- The kernel function handle is valid only on the current device. After switching the device, you need to obtain the handle again.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtLaunchSIMTKernelWithArgsArray"></a>

## aclrtLaunchSIMTKernelWithArgsArray

```c
aclError aclrtLaunchSIMTKernelWithArgsArray(void *func, dim3 gridDim, dim3 blockDim, size_t dynUbufSize, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void **args)
```

### Applicable Products

<!-- npu="950" id3494 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3494 -->
<!-- npu="A3" id3495 -->
- Atlas A3 products: Not supported
<!-- end id3495 -->
<!-- npu="910b" id3496 -->
- Atlas A2 products: Not supported
<!-- end id3496 -->
<!-- npu="310b" id3497 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3497 -->
<!-- npu="310p" id3498 -->
- Atlas inference products: Not supported
<!-- end id3498 -->
<!-- npu="910" id3499 -->
- Atlas training products: Not supported
<!-- end id3499 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id39 -->

### Description

Passes the Single Instruction Multiple Thread (SIMT) kernel function input arguments in the form of an argument array and launches the computation task of the corresponding operator. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| gridDim | Input | Thread block grid, composed of multiple thread blocks. The grid uses a three-dimensional structure, and its dimensions X, Y, and Z respectively represent the size of the thread blocks in different dimensions. For details about the type definition, see [dim3](25-04_Structs.md#dim3). |
| blockDim | Input | Thread block, which uses a three-dimensional structure. Its dimensions X, Y, and Z respectively represent the number of threads in the three dimensions of the thread block. For details about the type definition, see [dim3](25-04_Structs.md#dim3). |
| dynUbufSize | Input | Dynamic memory size of the Unified Buffer (UB) required for Single Instruction Multiple Thread (SIMT) operator execution, in bytes. If the **ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE** attribute is also set in cfg, this parameter takes higher priority. |
| stream | Input | Stream on which the task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| cfg | Input | Configuration information for task dispatch. For details about the type definition, see [aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg).<br>If no configuration is specified, **NULL** can be passed here. |
| args | Input | Pointer to the argument array.<br/>Each element in the argument array points to the memory address of the kernel function parameter data on the Host side. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The order of elements in the argument array must be consistent with the order of the kernel function arguments, and the size of the argument array must be consistent with the number of kernel function arguments; otherwise, undefined behavior occurs.

### Reference Resources

For a comparison of the features and usage of each launch API, see the [launch API comparison table](#launch_kernel_comparison).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtLaunchSIMTKernelWithHostArgs"></a>

## aclrtLaunchSIMTKernelWithHostArgs

```c
aclError aclrtLaunchSIMTKernelWithHostArgs(void *func, dim3 gridDim, dim3 blockDim, size_t dynUbufSize, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
```

### Applicable Products

<!-- npu="950" id3501 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3501 -->
<!-- npu="A3" id3502 -->
- Atlas A3 products: Not supported
<!-- end id3502 -->
<!-- npu="910b" id3503 -->
- Atlas A2 products: Not supported
<!-- end id3503 -->
<!-- npu="310b" id3504 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3504 -->
<!-- npu="310p" id3505 -->
- Atlas inference products: Not supported
<!-- end id3505 -->
<!-- npu="910" id3506 -->
- Atlas training products: Not supported
<!-- end id3506 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id40 -->

### Description

Passes the input arguments of a Single Instruction Multiple Thread (SIMT) kernel function based on host memory parameters, and launches the computation task of the corresponding operator. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| func | Input | Kernel function pointer. This can be a kernel function name declared with `__global__` (for example, **myKernel**, which is applicable only to the scenario where custom operators are developed in Ascend C and host and device code are compiled together based on the BiSheng compiler), or a kernel function handle of the [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle) type. |
| gridDim | Input | Thread block grid, which consists of multiple thread blocks. The grid uses a three-dimensional structure, and its dimensions X, Y, and Z respectively indicate the size of the thread block in different dimensions. For details about the type definition, see [dim3](25-04_Structs.md#dim3). |
| blockDim | Input | Thread block, which uses a three-dimensional structure, and its dimensions X, Y, and Z respectively indicate the number of threads in the three dimensions of the thread block. For details about the type definition, see [dim3](25-04_Structs.md#dim3). |
| dynUbufSize | Input | Dynamic memory size of the Unified Buffer (UB) required for executing the Single Instruction Multiple Thread (SIMT) operator, in bytes. If the **ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE** attribute is also set in cfg, this parameter takes precedence. |
| stream | Input | Stream on which the task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| cfg | Input | Configuration information for task dispatch. For details about the type definition, see [aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg).<br>If no configuration is specified, **NULL** can be passed here. |
| hostArgs | Input | Host memory address pointer that stores all input argument data of the kernel function. |
| argsSize | Input | Size of the **hostArgs** parameter value, in bytes. |
| placeHolderArray | Input | Placeholder parameter array. For details about the type definition, see [aclrtPlaceHolderInfo](25-04_Structs.md#aclrtPlaceHolderInfo). |
| placeHolderNum | Input | Size of the placeholder parameter array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The **hostArgs** memory must be compactly arranged in the order of the kernel function arguments, and **argsSize** must match the actual total size of the arguments.
- The address offsets in **placeHolderArray** must correspond to the actual positions of the placeholder arguments in **hostArgs**.

### Reference Resources

For a comparison of the features and usage of each launch API, see the [launch API comparison table](#launch_kernel_comparison).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtBinaryGetFunctionCount"></a>

## aclrtBinaryGetFunctionCount

```c
aclError aclrtBinaryGetFunctionCount(const aclrtBinHandle binHandle, uint32_t *count)
```

### Applicable Products

<!-- npu="950" id4001 -->
- Ascend 950PR&950DT products: Supported
<!-- end id4001 -->
<!-- npu="A3" id4002 -->
- Atlas A3 products: Supported
<!-- end id4002 -->
<!-- npu="910b" id4003 -->
- Atlas A2 products: Supported
<!-- end id4003 -->
<!-- npu="310b" id4004 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id4004 -->
<!-- npu="310p" id4005 -->
- Atlas inference products: Supported
<!-- end id4005 -->
<!-- npu="910" id4006 -->
- Atlas training products: Supported
<!-- end id4006 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id41 -->

### Description

Obtains the number of kernel functions in the operator binary.

After loading the operator binary through [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) or [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData), the user can call this API to obtain the number of kernel functions contained in the operator binary.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binHandle | Input | Operator binary handle. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle).<br>Call the [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) API or the [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) API to obtain the operator binary handle, and then pass it as an input parameter to this API. |
| count | Output | Number of kernel functions. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>
<a class="method_anchor" id="aclrtBinaryEnumerateFunctions"></a>

## aclrtBinaryEnumerateFunctions

```c
aclError aclrtBinaryEnumerateFunctions(const aclrtBinHandle binHandle, aclrtFuncHandle *funcHandles, uint32_t numFunctions)
```

### Applicable Products

<!-- npu="950" id84247 -->
- Ascend 950PR&950DT: Supported
<!-- end id84247 -->
<!-- npu="A3" id84248 -->
- Atlas A3 products: Supported
<!-- end id84248 -->
<!-- npu="910b" id84249 -->
- Atlas A2 products: Supported
<!-- end id84249 -->
<!-- npu="310b" id84250 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id84250 -->
<!-- npu="310p" id84251 -->
- Atlas inference products: Supported
<!-- end id84251 -->
<!-- npu="910" id84252 -->
- Atlas training products: Supported
<!-- end id84252 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_Kernel_loading_and_execution_res.md#id42 -->
### Description

Obtains the specified number of kernel function handles in the operator binary.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| binHandle | Input | Operator binary handle. For details about the type definition, see [aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle).<br>Call [aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile) or [aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData) to obtain the operator binary handle, and then pass it as an input parameter to this API. |
| funcHandles | Output | Kernel function handle array. For details about the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |
| numFunctions | Input | Number of kernel function handles to obtain, which can be obtained by calling [aclrtBinaryGetFunctionCount](#aclrtBinaryGetFunctionCount) first.<br>When numFunctions==0, no kernel function handle needs to be obtained.<br>When numFunctions≤len(funcHandles), **numFunctions** kernel function handles are returned.<br>When numFunctions>len(funcHandles), **len(funcHandles)** kernel function handles are returned.|

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
