# 14. Kernel加载与执行

本章节描述 CANN Runtime 的 Kernel 加载与执行接口，包括二进制加载、函数获取、参数组装及 Kernel 启动。

---

- [概念及使用说明](#概念及使用说明)
- [`aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)`](#aclrtBinaryLoadFromFile)：从文件加载并解析算子二进制文件，输出指向算子二进制的binHandle。
- [`aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)`](#aclrtBinaryLoadFromData)：从内存加载并解析算子二进制数据，输出指向算子二进制的binHandle。
- [`aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)`](#aclrtBinaryGetFunction)：根据核函数名称，查找到对应的核函数，并使用funcHandle表达。
- [`aclError aclrtBinaryGetFunctionByEntry(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)`](#aclrtBinaryGetFunctionByEntry)：根据Function Entry获取核函数句柄。
- [`aclError aclrtBinaryGetDevAddress(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)`](#aclrtBinaryGetDevAddress)：获取算子二进制数据在Device上的内存地址及内存大小。
- [`aclError aclrtBinaryGetGlobal(aclrtBinHandle binHandle, const char *name, void **dptr, size_t *size)`](#aclrtBinaryGetGlobal)：根据全局变量名称获取Device侧全局变量的地址和大小。
- [`aclError aclrtBinarySetExceptionCallback(aclrtBinHandle binHandle, aclrtOpExceptionCallback callback, void *userData)`](#aclrtBinarySetExceptionCallback)：调用本接口注册回调函数。若多次设置回调函数，以最后一次设置为准。
- [`aclError aclrtGetArgsFromExceptionInfo(const aclrtExceptionInfo *info, void **devArgsPtr, uint32_t *devArgsLen)`](#aclrtGetArgsFromExceptionInfo)：从aclrtExceptionInfo异常信息中获取用户下发算子执行任务时的参数。
- [`aclError aclrtGetFuncHandleFromExceptionInfo(const aclrtExceptionInfo *info, aclrtFuncHandle *func)`](#aclrtGetFuncHandleFromExceptionInfo)：从aclrtExceptionInfo异常信息中获取核函数句柄。
- [`aclError aclrtGetFunctionAddr(aclrtFuncHandle funcHandle, void **aicAddr, void **aivAddr)`](#aclrtGetFunctionAddr)：根据核函数句柄获取Device侧算子起始地址。
- [`aclError aclrtGetFunctionSize(aclrtFuncHandle funcHandle, size_t *aicSize, size_t *aivSize)`](#aclrtGetFunctionSize)：根据核函数句柄获取核函数代码段的大小。
- [`aclError aclrtGetFunctionName(aclrtFuncHandle funcHandle, uint32_t maxLen, char *name)`](#aclrtGetFunctionName)：根据核函数句柄获取核函数名称。
- [`aclError aclrtGetFunctionAttribute(aclrtFuncHandle funcHandle, aclrtFuncAttribute attrType, int64_t *attrValue)`](#aclrtGetFunctionAttribute)：根据核函数句柄获取核函数属性信息。
- [`aclError aclrtGetHardwareSyncAddr(void **addr)`](#aclrtGetHardwareSyncAddr)：获取Cube Core、Vector Core之间的同步地址。
- [`aclError aclrtRegisterCpuFunc(const aclrtBinHandle handle, const char *funcName, const char *kernelName, aclrtFuncHandle *funcHandle)`](#aclrtRegisterCpuFunc)：若使用[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口加载AI CPU算子二进制数据，还需配合使用本接口注册AI CPU算子信息，得到对应的funcHandle。
- [`aclError aclrtKernelArgsInit(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)`](#aclrtKernelArgsInit)：根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。
- [`aclError aclrtKernelArgsInitByUserMem(aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, void *userHostMem, size_t actualArgsSize)`](#aclrtKernelArgsInitByUserMem)：根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。
- [`aclError aclrtKernelArgsGetMemSize(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)`](#aclrtKernelArgsGetMemSize)：获取Kernel Launch时参数列表所需内存的实际大小。
- [`aclError aclrtKernelArgsGetHandleMemSize(aclrtFuncHandle funcHandle, size_t *memSize)`](#aclrtKernelArgsGetHandleMemSize)：获取参数列表句柄占用的内存大小。
- [`aclError aclrtKernelArgsAppend(aclrtArgsHandle argsHandle, void *param, size_t paramSize, aclrtParamHandle *paramHandle)`](#aclrtKernelArgsAppend)：调用本接口将用户设置的参数值追加拷贝到argsHandle指向的参数数据区域。若参数列表中有多个参数，则需按顺序追加参数。
- [`aclError aclrtKernelArgsAppendPlaceHolder(aclrtArgsHandle argsHandle, aclrtParamHandle *paramHandle)`](#aclrtKernelArgsAppendPlaceHolder)：对于placeholder参数，调用本接口先占位，返回的是paramHandle占位符。
- [`aclError aclrtKernelArgsGetPlaceHolderBuffer(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, size_t dataSize, void **bufferAddr)`](#aclrtKernelArgsGetPlaceHolderBuffer)：根据用户指定的内存大小，获取paramHandle占位符指向的内存地址。
- [`aclError aclrtKernelArgsParaUpdate(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param, size_t paramSize)`](#aclrtKernelArgsParaUpdate)：通过aclrtKernelArgsAppend接口追加的参数，可调用本接口更新参数值。
- [`aclError aclrtKernelArgsFinalize(aclrtArgsHandle argsHandle)`](#aclrtKernelArgsFinalize)：在所有参数追加完成后，调用本接口以标识参数组装完毕。
- [`aclError aclrtLaunchKernel(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtStream stream)`](#aclrtLaunchKernel)：启动对应算子的计算任务，异步接口。此处的算子为使用Ascend C语言开发的自定义算子。
- [`aclError aclrtLaunchKernelV2(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtLaunchKernelCfg *cfg, aclrtStream stream)`](#aclrtLaunchKernelV2)：指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。
- [`aclError aclrtLaunchKernelWithConfig(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)`](#aclrtLaunchKernelWithConfig)：指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。
- [`aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)`](#aclrtLaunchKernelWithHostArgs)：指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。
- [`aclError aclrtLaunchKernelWithArgsArray(void *func, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void **args)`](#aclrtLaunchKernelWithArgsArray)：使用参数数组启动核函数计算任务，异步接口。
- [`aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)`](#aclrtCreateBinary)：创建aclrtBinary类型的数据，该数据类型用于描述算子二进制信息。此处的算子为使用Ascend C语言开发的自定义算子。
- [`aclError aclrtDestroyBinary(aclrtBinary binary)`](#aclrtDestroyBinary)：销毁通过[aclrtCreateBinary](#aclrtCreateBinary)接口创建的aclrtBinary类型的数据。
- [`aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)`](#aclrtBinaryLoad)：解析、加载算子二进制文件，输出指向算子二进制的binHandle，同时将算子二进制文件数据拷贝至当前Context对应的Device上。
- [`aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)`](#aclrtBinaryUnLoad)：删除binHandle指向的算子二进制数据，同时也删除加载算子二进制文件时拷贝到Device上的算子二进制数据。
- [`aclError aclrtFunctionGetBinary(const aclrtFuncHandle funcHandle, aclrtBinHandle *binHandle)`](#aclrtFunctionGetBinary)：根据核函数句柄获取算子二进制句柄。
- [`aclError aclrtFunctionGetParamCount(const void *func, size_t *paramCount)`](#aclrtFunctionGetParamCount)：从核函数句柄获取参数个数。
- [`aclError aclrtFunctionGetParamInfo(const void *func, size_t paramIndex, size_t *paramOffset, size_t *paramSize)`](#aclrtFunctionGetParamInfo)：根据索引从核函数句柄获取参数信息。
- [`aclError aclrtFunctionGetAvailDynUbufPerBlock(void *func, uint32_t flags, size_t *dynamicUbufSize)`](#aclrtFunctionGetAvailDynUbufPerBlock)：从核函数句柄获取每个Block可用的动态UB buffer大小。
- [`aclError aclrtGetFuncBySymbol(const void *symbol, aclrtFuncHandle *funcHandle)`](#aclrtGetFuncBySymbol)：根据核函数名获取核函数句柄。

## 概念及使用说明

### 相关概念

本章中的接口涉及对算子的算子二进制、核函数、核函数参数列表以及参数的操作，为便于理解，您可以先通过下图了解它们之间的关系。

![](figures/operator_binary_and_kernel_function_relationship.png)

- **算子二进制**：编译算子源码，可得到算子二进制文件\*.o。对于CANN内置算子，可从算子二进制包（包名为Ascend-cann-\*-ops-\*.run）中获取算子二进制文件。对于自定义算子，可在编译算子、发布二进制之后获取算子二进制文件。自定义算子的开发、编译请参见[《Ascend C算子开发指南》](https://hiascend.com/document/redirect/CannCommunityOpdevAscendC)。
- **核函数**：是算子设备侧实现的入口函数。当前允许使用C/C++函数的语法扩展来编写设备端的运行代码，用户在核函数中进行数据访问和计算操作，由此实现该算子的所有功能。

### Kernel加载与执行接口调用流程

![](figures/kernel_loading_and_execution_process.png)

关键流程说明如下：

1. 调用[aclInit](02_initialization_and_deinitialization.md#aclInit)接口初始化。
2. 申请运行时资源，包括调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口指定用于运算的Device、调用[aclrtCreateStream](06_stream_management.md#aclrtCreateStream)接口创建Stream。
3. 调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口加载算子二进制文件。

    AI CPU算子还支持从内存加载算子二进制数据的方式（调用[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口），但加载算子二进制数据后，还需配合使用[aclrtRegisterCpuFunc](#aclrtRegisterCpuFunc)接口注册AI CPU算子信息。

4. 调用[aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry)或[aclrtBinaryGetFunction](#aclrtBinaryGetFunction)接口获取核函数句柄。
5. **（可选）**根据核函数句柄操作其参数列表，操作包括：
    1. **初始化参数列表**

        当前支持由系统管理内存（调用[aclrtKernelArgsInit](#aclrtKernelArgsInit)接口）、由用户管理内存（调用[aclrtKernelArgsInitByUserMem](#aclrtKernelArgsInitByUserMem)接口）两种方式。

    2. **追加参数、更新参数值**

        核函数参数列表中包含不同类型的参数，例如指针类型参数、placeholder、uint8\_t类型参数等，其中：

        - 指针类型参数：其值为Device内存地址。一般来说，算子的输入、输出是该种类型的参数，用户需提前调用Device内存申请接口（例如[aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc)接口）申请内存，并自行拷贝数据至Device侧。
        - placeholder：也是指针类型参数，但区别在于，用户无需手动将参数数据复制到Device，这项操作由Runtime完成。在追加参数时Runtime并不会填写真实的Device地址，而是在Launch Kernel时才会刷新为真实的Device地址，所以称之为placeholder。对算子的非输入、输出参数，可以使用placeholder方式，将小块数据（建议小于2KB）的Host-\>Device拷贝合并到Launch Kernel时的一次拷贝操作中去，减少拷贝次数，提升性能。

        ![](figures/kernel_function_parameter_list_diagram.png)

        **不同类型参数，可调用不同的参数追加接口：**

        - 对于placeholder参数，由于关联的内存必须放在所有参数之后，所以在追加参数时，先调用[aclrtKernelArgsAppendPlaceHolder](#aclrtKernelArgsAppendPlaceHolder)接口占位，等所有参数都追加之后，可调用[aclrtKernelArgsGetPlaceHolderBuffer](#aclrtKernelArgsGetPlaceHolderBuffer)接口获取对应占位符指向的内存地址。用户可根据获取的内存地址，管理该内存中的数据。
        - 对于非placeholder参数（例如指针类型参数、uint8\_t类型参数等），调用[aclrtKernelArgsAppend](#aclrtKernelArgsAppend)接口将用户设置的参数值追加拷贝到argsHandle指向的参数数据区域。如果要更新参数值，可调用[aclrtKernelArgsParaUpdate](#aclrtKernelArgsParaUpdate)接口进行更新。

        **注意**，核函数参数列表中，实际可能存在多个参数，并且不同类型的参数可能交错出现，因此需要按照参数列表中的参数顺序从左到右进行追加，追加的参数最多支持128个。

    3. **结束参数列表的追加、参数值的更新**

        在所有参数追加之后，调用[aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize)接口以标识参数组装完毕。但[aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize)接口之后，也支持继续更新参数值，更新之后，还要再调用一次[aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize)接口。

6. 调用Launch Kernel接口，启动对应算子的计算任务。

    若使用aclrtArgsHandle参数列表句柄组装核函数的入参数据，则调用[aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig)接口启动对应算子的计算任务。该方式下，用户只需按顺序在参数列表中追加参数，无需关注内存中的组装细节，也无需关注内部参数。

    若核函数的入参数据都存放在Host或Device内存中，则调用[aclrtLaunchKernel](#aclrtLaunchKernel)、[aclrtLaunchKernelV2](#aclrtLaunchKernelV2)或[aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs)接口启动对应算子的计算任务。

7. 调用接口[aclrtBinaryUnLoad](#aclrtBinaryUnLoad)卸载算子二进制文件。
8. 释放运行时资源，包括调用[aclrtDestroyStream](06_stream_management.md#aclrtDestroyStream)接口释放Stream、调用[aclrtResetDevice](04_device_management.md#aclrtResetDevice)接口释放Device上的资源。
9. 调用[aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)接口去初始化。

<a id="aclrtBinaryLoadFromFile"></a>

## aclrtBinaryLoadFromFile

```c
aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
```

### 产品支持情况

<!-- npu="950" id2997 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2997 -->
<!-- npu="A3" id2998 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2998 -->
<!-- npu="910b" id2999 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2999 -->
<!-- npu="310b" id3000 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3000 -->
<!-- npu="310p" id3001 -->
- Atlas 推理系列产品：支持
<!-- end id3001 -->
<!-- npu="910" id3002 -->
- Atlas 训练系列产品：支持
<!-- end id3002 -->
<!-- npu="IPV350" id3003 -->
- IPV350：不支持
<!-- end id3003 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id1 -->

### 功能说明

从文件加载并解析算子二进制文件，输出指向算子二进制的binHandle。

对于AI Core算子，若使用本接口加载并解析算子二进制文件，需配套使用[aclrtLaunchKernelWithConfig](#aclrtBinaryLoadFromFile)、[aclrtLaunchKernelV2](#aclrtLaunchKernelV2)或[aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs)接口下发计算任务。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binPath | 输入 | 算子二进制文件（*.o文件）的路径，要求绝对路径。<br>对于AI CPU算子，该参数支持传算子信息库文件（*.json）。 |
| options | 输入 | 加载算子二进制文件的可选参数。类型定义请参见[aclrtBinaryLoadOptions](25-04_Structs.md#aclrtBinaryLoadOptions)。 |
| binHandle | 输出 | 标识算子二进制的句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

针对某一型号的产品，编译生成的算子二进制文件，必须在相同型号的产品上使用。

<br>
<br>
<br>

<a id="aclrtBinaryLoadFromData"></a>

## aclrtBinaryLoadFromData

```c
aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
```

### 产品支持情况

<!-- npu="950" id71 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id71 -->
<!-- npu="A3" id72 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id72 -->
<!-- npu="910b" id73 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id73 -->
<!-- npu="310b" id74 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id74 -->
<!-- npu="310p" id75 -->
- Atlas 推理系列产品：支持
<!-- end id75 -->
<!-- npu="910" id76 -->
- Atlas 训练系列产品：支持
<!-- end id76 -->
<!-- npu="IPV350" id77 -->
- IPV350：不支持
<!-- end id77 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id2 -->

### 功能说明

从内存加载并解析算子二进制数据，输出指向算子二进制的binHandle。

调用本接口用于加载AI CPU算子信息（[aclrtBinaryLoadOption](25-04_Structs.md#aclrtBinaryLoadOption).type包含ACL\_RT\_BINARY\_LOAD\_OPT\_CPU\_KERNEL\_MODE）时，还需配合使用[aclrtRegisterCpuFunc](#aclrtRegisterCpuFunc)接口注册AI CPU算子。

注意，系统仅将算子加载至当前Context所对应的Device上，因此在调用[aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig)接口启动算子计算任务时，所在的Device必须与算子加载时的Device相同。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| data | 输入 | 存放算子二进制数据的Host内存地址，不能为空。 |
| length | 输入 | 算子二进制数据的内存大小，必须大于0，单位Byte。 |
| options | 输入 | 加载算子二进制文件的可选参数。类型定义请参见[aclrtBinaryLoadOptions](25-04_Structs.md#aclrtBinaryLoadOptions)。 |
| binHandle | 输出 | 标识算子二进制的句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtBinaryGetFunction"></a>

## aclrtBinaryGetFunction

```c
aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)
```

### 产品支持情况

<!-- npu="950" id3389 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3389 -->
<!-- npu="A3" id3390 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3390 -->
<!-- npu="910b" id3391 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3391 -->
<!-- npu="310b" id3392 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3392 -->
<!-- npu="310p" id3393 -->
- Atlas 推理系列产品：支持
<!-- end id3393 -->
<!-- npu="910" id3394 -->
- Atlas 训练系列产品：支持
<!-- end id3394 -->
<!-- npu="IPV350" id3395 -->
- IPV350：不支持
<!-- end id3395 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id3 -->

### 功能说明

根据核函数名称，查找到对应的核函数，并使用funcHandle表达。

对于同一个binHandle，首次调用aclrtBinaryGetFunction接口时，会默认将binHandle关联的算子二进制数据拷贝至当前Context对应的Device上。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| kernelName | 输入 | 核函数名称。 |
| funcHandle | 输出 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtBinaryGetFunctionByEntry"></a>

## aclrtBinaryGetFunctionByEntry

```c
aclError aclrtBinaryGetFunctionByEntry(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)
```

**须知：本接口为预留接口，暂不支持。**

### 功能说明

根据Function Entry获取核函数句柄。

对于同一个binHandle，首次调用aclrtBinaryGetFunctionByEntry接口时，会默认将binHandle关联的算子二进制数据拷贝至当前Context对应的Device上。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| funcEntry | 输入 | 标识核函数的关键字。 |
| funcHandle | 输出 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtBinaryGetDevAddress"></a>

## aclrtBinaryGetDevAddress

```c
aclError aclrtBinaryGetDevAddress(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)
```

### 产品支持情况

<!-- npu="950" id2794 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2794 -->
<!-- npu="A3" id2795 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2795 -->
<!-- npu="910b" id2796 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2796 -->
<!-- npu="310b" id2797 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2797 -->
<!-- npu="310p" id2798 -->
- Atlas 推理系列产品：支持
<!-- end id2798 -->
<!-- npu="910" id2799 -->
- Atlas 训练系列产品：支持
<!-- end id2799 -->
<!-- npu="IPV350" id2800 -->
- IPV350：不支持
<!-- end id2800 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id4 -->

### 功能说明

获取算子二进制数据在Device上的内存地址及内存大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| binAddr | 输出 | 算子二进制数据在Device上的内存地址。<br>如果加载算子二进制时设置了懒加载标识（将aclrtBinaryLoadOptions.aclrtBinaryLoadOption.[aclrtBinaryLoadOptionValue](25-04_Structs.md#aclrtBinaryLoadOptionValue).isLazyLoad设置为1），那么调用本接口获取到的binAddr为空指针。 |
| binSize | 输出 | 算子二进制数据的大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtBinaryGetGlobal"></a>

## aclrtBinaryGetGlobal

```c
aclError aclrtBinaryGetGlobal(aclrtBinHandle binHandle, const char *name, void **dptr, size_t *size)
```

### 产品支持情况

<!-- npu="950" id1723 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1723 -->
<!-- npu="A3" id1724 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1724 -->
<!-- npu="910b" id1725 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1725 -->
<!-- npu="310b" id1726 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1726 -->
<!-- npu="310p" id1727 -->
- Atlas 推理系列产品：支持
<!-- end id1727 -->
<!-- npu="910" id1728 -->
- Atlas 训练系列产品：支持
<!-- end id1728 -->
<!-- npu="IPV350" id1729 -->
- IPV350：不支持
<!-- end id1729 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id5 -->

### 功能说明

根据全局变量名称，获取算子二进制中的全局变量在Device侧的内存地址和大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| name | 输入 | 全局变量名称。需与算子二进制中定义的全局变量名称一致。                                                                                                                                                                               |
| dptr | 输出 | Device侧全局变量的地址指针。<br/>若此处传nullptr，表示不需要获取地址。                                                                                                                                                              |
| size | 输出 | Device侧全局变量的大小，单位Byte。<br/>若此处传nullptr，表示不需要获取大小。<br>dptr和size不能同时为nullptr。                                                                                                                              |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtBinarySetExceptionCallback"></a>

## aclrtBinarySetExceptionCallback

```c
aclError aclrtBinarySetExceptionCallback(aclrtBinHandle binHandle, aclrtOpExceptionCallback callback, void *userData)
```

### 产品支持情况

<!-- npu="950" id274 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id274 -->
<!-- npu="A3" id275 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id275 -->
<!-- npu="910b" id276 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id276 -->
<!-- npu="310b" id277 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id277 -->
<!-- npu="310p" id278 -->
- Atlas 推理系列产品：支持
<!-- end id278 -->
<!-- npu="910" id279 -->
- Atlas 训练系列产品：支持
<!-- end id279 -->
<!-- npu="IPV350" id280 -->
- IPV350：不支持
<!-- end id280 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id6 -->

### 功能说明

调用本接口注册回调函数。若多次设置回调函数，以最后一次设置为准。

在执行算子之前，调用本接口注册回调函数。如果算子执行过程中出现异常，将触发回调函数的执行，并将异常信息存储在aclrtExceptionInfo结构体中。之后，可以通过调用[aclrtGetArgsFromExceptionInfo](#aclrtGetArgsFromExceptionInfo)和[aclrtGetFuncHandleFromExceptionInfo](#aclrtGetFuncHandleFromExceptionInfo)接口，从异常信息中获取用户下发算子执行任务时的参数以及核函数句柄。目前，支持获取AI Core算子或AICPU算子执行异常时的信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。<br>取值详见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。 |
| callback | 输入 | 指定要注册的回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtOpExceptionCallback)(aclrtExceptionInfo*exceptionInfo, void *userData); |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetArgsFromExceptionInfo"></a>

## aclrtGetArgsFromExceptionInfo

```c
aclError aclrtGetArgsFromExceptionInfo(const aclrtExceptionInfo *info, void **devArgsPtr, uint32_t *devArgsLen)
```

### 产品支持情况

<!-- npu="950" id253 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id253 -->
<!-- npu="A3" id254 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id254 -->
<!-- npu="910b" id255 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id255 -->
<!-- npu="310b" id256 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id256 -->
<!-- npu="310p" id257 -->
- Atlas 推理系列产品：支持
<!-- end id257 -->
<!-- npu="910" id258 -->
- Atlas 训练系列产品：支持
<!-- end id258 -->
<!-- npu="IPV350" id259 -->
- IPV350：不支持
<!-- end id259 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id7 -->

### 功能说明

从aclrtExceptionInfo异常信息中获取用户下发算子执行任务时的参数。此接口与[aclrtBinarySetExceptionCallback](#aclrtBinarySetExceptionCallback)接口配合使用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| info | 输入 | 异常信息的指针。 |
| devArgsPtr | 输出 | 用户下发算子执行任务时的参数。 |
| devArgsLen | 输出 | 参数个数。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetFuncHandleFromExceptionInfo"></a>

## aclrtGetFuncHandleFromExceptionInfo

```c
aclError aclrtGetFuncHandleFromExceptionInfo(const aclrtExceptionInfo *info, aclrtFuncHandle *func)
```

### 产品支持情况

<!-- npu="950" id2458 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2458 -->
<!-- npu="A3" id2459 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2459 -->
<!-- npu="910b" id2460 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2460 -->
<!-- npu="310b" id2461 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2461 -->
<!-- npu="310p" id2462 -->
- Atlas 推理系列产品：支持
<!-- end id2462 -->
<!-- npu="910" id2463 -->
- Atlas 训练系列产品：支持
<!-- end id2463 -->
<!-- npu="IPV350" id2464 -->
- IPV350：不支持
<!-- end id2464 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id8 -->

### 功能说明

从aclrtExceptionInfo异常信息中获取核函数句柄。此接口与[aclrtBinarySetExceptionCallback](#aclrtBinarySetExceptionCallback)接口配合使用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| info | 输入 | 异常信息的指针。 |
| func | 输出 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetFunctionAddr"></a>

## aclrtGetFunctionAddr

```c
aclError aclrtGetFunctionAddr(aclrtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
```

### 产品支持情况

<!-- npu="950" id1072 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1072 -->
<!-- npu="A3" id1073 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1073 -->
<!-- npu="910b" id1074 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1074 -->
<!-- npu="310b" id1075 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1075 -->
<!-- npu="310p" id1076 -->
- Atlas 推理系列产品：支持
<!-- end id1076 -->
<!-- npu="910" id1077 -->
- Atlas 训练系列产品：支持
<!-- end id1077 -->
<!-- npu="IPV350" id1078 -->
- IPV350：不支持
<!-- end id1078 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id9 -->

### 功能说明

根据核函数句柄获取Device侧算子起始地址。

不同产品上的AI数据处理核心单元不同，关于Core的定义及详细说明，请参见[aclrtDevAttr](25-02_Enumerations.md#aclrtDevAttr)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| aicAddr | 输出 | AI Core或Cube Core上的算子起始地址。<br><br>  - 对于以下产品，此处返回的是Cube Core上的算子起始地址。Ascend 950PR/Ascend 950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| aivAddr | 输出 | Vector Core上的算子起始地址。<br>若通过本接口获取到aivAddr为空，则表示该算子不在Vector Core上执行。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetFunctionSize"></a>

## aclrtGetFunctionSize

```c
aclError aclrtGetFunctionSize(aclrtFuncHandle funcHandle, size_t *aicSize, size_t *aivSize)
```

### 产品支持情况

<!-- npu="950" id673 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id673 -->
<!-- npu="A3" id674 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id674 -->
<!-- npu="910b" id675 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id675 -->
<!-- npu="310b" id676 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id676 -->
<!-- npu="310p" id677 -->
- Atlas 推理系列产品：支持
<!-- end id677 -->
<!-- npu="910" id678 -->
- Atlas 训练系列产品：不支持
<!-- end id678 -->
<!-- npu="IPV350" id679 -->
- IPV350：不支持
<!-- end id679 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id10 -->

### 功能说明

根据核函数句柄获取核函数代码段的大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| aicSize | 输出 | 在AI Core或Cube Core上执行算子的代码段大小，单位Byte。<br>如果算子仅在Vector Core上执行，则该值为0。 |
| aivSize | 输出 | 在Vector Core上执行算子的代码段大小，单位Byte。<br>如果算子仅在AI Core或Cube Core上执行，则该值为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetFunctionName"></a>

## aclrtGetFunctionName

```c
aclError aclrtGetFunctionName(aclrtFuncHandle funcHandle, uint32_t maxLen, char *name)
```

### 产品支持情况

<!-- npu="950" id162 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id162 -->
<!-- npu="A3" id163 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id163 -->
<!-- npu="910b" id164 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id164 -->
<!-- npu="310b" id165 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id165 -->
<!-- npu="310p" id166 -->
- Atlas 推理系列产品：支持
<!-- end id166 -->
<!-- npu="910" id167 -->
- Atlas 训练系列产品：支持
<!-- end id167 -->
<!-- npu="IPV350" id168 -->
- IPV350：不支持
<!-- end id168 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id11 -->

### 功能说明

根据核函数句柄获取核函数名称。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| maxLen | 输入 | 用户申请用于存储核函数名称的最大内存大小，单位Byte。 |
| name | 输出 | 核函数名称。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetFunctionAttribute"></a>

## aclrtGetFunctionAttribute

```c
aclError aclrtGetFunctionAttribute(aclrtFuncHandle funcHandle, aclrtFuncAttribute attrType, int64_t *attrValue)
```

### 产品支持情况

<!-- npu="950" id57 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id57 -->
<!-- npu="A3" id58 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id58 -->
<!-- npu="910b" id59 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id59 -->
<!-- npu="310b" id60 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id60 -->
<!-- npu="310p" id61 -->
- Atlas 推理系列产品：支持
<!-- end id61 -->
<!-- npu="910" id62 -->
- Atlas 训练系列产品：支持
<!-- end id62 -->
<!-- npu="IPV350" id63 -->
- IPV350：不支持
<!-- end id63 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id12 -->

### 功能说明

根据核函数句柄获取核函数属性信息。

此接口仅支持查询算子二进制文件中的核函数属性信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| attrType | 输入 | 指定属性。类型定义请参见[aclrtFuncAttribute](25-02_Enumerations.md#aclrtFuncAttribute)。 |
| attrValue | 输出 | 获取属性值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetHardwareSyncAddr"></a>

## aclrtGetHardwareSyncAddr

```c
aclError aclrtGetHardwareSyncAddr(void **addr)
```

### 产品支持情况

<!-- npu="950" id22 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id22 -->
<!-- npu="A3" id23 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id23 -->
<!-- npu="910b" id24 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id24 -->
<!-- npu="310b" id25 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id25 -->
<!-- npu="310p" id26 -->
- Atlas 推理系列产品：不支持
<!-- end id26 -->
<!-- npu="910" id27 -->
- Atlas 训练系列产品：不支持
<!-- end id27 -->
<!-- npu="IPV350" id28 -->
- IPV350：不支持
<!-- end id28 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id13 -->

### 功能说明

获取Cube Core、Vector Core之间的同步地址。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| addr | 输出 | 同步地址。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtRegisterCpuFunc"></a>

## aclrtRegisterCpuFunc

```c
aclError aclrtRegisterCpuFunc(const aclrtBinHandle handle, const char *funcName, const char *kernelName, aclrtFuncHandle *funcHandle)
```

### 产品支持情况

<!-- npu="950" id407 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id407 -->
<!-- npu="A3" id408 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id408 -->
<!-- npu="910b" id409 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id409 -->
<!-- npu="310b" id410 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id410 -->
<!-- npu="310p" id411 -->
- Atlas 推理系列产品：支持
<!-- end id411 -->
<!-- npu="910" id412 -->
- Atlas 训练系列产品：支持
<!-- end id412 -->
<!-- npu="IPV350" id413 -->
- IPV350：不支持
<!-- end id413 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id14 -->

### 功能说明

若使用[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口加载AI CPU算子二进制数据，还需配合使用本接口注册AI CPU算子信息，得到对应的funcHandle。

本接口只用于AI CPU算子，其它算子会返回报错ACL\_ERROR\_RT\_PARAM\_INVALID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| funcName | 输入 | 执行AI CPU算子的入口函数。不能为空。 |
| kernelName | 输入 | AI CPU算子的opType。不能为空。 |
| funcHandle | 输出 | 函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsInit"></a>

## aclrtKernelArgsInit

```c
aclError aclrtKernelArgsInit(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)
```

### 产品支持情况

<!-- npu="950" id939 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id939 -->
<!-- npu="A3" id940 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id940 -->
<!-- npu="910b" id941 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id941 -->
<!-- npu="310b" id942 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id942 -->
<!-- npu="310p" id943 -->
- Atlas 推理系列产品：支持
<!-- end id943 -->
<!-- npu="910" id944 -->
- Atlas 训练系列产品：支持
<!-- end id944 -->
<!-- npu="IPV350" id945 -->
- IPV350：不支持
<!-- end id945 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id15 -->

### 功能说明

根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。

与[aclrtKernelArgsInitByUserMem](#aclrtKernelArgsInitByUserMem)接口的区别在于，调用本接口表示由系统管理内存。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。<br>调用[aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry)或[aclrtBinaryGetFunction](#aclrtBinaryGetFunction)获取核函数句柄，再将其作为入参传入本接口。 |
| argsHandle | 输出 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsInitByUserMem"></a>

## aclrtKernelArgsInitByUserMem

```c
aclError aclrtKernelArgsInitByUserMem(aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, void *userHostMem, size_t actualArgsSize)
```

### 产品支持情况

<!-- npu="950" id631 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id631 -->
<!-- npu="A3" id632 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id632 -->
<!-- npu="910b" id633 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id633 -->
<!-- npu="310b" id634 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id634 -->
<!-- npu="310p" id635 -->
- Atlas 推理系列产品：支持
<!-- end id635 -->
<!-- npu="910" id636 -->
- Atlas 训练系列产品：支持
<!-- end id636 -->
<!-- npu="IPV350" id637 -->
- IPV350：不支持
<!-- end id637 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id16 -->

### 功能说明

根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。

与[aclrtKernelArgsInit](#aclrtKernelArgsInit)接口的区别在于，调用本接口表示由用户管理内存。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。<br>调用[aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry)或[aclrtBinaryGetFunction](#aclrtBinaryGetFunction)获取核函数句柄，再将其作为入参传入本接口。 |
| argsHandle | 输出 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle)。<br>需提前调用[aclrtKernelArgsGetHandleMemSize](#aclrtKernelArgsGetHandleMemSize)接口获取内存大小，申请Host内存，再将Host内存地址作为入参传入此处。 |
| userHostMem | 输入 | Host内存地址。<br>需提前调用[aclrtKernelArgsGetMemSize](#aclrtKernelArgsGetMemSize)接口获取内存大小，申请Host内存，再将Host内存地址作为入参传入此处。 |
| actualArgsSize | 输入 | 内存大小。<br>需提前调用[aclrtKernelArgsGetMemSize](#aclrtKernelArgsGetMemSize)接口获取内存大小，再将其作为入参传入此处。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsGetMemSize"></a>

## aclrtKernelArgsGetMemSize

```c
aclError aclrtKernelArgsGetMemSize(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
```

### 产品支持情况

<!-- npu="950" id1527 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1527 -->
<!-- npu="A3" id1528 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1528 -->
<!-- npu="910b" id1529 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1529 -->
<!-- npu="310b" id1530 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1530 -->
<!-- npu="310p" id1531 -->
- Atlas 推理系列产品：支持
<!-- end id1531 -->
<!-- npu="910" id1532 -->
- Atlas 训练系列产品：支持
<!-- end id1532 -->
<!-- npu="IPV350" id1533 -->
- IPV350：不支持
<!-- end id1533 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id17 -->

### 功能说明

获取Kernel Launch时参数列表所需内存的实际大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| userArgsSize | 输入 | 在内存中存放参数列表数据所需的大小，单位为Byte。<br>每个参数数据的内存大小都需要8字节对齐，这里的userArgsSize是这些对齐后的参数数据内存大小相加的总和。 |
| actualArgsSize | 输出 | Kernel Launch时参数列表所需内存的实际大小，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsGetHandleMemSize"></a>

## aclrtKernelArgsGetHandleMemSize

```c
aclError aclrtKernelArgsGetHandleMemSize(aclrtFuncHandle funcHandle, size_t *memSize)
```

### 产品支持情况

<!-- npu="950" id1464 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1464 -->
<!-- npu="A3" id1465 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1465 -->
<!-- npu="910b" id1466 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1466 -->
<!-- npu="310b" id1467 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1467 -->
<!-- npu="310p" id1468 -->
- Atlas 推理系列产品：支持
<!-- end id1468 -->
<!-- npu="910" id1469 -->
- Atlas 训练系列产品：支持
<!-- end id1469 -->
<!-- npu="IPV350" id1470 -->
- IPV350：不支持
<!-- end id1470 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id18 -->

### 功能说明

获取参数列表句柄占用的内存大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| memSize | 输出 | 参数列表句柄占用的内存大小，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsAppend"></a>

## aclrtKernelArgsAppend

```c
aclError aclrtKernelArgsAppend(aclrtArgsHandle argsHandle, void *param, size_t paramSize, aclrtParamHandle *paramHandle)
```

### 产品支持情况

<!-- npu="950" id1198 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1198 -->
<!-- npu="A3" id1199 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1199 -->
<!-- npu="910b" id1200 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1200 -->
<!-- npu="310b" id1201 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1201 -->
<!-- npu="310p" id1202 -->
- Atlas 推理系列产品：支持
<!-- end id1202 -->
<!-- npu="910" id1203 -->
- Atlas 训练系列产品：支持
<!-- end id1203 -->
<!-- npu="IPV350" id1204 -->
- IPV350：不支持
<!-- end id1204 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id19 -->

### 功能说明

调用本接口将用户设置的参数值追加拷贝到argsHandle指向的参数数据区域。若参数列表中有多个参数，则需按顺序追加参数。

如果要更新参数值，可调用[aclrtKernelArgsParaUpdate](#aclrtKernelArgsParaUpdate)接口进行更新。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle)。 |
| param | 输入 | 待追加参数值的内存地址。<br>此处为Host内存地址。 |
| paramSize | 输入 | 内存大小，单位Byte。 |
| paramHandle | 输出 | 参数句柄。类型定义请参见[aclrtParamHandle](25-05_Typedefs.md#aclrtParamHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsAppendPlaceHolder"></a>

## aclrtKernelArgsAppendPlaceHolder

```c
aclError aclrtKernelArgsAppendPlaceHolder(aclrtArgsHandle argsHandle, aclrtParamHandle *paramHandle)
```

### 产品支持情况

<!-- npu="950" id2836 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2836 -->
<!-- npu="A3" id2837 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2837 -->
<!-- npu="910b" id2838 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2838 -->
<!-- npu="310b" id2839 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2839 -->
<!-- npu="310p" id2840 -->
- Atlas 推理系列产品：支持
<!-- end id2840 -->
<!-- npu="910" id2841 -->
- Atlas 训练系列产品：支持
<!-- end id2841 -->
<!-- npu="IPV350" id2842 -->
- IPV350：不支持
<!-- end id2842 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id20 -->

### 功能说明

对于placeholder参数，调用本接口先占位，返回的是paramHandle占位符。

若参数列表中有多个参数，则需按顺序追加参数。等所有参数都追加之后，可调用[aclrtKernelArgsGetPlaceHolderBuffer](#aclrtKernelArgsGetPlaceHolderBuffer)接口获取paramHandle占位符指向的内存地址。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle)。 |
| paramHandle | 输出 | 参数句柄。类型定义请参见[aclrtParamHandle](25-05_Typedefs.md#aclrtParamHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsGetPlaceHolderBuffer"></a>

## aclrtKernelArgsGetPlaceHolderBuffer

```c
aclError aclrtKernelArgsGetPlaceHolderBuffer(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, size_t dataSize, void **bufferAddr)
```

### 产品支持情况

<!-- npu="950" id197 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id197 -->
<!-- npu="A3" id198 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id198 -->
<!-- npu="910b" id199 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id199 -->
<!-- npu="310b" id200 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id200 -->
<!-- npu="310p" id201 -->
- Atlas 推理系列产品：支持
<!-- end id201 -->
<!-- npu="910" id202 -->
- Atlas 训练系列产品：支持
<!-- end id202 -->
<!-- npu="IPV350" id203 -->
- IPV350：不支持
<!-- end id203 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id21 -->

### 功能说明

根据用户指定的内存大小，获取paramHandle占位符指向的内存地址。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle)。 |
| paramHandle | 输入 | 参数句柄。类型定义请参见[aclrtParamHandle](25-05_Typedefs.md#aclrtParamHandle)。<br>此处的paramHandle需与[aclrtKernelArgsAppendPlaceHolder](#aclrtKernelArgsAppendPlaceHolder)接口中的paramHandle保持一致。 |
| dataSize | 输入 | 内存大小。 |
| bufferAddr | 输出 | paramHandle占位符指向的内存地址。<br>后续由用户管理该内存中的数据，但无需管理该内存的生命周期。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsParaUpdate"></a>

## aclrtKernelArgsParaUpdate

```c
aclError aclrtKernelArgsParaUpdate(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param, size_t paramSize)
```

### 产品支持情况

<!-- npu="950" id3410 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3410 -->
<!-- npu="A3" id3411 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3411 -->
<!-- npu="910b" id3412 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3412 -->
<!-- npu="310b" id3413 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3413 -->
<!-- npu="310p" id3414 -->
- Atlas 推理系列产品：支持
<!-- end id3414 -->
<!-- npu="910" id3415 -->
- Atlas 训练系列产品：支持
<!-- end id3415 -->
<!-- npu="IPV350" id3416 -->
- IPV350：不支持
<!-- end id3416 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id22 -->

### 功能说明

通过aclrtKernelArgsAppend接口追加的参数，可调用本接口更新参数值。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle)。 |
| paramHandle | 输入 | 参数句柄。类型定义请参见[aclrtParamHandle](25-05_Typedefs.md#aclrtParamHandle)。 |
| param | 输入 | 待更新参数值的内存地址。<br>此处为Host内存地址。 |
| paramSize | 输入 | 内存大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtKernelArgsFinalize"></a>

## aclrtKernelArgsFinalize

```c
aclError aclrtKernelArgsFinalize(aclrtArgsHandle argsHandle)
```

### 产品支持情况

<!-- npu="950" id3431 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3431 -->
<!-- npu="A3" id3432 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3432 -->
<!-- npu="910b" id3433 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3433 -->
<!-- npu="310b" id3434 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3434 -->
<!-- npu="310p" id3435 -->
- Atlas 推理系列产品：支持
<!-- end id3435 -->
<!-- npu="910" id3436 -->
- Atlas 训练系列产品：支持
<!-- end id3436 -->
<!-- npu="IPV350" id3437 -->
- IPV350：不支持
<!-- end id3437 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id23 -->

### 功能说明

在所有参数追加完成后，调用本接口以标识参数组装完毕。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtLaunchKernel"></a>

## aclrtLaunchKernel

```c
aclError aclrtLaunchKernel(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3487 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3487 -->
<!-- npu="A3" id3488 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3488 -->
<!-- npu="910b" id3489 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3489 -->
<!-- npu="310b" id3490 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3490 -->
<!-- npu="310p" id3491 -->
- Atlas 推理系列产品：支持
<!-- end id3491 -->
<!-- npu="910" id3492 -->
- Atlas 训练系列产品：支持
<!-- end id3492 -->
<!-- npu="IPV350" id3493 -->
- IPV350：支持
<!-- end id3493 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id24 -->

### 功能说明

启动对应算子的计算任务，异步接口。此处的算子为使用Ascend C语言开发的自定义算子。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。<br>调用[aclrtBinaryGetFunction](#aclrtBinaryGetFunction)接口根据kernelName获取funcHandle。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| argsData | 输入 | 存放核函数所有入参数据的Device内存地址指针。<br>内存申请接口请参见[内存管理](11_memory_management.md)。<br>注意，执行本接口下发任务的Device需与argsData中使用的Device内存要是同一个Device。 |
| argsSize | 输入 | argsData参数值的大小，单位为Byte。 |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：

| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |
| [aclrtLaunchKernelWithArgsArray](#aclrtLaunchKernelWithArgsArray) | 在接口中指定参数数组指针，每个元素指向一个参数数据 | Host内存 | 是 |

<br>
<br>
<br>

<a id="aclrtLaunchKernelV2"></a>

## aclrtLaunchKernelV2

```c
aclError aclrtLaunchKernelV2(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtLaunchKernelCfg *cfg, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2969 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2969 -->
<!-- npu="A3" id2970 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2970 -->
<!-- npu="910b" id2971 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2971 -->
<!-- npu="310b" id2972 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2972 -->
<!-- npu="310p" id2973 -->
- Atlas 推理系列产品：支持
<!-- end id2973 -->
<!-- npu="910" id2974 -->
- Atlas 训练系列产品：支持
<!-- end id2974 -->
<!-- npu="IPV350" id2975 -->
- IPV350：不支持
<!-- end id2975 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id25 -->

### 功能说明

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| argsData | 输入 | 存放核函数所有入参数据的Device内存地址指针。<br>内存申请接口请参见[内存管理](11_memory_management.md)。<br>注意，执行本接口下发任务的Device需与argsData中使用的Device内存要是同一个Device。 |
| argsSize | 输入 | argsData参数值的大小，单位为Byte。 |
| cfg | 输入 | 任务下发的配置信息。类型定义请参见[aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg)。<br>不指定配置时，此处可传NULL。 |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：

| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |
| [aclrtLaunchKernelWithArgsArray](#aclrtLaunchKernelWithArgsArray) | 在接口中指定参数数组指针，每个元素指向一个参数数据 | Host内存 | 是 |

<br>
<br>
<br>

<a id="aclrtLaunchKernelWithConfig"></a>

## aclrtLaunchKernelWithConfig

```c
aclError aclrtLaunchKernelWithConfig(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)
```

### 产品支持情况

<!-- npu="950" id2563 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2563 -->
<!-- npu="A3" id2564 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2564 -->
<!-- npu="910b" id2565 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2565 -->
<!-- npu="310b" id2566 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2566 -->
<!-- npu="310p" id2567 -->
- Atlas 推理系列产品：支持
<!-- end id2567 -->
<!-- npu="910" id2568 -->
- Atlas 训练系列产品：支持
<!-- end id2568 -->
<!-- npu="IPV350" id2569 -->
- IPV350：不支持
<!-- end id2569 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id26 -->

### 功能说明

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

若使用本接口下发AI Core算子的计算任务，需配套使用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口加载并解析算子二进制文件。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| cfg | 输入 | 任务下发的配置信息。类型定义请参见[aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg)。<br>不指定配置时，此处可传NULL。 |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](25-05_Typedefs.md#aclrtArgsHandle)。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：

| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |
| [aclrtLaunchKernelWithArgsArray](#aclrtLaunchKernelWithArgsArray) | 在接口中指定参数数组指针，每个元素指向一个参数数据 | Host内存 | 是 |

<br>
<br>
<br>

<a id="aclrtLaunchKernelWithHostArgs"></a>

## aclrtLaunchKernelWithHostArgs

```c
aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
```

### 产品支持情况

<!-- npu="950" id841 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id841 -->
<!-- npu="A3" id842 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id842 -->
<!-- npu="910b" id843 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id843 -->
<!-- npu="310b" id844 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id844 -->
<!-- npu="310p" id845 -->
- Atlas 推理系列产品：支持
<!-- end id845 -->
<!-- npu="910" id846 -->
- Atlas 训练系列产品：支持
<!-- end id846 -->
<!-- npu="IPV350" id847 -->
- IPV350：不支持
<!-- end id847 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id27 -->

### 功能说明

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| cfg | 输入 | 任务下发的配置信息。类型定义请参见[aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg)。<br>不指定配置时，此处可传NULL。 |
| hostArgs | 输入 | 存放核函数所有入参数据的Host内存地址指针。 |
| argsSize | 输入 | hostArgs参数值的大小，单位为Byte。 |
| placeHolderArray | 输入 | placeholder参数数组。<br>aclrtPlaceHolderInfo定义如下：<br>typedef struct {<br>   uint32_t addrOffset;<br>   uint32_t dataOffset;<br>} aclrtPlaceHolderInfo;<br>成员变量说明如下：<br><br>  - addrOffset：placeholder指向的数据区拷贝到Device后，其真实Device内存地址在launch时需要刷新到hostArgs中，该参数用于指定需刷新的位置偏移<br>  - dataOffset：placeholder指向的数据区需拷贝到Device侧，该参数用于指定数据区基于hostArgs的地址偏移 |
| placeHolderNum | 输入 | placeholder参数数组的大小。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：

| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |
| [aclrtLaunchKernelWithArgsArray](#aclrtLaunchKernelWithArgsArray) | 在接口中指定参数数组指针，每个元素指向一个参数数据 | Host内存 | 是 |

<br>
<br>
<br>

<a id="aclrtLaunchKernelWithArgsArray"></a>

## aclrtLaunchKernelWithArgsArray

```c
aclError aclrtLaunchKernelWithArgsArray(void *func, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void **args)
```

### 产品支持情况

<!-- npu="950" id701 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id701 -->
<!-- npu="A3" id702 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id702 -->
<!-- npu="910b" id703 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id703 -->
<!-- npu="310b" id704 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id704 -->
<!-- npu="310p" id705 -->
- Atlas 推理系列产品：支持
<!-- end id705 -->
<!-- npu="910" id706 -->
- Atlas 训练系列产品：支持
<!-- end id706 -->
<!-- npu="IPV350" id707 -->
- IPV350：不支持
<!-- end id707 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id28 -->

### 功能说明

基于参数数组的方式传递核函数入参，并启动对应算子的计算任务。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| func | 输入 | 内核函数指针（可以是符号或[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)）。                                  |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。                                                                                     |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。                                   |
| cfg | 输入 | 任务下发的配置信息。类型定义请参见[aclrtLaunchKernelCfg](25-04_Structs.md#aclrtLaunchKernelCfg)。<br>不指定配置时，此处可传NULL。 |
| args | 输入 | 参数数组指针。<br/>参数数组中的每个元素均指向核函数参数数据在Host侧的内存地址。                                                        |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

参数数组中的元素顺序需与核函数参数顺序保持一致，且参数数组大小需与核函数参数数量保持一致，否则会导致未定义行为。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：

| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |
| [aclrtLaunchKernelWithArgsArray](#aclrtLaunchKernelWithArgsArray) | 在接口中指定参数数组指针，每个元素指向一个参数数据 | Host内存 | 是 |

<br>
<br>
<br>

<a id="aclrtCreateBinary"></a>

## aclrtCreateBinary

```c
aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)
```

### 产品支持情况

<!-- npu="950" id3403 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3403 -->
<!-- npu="A3" id3404 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3404 -->
<!-- npu="910b" id3405 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3405 -->
<!-- npu="310b" id3406 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3406 -->
<!-- npu="310p" id3407 -->
- Atlas 推理系列产品：支持
<!-- end id3407 -->
<!-- npu="910" id3408 -->
- Atlas 训练系列产品：支持
<!-- end id3408 -->
<!-- npu="IPV350" id3409 -->
- IPV350：不支持
<!-- end id3409 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id29 -->

### 功能说明

创建aclrtBinary类型的数据，该数据类型用于描述算子二进制信息。此处的算子为使用Ascend C语言开发的自定义算子。

如需销毁aclrtBinary类型的数据，请参见[aclrtDestroyBinary](#aclrtDestroyBinary)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| data | 输入 | 存放算子二进制文件（*.o文件）数据的内存地址指针。<br>Ascend EP标准形态下，此处需申请Host上的内存；Ascend RC形态或Control CPU开放形态下，此处需申请Device上的内存。 |
| dataLen | 输入 | 内存大小，单位Byte。 |

### 返回值说明

返回aclrtBinary类型的指针。

## 约束说明

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
Ascend EP标准形态下，data参数处需申请Host上的内存。
<!-- end id1 -->

<!-- npu="310p,310b" id2 -->
Ascend RC形态或Control CPU开放形态下，data参数处需申请Device上的内存。
<!-- end id2 -->

<!-- npu="IPV350" id3 -->
data参数处需申请Device上的内存。
<!-- end id3 -->

<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id38 -->

<br>
<br>
<br>

<a id="aclrtDestroyBinary"></a>

## aclrtDestroyBinary

```c
aclError aclrtDestroyBinary(aclrtBinary binary)
```

### 产品支持情况

<!-- npu="950" id2241 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2241 -->
<!-- npu="A3" id2242 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2242 -->
<!-- npu="910b" id2243 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2243 -->
<!-- npu="310b" id2244 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2244 -->
<!-- npu="310p" id2245 -->
- Atlas 推理系列产品：支持
<!-- end id2245 -->
<!-- npu="910" id2246 -->
- Atlas 训练系列产品：支持
<!-- end id2246 -->
<!-- npu="IPV350" id2247 -->
- IPV350：不支持
<!-- end id2247 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id30 -->

### 功能说明

销毁通过[aclrtCreateBinary](#aclrtCreateBinary)接口创建的aclrtBinary类型的数据。此处的算子为使用Ascend C语言开发的自定义算子。

注意，此处仅销毁aclrtBinary的数据，调用[aclrtCreateBinary](#aclrtCreateBinary)接口时传入的data内存需由用户自行、及时释放，否则可能会导致内存异常。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binary | 输入 | 待销毁的aclrtBinary类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtBinaryLoad"></a>

## aclrtBinaryLoad

```c
aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)
```

### 产品支持情况

<!-- npu="950" id533 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id533 -->
<!-- npu="A3" id534 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id534 -->
<!-- npu="910b" id535 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id535 -->
<!-- npu="310b" id536 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id536 -->
<!-- npu="310p" id537 -->
- Atlas 推理系列产品：支持
<!-- end id537 -->
<!-- npu="910" id538 -->
- Atlas 训练系列产品：支持
<!-- end id538 -->
<!-- npu="IPV350" id539 -->
- IPV350：不支持
<!-- end id539 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id31 -->

### 功能说明

解析、加载算子二进制文件，输出指向算子二进制的binHandle，同时将算子二进制文件数据拷贝至当前Context对应的Device上。此处的算子为使用Ascend C语言开发的自定义算子。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binary | 输入 | 算子二进制信息。<br>此处需先调用[aclrtCreateBinary](#aclrtCreateBinary)接口，获取aclrtBinary类型数据的指针。 |
| binHandle | 输出 | 指向二进制的handle。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtBinaryUnLoad"></a>

## aclrtBinaryUnLoad

```c
aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)
```

### 产品支持情况

<!-- npu="950" id2514 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2514 -->
<!-- npu="A3" id2515 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2515 -->
<!-- npu="910b" id2516 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2516 -->
<!-- npu="310b" id2517 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2517 -->
<!-- npu="310p" id2518 -->
- Atlas 推理系列产品：支持
<!-- end id2518 -->
<!-- npu="910" id2519 -->
- Atlas 训练系列产品：支持
<!-- end id2519 -->
<!-- npu="IPV350" id2520 -->
- IPV350：不支持
<!-- end id2520 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id32 -->

### 功能说明

删除binHandle指向的算子二进制数据，同时也删除加载算子二进制文件时拷贝到Device上的算子二进制数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。<br>该handle在调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)、[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)或者[aclrtBinaryLoad](#aclrtBinaryLoad)接口时生成。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

调用本接口删除算子二进制数据时，需跟[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)、[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)或者[aclrtBinaryLoad](#aclrtBinaryLoad)接口在同一个Context下，这样才能一并删除加载算子二进制文件时拷贝到Device上的算子二进制数据，否则可能会导致Device上的算子二进制数据删除异常。

<br>
<br>
<br>

<a id="aclrtFunctionGetBinary"></a>

## aclrtFunctionGetBinary

```c
aclError aclrtFunctionGetBinary(const aclrtFuncHandle funcHandle, aclrtBinHandle *binHandle)
```

### 产品支持情况

<!-- npu="950" id2843 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2843 -->
<!-- npu="A3" id2844 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2844 -->
<!-- npu="910b" id2845 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2845 -->
<!-- npu="310b" id2846 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2846 -->
<!-- npu="310p" id2847 -->
- Atlas 推理系列产品：支持
<!-- end id2847 -->
<!-- npu="910" id2848 -->
- Atlas 训练系列产品：支持
<!-- end id2848 -->
<!-- npu="IPV350" id2849 -->
- IPV350：不支持
<!-- end id2849 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id33 -->

### 功能说明

根据核函数句柄获取算子二进制句柄。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| binHandle | 输出 | 算子二进制的句柄。类型定义请参见[aclrtBinHandle](25-05_Typedefs.md#aclrtBinHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtFunctionGetParamCount"></a>

## aclrtFunctionGetParamCount

```c
aclError aclrtFunctionGetParamCount(const void *func, size_t *paramCount)
```

### 产品支持情况

<!-- npu="950" id260 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id260 -->
<!-- npu="A3" id261 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id261 -->
<!-- npu="910b" id262 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id262 -->
<!-- npu="310b" id263 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id263 -->
<!-- npu="310p" id264 -->
- Atlas 推理系列产品：支持
<!-- end id264 -->
<!-- npu="910" id265 -->
- Atlas 训练系列产品：支持
<!-- end id265 -->
<!-- npu="IPV350" id266 -->
- IPV350：不支持
<!-- end id266 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id34 -->

### 功能说明

从核函数句柄获取参数个数。

使用本接口查询核函数的参数列表中包含多少个参数后，再配合[aclrtFunctionGetParamInfo](#aclrtFunctionGetParamInfo)接口使用，可遍历获取每个参数的详细信息（偏移和大小）。

### 参数说明

| 参数名 | 输入/输出 | 说明                                                                |
| --- | :---: |-------------------------------------------------------------------|
| func | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| paramCount | 输出 | 核函数参数列表中所包含的参数数量。                                                 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtFunctionGetParamInfo"></a>

## aclrtFunctionGetParamInfo

```c
aclError aclrtFunctionGetParamInfo(const void *func, size_t paramIndex, size_t *paramOffset, size_t *paramSize)
```

### 产品支持情况

<!-- npu="950" id2248 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2248 -->
<!-- npu="A3" id2249 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2249 -->
<!-- npu="910b" id2250 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2250 -->
<!-- npu="310b" id2251 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2251 -->
<!-- npu="310p" id2252 -->
- Atlas 推理系列产品：支持
<!-- end id2252 -->
<!-- npu="910" id2253 -->
- Atlas 训练系列产品：支持
<!-- end id2253 -->
<!-- npu="IPV350" id2254 -->
- IPV350：不支持
<!-- end id2254 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id35 -->

### 功能说明

根据索引从核函数句柄获取参数信息（偏移和大小）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| func | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。                                                    |
| paramIndex | 输入 | 参数索引。<br/> 可先调用[aclrtFunctionGetParamCount](#aclrtFunctionGetParamCount)接口获取可用的参数数量后，这个paramIndex的取值范围：[0，(参数数量-1)]. |
| paramOffset | 输出 | 参数在参数数据区中的偏移，单位为Byte。                                                                                                |
| paramSize | 输出 | 参数的大小，单位为Byte。                                                                                                       |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtFunctionGetAvailDynUbufPerBlock"></a>

## aclrtFunctionGetAvailDynUbufPerBlock

```c
aclError aclrtFunctionGetAvailDynUbufPerBlock(void *func, uint32_t flags, size_t *dynamicUbufSize)
```

### 产品支持情况

<!-- npu="950" id3263 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3263 -->
<!-- npu="A3" id3264 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3264 -->
<!-- npu="910b" id3265 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3265 -->
<!-- npu="310b" id3266 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3266 -->
<!-- npu="310p" id3267 -->
- Atlas 推理系列产品：支持
<!-- end id3267 -->
<!-- npu="910" id3268 -->
- Atlas 训练系列产品：支持
<!-- end id3268 -->
<!-- npu="IPV350" id3269 -->
- IPV350：不支持
<!-- end id3269 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id36 -->

### 功能说明

对于SIMT（Single Instruction Multiple Thread）核函数，本接口通过dynamicUbufSize输出Kernel Launch前可设置的最大动态UB buffer大小。

对于非SIMT核函数，本接口返回成功，且`dynamicUbufSize`固定为0。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| func | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)，不能为空。 |
| flags | 输入 | 预留参数，当前固定配置为0。 |
| dynamicUbufSize | 输出 | 每个Block可用的动态UB buffer大小，单位为Byte，不能为空。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetFuncBySymbol"></a>

## aclrtGetFuncBySymbol

```c
aclError aclrtGetFuncBySymbol(const void *symbol, aclrtFuncHandle *funcHandle)
```

### 产品支持情况

<!-- npu="950" id603 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id603 -->
<!-- npu="A3" id604 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id604 -->
<!-- npu="910b" id605 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id605 -->
<!-- npu="310b" id606 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id606 -->
<!-- npu="310p" id607 -->
- Atlas 推理系列产品：支持
<!-- end id607 -->
<!-- npu="910" id608 -->
- Atlas 训练系列产品：不支持
<!-- end id608 -->
<!-- npu="IPV350" id609 -->
- IPV350：不支持
<!-- end id609 -->
<!-- @ref: runtime/res/docs/zh/api_ref/14_kerne_loading_and_execution_res.md#id37 -->

### 功能说明

根据核函数名（__global__声明的函数名，比如myKernel）获取核函数句柄。

本接口仅适用于使用Ascend C语言开发自定义算子并基于毕昇编译器进行Host和Device代码混合编译的场景。不适用于直接加载算子二进制文件的场景。
用户自定义Device侧核函数后，可以通过本接口根据核函数名在内部符号表中查找到对应的核函数，并使用funcHandle表达，用于后续Launch Kernel。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | 核函数名。|
| funcHandle | 输出 | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口只能用于算子静态Shape场景，且仅支持AI Core算子。
- 核函数句柄仅在当前Device有效，切换Device后需要重新获取。
