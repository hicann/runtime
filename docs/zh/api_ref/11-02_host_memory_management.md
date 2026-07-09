# 11-02 主机内存管理

本章节描述主机（Host）内存的分配、释放、注册及指针获取接口。

- [`aclError aclrtMallocHost(void **hostPtr, size_t size)`](#aclrtMallocHost)：申请Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。
- [`aclError aclrtMallocHostWithCfg(void **ptr, uint64_t size, aclrtMallocConfig *cfg)`](#aclrtMallocHostWithCfg)：申请Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。
- [`aclError aclrtFreeHost(void *hostPtr)`](#aclrtFreeHost)：释放通过[aclrtMallocHost](#aclrtMallocHost)接口或[aclrtMallocHostWithCfg](#aclrtMallocHostWithCfg)接口申请的Host内存。
- [`aclError aclrtFreeHostWithDevSync(void *hostPtr)`](#aclrtFreeHostWithDevSync)：释放通过[aclrtMallocHost](#aclrtMallocHost)接口或[aclrtMallocHostWithCfg](#aclrtMallocHostWithCfg)接口申请的Host内存。
- [`aclError aclrtHostRegister(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr)`](#aclrtHostRegister)：将Host内存映射注册为Device可访问的内存地址，并获取映射后的Device内存地址。映射后的Device内存地址不能用于内存操作，例如内存复制。
- [`aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)`](#aclrtHostRegisterV2)：注册Host内存地址。
- [`aclError aclrtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)`](#aclrtHostGetDevicePointer)：获取由aclrtHostRegister或aclrtHostRegisterV2接口注册映射的Device内存地址。映射后的Device内存地址不能用于内存操作，例如内存复制。
- [`aclError aclrtHostMemMapCapabilities(uint32_t deviceId, aclrtHacType hacType, aclrtHostMemMapCapability *capabilities)`](#aclrtHostMemMapCapabilities)：查询指定的硬件驱动加速器是否支持访问通过[aclrtHostRegister](#aclrtHostRegister)接口注册的内存。
- [`aclError aclrtHostUnregister(void *ptr)`](#aclrtHostUnregister)：取消注册Host内存。

<a id="aclrtMallocHost"></a>

## aclrtMallocHost

```c
aclError aclrtMallocHost(void **hostPtr, size_t size)
```

### 产品支持情况

<!-- npu="950" id1681 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1681 -->
<!-- npu="A3" id1682 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1682 -->
<!-- npu="910b" id1683 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1683 -->
<!-- npu="310b" id1684 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1684 -->
<!-- npu="310p" id1685 -->
- Atlas 推理系列产品：支持
<!-- end id1685 -->
<!-- npu="910" id1686 -->
- Atlas 训练系列产品：支持
<!-- end id1686 -->
<!-- npu="IPV350" id1687 -->
- IPV350：不支持
<!-- end id1687 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id1 -->

### 功能说明

申请Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。

通过本接口申请的内存，需要通过[aclrtFreeHost](#aclrtFreeHost)接口或[aclrtFreeHostWithDevSync](#aclrtFreeHostWithDevSync)接口释放内存。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| hostPtr | 输出 | “已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口分配的内存不会进行对内容进行初始化，建议在使用内存前先调用[aclrtMemset](11-03_memory_copy_and_set.md#aclrtMemset)接口先初始化内存，清除内存中的随机数。
- 本接口内部不会进行隐式的device同步或流同步。如果申请内存成功或申请内存失败会立刻返回结果。
- 使用aclrtMallocHost接口分配过多的锁页内存，将导致操作系统用于分页的物理内存变少，从而降低系统整体的性能。
- 频繁调用aclrtMallocHost接口申请内存、调用[aclrtFreeHost](#aclrtFreeHost)接口释放内存，会损耗性能，建议用户提前做内存预先分配或二次管理，避免频繁申请/释放内存。
<!-- npu="310p,310b" id8 -->
- 针对Ascend RC形态、Control CPU开放形态，Host与Device是合一的，所以申请Host内存也等同于申请Device内存。此外，申请内存时，按普通页申请。如果需要64字节对齐的首地址，用户需自行处理对齐问题。
<!-- end id8 -->
    <!-- npu="310p,310b" id9 -->
- 针对Ascend RC形态、Control CPU开放形态，若用户使用本接口申请大块内存并自行划分、管理内存时，每段内存需同时满足以下需求，其中，len表示某段内存的大小，ALIGN\_UP\[len,k\]表示向上按k字节对齐：\(\(len-1\)/k+1\)\*k：
    - 内存大小向上对齐成32整数倍+32字节（m=ALIGN\_UP\[len,32\]+32字节）；
    - 内存起始地址需满足64字节对齐（ALIGN\_UP\[m,64\]）。
    <!-- end id9 -->

<br>
<br>
<br>

<a id="aclrtMallocHostWithCfg"></a>

## aclrtMallocHostWithCfg

```c
aclError aclrtMallocHostWithCfg(void **ptr, uint64_t size, aclrtMallocConfig *cfg)
```

### 产品支持情况

<!-- npu="950" id715 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id715 -->
<!-- npu="A3" id716 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id716 -->
<!-- npu="910b" id717 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id717 -->
<!-- npu="310b" id718 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id718 -->
<!-- npu="310p" id719 -->
- Atlas 推理系列产品：支持
<!-- end id719 -->
<!-- npu="910" id720 -->
- Atlas 训练系列产品：支持
<!-- end id720 -->
<!-- npu="IPV350" id721 -->
- IPV350：不支持
<!-- end id721 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id2 -->

### 功能说明

申请Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。

与aclrtMallocHost接口相比，本接口在申请内存时，还可以指定内存相关的配置信息。

通过本接口申请的内存，需要通过[aclrtFreeHost](#aclrtFreeHost)接口或[aclrtFreeHostWithDevSync](#aclrtFreeHostWithDevSync)接口释放内存。

<!-- npu="310p,310b" id10 -->
针对Ascend RC形态、Control CPU开放形态，Host与Device是合一的，所以申请Host内存也等同于申请Device内存。此外，申请内存时，按普通页申请。如果需要64字节对齐的首地址，用户需自行处理对齐问题。
<!-- end id10 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ptr | 输出 | “已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| cfg | 输入 | 内存配置信息。类型定义请参见[aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig)。<br>不指定配置时，此处可传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtFreeHost"></a>

## aclrtFreeHost

```c
aclError aclrtFreeHost(void *hostPtr)
```

### 产品支持情况

<!-- npu="950" id540 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id540 -->
<!-- npu="A3" id541 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id541 -->
<!-- npu="910b" id542 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id542 -->
<!-- npu="310b" id543 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id543 -->
<!-- npu="310p" id544 -->
- Atlas 推理系列产品：支持
<!-- end id544 -->
<!-- npu="910" id545 -->
- Atlas 训练系列产品：支持
<!-- end id545 -->
<!-- npu="IPV350" id546 -->
- IPV350：不支持
<!-- end id546 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id3 -->

### 功能说明

释放通过[aclrtMallocHost](#aclrtMallocHost)接口或[aclrtMallocHostWithCfg](#aclrtMallocHostWithCfg)接口申请的Host内存。

本接口会立刻释放传入的内存，接口内部不会进行隐式的Device同步或流同步、也不会等待使用该内存的任务完成。用户需确保在调用本接口后不再访问该内存指针。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| hostPtr | 输入 | 待释放内存的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtFreeHostWithDevSync"></a>

## aclrtFreeHostWithDevSync

```c
aclError aclrtFreeHostWithDevSync(void *hostPtr)
```

### 产品支持情况

<!-- npu="950" id778 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id778 -->
<!-- npu="A3" id779 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id779 -->
<!-- npu="910b" id780 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id780 -->
<!-- npu="310b" id781 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id781 -->
<!-- npu="310p" id782 -->
- Atlas 推理系列产品：支持
<!-- end id782 -->
<!-- npu="910" id783 -->
- Atlas 训练系列产品：支持
<!-- end id783 -->
<!-- npu="IPV350" id784 -->
- IPV350：不支持
<!-- end id784 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id4 -->

### 功能说明

释放通过[aclrtMallocHost](#aclrtMallocHost)接口或[aclrtMallocHostWithCfg](#aclrtMallocHostWithCfg)接口申请的Host内存。

本接口内部会进行隐式的Device同步，并等待使用该内存的任务完成。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| hostPtr | 输入 | 待释放内存的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtHostRegister"></a>

## aclrtHostRegister

```c
aclError aclrtHostRegister(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr)
```

### 产品支持情况

<!-- npu="950" id1576 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id1576 -->
<!-- npu="A3" id1577 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1577 -->
<!-- npu="910b" id1578 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1578 -->
<!-- npu="310b" id1579 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1579 -->
<!-- npu="310p" id1580 -->
- Atlas 推理系列产品：不支持
<!-- end id1580 -->
<!-- npu="910" id1581 -->
- Atlas 训练系列产品：不支持
<!-- end id1581 -->
<!-- npu="IPV350" id1582 -->
- IPV350：不支持
<!-- end id1582 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id5 -->

### 功能说明

将Host内存映射注册为Device可访问的内存地址，并获取映射后的Device内存地址，该地址仅支持在Device上访问，例如作为核函数的参数，供Device的AI Core访问。若涉及Host侧的内存处理，需使用原始Host内存地址。

取消注册Host内存需调用[aclrtHostUnregister](#aclrtHostUnregister)接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ptr | 输入 | Host内存地址。<br>Host内存地址需4K页对齐。<br>当os内核版本为5.10或更低时，使用非锁页内存会导致异常，因此必须调用aclrtMallocHost接口来申请Host锁页内存。<br>当os内核版本为5.10以上时，支持使用非锁页的Host内存，因此既支持调用aclrtMallocHost接口申请Host锁页内存，也支持使用malloc接口申请Host非锁页内存。 |
| size | 输入 | 内存大小，单位Byte。 |
| type | 输入 | 内存注册类型。类型定义请参见[aclrtHostRegisterType](25-02_Enumerations.md#aclrtHostRegisterType)。 |
| devPtr | 输出 | Host内存映射成的Device可访问的内存地址。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtHostRegisterV2"></a>

## aclrtHostRegisterV2

```c
aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id1401 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id1401 -->
<!-- npu="A3" id1402 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1402 -->
<!-- npu="910b" id1403 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1403 -->
<!-- npu="310b" id1404 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1404 -->
<!-- npu="310p" id1405 -->
- Atlas 推理系列产品：不支持
<!-- end id1405 -->
<!-- npu="910" id1406 -->
- Atlas 训练系列产品：不支持
<!-- end id1406 -->
<!-- npu="IPV350" id1407 -->
- IPV350：不支持
<!-- end id1407 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id6 -->

### 功能说明

注册Host内存地址。

取消注册需调用[aclrtHostUnregister](#aclrtHostUnregister)接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ptr | 输入 | Host内存地址。<br>Host内存地址需4K页对齐。<br>当os内核版本为5.10或更低时，使用非锁页内存会导致异常，因此必须调用aclrtMallocHost接口来申请Host锁页内存。<br>当os内核版本为5.10以上时，支持使用非锁页的Host内存，因此既支持调用aclrtMallocHost接口申请Host锁页内存，也支持使用malloc接口申请Host非锁页内存。 |
| size | 输入 | 内存大小，单位Byte。 |
| flag | 输入 | 内存注册类型。<br>取值为如下宏，支持配置单个宏，也支持配置多个宏位或（例如ACL_HOST_REG_MAPPED \| ACL_HOST_REG_PINNED）：<br><br>  - ACL_HOST_REG_MAPPED：将Host内存映射注册为Device可访问的内存地址，再配合调用[aclrtHostGetDevicePointer](#aclrtHostGetDevicePointer)接口获取映射后的Device内存地址。<br>  - ACL_HOST_REG_IOMEMORY：将Host上第三方PCIe设备的IO space(寄存器、缓存)映射注册为Device可访问，包括读写。预留选项，当前不支持。<br>  - ACL_HOST_REG_READONLY：Host内存映射注册为Device只读。预留选项，当前不支持。<br>  - ACL_HOST_REG_PINNED：将Host非锁页内存注册为锁页内存。Host非锁页内存可通过C/C++标准库函数（如malloc、calloc、new）或默认的mmap系统调用等方式申请。<br><br>宏定义如下：<br>#define ACL_HOST_REG_MAPPED 0x2UL<br>#define ACL_HOST_REG_IOMEMORY 0x4UL<br>#define ACL_HOST_REG_READONLY 0x8UL<br>#define ACL_HOST_REG_PINNED 0X10000000UL |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtHostGetDevicePointer"></a>

## aclrtHostGetDevicePointer

```c
aclError aclrtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas 推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas 训练系列产品：不支持
<!-- end id6 -->
<!-- npu="IPV350" id7 -->
- IPV350：不支持
<!-- end id7 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id7 -->

### 功能说明

获取由aclrtHostRegister或aclrtHostRegisterV2接口注册映射的Device内存地址。映射后的Device内存地址不能用于内存操作，例如内存复制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pHost | 输入 | 通过aclrtHostRegister或aclrtHostRegisterV2接口注册映射的Host内存地址。 |
| pDevice | 输出 | Host内存映射成的Device内存地址。 |
| flag | 输入 | 预留参数，当前固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtHostMemMapCapabilities"></a>

## aclrtHostMemMapCapabilities

```c
aclError aclrtHostMemMapCapabilities(uint32_t deviceId, aclrtHacType hacType, aclrtHostMemMapCapability *capabilities)
```

### 产品支持情况

<!-- npu="950" id561 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id561 -->
<!-- npu="A3" id562 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id562 -->
<!-- npu="910b" id563 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id563 -->
<!-- npu="310b" id564 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id564 -->
<!-- npu="310p" id565 -->
- Atlas 推理系列产品：支持
<!-- end id565 -->
<!-- npu="910" id566 -->
- Atlas 训练系列产品：支持
<!-- end id566 -->
<!-- npu="IPV350" id567 -->
- IPV350：不支持
<!-- end id567 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id8 -->

### 功能说明

查询指定的硬件驱动加速器是否支持访问通过[aclrtHostRegister](#aclrtHostRegister)接口注册的内存。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| hacType | 输入 | HAC（Hardware Accelerator Controller，硬件加速控制器）类型。类型定义请参见[aclrtHacType](25-02_Enumerations.md#aclrtHacType)。 |
| capabilities | 输出 | 是否支持访问通过aclrtHostRegister接口注册的内存。类型定义请参见[aclrtHostMemMapCapability](25-02_Enumerations.md#aclrtHostMemMapCapability)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtHostUnregister"></a>

## aclrtHostUnregister

```c
aclError aclrtHostUnregister(void *ptr)
```

### 产品支持情况

<!-- npu="950" id1898 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id1898 -->
<!-- npu="A3" id1899 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1899 -->
<!-- npu="910b" id1900 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1900 -->
<!-- npu="310b" id1901 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1901 -->
<!-- npu="310p" id1902 -->
- Atlas 推理系列产品：不支持
<!-- end id1902 -->
<!-- npu="910" id1903 -->
- Atlas 训练系列产品：支持
<!-- end id1903 -->
<!-- npu="IPV350" id1904 -->
- IPV350：不支持
<!-- end id1904 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id9 -->

### 功能说明

取消注册Host内存。

本接口与[aclrtHostRegister](#aclrtHostRegister)或[aclrtHostRegisterV2](#aclrtHostRegisterV2)接口成对使用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ptr | 输入 | Host侧内存地址。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
