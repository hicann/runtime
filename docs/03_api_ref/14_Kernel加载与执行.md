# 14. Kernel加载与执行

本章节描述 CANN Runtime 的 Kernel 加载与执行接口，包括二进制加载、函数获取、参数组装及 Kernel 启动。

## 概念及使用说明

### 相关概念

本章中的接口涉及对算子的算子二进制、核函数、核函数参数列表以及参数的操作，为便于理解，您可以先通过下图了解它们之间的关系。

![](figures/aclmdlDataset类型与aclDataBuffer类型的关系.png)

-   **算子二进制**：编译算子源码，可得到算子二进制文件\*.o。对于CANN内置算子，可从算子二进制包（包名为Ascend-cann-\*-ops-\*.run）中获取算子二进制文件。对于自定义算子，可在编译算子、发布二进制之后获取算子二进制文件。自定义算子的开发、编译请参见《Ascend C算子开发指南》。
-   **核函数**：是算子设备侧实现的入口函数。当前允许使用C/C++函数的语法扩展来编写设备端的运行代码，用户在核函数中进行数据访问和计算操作，由此实现该算子的所有功能。

### Kernel加载与执行接口调用流程

![](figures/接口调用流程图-2.png)

关键流程说明如下：

1.  调用[aclInit](02_初始化与去初始化.md#aclInit)接口初始化。
2.  申请运行时资源，包括调用[aclrtSetDevice](04_Device管理.md#aclrtSetDevice)接口指定用于运算的Device、调用[aclrtCreateStream](06_Stream管理.md#aclrtCreateStream)接口创建Stream。
3.  调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口加载算子二进制文件。

    AI CPU算子还支持从内存加载算子二进制数据的方式（调用[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口），但加载算子二进制数据后，还需配合使用[aclrtRegisterCpuFunc](#aclrtRegisterCpuFunc)接口注册AI CPU算子信息。

4.  调用[aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry)或[aclrtBinaryGetFunction](#aclrtBinaryGetFunction)接口获取核函数句柄。
5.  **（可选）**根据核函数句柄操作其参数列表，操作包括：
    1.  **初始化参数列表**

        当前支持由系统管理内存（调用[aclrtKernelArgsInit](#aclrtKernelArgsInit)接口）、由用户管理内存（调用[aclrtKernelArgsInitByUserMem](#aclrtKernelArgsInitByUserMem)接口）两种方式。

    2.  **追加参数、更新参数值**

        核函数参数列表中包含不同类型的参数，例如指针类型参数、placeholder、uint8\_t类型参数等，其中：

        -   指针类型参数：其值为Device内存地址。一般来说，算子的输入、输出是该种类型的参数，用户需提前调用Device内存申请接口（例如[aclrtMalloc](11-01_设备内存分配与释放.md#aclrtMalloc)接口）申请内存，并自行拷贝数据至Device侧。
        -   placeholder：也是指针类型参数，但区别在于，用户无需手动将参数数据复制到Device，这项操作由Runtime完成。在追加参数时Runtime并不会填写真实的Device地址，而是在Launch Kernel时才会刷新为真实的Device地址，所以称之为placeholder。对算子的非输入、输出参数，可以使用placeholder方式，将小块数据（建议小于2KB）的Host-\>Device拷贝合并到Launch Kernel时的一次拷贝操作中去，减少拷贝次数，提升性能。

        ![](figures/aclmdlDataset类型与aclDataBuffer类型的关系-3.png)

        **不同类型参数，可调用不同的参数追加接口：**

        -   对于placeholder参数，由于关联的内存必须放在所有参数之后，所以在追加参数时，先调用[aclrtKernelArgsAppendPlaceHolder](#aclrtKernelArgsAppendPlaceHolder)接口占位，等所有参数都追加之后，可调用[aclrtKernelArgsGetPlaceHolderBuffer](#aclrtKernelArgsGetPlaceHolderBuffer)接口获取对应占位符指向的内存地址。用户可根据获取的内存地址，管理该内存中的数据。
        -   对于非placeholder参数（例如指针类型参数、uint8\_t类型参数等），调用[aclrtKernelArgsAppend](#aclrtKernelArgsAppend)接口将用户设置的参数值追加拷贝到argsHandle指向的参数数据区域。如果要更新参数值，可调用[aclrtKernelArgsParaUpdate](#aclrtKernelArgsParaUpdate)接口进行更新。

        **注意**，核函数参数列表中，实际可能存在多个参数，并且不同类型的参数可能交错出现，因此需要按照参数列表中的参数顺序从左到右进行追加，追加的参数最多支持128个。

    3.  **结束参数列表的追加、参数值的更新**

        在所有参数追加之后，调用[aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize)接口以标识参数组装完毕。但[aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize)接口之后，也支持继续更新参数值，更新之后，还要再调用一次[aclrtKernelArgsFinalize](#aclrtKernelArgsFinalize)接口。

6.  调用Launch Kernel接口，启动对应算子的计算任务。

    若使用aclrtArgsHandle参数列表句柄组装核函数的入参数据，则调用[aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig)接口启动对应算子的计算任务。该方式下，用户只需按顺序在参数列表中追加参数，无需关注内存中的组装细节，也无需关注内部参数。

    若核函数的入参数据都存放在Host或Device内存中，则调用[aclrtLaunchKernel](#aclrtLaunchKernel)、[aclrtLaunchKernelV2](#aclrtLaunchKernelV2)或[aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs)接口启动对应算子的计算任务。

7.  调用接口[aclrtBinaryUnLoad](#aclrtBinaryUnLoad)卸载算子二进制文件。
8.  释放运行时资源，包括调用[aclrtDestroyStream](06_Stream管理.md#aclrtDestroyStream)接口释放Stream、调用[aclrtResetDevice](04_Device管理.md#aclrtResetDevice)接口释放Device上的资源。
9.  调用[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口去初始化。

---

- [`aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)`](#aclrtBinaryLoadFromFile)：从文件加载并解析算子二进制文件，输出指向算子二进制的binHandle。
- [`aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)`](#aclrtBinaryLoadFromData)：从内存加载并解析算子二进制数据，输出指向算子二进制的binHandle。
- [`aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)`](#aclrtBinaryGetFunction)：根据核函数名称，查找到对应的核函数，并使用funcHandle表达。
- [`aclError aclrtBinaryGetFunctionByEntry(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)`](#aclrtBinaryGetFunctionByEntry)：根据Function Entry获取核函数句柄。
- [`aclError aclrtBinaryGetDevAddress(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)`](#aclrtBinaryGetDevAddress)：获取算子二进制数据在Device上的内存地址及内存大小。
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
- [`aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)`](#aclrtCreateBinary)：创建aclrtBinary类型的数据，该数据类型用于描述算子二进制信息。此处的算子为使用Ascend C语言开发的自定义算子。
- [`aclError aclrtDestroyBinary(aclrtBinary binary)`](#aclrtDestroyBinary)：销毁通过[aclrtCreateBinary](#aclrtCreateBinary)接口创建的aclrtBinary类型的数据。
- [`aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)`](#aclrtBinaryLoad)：解析、加载算子二进制文件，输出指向算子二进制的binHandle，同时将算子二进制文件数据拷贝至当前Context对应的Device上。
- [`aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)`](#aclrtBinaryUnLoad)：删除binHandle指向的算子二进制数据，同时也删除加载算子二进制文件时拷贝到Device上的算子二进制数据。
- [`aclError aclrtFunctionGetBinary(const aclrtFuncHandle funcHandle, aclrtBinHandle *binHandle)`](#aclrtFunctionGetBinary)：根据核函数句柄获取算子二进制句柄。


<a id="aclrtBinaryLoadFromFile"></a>

# aclrtBinaryLoadFromFile

```c
aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

从文件加载并解析算子二进制文件，输出指向算子二进制的binHandle。

对于AI Core算子，若使用本接口加载并解析算子二进制文件，需配套使用[aclrtLaunchKernelWithConfig](#aclrtBinaryLoadFromFile)、[aclrtLaunchKernelV2](#aclrtLaunchKernelV2)或[aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs)接口下发计算任务。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binPath | 输入 | 算子二进制文件（*.o文件）的路径，要求绝对路径。<br>对于AI CPU算子，该参数支持传算子信息库文件（*.json）。 |
| options | 输入 | 加载算子二进制文件的可选参数。类型定义请参见[aclrtBinaryLoadOptions](24_数据类型及其操作接口.md#aclrtBinaryLoadOptions)。 |
| binHandle | 输出 | 标识算子二进制的句柄。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

针对某一型号的产品，编译生成的算子二进制文件，必须在相同型号的产品上使用。


<br>
<br>
<br>



<a id="aclrtBinaryLoadFromData"></a>

# aclrtBinaryLoadFromData

```c
aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

从内存加载并解析算子二进制数据，输出指向算子二进制的binHandle。

调用本接口用于加载AI CPU算子信息（[aclrtBinaryLoadOption](24_数据类型及其操作接口.md#aclrtBinaryLoadOption).type包含ACL\_RT\_BINARY\_LOAD\_OPT\_CPU\_KERNEL\_MODE）时，还需配合使用[aclrtRegisterCpuFunc](#aclrtRegisterCpuFunc)接口注册AI CPU算子。

注意，系统仅将算子加载至当前Context所对应的Device上，因此在调用[aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig)接口启动算子计算任务时，所在的Device必须与算子加载时的Device相同。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| data | 输入 | 存放算子二进制数据的Host内存地址，不能为空。 |
| length | 输入 | 算子二进制数据的内存大小，必须大于0，单位Byte。 |
| options | 输入 | 加载算子二进制文件的可选参数。类型定义请参见[aclrtBinaryLoadOptions](24_数据类型及其操作接口.md#aclrtBinaryLoadOptions)。 |
| binHandle | 输出 | 标识算子二进制的句柄。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtBinaryGetFunction"></a>

# aclrtBinaryGetFunction

```c
aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | x |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据核函数名称，查找到对应的核函数，并使用funcHandle表达。

对于同一个binHandle，首次调用aclrtBinaryGetFunction接口时，会默认将binHandle关联的算子二进制数据拷贝至当前Context对应的Device上。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| kernelName | 输入 | 核函数名称。 |
| funcHandle | 输出 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtBinaryGetFunctionByEntry"></a>

# aclrtBinaryGetFunctionByEntry

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
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| funcEntry | 输入 | 标识核函数的关键字。 |
| funcHandle | 输出 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtBinaryGetDevAddress"></a>

# aclrtBinaryGetDevAddress

```c
aclError aclrtBinaryGetDevAddress(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取算子二进制数据在Device上的内存地址及内存大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| binAddr | 输出 | 算子二进制数据在Device上的内存地址。<br>如果加载算子二进制时设置了懒加载标识（将aclrtBinaryLoadOptions.[aclrtBinaryLoadOption](24_数据类型及其操作接口.md#aclrtBinaryLoadOption).isLazyLoad设置为1），那么调用本接口获取到的binAddr为空指针。 |
| binSize | 输出 | 算子二进制数据的大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtBinarySetExceptionCallback"></a>

# aclrtBinarySetExceptionCallback

```c
aclError aclrtBinarySetExceptionCallback(aclrtBinHandle binHandle, aclrtOpExceptionCallback callback, void *userData)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

调用本接口注册回调函数。若多次设置回调函数，以最后一次设置为准。

在执行算子之前，调用本接口注册回调函数。如果算子执行过程中出现异常，将触发回调函数的执行，并将异常信息存储在aclrtExceptionInfo结构体中。之后，可以通过调用[aclrtGetArgsFromExceptionInfo](#aclrtGetArgsFromExceptionInfo)和[aclrtGetFuncHandleFromExceptionInfo](#aclrtGetFuncHandleFromExceptionInfo)接口，从异常信息中获取用户下发算子执行任务时的参数以及核函数句柄。目前，仅支持获取AI Core算子执行异常时的信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。<br>调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口或[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。<br>取值详见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。 |
| callback | 输入 | 指定要注册的回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtOpExceptionCallback)(aclrtExceptionInfo *exceptionInfo, void *userData); |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetArgsFromExceptionInfo"></a>

# aclrtGetArgsFromExceptionInfo

```c
aclError aclrtGetArgsFromExceptionInfo(const aclrtExceptionInfo *info, void **devArgsPtr, uint32_t *devArgsLen)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

从aclrtExceptionInfo异常信息中获取用户下发算子执行任务时的参数。此接口与[aclrtBinarySetExceptionCallback](#aclrtBinarySetExceptionCallback)接口配合使用。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| info | 输入 | 异常信息的指针。 |
| devArgsPtr | 输出 | 用户下发算子执行任务时的参数。 |
| devArgsLen | 输出 | 参数个数。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetFuncHandleFromExceptionInfo"></a>

# aclrtGetFuncHandleFromExceptionInfo

```c
aclError aclrtGetFuncHandleFromExceptionInfo(const aclrtExceptionInfo *info, aclrtFuncHandle *func)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

从aclrtExceptionInfo异常信息中获取核函数句柄。此接口与[aclrtBinarySetExceptionCallback](#aclrtBinarySetExceptionCallback)接口配合使用。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| info | 输入 | 异常信息的指针。 |
| func | 输出 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetFunctionAddr"></a>

# aclrtGetFunctionAddr

```c
aclError aclrtGetFunctionAddr(aclrtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据核函数句柄获取Device侧算子起始地址。

不同产品上的AI数据处理核心单元不同，关于Core的定义及详细说明，请参见[aclrtDevAttr](24_数据类型及其操作接口.md#aclrtDevAttr)。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| aicAddr | 输出 | AI Core或Cube Core上的算子起始地址。<br><br>  - 对于以下产品，此处返回的是Cube Core上的算子起始地址。Ascend 950PR/Ascend 950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| aivAddr | 输出 | Vector Core上的算子起始地址。<br>若通过本接口获取到aivAddr为空，则表示该算子不在Vector Core上执行。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetFunctionSize"></a>

# aclrtGetFunctionSize

```c
aclError aclrtGetFunctionSize(aclrtFuncHandle funcHandle, size_t *aicSize, size_t *aivSize)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据核函数句柄获取核函数代码段的大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| aicSize | 输出 | 在AI Core或Cube Core上执行算子的代码段大小，单位Byte。<br>如果算子仅在Vector Core上执行，则该值为0。 |
| aivSize | 输出 | 在Vector Core上执行算子的代码段大小，单位Byte。<br>如果算子仅在AI Core或Cube Core上执行，则该值为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetFunctionName"></a>

# aclrtGetFunctionName

```c
aclError aclrtGetFunctionName(aclrtFuncHandle funcHandle, uint32_t maxLen, char *name)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据核函数句柄获取核函数名称。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| maxLen | 输入 | 用户申请用于存储核函数名称的最大内存大小，单位Byte。 |
| name | 输出 | 核函数名称。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetFunctionAttribute"></a>

# aclrtGetFunctionAttribute

```c
aclError aclrtGetFunctionAttribute(aclrtFuncHandle funcHandle, aclrtFuncAttribute attrType, int64_t *attrValue)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据核函数句柄获取核函数属性信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| attrType | 输入 | 指定属性。类型定义请参见[aclrtFuncAttribute](24_数据类型及其操作接口.md#aclrtFuncAttribute)。 |
| attrValue | 输出 | 获取属性值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetHardwareSyncAddr"></a>

# aclrtGetHardwareSyncAddr

```c
aclError aclrtGetHardwareSyncAddr(void **addr)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取Cube Core、Vector Core之间的同步地址。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| addr | 输出 | 同步地址。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtRegisterCpuFunc"></a>

# aclrtRegisterCpuFunc

```c
aclError aclrtRegisterCpuFunc(const aclrtBinHandle handle, const char *funcName, const char *kernelName, aclrtFuncHandle *funcHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

若使用[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口加载AI CPU算子二进制数据，还需配合使用本接口注册AI CPU算子信息，得到对应的funcHandle。

本接口只用于AI CPU算子，其它算子会返回报错ACL\_ERROR\_RT\_PARAM\_INVALID。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。<br>调用[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| funcName | 输入 | 执行AI CPU算子的入口函数。不能为空。 |
| kernelName | 输入 | AI CPU算子的opType。不能为空。 |
| funcHandle | 输出 | 函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsInit"></a>

# aclrtKernelArgsInit

```c
aclError aclrtKernelArgsInit(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。

与[aclrtKernelArgsInitByUserMem](#aclrtKernelArgsInitByUserMem)接口的区别在于，调用本接口表示由系统管理内存。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。<br>调用[aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry)或[aclrtBinaryGetFunction](#aclrtBinaryGetFunction)获取核函数句柄，再将其作为入参传入本接口。 |
| argsHandle | 输出 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](24_数据类型及其操作接口.md#aclrtArgsHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsInitByUserMem"></a>

# aclrtKernelArgsInitByUserMem

```c
aclError aclrtKernelArgsInitByUserMem(aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, void *userHostMem, size_t actualArgsSize)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。

与[aclrtKernelArgsInit](#aclrtKernelArgsInit)接口的区别在于，调用本接口表示由用户管理内存。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。<br>调用[aclrtBinaryGetFunctionByEntry](#aclrtBinaryGetFunctionByEntry)或[aclrtBinaryGetFunction](#aclrtBinaryGetFunction)获取核函数句柄，再将其作为入参传入本接口。 |
| argsHandle | 输出 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](24_数据类型及其操作接口.md#aclrtArgsHandle)。<br>需提前调用[aclrtKernelArgsGetHandleMemSize](#aclrtKernelArgsGetHandleMemSize)接口获取内存大小，申请Host内存，再将Host内存地址作为入参传入此处。 |
| userHostMem | 输入 | Host内存地址。<br>需提前调用[aclrtKernelArgsGetMemSize](#aclrtKernelArgsGetMemSize)接口获取内存大小，申请Host内存，再将Host内存地址作为入参传入此处。 |
| actualArgsSize | 输入 | 内存大小。<br>需提前调用[aclrtKernelArgsGetMemSize](#aclrtKernelArgsGetMemSize)接口获取内存大小，再将其作为入参传入此处。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsGetMemSize"></a>

# aclrtKernelArgsGetMemSize

```c
aclError aclrtKernelArgsGetMemSize(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取Kernel Launch时参数列表所需内存的实际大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| userArgsSize | 输入 | 在内存中存放参数列表数据所需的大小，单位为Byte。<br>每个参数数据的内存大小都需要8字节对齐，这里的userArgsSize是这些对齐后的参数数据内存大小相加的总和。 |
| actualArgsSize | 输出 | Kernel Launch时参数列表所需内存的实际大小，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsGetHandleMemSize"></a>

# aclrtKernelArgsGetHandleMemSize

```c
aclError aclrtKernelArgsGetHandleMemSize(aclrtFuncHandle funcHandle, size_t *memSize)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取参数列表句柄占用的内存大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| memSize | 输出 | 参数列表句柄占用的内存大小，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsAppend"></a>

# aclrtKernelArgsAppend

```c
aclError aclrtKernelArgsAppend(aclrtArgsHandle argsHandle, void *param, size_t paramSize, aclrtParamHandle *paramHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

调用本接口将用户设置的参数值追加拷贝到argsHandle指向的参数数据区域。若参数列表中有多个参数，则需按顺序追加参数。

如果要更新参数值，可调用[aclrtKernelArgsParaUpdate](#aclrtKernelArgsParaUpdate)接口进行更新。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](24_数据类型及其操作接口.md#aclrtArgsHandle)。 |
| param | 输入 | 待追加参数值的内存地址。<br>此处为Host内存地址。 |
| paramSize | 输入 | 内存大小，单位Byte。 |
| paramHandle | 输出 | 参数句柄。类型定义请参见[aclrtParamHandle](24_数据类型及其操作接口.md#aclrtParamHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsAppendPlaceHolder"></a>

# aclrtKernelArgsAppendPlaceHolder

```c
aclError aclrtKernelArgsAppendPlaceHolder(aclrtArgsHandle argsHandle, aclrtParamHandle *paramHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

对于placeholder参数，调用本接口先占位，返回的是paramHandle占位符。

若参数列表中有多个参数，则需按顺序追加参数。等所有参数都追加之后，可调用[aclrtKernelArgsGetPlaceHolderBuffer](#aclrtKernelArgsGetPlaceHolderBuffer)接口获取paramHandle占位符指向的内存地址。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](24_数据类型及其操作接口.md#aclrtArgsHandle)。 |
| paramHandle | 输出 | 参数句柄。类型定义请参见[aclrtParamHandle](24_数据类型及其操作接口.md#aclrtParamHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsGetPlaceHolderBuffer"></a>

# aclrtKernelArgsGetPlaceHolderBuffer

```c
aclError aclrtKernelArgsGetPlaceHolderBuffer(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, size_t dataSize, void **bufferAddr)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据用户指定的内存大小，获取paramHandle占位符指向的内存地址。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](24_数据类型及其操作接口.md#aclrtArgsHandle)。 |
| paramHandle | 输入 | 参数句柄。类型定义请参见[aclrtParamHandle](24_数据类型及其操作接口.md#aclrtParamHandle)。<br>此处的paramHandle需与[aclrtKernelArgsAppendPlaceHolder](#aclrtKernelArgsAppendPlaceHolder)接口中的paramHandle保持一致。 |
| dataSize | 输入 | 内存大小。 |
| bufferAddr | 输出 | paramHandle占位符指向的内存地址。<br>后续由用户管理该内存中的数据，但无需管理该内存的生命周期。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsParaUpdate"></a>

# aclrtKernelArgsParaUpdate

```c
aclError aclrtKernelArgsParaUpdate(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param, size_t paramSize)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

通过aclrtKernelArgsAppend接口追加的参数，可调用本接口更新参数值。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](24_数据类型及其操作接口.md#aclrtArgsHandle)。 |
| paramHandle | 输入 | 参数句柄。类型定义请参见[aclrtParamHandle](24_数据类型及其操作接口.md#aclrtParamHandle)。 |
| param | 输入 | 待更新参数值的内存地址。<br>此处为Host内存地址。 |
| paramSize | 输入 | 内存大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtKernelArgsFinalize"></a>

# aclrtKernelArgsFinalize

```c
aclError aclrtKernelArgsFinalize(aclrtArgsHandle argsHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在所有参数追加完成后，调用本接口以标识参数组装完毕。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](24_数据类型及其操作接口.md#aclrtArgsHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtLaunchKernel"></a>

# aclrtLaunchKernel

```c
aclError aclrtLaunchKernel(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

启动对应算子的计算任务，异步接口。此处的算子为使用Ascend C语言开发的自定义算子。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。<br>调用[aclrtBinaryGetFunction](#aclrtBinaryGetFunction)接口根据kernelName获取funcHandle。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| argsData | 输入 | 存放核函数所有入参数据的Device内存地址指针。<br>内存申请接口请参见[内存管理](内存管理.md)。<br>注意，执行本接口下发任务的Device需与argsData中使用的Device内存要是同一个Device。 |
| argsSize | 输入 | argsData参数值的大小，单位为Byte。 |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：


| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |


<br>
<br>
<br>



<a id="aclrtLaunchKernelV2"></a>

# aclrtLaunchKernelV2

```c
aclError aclrtLaunchKernelV2(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtLaunchKernelCfg *cfg, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| argsData | 输入 | 存放核函数所有入参数据的Device内存地址指针。<br>内存申请接口请参见[内存管理](内存管理.md)。<br>注意，执行本接口下发任务的Device需与argsData中使用的Device内存要是同一个Device。 |
| argsSize | 输入 | argsData参数值的大小，单位为Byte。 |
| cfg | 输入 | 任务下发的配置信息。类型定义请参见[aclrtLaunchKernelCfg](24_数据类型及其操作接口.md#aclrtLaunchKernelCfg)。<br>不指定配置时，此处可传NULL。 |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：


| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |


<br>
<br>
<br>



<a id="aclrtLaunchKernelWithConfig"></a>

# aclrtLaunchKernelWithConfig

```c
aclError aclrtLaunchKernelWithConfig(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

若使用本接口下发AI Core算子的计算任务，需配套使用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)接口加载并解析算子二进制文件。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| cfg | 输入 | 任务下发的配置信息。类型定义请参见[aclrtLaunchKernelCfg](24_数据类型及其操作接口.md#aclrtLaunchKernelCfg)。<br>不指定配置时，此处可传NULL。 |
| argsHandle | 输入 | 参数列表句柄。类型定义请参见[aclrtArgsHandle](24_数据类型及其操作接口.md#aclrtArgsHandle)。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：


| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |


<br>
<br>
<br>



<a id="aclrtLaunchKernelWithHostArgs"></a>

# aclrtLaunchKernelWithHostArgs

```c
aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| numBlocks | 输入 | 指定核函数将会在几个核上执行。 |
| stream | 输入 | 指定执行任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| cfg | 输入 | 任务下发的配置信息。类型定义请参见[aclrtLaunchKernelCfg](24_数据类型及其操作接口.md#aclrtLaunchKernelCfg)。<br>不指定配置时，此处可传NULL。 |
| hostArgs | 输入 | 存放核函数所有入参数据的Host内存地址指针。 |
| argsSize | 输入 | hostArgs参数值的大小，单位为Byte。 |
| placeHolderArray | 输入 | placeholder参数数组。<br>aclrtPlaceHolderInfo定义如下：<br>typedef struct {<br>   uint32_t addrOffset;<br>   uint32_t dataOffset;<br>} aclrtPlaceHolderInfo;<br>成员变量说明如下：<br><br>  - addrOffset：placeholder指向的数据区拷贝到Device后，其真实Device内存地址在launch时需要刷新到hostArgs中，该参数用于指定需刷新的位置偏移<br>  - dataOffset：placeholder指向的数据区需拷贝到Device侧，该参数用于指定数据区基于hostArgs的地址偏移 |
| placeHolderNum | 输入 | placeholder参数数组的大小。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 参考资源

下表的几个接口都用于启用对应算子的计算任务，但功能和使用方式有所不同：


| 接口 | 核函数参数值的传入方式 | 核函数参数值的存放位置 | 是否可指定任务下发的配置信息 |
| --- | --- | --- | --- |
| [aclrtLaunchKernel](#aclrtLaunchKernel) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 否 |
| [aclrtLaunchKernelV2](#aclrtLaunchKernelV2) | 在接口中指定存放核函数所有入参数据的Device内存地址指针 | Device内存 | 是 |
| [aclrtLaunchKernelWithConfig](#aclrtLaunchKernelWithConfig) | 在接口中指定参数列表句柄aclrtArgsHandle | Host内存 | 是 |
| [aclrtLaunchKernelWithHostArgs](#aclrtLaunchKernelWithHostArgs) | 在接口中指定存放核函数所有入参数据的Host内存地址指针 | Host内存 | 是 |


<br>
<br>
<br>



<a id="aclrtCreateBinary"></a>

# aclrtCreateBinary

```c
aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

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


<br>
<br>
<br>



<a id="aclrtDestroyBinary"></a>

# aclrtDestroyBinary

```c
aclError aclrtDestroyBinary(aclrtBinary binary)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[aclrtCreateBinary](#aclrtCreateBinary)接口创建的aclrtBinary类型的数据。此处的算子为使用Ascend C语言开发的自定义算子。

注意，此处仅销毁aclrtBinary的数据，调用[aclrtCreateBinary](#aclrtCreateBinary)接口时传入的data内存需由用户自行、及时释放，否则可能会导致内存异常。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binary | 输入 | 待销毁的aclrtBinary类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtBinaryLoad"></a>

# aclrtBinaryLoad

```c
aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

解析、加载算子二进制文件，输出指向算子二进制的binHandle，同时将算子二进制文件数据拷贝至当前Context对应的Device上。此处的算子为使用Ascend C语言开发的自定义算子。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binary | 输入 | 算子二进制信息。<br>此处需先调用[aclrtCreateBinary](#aclrtCreateBinary)接口，获取aclrtBinary类型数据的指针。 |
| binHandle | 输出 | 指向二进制的handle。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtBinaryUnLoad"></a>

# aclrtBinaryUnLoad

```c
aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

删除binHandle指向的算子二进制数据，同时也删除加载算子二进制文件时拷贝到Device上的算子二进制数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| binHandle | 输入 | 算子二进制句柄。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。<br>该handle在调用[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)、[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)或者[aclrtBinaryLoad](#aclrtBinaryLoad)接口时生成。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

调用本接口删除算子二进制数据时，需跟[aclrtBinaryLoadFromFile](#aclrtBinaryLoadFromFile)、[aclrtBinaryLoadFromData](#aclrtBinaryLoadFromData)或者[aclrtBinaryLoad](#aclrtBinaryLoad)接口在同一个Context下，这样才能一并删除加载算子二进制文件时拷贝到Device上的算子二进制数据，否则可能会导致Device上的算子二进制数据删除异常。


<br>
<br>
<br>



<a id="aclrtFunctionGetBinary"></a>

# aclrtFunctionGetBinary

```c
aclError aclrtFunctionGetBinary(const aclrtFuncHandle funcHandle, aclrtBinHandle *binHandle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据核函数句柄获取算子二进制句柄。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| funcHandle | 输入 | 核函数句柄。类型定义请参见[aclrtFuncHandle](24_数据类型及其操作接口.md#aclrtFuncHandle)。 |
| binHandle | 输出 | 算子二进制的句柄。类型定义请参见[aclrtBinHandle](24_数据类型及其操作接口.md#aclrtBinHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。
