# 11-01 设备内存分配与释放

本章节描述设备（Device）内存的分配与释放接口。

- [`aclError aclrtMalloc(void **devPtr, size_t size, aclrtMemMallocPolicy policy)`](#aclrtMalloc)：在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针，且内存首地址64字节对齐。
- [`aclError aclrtMallocAlign32(void **devPtr, size_t size, aclrtMemMallocPolicy policy)`](#aclrtMallocAlign32)：在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针。
- [`aclError aclrtMallocCached(void **devPtr, size_t size, aclrtMemMallocPolicy policy)`](#aclrtMallocCached)：在Device上申请size大小的线性内存，通过\*devPtr返回已分配内存的指针，该接口在任何场景下申请的内存都是支持Cache缓存。
- [`aclError aclrtMemFlush(void *devPtr, size_t size)`](#aclrtMemFlush)：将Cache中的数据刷新到DDR中，并将Cache中的内容设置成无效。
- [`aclError aclrtMemInvalidate(void *devPtr, size_t size)`](#aclrtMemInvalidate)：将Cache中的数据设置成无效。
- [`aclError aclrtMallocWithCfg(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)`](#aclrtMallocWithCfg)：在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针，且内存首地址64字节对齐。
- [`aclError aclrtMallocForTaskScheduler(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)`](#aclrtMallocForTaskScheduler)：申请AI处理器上Task调度器可使用的内存。
- [`aclError aclrtFree(void *devPtr)`](#aclrtFree)：释放Device上的内存。
- [`aclError aclrtFreeWithDevSync(void *devPtr)`](#aclrtFreeWithDevSync)：释放Device上的内存。
- [`aclError aclrtGetMemInfo(aclrtMemAttr attr, size_t *free, size_t *total)`](#aclrtGetMemInfo)：根据指定属性，获取Device上可用内存的空闲大小和总大小，不包括系统预留内存大小。
- [`aclError aclrtGetMemUsageInfo(int32_t deviceId, aclrtMemUsageInfo *memUsageInfo, size_t inputNum, size_t *outputNum)`](#aclrtGetMemUsageInfo)：查询组件的内存使用信息，包括组件名称、当前内存大小和峰值内存大小等信息。
- [`aclError aclrtCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)`](#aclrtCheckMemType)：检查Device内存类型。

<a id="aclrtMalloc"></a>

## aclrtMalloc

```c
aclError aclrtMalloc(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
```

### 产品支持情况

<!-- npu="950" id729 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id729 -->
<!-- npu="A3" id730 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id730 -->
<!-- npu="910b" id731 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id731 -->
<!-- npu="310b" id732 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id732 -->
<!-- npu="310p" id733 -->
- Atlas 推理系列产品：支持
<!-- end id733 -->
<!-- npu="910" id734 -->
- Atlas 训练系列产品：支持
<!-- end id734 -->
<!-- npu="IPV350" id735 -->
- IPV350：支持
<!-- end id735 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id1 -->

### 功能说明

在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针，且内存首地址64字节对齐。使用本接口申请的内存，需要通过[aclrtFree](#aclrtFree)接口或[aclrtFreeWithDevSync](#aclrtFreeWithDevSync)接口释放内存。

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
本接口分配的内存，会进行字节对齐，对齐规则各产品型号有所不同：
<!-- end id1 -->

<!-- npu="950" id2 -->
- 对于Ascend 950PR/Ascend 950DT，本接口分配的内存，会进行字节对齐，会对用户申请的size向上对齐成32字节整数倍。
<!-- end id2 -->
<!-- npu="A3,910b,910,310p,310b" id3 -->
- 对于以下产品型号，本接口分配的内存，会进行字节对齐，会对用户申请的size向上对齐成32字节整数倍后再多加32字节。但对于内存申请粒度为1G的大页内存，为节省大页内存，本接口会对用户申请的size仅向上对齐成32字节整数倍，不会再增加32字节。
    <!-- npu="A3" id4 -->
    - Atlas A3 训练系列产品/Atlas A3 推理系列产品
    <!-- end id4 -->
    <!-- npu="910b" id5 -->
    - Atlas A2 训练系列产品/Atlas A2 推理系列产品
    <!-- end id5 -->
    <!-- npu="310b" id6 -->
    - Atlas 200I/500 A2 推理产品
    <!-- end id6 -->
    <!-- npu="310p" id7 -->
    - Atlas 推理系列产品
    <!-- end id7 -->
    <!-- npu="910" id8 -->
    - Atlas 训练系列产品
    <!-- end id8 -->
<!-- end id3 -->

<!-- npu="IPV350" id9 -->
本接口分配的内存，会进行字节对齐，会对用户申请的size向上对齐成32字节整数倍后再多加32字节。但对于内存申请粒度为1G的大页内存，为节省大页内存，本接口会对用户申请的size仅向上对齐成32字节整数倍，不会再增加32字节。
<!-- end id9 -->

<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id11 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。类型定义请参见[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口分配的内存不会对内容初始化，建议在使用内存前先调用[aclrtMemset](11-03_memory_copy_and_set.md#aclrtMemset)接口先初始化内存，清除内存中的随机数。
- 本接口内部不会进行隐式的Device同步或流同步，如果申请内存成功或申请内存失败会立刻返回结果。
<!-- npu="950,A3,910b,910,310p,310b" id10 -->
- policy处仅支持配置单个枚举项，不支持配置多个枚举项位或。
<!-- end id10 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id12 -->
<!-- npu="IPV350" id11 -->
- policy处支持配置单个枚举项，也支持配置多个枚举项位或。位或时，支持这三项（ACL\_MEM\_MALLOC\_HUGE\_FIRST、ACL\_MEM\_MALLOC\_HUGE\_ONLY、ACL\_MEM\_MALLOC\_NORMAL\_ONLY）与这两项（ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH、ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH）组合，**例如**：ACL\_MEM\_MALLOC\_HUGE\_FIRST | ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH
<!-- end id11 -->
- 针对ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P、ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P内存分配规则，建议使用aclrtMallocWithCfg接口，否则可能存在性能问题或无法申请到内存。
- 频繁调用aclrtMalloc接口申请内存、调用[aclrtFree](#aclrtFree)接口释放内存，会损耗性能，建议用户提前做内存预先分配或二次管理，避免频繁申请/释放内存。
- 若用户需申请大块内存并自行划分、管理内存时，每段内存需同时满足以下需求，其中，len表示某段内存的大小，ALIGN\_UP\[len,k\]表示向上按k字节对齐：\(\(len-1\)/k+1\)\*k：
    <!-- npu="950,A3,910b,910,310p,310b" id12 -->
    - 内存大小对齐规则，各产品型号有所不同：
        <!-- npu="950" id13 -->
        - 对于Ascend 950PR/Ascend 950DT，内存大小向上对齐成32整数倍（m=ALIGN\_UP\[len,32\]字节）。
        <!-- end id13 -->
        <!-- npu="A3,910b,910,310p,310b" id14 -->
        - 对于以下产品型号，内存大小向上对齐成32整数倍+32字节（m=ALIGN\_UP\[len,32\]+32字节）。

            <!-- npu="A3" id15 -->
            Atlas A3 训练系列产品/Atlas A3 推理系列产品
            <!-- end id15 -->

            <!-- npu="910b" id16 -->
            Atlas A2 训练系列产品/Atlas A2 推理系列产品
            <!-- end id16 -->

            <!-- npu="310b" id17 -->
            Atlas 200I/500 A2 推理产品
            <!-- end id17 -->

            <!-- npu="310p" id18 -->
            Atlas 推理系列产品
            <!-- end id18 -->

            <!-- npu="910" id19 -->
            Atlas 训练系列产品
            <!-- end id19 -->
        <!-- end id14 -->
    <!-- end id12 -->

    <!-- npu="IPV350" id20 -->
    - 内存大小向上对齐成32整数倍+32字节（m=ALIGN\_UP\[len,32\]+32字节）。
    <!-- end id20 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id13 -->
    - 内存起始地址需满足64字节对齐（ALIGN\_UP\[m,64\]）。

<br>
<br>
<br>

<a id="aclrtMallocAlign32"></a>

## aclrtMallocAlign32

```c
aclError aclrtMallocAlign32(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
```

### 产品支持情况

<!-- npu="950" id1786 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1786 -->
<!-- npu="A3" id1787 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1787 -->
<!-- npu="910b" id1788 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1788 -->
<!-- npu="310b" id1789 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1789 -->
<!-- npu="310p" id1790 -->
- Atlas 推理系列产品：支持
<!-- end id1790 -->
<!-- npu="910" id1791 -->
- Atlas 训练系列产品：支持
<!-- end id1791 -->
<!-- npu="IPV350" id1792 -->
- IPV350：支持
<!-- end id1792 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id2 -->

### 功能说明

在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针。本接口分配的内存会进行字节对齐，会对用户申请的size向上对齐成32字节整数倍。使用本接口申请的内存，需要通过[aclrtFree](#aclrtFree)接口或[aclrtFreeWithDevSync](#aclrtFreeWithDevSync)接口释放内存。

<!-- npu="950" id21 -->
对于Ascend 950PR/Ascend 950DT，本接口功能等同于aclrtMalloc接口。
<!-- end id21 -->

<!-- npu="A3,910b,910,310p,310b" id22 -->
对于以下产品型号，与aclrtMalloc接口相比，本接口只会对用户申请的size向上对齐成32字节整数倍，不会再多加32字节。

<!-- npu="A3" id23 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
<!-- end id23 -->
<!-- npu="910b" id24 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品
<!-- end id24 -->
<!-- npu="310b" id25 -->
- Atlas 200I/500 A2 推理产品
<!-- end id25 -->
<!-- npu="310p" id26 -->
- Atlas 推理系列产品
<!-- end id26 -->
<!-- npu="910" id27 -->
- Atlas 训练系列产品
<!-- end id27 -->
<!-- end id22 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。类型定义请参见[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口分配的内存不会进行对内容进行初始化。

- 本接口内部不会进行隐式的Device同步或流同步。如果申请内存成功或申请内存失败会立刻返回结果。
<!-- npu="950,A3,910b,910,310p,310b" id28 -->
- policy处仅支持配置单个枚举项，不支持配置多个枚举项位或。
<!-- end id28 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id14 -->
<!-- npu="IPV350" id29 -->
- policy处支持配置单个枚举项，也支持配置多个枚举项位或。位或时，支持这三项（ACL\_MEM\_MALLOC\_HUGE\_FIRST、ACL\_MEM\_MALLOC\_HUGE\_ONLY、ACL\_MEM\_MALLOC\_NORMAL\_ONLY）与这两项（ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH、ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH）组合，**例如**：ACL\_MEM\_MALLOC\_HUGE\_FIRST | ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH
<!-- end id29 -->
- 针对ACL_MEM_MALLOC_HUGE_FIRST_P2P、ACL_MEM_MALLOC_HUGE_ONLY_P2P内存分配规则，建议使用aclrtMallocWithCfg接口，否则可能存在性能问题或无法申请到内存。- 频繁调用aclrtMallocAlign32接口申请内存、调用[aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree)接口释放内存，会损耗性能，建议用户提前做内存预先分配或二次管理，避免频繁申请/释放内存。
- 若用户使用本接口申请大块内存并自行划分、管理内存时，每段内存需同时满足以下需求，其中，len表示某段内存的大小，ALIGN\_UP\[len,k\]表示向上按k字节对齐：\(\(len-1\)/k+1\)\*k：
    <!-- npu="950,A3,910b,910,310p,310b" id30 -->
    - 内存大小对齐规则，各产品型号有所不同：
        <!-- npu="950" id31 -->
        - 对于Ascend 950PR/Ascend 950DT，内存大小向上对齐成32整数倍（m=ALIGN\_UP\[len,32\]字节）。
        <!-- end id31 -->
        <!-- npu="A3,910b,910,310p,310b" id32 -->
        - 对于以下产品型号，内存大小向上对齐成32整数倍+32字节（m=ALIGN\_UP\[len,32\]+32字节）。

            <!-- npu="A3" id34 -->
            Atlas A3 训练系列产品/Atlas A3 推理系列产品
            <!-- end id34 -->

            <!-- npu="910b" id35 -->
            Atlas A2 训练系列产品/Atlas A2 推理系列产品
            <!-- end id35 -->

            <!-- npu="310b" id36 -->
            Atlas 200I/500 A2 推理产品
            <!-- end id36 -->

            <!-- npu="310p" id37 -->
            Atlas 推理系列产品
            <!-- end id37 -->

            <!-- npu="910" id38 -->
            Atlas 训练系列产品
            <!-- end id38 -->
        <!-- end id32 -->
    <!-- end id30 -->

    <!-- npu="IPV350" id33 -->
    - 内存大小向上对齐成32整数倍+32字节（m=ALIGN\_UP\[len,32\]+32字节）。
    <!-- end id33 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id15 -->
    - 内存起始地址需满足64字节对齐（ALIGN\_UP\[m,64\]）。

<br>
<br>
<br>

<a id="aclrtMallocCached"></a>

## aclrtMallocCached

```c
aclError aclrtMallocCached(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
```

### 产品支持情况

<!-- npu="950" id316 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id316 -->
<!-- npu="A3" id317 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id317 -->
<!-- npu="910b" id318 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id318 -->
<!-- npu="310b" id319 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id319 -->
<!-- npu="310p" id320 -->
- Atlas 推理系列产品：支持
<!-- end id320 -->
<!-- npu="910" id321 -->
- Atlas 训练系列产品：支持
<!-- end id321 -->
<!-- npu="IPV350" id322 -->
- IPV350：不支持
<!-- end id322 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id3 -->

### 功能说明

在Device上申请size大小的线性内存，通过\*devPtr返回已分配内存的指针，该接口在任何场景下申请的内存都是支持Cache缓存。

使用aclrtMallocCached接口申请的内存与使用[aclrtMalloc](#aclrtMalloc)接口申请的内存是等价的，都支持Cache缓存，不需要用户处理CPU与NPU之间的Cache一致性。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。类型定义请参见[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

policy处仅支持配置单个枚举项，不支持配置多个枚举项位或。且仅支持以下枚举项：ACL\_MEM\_MALLOC\_HUGE\_FIRST、ACL\_MEM\_MALLOC\_HUGE\_ONLY、ACL\_MEM\_MALLOC\_NORMAL\_ONLY、ACL\_MEM\_MALLOC\_HUGE1G\_ONLY。

<br>
<br>
<br>

<a id="aclrtMemFlush"></a>

## aclrtMemFlush

```c
aclError aclrtMemFlush(void *devPtr, size_t size)
```

### 产品支持情况

<!-- npu="950" id2094 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2094 -->
<!-- npu="A3" id2095 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2095 -->
<!-- npu="910b" id2096 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2096 -->
<!-- npu="310b" id2097 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2097 -->
<!-- npu="310p" id2098 -->
- Atlas 推理系列产品：支持
<!-- end id2098 -->
<!-- npu="910" id2099 -->
- Atlas 训练系列产品：支持
<!-- end id2099 -->
<!-- npu="IPV350" id2100 -->
- IPV350：不支持
<!-- end id2100 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id16 -->

### 功能说明

将Cache中的数据刷新到DDR中，并将Cache中的内容设置成无效。

该版本不需要用户处理CPU与NPU之间的Cache一致性，无需调用该接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输入 | 要Flush的DDR内存起始地址指针。 |
| size | 输入 | 要Flush的DDR内存大小，单位Byte。<br>size不能为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemInvalidate"></a>

## aclrtMemInvalidate

```c
aclError aclrtMemInvalidate(void *devPtr, size_t size)
```

### 产品支持情况

<!-- npu="950" id2031 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2031 -->
<!-- npu="A3" id2032 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2032 -->
<!-- npu="910b" id2033 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2033 -->
<!-- npu="310b" id2034 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2034 -->
<!-- npu="310p" id2035 -->
- Atlas 推理系列产品：支持
<!-- end id2035 -->
<!-- npu="910" id2036 -->
- Atlas 训练系列产品：支持
<!-- end id2036 -->
<!-- npu="IPV350" id2037 -->
- IPV350：不支持
<!-- end id2037 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id17 -->

### 功能说明

将Cache中的数据设置成无效。

该版本不需要用户处理CPU与NPU之间的Cache一致性，无需调用该接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输入 | 需要将其中Cache数据置为无效的DDR内存起始地址指针。 |
| size | 输入 | DDR内存大小，单位Byte。<br>size不能为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMallocWithCfg"></a>

## aclrtMallocWithCfg

```c
aclError aclrtMallocWithCfg(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
```

### 产品支持情况

<!-- npu="950" id589 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id589 -->
<!-- npu="A3" id590 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id590 -->
<!-- npu="910b" id591 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id591 -->
<!-- npu="310b" id592 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id592 -->
<!-- npu="310p" id593 -->
- Atlas 推理系列产品：支持
<!-- end id593 -->
<!-- npu="910" id594 -->
- Atlas 训练系列产品：支持
<!-- end id594 -->
<!-- npu="IPV350" id595 -->
- IPV350：不支持
<!-- end id595 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id4 -->

### 功能说明

在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针，且内存首地址64字节对齐。

与aclrtMalloc接口相比，本接口在申请内存时，还可以指定内存相关的配置信息。

使用本接口申请的内存，需要通过[aclrtFree](#aclrtFree)接口或[aclrtFreeWithDevSync](#aclrtFreeWithDevSync)接口释放内存。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。类型定义请参见[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |
| cfg | 输入 | 内存配置信息。类型定义请参见[aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig)。<br>不指定配置时，此处可传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id19 -->

policy处支持配置单个枚举项，也支持配置多个枚举项位或。位或时，支持以下3组中枚举项组合，例如ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH | ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY | ACL\_MEM\_MALLOC\_HUGE\_FIRST：

- 用于区分高、低带宽：ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH、ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH
- 用于控制申请的内存在用户态为只读：ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY
- 剩下其他基础内存分配规则：例如ACL\_MEM\_MALLOC\_HUGE\_FIRST、ACL\_MEM\_MALLOC\_HUGE\_ONLY、ACL\_MEM\_MALLOC\_NORMAL\_ONLY等

<br>
<br>
<br>

<a id="aclrtMallocForTaskScheduler"></a>

## aclrtMallocForTaskScheduler

```c
aclError aclrtMallocForTaskScheduler(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
```

### 产品支持情况

<!-- npu="950" id2381 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2381 -->
<!-- npu="A3" id2382 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2382 -->
<!-- npu="910b" id2383 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2383 -->
<!-- npu="310b" id2384 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2384 -->
<!-- npu="310p" id2385 -->
- Atlas 推理系列产品：支持
<!-- end id2385 -->
<!-- npu="910" id2386 -->
- Atlas 训练系列产品：支持
<!-- end id2386 -->
<!-- npu="IPV350" id2387 -->
- IPV350：不支持
<!-- end id2387 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id5 -->

### 功能说明

申请AI处理器上Task调度器可使用的内存。

图模式下有部分算子需要使用该类型的内存。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。类型定义请参见[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](25-02_Enumerations.md#aclrtMemMallocPolicy)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |
| cfg | 输入 | 内存配置信息。类型定义请参见[aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig)。<br>不指定配置时，此处可传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtFree"></a>

## aclrtFree

```c
aclError aclrtFree(void *devPtr)
```

### 产品支持情况

<!-- npu="950" id323 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id323 -->
<!-- npu="A3" id324 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id324 -->
<!-- npu="910b" id325 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id325 -->
<!-- npu="310b" id326 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id326 -->
<!-- npu="310p" id327 -->
- Atlas 推理系列产品：支持
<!-- end id327 -->
<!-- npu="910" id328 -->
- Atlas 训练系列产品：支持
<!-- end id328 -->
<!-- npu="IPV350" id329 -->
- IPV350：支持
<!-- end id329 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id6 -->

### 功能说明

释放Device上的内存。

本接口会立刻释放传入的内存，接口内部不会进行隐式的Device同步或流同步、也不会等待使用该内存的任务完成。用户需确保在调用本接口后不再访问该内存指针。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输入 | 待释放内存的指针。<br>如果传入的devPtr为空指针，本接口会返回报错。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

[aclrtFree](#aclrtFree)接口只能释放通过[aclrtMalloc](#aclrtMalloc)接口或[aclrtMallocCached](#aclrtMallocCached)接口或[aclrtMallocAlign32](#aclrtMallocAlign32)接口申请的内存。

<br>
<br>
<br>

<a id="aclrtFreeWithDevSync"></a>

## aclrtFreeWithDevSync

```c
aclError aclrtFreeWithDevSync(void *devPtr)
```

### 产品支持情况

<!-- npu="950" id1100 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1100 -->
<!-- npu="A3" id1101 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1101 -->
<!-- npu="910b" id1102 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1102 -->
<!-- npu="310b" id1103 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1103 -->
<!-- npu="310p" id1104 -->
- Atlas 推理系列产品：支持
<!-- end id1104 -->
<!-- npu="910" id1105 -->
- Atlas 训练系列产品：支持
<!-- end id1105 -->
<!-- npu="IPV350" id1106 -->
- IPV350：不支持
<!-- end id1106 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id7 -->

### 功能说明

释放Device上的内存。

本接口内部会进行隐式的Device同步，并等待使用该内存的任务完成。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输入 | 待释放内存的指针。<br>如果传入的devPtr为空指针，本接口会返回报错。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetMemInfo"></a>

## aclrtGetMemInfo

```c
aclError aclrtGetMemInfo(aclrtMemAttr attr, size_t *free, size_t *total)
```

### 产品支持情况

<!-- npu="950" id463 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id463 -->
<!-- npu="A3" id464 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id464 -->
<!-- npu="910b" id465 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id465 -->
<!-- npu="310b" id466 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id466 -->
<!-- npu="310p" id467 -->
- Atlas 推理系列产品：支持
<!-- end id467 -->
<!-- npu="910" id468 -->
- Atlas 训练系列产品：支持
<!-- end id468 -->
<!-- npu="IPV350" id469 -->
- IPV350：支持
<!-- end id469 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id8 -->

### 功能说明

根据指定属性，获取Device上可用内存的空闲大小和总大小，不包括系统预留内存大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| attr | 输入 | 需要查询的内存的属性值。类型定义请参见[aclrtMemAttr](25-02_Enumerations.md#aclrtMemAttr)。 |
| free | 输出 | 对应属性内存空闲大小的指针，单位Byte。 |
| total | 输出 | 对应属性内存总大小的指针，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 调用本接口前必须先指定用于计算的Device（例如调用aclrtSetDevice接口指定用于计算的Device），因此本接口中不体现Device ID。
- 请根据实际硬件支持的情况选择相应的内存属性；否则，通过本接口获取的空闲大小和总大小都将为0。如果硬件不支持HBM内存，在查询HBM内存信息时，接口将自动转换为查询DDR内存信息，例如，查询ACL\_HBM\_MEM时，接口实际会查询ACL\_DDR\_MEM。

<br>
<br>
<br>

<a id="aclrtGetMemUsageInfo"></a>

## aclrtGetMemUsageInfo

```c
aclError aclrtGetMemUsageInfo(int32_t deviceId, aclrtMemUsageInfo *memUsageInfo, size_t inputNum, size_t *outputNum)
```

### 产品支持情况

<!-- npu="950" id85 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id85 -->
<!-- npu="A3" id86 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id86 -->
<!-- npu="910b" id87 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id87 -->
<!-- npu="310b" id88 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id88 -->
<!-- npu="310p" id89 -->
- Atlas 推理系列产品：支持
<!-- end id89 -->
<!-- npu="910" id90 -->
- Atlas 训练系列产品：支持
<!-- end id90 -->
<!-- npu="IPV350" id91 -->
- IPV350：不支持
<!-- end id91 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id9 -->

### 功能说明

查询组件的内存使用信息，包括组件名称、当前内存大小和峰值内存大小等信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| memUsageInfo | 输入&输出 | 内存使用信息数组。类型定义请参见[aclrtMemUsageInfo](25-04_Structs.md#aclrtMemUsageInfo)。<br>该参数作为输入时，由用户传入aclrtMemUsageInfo结构体指针，其内存大小需确保足以存放inputNum个组件的内存使用信息。<br>该参数作为输出时，可以获取组件名称、当前内存大小和峰值内存大小等信息。memUsageInfo数组中的元素按照当前内存占用量从大到小排序。 |
| inputNum | 输入 | 指定需查询的组件数量。<br>如果实际组件数量少于inputNum，则按实际组件数量查询。 |
| outputNum | 输出 | 实际查询到的组件数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCheckMemType"></a>

## aclrtCheckMemType

```c
aclError aclrtCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
```

### 产品支持情况

<!-- npu="950" id2668 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2668 -->
<!-- npu="A3" id2669 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2669 -->
<!-- npu="910b" id2670 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2670 -->
<!-- npu="310b" id2671 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2671 -->
<!-- npu="310p" id2672 -->
- Atlas 推理系列产品：支持
<!-- end id2672 -->
<!-- npu="910" id2673 -->
- Atlas 训练系列产品：支持
<!-- end id2673 -->
<!-- npu="IPV350" id2674 -->
- IPV350：不支持
<!-- end id2674 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id10 -->

### 功能说明

检查Device内存类型。

<!-- npu="950" id39 -->
Ascend 950PR/Ascend 950DT中不再有单独的DVPP Device内存类型（即ACL\_RT\_MEM\_TYPE\_DVPP），而是当做普通Device内存处理。
<!-- end id39 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-01_device_memory_malloc_and_free_res.md#id18 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| addrList | 输入 | Device内存地址数组。 |
| size | 输入 | addrList数组大小。 |
| memType | 输入 | Device内存类型。若addrList数组中有多种不同类型的内存地址，则memType处需配置为多种内存类型位或，例如配置为：RT_MEM_MASK_DEV_TYPE \| RT_MEM_MASK_DVPP_TYPE <br><br>当前支持设置为如下宏：<br>  - ACL_RT_MEM_TYPE_DEV：表示调用[aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc)、[aclrtMallocWithCfg](11-01_device_memory_malloc_and_free.md#aclrtMallocWithCfg)等接口申请的Device内存。<br>  - ACL_RT_MEM_TYPE_DVPP：表示DVPP专用的Device内存，可调用相关内存申请接口（例如hi_mpi_dvpp_malloc）申请该内存。Ascend 950PR/Ascend 950DT中不再有单独的DVPP Device内存类型，而是当做普通Device内存处理。<br>  - ACL_RT_MEM_TYPE_RSVD：表示调用[aclrtReserveMemAddress](11-04_virtual_memory_management.md#aclrtReserveMemAddress)接口预留的虚拟内存。<br><br><br>宏定义如下：<br>#define ACL_RT_MEM_TYPE_DEV  (0X2U)<br>#define ACL_RT_MEM_TYPE_DVPP  (0X8U)<br>#define ACL_RT_MEM_TYPE_RSVD  (0X10U) |
| checkResult | 输出 | 检查addrList数组中内存地址类型与memType处是否匹配，1表示匹配，0表示不匹配。 |
| reserve | 输入 | 预留参数，当前固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
