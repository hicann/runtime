# 11-04 虚拟内存管理

本章节描述虚拟内存管理接口，包括物理内存分配、虚拟地址预留、内存映射及跨进程共享。

- [`aclError aclrtMallocPhysical(aclrtDrvMemHandle *handle, size_t size, const aclrtPhysicalMemProp *prop, uint64_t flags)`](#aclrtMallocPhysical)：申请Host或Device物理内存，并返回一个物理内存handle。
- [`aclError aclrtFreePhysical(aclrtDrvMemHandle handle)`](#aclrtFreePhysical)：释放通过[aclrtMallocPhysical](#aclrtMallocPhysical)接口申请的物理内存。
- [`aclError aclrtReserveMemAddress(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)`](#aclrtReserveMemAddress)：预留虚拟内存。
- [`aclError aclrtReserveMemAddressNoUCMemory(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)`](#aclrtReserveMemAddressNoUCMemory)：预留虚拟内存。
- [`aclError aclrtReleaseMemAddress(void *virPtr)`](#aclrtReleaseMemAddress)：释放通过[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口申请的虚拟内存。
- [`aclError aclrtMapMem(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)`](#aclrtMapMem)：将虚拟内存映射到物理内存。
- [`aclError aclrtUnmapMem(void *virPtr)`](#aclrtUnmapMem)：取消虚拟内存与物理内存之间的映射关系。
- [`aclError aclrtMemExportToShareableHandle(aclrtDrvMemHandle handle, aclrtMemHandleType handleType, uint64_t flags, uint64_t *shareableHandle)`](#aclrtMemExportToShareableHandle)：将本进程通过[aclrtMallocPhysical](#aclrtMallocPhysical)接口获取到的Device物理内存handle导出，以便后续将Device物理内存共享给其它进程。
- [`aclError aclrtMemSetPidToShareableHandle(uint64_t shareableHandle, int32_t *pid, size_t pidNum)`](#aclrtMemSetPidToShareableHandle)：设置共享内存的进程白名单。
- [`aclError aclrtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId, aclrtDrvMemHandle *handle)`](#aclrtMemImportFromShareableHandle)：在本进程中获取shareableHandle里的信息，并返回本进程中的handle，用于在本进程中建立虚拟地址与物理地址之间的映射关系。
- [`aclError aclrtMemExportToShareableHandleV2(aclrtDrvMemHandle handle, uint64_t flags, aclrtMemSharedHandleType shareType, void *shareableHandle)`](#aclrtMemExportToShareableHandleV2)：将本进程通过[aclrtMallocPhysical](#aclrtMallocPhysical)接口获取到的Device物理内存handle导出，以便后续将Device物理内存共享给其它进程。
- [`aclError aclrtMemSetPidToShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, int32_t *pid, size_t pidNum)`](#aclrtMemSetPidToShareableHandleV2)：设置共享内存的进程白名单。
- [`aclError aclrtMemImportFromShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, uint64_t flags, aclrtDrvMemHandle *handle);`](#aclrtMemImportFromShareableHandleV2)：在本进程中获取shareableHandle里的信息，并返回本进程中的handle，用于在本进程中建立虚拟地址与物理地址之间的映射关系。
- [`aclError aclrtMemGetAllocationGranularity(aclrtPhysicalMemProp *prop, aclrtMemGranularityOptions option, size_t *granularity)`](#aclrtMemGetAllocationGranularity)：查询内存申请粒度。
- [`aclError aclrtMemSetAccess(void* virPtr, size_t size, aclrtMemAccessDesc* desc, size_t count)`](#aclrtMemSetAccess)：设置内存的访问权限。
- [`aclError aclrtMemGetAccess(void *virPtr, aclrtMemLocation *location, uint64_t *flag)`](#aclrtMemGetAccess)：获取内存的访问权限。
- [`aclError aclrtMemRetainAllocationHandle(void* virPtr, aclrtDrvMemHandle *handle)`](#aclrtMemRetainAllocationHandle)：根据虚拟内存地址获取物理内存信息的handle。
- [`aclError aclrtMemGetAllocationPropertiesFromHandle(aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop)`](#aclrtMemGetAllocationPropertiesFromHandle)：根据物理内存信息的handle查询其内存属性信息。
- [`aclError aclrtMemGetAddressRange(void *ptr, void **pbase, size_t *psize)`](#aclrtMemGetAddressRange)：获取待查询地址所属内存块的起始地址以及内存块大小。
- [`aclError aclrtMemMapSelectedLink(void *virPtrDst, size_t size, void *virPtrSrc, uint32_t linkIdx)`](#aclrtMemMapSelectedLink)：将虚拟地址 virPtrSrc 映射到虚拟地址 virPtrDst 对应的物理地址，可以通过 linkIdx 选择 HCCS 链路或者 SIO 链路。

<a id="aclrtMallocPhysical"></a>

## aclrtMallocPhysical

```c
aclError aclrtMallocPhysical(aclrtDrvMemHandle *handle, size_t size, const aclrtPhysicalMemProp *prop, uint64_t flags)
```

### 产品支持情况

<!-- npu="950" id1492 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1492 -->
<!-- npu="A3" id1493 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1493 -->
<!-- npu="910b" id1494 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1494 -->
<!-- npu="310b" id1495 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1495 -->
<!-- npu="310p" id1496 -->
- Atlas 推理系列产品：支持
<!-- end id1496 -->
<!-- npu="910" id1497 -->
- Atlas 训练系列产品：支持
<!-- end id1497 -->
<!-- npu="IPV350" id1498 -->
- IPV350：不支持
<!-- end id1498 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id1 -->

### 功能说明

申请Host或Device物理内存，并返回一个物理内存handle。

本接口可配合[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口（申请虚拟内存）、[aclrtMapMem](#aclrtMapMem)接口（建立虚拟内存与物理内存之间的映射）使用，以便申请地址连续的虚拟内存、最大化利用物理内存。

本接口可配合[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口（导出物理内存handle）、[aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle)（导入共享handle）使用，用于实现多进程之间的物理内存共享。同时，也支持在共享物理内存时，使用虚拟内存，请参见[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口处的说明。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输出 | 存放物理内存信息的handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。 |
| size | 输入 | 物理内存大小，单位Byte。<br>先调用[aclrtMemGetAllocationGranularity](#aclrtMemGetAllocationGranularity)接口获取内存申请粒度，然后再调用本接口申请物理内存时size按获取到的内存申请粒度对齐，以便节约内存。 |
| prop | 输入 | 物理内存属性信息。类型定义请参见[aclrtPhysicalMemProp](25-04_Structs.md#aclrtPhysicalMemProp)。 |
| flags | 输入 | 预留，当前只能设置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="310b" id1 -->
- 对于Atlas 200I/500 A2 推理产品，Ascend RC形态不支持调用本接口。
<!-- end id1 -->
<!-- npu="A3" id2 -->
- 针对Atlas A3 训练系列产品/Atlas A3 推理系列产品中的超节点产品，当内存所在位置aclrtPhysicalMemProp.location.type = ACL\_MEM\_LOCATION\_TYPE\_HOST\_NUMA，且内存属性类型aclrtPhysicalMemProp.aclrtMemAttr为P2P选项（例如ACL\_MEM\_P2P\_HUGE）时，可申请到的最大内存大小根据服务器型号、Bios版本会有所不同。建议通过aclrtMallocPhysical接口按内存规划尝试申请，以确认内存是否足够。
<!-- end id2 -->
- 内存属性类型aclrtPhysicalMemProp.aclrtMemAttr当前仅支持如下选项：
    - ACL\_MEM\_NORMAL：普通内存。
    - ACL\_MEM\_HUGE：2M粒度对齐的大页内存。
    - ACL\_MEM\_HUGE1G：1G粒度对齐的大页内存，仅支持Device。

        <!-- npu="A3,910b" id3 -->
        仅Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持该类型。
        <!-- end id3 -->

        <!-- npu="950" id4 -->
        Ascend 950PR/Ascend 950DT不支持该类型。
        <!-- end id4 -->

        <!-- npu="910,310p,310b" id5 -->
        Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品不支持该类型。
        <!-- end id5 -->

    - ACL\_MEM\_P2P\_NORMAL：用于Device间数据复制的普通内存。
    - ACL\_MEM\_P2P\_HUGE：用于Device间数据复制的大页内存，内存申请粒度为2M。
    - ACL\_MEM\_P2P\_HUGE1G：用于Device间数据复制的大页内存，内存申请粒度为1G，仅支持Device。

        <!-- npu="A3" id6 -->
        仅Atlas A3 训练系列产品/Atlas A3 推理系列产品中的部分互联形态支持该类型，以接口实际返回情况为准。
        <!-- end id6 -->

        <!-- npu="950,910b" id7 -->
        Ascend 950PR/Ascend 950DT、Atlas A2 训练系列产品/Atlas A2 推理系列产品不支持该类型。
        <!-- end id7 -->

        <!-- npu="910,310p,310b" id8 -->
        Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品不支持该类型。
        <!-- end id8 -->

    - ACL\_HBM\_MEM\_HUGE：2M粒度对齐的大页内存。
    - ACL\_HBM\_MEM\_HUGE1G：1G粒度对齐的大页内存，仅支持Device。

        <!-- npu="950,A3,910b" id9 -->
        Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持该类型。
        <!-- end id9 -->

        <!-- npu="910,310p,310b" id10 -->
        Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品不支持该类型。
        <!-- end id10 -->

    - ACL\_HBM\_MEM\_NORMAL：普通内存，接口内部会按照ACL\_HBM\_MEM\_HUGE类型申请大页内存。
    - ACL\_DDR\_MEM\_HUGE：大页内存，仅支持Host内存。
    - ACL\_DDR\_MEM\_NORMAL：普通内存，仅支持Host内存。
    - ACL\_DDR\_MEM\_P2P\_HUGE：用于Device间数据复制的大页内存，仅支持Host内存。
    - ACL\_DDR\_MEM\_P2P\_NORMAL：用于Device间数据复制的普通内存，仅支持Host内存。

<br>
<br>
<br>

<a id="aclrtFreePhysical"></a>

## aclrtFreePhysical

```c
aclError aclrtFreePhysical(aclrtDrvMemHandle handle)
```

### 产品支持情况

<!-- npu="950" id1947 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1947 -->
<!-- npu="A3" id1948 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1948 -->
<!-- npu="910b" id1949 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1949 -->
<!-- npu="310b" id1950 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1950 -->
<!-- npu="310p" id1951 -->
- Atlas 推理系列产品：支持
<!-- end id1951 -->
<!-- npu="910" id1952 -->
- Atlas 训练系列产品：支持
<!-- end id1952 -->
<!-- npu="IPV350" id1953 -->
- IPV350：不支持
<!-- end id1953 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id2 -->

### 功能说明

释放通过[aclrtMallocPhysical](#aclrtMallocPhysical)接口申请的物理内存。

如果物理内存与虚拟内存之间存在映射关系，则此处不会实际释放物理内存。只有在调用[aclrtUnmapMem](#aclrtUnmapMem)接口取消该物理内存与虚拟内存的映射之后，物理内存才会被真正释放。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 待释放的物理内存信息handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310b" id11 -->
### 约束说明

Atlas 200I/500 A2 推理产品上，Ascend RC形态不支持调用本接口。
<!-- end id11 -->

<br>
<br>
<br>

<a id="aclrtReserveMemAddress"></a>

## aclrtReserveMemAddress

```c
aclError aclrtReserveMemAddress(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
```

### 产品支持情况

<!-- npu="950" id1142 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1142 -->
<!-- npu="A3" id1143 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1143 -->
<!-- npu="910b" id1144 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1144 -->
<!-- npu="310b" id1145 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1145 -->
<!-- npu="310p" id1146 -->
- Atlas 推理系列产品：支持
<!-- end id1146 -->
<!-- npu="910" id1147 -->
- Atlas 训练系列产品：支持
<!-- end id1147 -->
<!-- npu="IPV350" id1148 -->
- IPV350：不支持
<!-- end id1148 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id3 -->

### 功能说明

预留虚拟内存。

**本接口需与以下其它接口配合使用**，以便申请地址连续的虚拟内存、最大化利用物理内存：

1. 申请虚拟内存（[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口）；
2. 申请物理内存（[aclrtMallocPhysical](#aclrtMallocPhysical)接口）；
3. 将虚拟内存映射到物理内存（[aclrtMapMem](#aclrtMapMem)接口）；
4. 执行任务（调用具体的任务接口）；
5. 取消虚拟内存与物理内存的映射（[aclrtUnmapMem](#aclrtUnmapMem)接口）；
6. 释放物理内存（[aclrtFreePhysical](#aclrtFreePhysical)接口）；
7. 释放虚拟内存（[aclrtReleaseMemAddress](#aclrtReleaseMemAddress)接口）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtr | 输出 | “已分配的虚拟内存地址的指针”的指针。 |
| size | 输入 | 虚拟内存大小，单位Byte。<br>size不能为0。 |
| alignment | 输入 | 虚拟地址对齐值，预留，当前只能设置为0。 |
| expectPtr | 输入 | 指定期望返回的虚拟内存起始地址。<br>取值说明如下：<br>  - nullptr：系统自动分配符合对齐规则的虚拟地址。<br>  - 非nullptr：由用户指定起始地址，地址必须在8T范围内（16T-24T）。用户需确保指定的地址未被占用，且符合对齐规则，否则预留虚拟内存失败，接口返回错误。对齐规则为：若size小于1G，expectPtr需按2的n次方对齐；如果size大于1G，expectPtr需按1G对齐。须知：由用户指定起始地址是试验特性，后续版本可能存在变更，不支持应用于生产环境中。 |
| flags | 输入 | 预留参数，建议固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="950" id13 -->
- 对于Ascend 950PR/Ascend 950DT，expectPtr参数处仅支持配置为nullptr。
<!-- end id13 -->

<!-- npu="310b" id12 -->
- Atlas 200I/500 A2 推理产品上，Ascend RC形态下，不支持调用本接口。
<!-- end id12 -->

- 使用本接口预留的虚拟内存，单进程场景下只支持调用[aclrtMemcpyAsync](11-03_memory_copy_and_set.md#aclrtMemcpyAsync)接口实现两个Device之间的数据拷贝。

<br>
<br>
<br>

<a id="aclrtReserveMemAddressNoUCMemory"></a>

## aclrtReserveMemAddressNoUCMemory

```c
aclError aclrtReserveMemAddressNoUCMemory(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
```

**须知：由用户指定起始地址是试验特性，后续版本可能存在变更，不支持应用于生产环境中**

### 产品支持情况

<!-- npu="950" id2192 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2192 -->
<!-- npu="A3" id2193 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2193 -->
<!-- npu="910b" id2194 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2194 -->
<!-- npu="310b" id2195 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2195 -->
<!-- npu="310p" id2196 -->
- Atlas 推理系列产品：不支持
<!-- end id2196 -->
<!-- npu="910" id2197 -->
- Atlas 训练系列产品：不支持
<!-- end id2197 -->
<!-- npu="IPV350" id2198 -->
- IPV350：不支持
<!-- end id2198 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id4 -->

### 功能说明

预留虚拟内存。

本接口与aclrtReserveMemAddress接口的使用方法相同，区别在于：根据环境变量AUTO\_USE\_UC\_MEMORY决定是否允许数据搬移不经过L2 Cache的算子，本接口预留的虚拟内存不能用作此类算子的输入或输出内存，否则可能会导致算子精度问题或异常。AUTO\_USE\_UC\_MEMORY环境变量的详细说明请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

另外，本接口中的虚拟内存起始地址不支持由系统自动分配，只能由用户指定，且地址建议在40T-224T范围内。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtr | 输出 | “已分配的虚拟内存地址的指针”的指针。 |
| size | 输入 | 虚拟内存大小，单位Byte。<br>size不能为0，只能为1G的整数倍，最小为1G。 |
| alignment | 输入 | 虚拟地址对齐值，预留，当前只能设置为0。 |
| expectPtr | 输入 | 指定期望返回的虚拟内存起始地址。<br>由用户指定起始地址，地址建议在40T-224T范围内。用户需确保指定的地址未被占用，否则预留虚拟内存失败，接口返回错误。 |
| flags | 输入 | 预留参数，建议固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtReleaseMemAddress"></a>

## aclrtReleaseMemAddress

```c
aclError aclrtReleaseMemAddress(void *virPtr)
```

### 产品支持情况

<!-- npu="950" id862 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id862 -->
<!-- npu="A3" id863 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id863 -->
<!-- npu="910b" id864 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id864 -->
<!-- npu="310b" id865 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id865 -->
<!-- npu="310p" id866 -->
- Atlas 推理系列产品：支持
<!-- end id866 -->
<!-- npu="910" id867 -->
- Atlas 训练系列产品：支持
<!-- end id867 -->
<!-- npu="IPV350" id868 -->
- IPV350：不支持
<!-- end id868 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id5 -->

### 功能说明

释放通过[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口申请的虚拟内存。

**本接口需与以下其它接口配合使用**，以便申请地址连续的虚拟内存、最大化利用物理内存：

1. 申请虚拟内存（[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口）；
2. 申请物理内存（[aclrtMallocPhysical](#aclrtMallocPhysical)接口）；
3. 将虚拟内存映射到物理内存（[aclrtMapMem](#aclrtMapMem)接口）；
4. 执行任务（调用具体的任务接口）；
5. 取消虚拟内存与物理内存的映射（[aclrtUnmapMem](#aclrtUnmapMem)接口）；
6. 释放物理内存（[aclrtFreePhysical](#aclrtFreePhysical)接口）；
7. 释放虚拟内存（[aclrtReleaseMemAddress](#aclrtReleaseMemAddress)接口）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtr | 输入 | 待释放的虚拟内存地址指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="310b" id14 -->
- 对于Atlas 200I/500 A2 推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id14 -->

- 若该虚拟内存与物理内存存在映射关系，则释放虚拟内存前，需调用[aclrtUnmapMem](#aclrtUnmapMem)接口取消该虚拟内存与物理内存的映射。

<br>
<br>
<br>

<a id="aclrtMapMem"></a>

## aclrtMapMem

```c
aclError aclrtMapMem(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)
```

### 产品支持情况

<!-- npu="950" id498 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id498 -->
<!-- npu="A3" id499 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id499 -->
<!-- npu="910b" id500 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id500 -->
<!-- npu="310b" id501 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id501 -->
<!-- npu="310p" id502 -->
- Atlas 推理系列产品：支持
<!-- end id502 -->
<!-- npu="910" id503 -->
- Atlas 训练系列产品：支持
<!-- end id503 -->
<!-- npu="IPV350" id504 -->
- IPV350：不支持
<!-- end id504 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id6 -->

### 功能说明

将虚拟内存映射到物理内存。

**本接口需与以下其它接口配合使用**，以便申请地址连续的虚拟内存、最大化利用物理内存：

1. 申请虚拟内存（[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口）；
2. 申请物理内存（[aclrtMallocPhysical](#aclrtMallocPhysical)接口）；
3. 将虚拟内存映射到物理内存（[aclrtMapMem](#aclrtMapMem)接口）；
4. 执行任务（调用具体的任务接口）；
5. 取消虚拟内存与物理内存的映射（[aclrtUnmapMem](#aclrtUnmapMem)接口）；
6. 释放物理内存（[aclrtFreePhysical](#aclrtFreePhysical)接口）；
7. 释放虚拟内存（[aclrtReleaseMemAddress](#aclrtReleaseMemAddress)接口）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtr | 输入 | 待映射的虚拟内存地址指针。<br>这个地址不一定是起始地址，用户也可以根据起始地址自行偏移后，再映射。 |
| size | 输入 | 待映射的内存大小，单位Byte。<br>此处的size必须与[aclrtMallocPhysical](#aclrtMallocPhysical)接口的size参数值相同，size必须与[aclrtMemGetAllocationGranularity](#aclrtMemGetAllocationGranularity)接口获取的ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM对齐。 |
| offset | 输入 | 物理内存偏移值，当前只能设置为0。 |
| handle | 输入 | 物理内存信息handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。<br>通过[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口预留出来的一整段虚拟地址，由用户自行管理、划分时，不能同时与两个Device上申请的物理地址绑定。<br>通过[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口预留出来的一整段虚拟地址，由用户自行管理、划分时，不能同时与[aclrtMallocPhysical](#aclrtMallocPhysical)、[aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle)接口输出的handle绑定。 |
| flags | 输入 | 预留，当前只能设置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310b" id15 -->
### 约束说明

对于Atlas 200I/500 A2 推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id15 -->

<br>
<br>
<br>

<a id="aclrtUnmapMem"></a>

## aclrtUnmapMem

```c
aclError aclrtUnmapMem(void *virPtr)
```

### 产品支持情况

<!-- npu="950" id3354 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3354 -->
<!-- npu="A3" id3355 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3355 -->
<!-- npu="910b" id3356 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3356 -->
<!-- npu="310b" id3357 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3357 -->
<!-- npu="310p" id3358 -->
- Atlas 推理系列产品：支持
<!-- end id3358 -->
<!-- npu="910" id3359 -->
- Atlas 训练系列产品：支持
<!-- end id3359 -->
<!-- npu="IPV350" id3360 -->
- IPV350：不支持
<!-- end id3360 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id7 -->

### 功能说明

取消虚拟内存与物理内存之间的映射关系。

**本接口需与以下其它接口配合使用**，以便申请地址连续的虚拟内存、最大化利用物理内存：

1. 申请虚拟内存（[aclrtReserveMemAddress](#aclrtReserveMemAddress)接口）；
2. 申请物理内存（[aclrtMallocPhysical](#aclrtMallocPhysical)接口）；
3. 将虚拟内存映射到物理内存（[aclrtMapMem](#aclrtMapMem)接口）；
4. 执行任务（调用具体的任务接口）；
5. 取消虚拟内存与物理内存的映射（[aclrtUnmapMem](#aclrtUnmapMem)接口）；
6. 释放物理内存（[aclrtFreePhysical](#aclrtFreePhysical)接口）；
7. 释放虚拟内存（[aclrtReleaseMemAddress](#aclrtReleaseMemAddress)接口）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtr | 输入 | 待取消映射的虚拟内存地址指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310b" id16 -->
### 约束说明

对于Atlas 200I/500 A2 推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id16 -->

<br>
<br>
<br>

<a id="aclrtMemExportToShareableHandle"></a>

## aclrtMemExportToShareableHandle

```c
aclError aclrtMemExportToShareableHandle(aclrtDrvMemHandle handle, aclrtMemHandleType handleType, uint64_t flags, uint64_t *shareableHandle)
```

### 产品支持情况

<!-- npu="950" id1940 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1940 -->
<!-- npu="A3" id1941 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1941 -->
<!-- npu="910b" id1942 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1942 -->
<!-- npu="310b" id1943 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1943 -->
<!-- npu="310p" id1944 -->
- Atlas 推理系列产品：支持
<!-- end id1944 -->
<!-- npu="910" id1945 -->
- Atlas 训练系列产品：支持
<!-- end id1945 -->
<!-- npu="IPV350" id1946 -->
- IPV350：不支持
<!-- end id1946 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id8 -->

### 功能说明

将本进程通过[aclrtMallocPhysical](#aclrtMallocPhysical)接口获取到的Device物理内存handle导出，以便后续将Device物理内存共享给其它进程。

**本接口需与以下其它关键接口配合使用**，以便实现内存共享，此处以A、B进程为例，说明两个进程间的物理内存共享接口调用流程：

1. 在A进程中：
    1. 调用[aclrtMallocPhysical](#aclrtMallocPhysical)接口，申请物理内存。

        先调用[aclrtMemGetAllocationGranularity](#aclrtMemGetAllocationGranularity)接口获取内存申请粒度，然后再调用[aclrtMallocPhysical](#aclrtMallocPhysical)接口申请物理内存时size按获取到的内存申请粒度对齐，以便节约内存。

        若需申请地址连续的虚拟内存、最大化利用物理内存，此处可配合[aclrtReserveMemAddress](#aclrtReserveMemAddress)、[aclrtMapMem](#aclrtMapMem)、[aclrtMemSetAccess](#aclrtMemSetAccess)等接口申请虚拟内存、建立虚拟内存与物理内存之间的映射、设置虚拟内存的访问权限。

    2. 调用[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口，导出物理内存handle，输出shareableHandle。

        调用[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口时，可指定是否启用进程白名单校验，若启用，则需单独调用[aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle)接口将B进程的进程ID设置为白名单；反之，则无需调用[aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle)接口。

    3. 调用[aclrtFreePhysical](#aclrtFreePhysical)接口，释放物理内存。

        内存使用完成后，要及时调用[aclrtFreePhysical](#aclrtFreePhysical)接口释放物理内存，实现销毁shareableHandle。若有进程还在使用shareableHandle，则等待shareableHandle使用完成后再执行销毁任务。

        所有涉及共享内存的进程都必须释放其物理内存，只有当所有相关进程都完成释放操作后，物理内存才能真正被释放。释放物理内存后，原先分配的内存将被归还给操作系统，此后使用该handle将导致未定义的行为。

2. 在B进程中：
    1. 调用[aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid)接口，获取B进程的进程ID。

        本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配合其它接口使用，达到物理内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

    2. 调用[aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle)，获取shareableHandle里的信息，并返回本进程中的handle。

        在调用[aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle)接口前，需确保待共享的物理内存存在，不能提前释放。

        若需申请地址连续的虚拟内存、最大化利用物理内存地址，此处可配合[aclrtReserveMemAddress](#aclrtReserveMemAddress)、[aclrtMapMem](#aclrtMapMem)、[aclrtMemSetAccess](#aclrtMemSetAccess)等接口申请虚拟内存、建立虚拟内存与物理内存之间的映射、设置虚拟内存的访问权限，请参见对应接口的说明。

    3. 调用[aclrtFreePhysical](#aclrtFreePhysical)接口，释放物理内存。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 存放物理内存信息的handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。<br>需先在本进程调用aclrtMallocPhysical接口申请物理内存，该接口调用成功，会返回一个handle。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一，否则报错，例如重复调用本接口导出时则会返回报错。 |
| handleType | 输入 | 预留参数，当前固定填ACL_MEM_HANDLE_TYPE_NONE。<br>类型定义请参见[aclrtMemHandleType](25-02_Enumerations.md#aclrtMemHandleType)。 |
| flags | 输入 | 是否启用进程白名单校验。<br>取值为如下宏：<br><br>  - ACL_RT_VMM_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。配置为该值时，需单独调用[aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle)接口将使用shareableHandle的进程ID设置为白名单。<br>  - ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。配置为该值时，则无需调用[aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle)接口。<br><br><br>宏的定义如下：<br>#define ACL_RT_VMM_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL |
| shareableHandle | 输出 | 标识共享给其它进程的shareableHandle。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="310b" id17 -->
- 对于Atlas 200I/500 A2 推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id17 -->
<!-- npu="950,A3,910b,910,310p" id18 -->
- 支持AI Server内跨进程共享物理内存。若跨Device，则还需配合[aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess)接口使用。AI Server通常是多个Device组成的服务器形态的统称。
<!-- end id18 -->
<!-- npu="910b,910,310p" id19 -->
- 不支持昇腾虚拟化实例场景。
<!-- end id19 -->
- 不支持算力分组场景。

<br>
<br>
<br>

<a id="aclrtMemSetPidToShareableHandle"></a>

## aclrtMemSetPidToShareableHandle

```c
aclError aclrtMemSetPidToShareableHandle(uint64_t shareableHandle, int32_t *pid, size_t pidNum)
```

### 产品支持情况

<!-- npu="950" id1345 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1345 -->
<!-- npu="A3" id1346 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1346 -->
<!-- npu="910b" id1347 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1347 -->
<!-- npu="310b" id1348 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1348 -->
<!-- npu="310p" id1349 -->
- Atlas 推理系列产品：支持
<!-- end id1349 -->
<!-- npu="910" id1350 -->
- Atlas 训练系列产品：支持
<!-- end id1350 -->
<!-- npu="IPV350" id1351 -->
- IPV350：不支持
<!-- end id1351 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id9 -->

### 功能说明

设置共享内存的进程白名单**。**

在调用aclrtMemExportToShareableHandle接口的进程中，调用本接口设置进程白名单。本接口需与其它接口配合使用，以便实现内存共享的目的，请参见[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口处的说明。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| shareableHandle | 输入 | 通过[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口导出的shareableHandle。 |
| pid | 输入 | 用于存放白名单进程ID的数组。<br>进程ID可调用[aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid)接口获取，Docker场景下获取到的是物理机上的进程ID，非Docker场景下获取到的是进程ID。 |
| pidNum | 输入 | 白名单进程数量，与pid参数数组的大小保持一致。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemImportFromShareableHandle"></a>

## aclrtMemImportFromShareableHandle

```c
aclError aclrtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId, aclrtDrvMemHandle *handle)
```

### 产品支持情况

<!-- npu="950" id1478 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1478 -->
<!-- npu="A3" id1479 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1479 -->
<!-- npu="910b" id1480 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1480 -->
<!-- npu="310b" id1481 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1481 -->
<!-- npu="310p" id1482 -->
- Atlas 推理系列产品：支持
<!-- end id1482 -->
<!-- npu="910" id1483 -->
- Atlas 训练系列产品：支持
<!-- end id1483 -->
<!-- npu="IPV350" id1484 -->
- IPV350：不支持
<!-- end id1484 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id10 -->

### 功能说明

在本进程中获取shareableHandle里的信息，并返回本进程中的handle，用于在本进程中建立虚拟地址与物理地址之间的映射关系。本接口还支持生成指定Device上的handle。

本接口需与其它接口配合使用，以便实现内存共享的目的，配合使用流程请参见[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口处的说明。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| shareableHandle | 输入 | 待共享的shareableHandle，与[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口中导出的shareableHandle保持一致。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一。 |
| deviceId | 输入 | 用于生成指定Device ID上的handle。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| handle | 输出 | 本进程的物理内存handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 在调用本接口前，需确保待共享的物理内存存在，不能提前释放。
- 不支持同一个进程中调用aclrtMemImportFromShareableHandle、[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)这两个接口，只支持跨进程调用。
- 支持在一个Device上调用[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)接口导出handle，然后调用本接口生成另一个Device上的handle。
- 内存使用完成后，要及时调用[aclrtFreePhysical](#aclrtFreePhysical)销毁handle，并且需所有调用本接口的进程都销毁shareableHandle的情况下，handle才会真正销毁。

<br>
<br>
<br>

<a id="aclrtMemExportToShareableHandleV2"></a>

## aclrtMemExportToShareableHandleV2

```c
aclError aclrtMemExportToShareableHandleV2(aclrtDrvMemHandle handle, uint64_t flags, aclrtMemSharedHandleType shareType, void *shareableHandle)
```

### 产品支持情况

<!-- npu="950" id1646 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1646 -->
<!-- npu="A3" id1647 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1647 -->
<!-- npu="910b" id1648 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1648 -->
<!-- npu="310b" id1649 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1649 -->
<!-- npu="310p" id1650 -->
- Atlas 推理系列产品：支持
<!-- end id1650 -->
<!-- npu="910" id1651 -->
- Atlas 训练系列产品：支持
<!-- end id1651 -->
<!-- npu="IPV350" id1652 -->
- IPV350：不支持
<!-- end id1652 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id11 -->

### 功能说明

将本进程通过[aclrtMallocPhysical](#aclrtMallocPhysical)接口获取到的Device物理内存handle导出，以便后续将Device物理内存共享给其它进程。

本接口是在接口[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)基础上进行了增强，用户可通过shareType参数指定导出AI Server内的共享句柄，或导出跨AI Server的共享句柄。AI Server通常是多个Device组成的服务器形态的统称。

本接口的使用流程可参见[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)，但本接口需配合调用[aclrtMemSetPidToShareableHandleV2](#aclrtMemSetPidToShareableHandleV2)接口设置进程白名单、调用[aclrtMemImportFromShareableHandleV2](#aclrtMemImportFromShareableHandleV2)接口导入共享句柄。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 存放物理内存信息的handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。<br>需先在本进程调用aclrtMallocPhysical接口申请物理内存，该接口调用成功，会返回一个handle。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一，否则报错，例如重复调用本接口导出时则会返回报错。 |
| flags | 输入 | 是否启用进程白名单校验。<br>取值为如下宏：<br><br>  - ACL_RT_VMM_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。配置为该值时，需单独调用[aclrtMemSetPidToShareableHandleV2](#aclrtMemSetPidToShareableHandleV2)接口将使用shareableHandle的进程ID设置为白名单。<br>  - ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。配置为该值时，则无需调用[aclrtMemSetPidToShareableHandleV2](#aclrtMemSetPidToShareableHandleV2)接口。<br><br><br>宏的定义如下：<br>#define ACL_RT_VMM_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL |
| shareType | 输入 | 导出的共享句柄类型。类型定义请参见[aclrtMemSharedHandleType](25-02_Enumerations.md#aclrtMemSharedHandleType)。 |
| shareableHandle | 输出 | 指向共享句柄的指针。其指向的内存由调用者提供，大小根据shareType决定：<br>若shareType为ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT，则指向一个uint64_t变量。<br>若shareType为ACL_MEM_SHARE_HANDLE_TYPE_FABRIC，则指向一个aclrtMemFabricHandle结构体。<br>typedef struct aclrtMemFabricHandle { <br>   uint8_t data[128];<br>} aclrtMemFabricHandle; |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="310b" id20 -->
- 对于Atlas 200I/500 A2 推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id20 -->
<!-- npu="950,A3,910b,910,310p" id21 -->
- 支持AI Server内跨进程共享物理内存，若跨Device，则还需配合[aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess)接口使用。
<!-- end id21 -->
<!-- npu="A3" id22 -->
- 仅Atlas A3 训练系列产品/Atlas A3 推理系列产品支持跨AI Server的跨进程共享物理内存。
<!-- end id22 -->
<!-- npu="910b,910,310p" id23 -->
- 不支持昇腾虚拟化实例场景。
<!-- end id23 -->
- 不支持算力分组场景。

<br>
<br>
<br>

<a id="aclrtMemSetPidToShareableHandleV2"></a>

## aclrtMemSetPidToShareableHandleV2

```c
aclError aclrtMemSetPidToShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, int32_t *pid, size_t pidNum)
```

### 产品支持情况

<!-- npu="950" id1366 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1366 -->
<!-- npu="A3" id1367 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1367 -->
<!-- npu="910b" id1368 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1368 -->
<!-- npu="310b" id1369 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1369 -->
<!-- npu="310p" id1370 -->
- Atlas 推理系列产品：支持
<!-- end id1370 -->
<!-- npu="910" id1371 -->
- Atlas 训练系列产品：支持
<!-- end id1371 -->
<!-- npu="IPV350" id1372 -->
- IPV350：不支持
<!-- end id1372 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id12 -->

### 功能说明

设置共享内存的进程白名单**。**

本接口是在接口[aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle)基础上进行了增强，用户可通过shareType参数指定导出AI Server内的共享句柄，或导出跨AI Server的共享句柄。

本接口的使用流程可参见[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)，但本接口需配合调用[aclrtMemExportToShareableHandleV2](#aclrtMemExportToShareableHandleV2)接口导出共享句柄、调用[aclrtMemImportFromShareableHandleV2](#aclrtMemImportFromShareableHandleV2)接口导入共享句柄。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| shareableHandle | 输入 | 通过aclrtMemExportToShareableHandleV2接口导出的shareableHandle，表示指向共享句柄的指针。 |
| shareType | 输入 | 导出的共享句柄类型。类型定义请参见[aclrtMemSharedHandleType](25-02_Enumerations.md#aclrtMemSharedHandleType)。 |
| pid | 输入 | 用于存放白名单进程ID的数组。<br>进程ID可调用[aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid)接口获取，Docker场景下获取到的是物理机上的进程ID，非Docker场景下获取到的是进程ID。 |
| pidNum | 输入 | 白名单进程数量，与pid参数数组的大小保持一致。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemImportFromShareableHandleV2"></a>

## aclrtMemImportFromShareableHandleV2

```c
aclError aclrtMemImportFromShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, uint64_t flags, aclrtDrvMemHandle *handle);
```

### 产品支持情况

<!-- npu="950" id827 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id827 -->
<!-- npu="A3" id828 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id828 -->
<!-- npu="910b" id829 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id829 -->
<!-- npu="310b" id830 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id830 -->
<!-- npu="310p" id831 -->
- Atlas 推理系列产品：支持
<!-- end id831 -->
<!-- npu="910" id832 -->
- Atlas 训练系列产品：支持
<!-- end id832 -->
<!-- npu="IPV350" id833 -->
- IPV350：不支持
<!-- end id833 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id13 -->

### 功能说明

在本进程中获取shareableHandle里的信息，并返回本进程中的handle，用于在本进程中建立虚拟地址与物理地址之间的映射关系。

本接口是在接口[aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle)基础上进行了增强，用户可通过shareType参数指定导出AI Server内的共享句柄，或导出跨AI Server的共享句柄。

本接口的使用流程可参见[aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle)，但本接口需配合调用[aclrtMemExportToShareableHandleV2](#aclrtMemExportToShareableHandleV2)接口导出共享句柄、调用[aclrtMemSetPidToShareableHandleV2](#aclrtMemSetPidToShareableHandleV2)接口设置进程白名单。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| shareableHandle | 输入 | 待共享的shareableHandle，与[aclrtMemExportToShareableHandleV2](#aclrtMemExportToShareableHandleV2)接口中导出的shareableHandle保持一致。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一。 |
| shareType | 输入 | 导出的共享句柄类型。类型定义请参见[aclrtMemSharedHandleType](25-02_Enumerations.md#aclrtMemSharedHandleType)。 |
| flags | 输入 | 预留参数，当前固定设置为0。 |
| handle | 输出 | 本进程的物理内存handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 在调用本接口前，需确保待共享的物理内存存在，不能提前释放。
- 不支持同一个进程中调用[aclrtMemImportFromShareableHandleV2](#aclrtMemImportFromShareableHandleV2)、[aclrtMemExportToShareableHandleV2](#aclrtMemExportToShareableHandleV2)这两个接口，只支持跨进程调用。
- 内存使用完成后，要及时调用[aclrtFreePhysical](#aclrtFreePhysical)销毁handle，并且需所有调用本接口的进程都销毁shareableHandle的情况下，handle才会真正销毁。

<br>
<br>
<br>

<a id="aclrtMemGetAllocationGranularity"></a>

## aclrtMemGetAllocationGranularity

```c
aclError aclrtMemGetAllocationGranularity(aclrtPhysicalMemProp *prop, aclrtMemGranularityOptions option, size_t *granularity)
```

### 产品支持情况

<!-- npu="950" id995 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id995 -->
<!-- npu="A3" id996 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id996 -->
<!-- npu="910b" id997 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id997 -->
<!-- npu="310b" id998 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id998 -->
<!-- npu="310p" id999 -->
- Atlas 推理系列产品：支持
<!-- end id999 -->
<!-- npu="910" id1000 -->
- Atlas 训练系列产品：支持
<!-- end id1000 -->
<!-- npu="IPV350" id1001 -->
- IPV350：不支持
<!-- end id1001 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id14 -->

### 功能说明

查询内存申请粒度。

系统内部会根据用户指定的内存属性信息计算最小粒度或建议粒度，并以granularity参数返回粒度。此粒度可用作对齐、地址大小或地址映射的倍数。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| prop | 输入 | 物理内存属性信息。类型定义请参见[aclrtPhysicalMemProp](25-04_Structs.md#aclrtPhysicalMemProp)。 |
| option | 输入 | 最小粒度或推荐粒度。类型定义请参见[aclrtMemGranularityOptions](25-02_Enumerations.md#aclrtMemGranularityOptions)。 |
| granularity | 输出 | 内存申请粒度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310b" id24 -->
### 约束说明

Atlas 200I/500 A2 推理产品上，Ascend RC形态不支持调用本接口。
<!-- end id24 -->

<br>
<br>
<br>

<a id="aclrtMemSetAccess"></a>

## aclrtMemSetAccess

```c
aclError aclrtMemSetAccess(void* virPtr, size_t size, aclrtMemAccessDesc* desc, size_t count)
```

### 产品支持情况

<!-- npu="950" id2703 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2703 -->
<!-- npu="A3" id2704 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2704 -->
<!-- npu="910b" id2705 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2705 -->
<!-- npu="310b" id2706 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2706 -->
<!-- npu="310p" id2707 -->
- Atlas 推理系列产品：支持
<!-- end id2707 -->
<!-- npu="910" id2708 -->
- Atlas 训练系列产品：支持
<!-- end id2708 -->
<!-- npu="IPV350" id2709 -->
- IPV350：不支持
<!-- end id2709 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id15 -->

### 功能说明

设置内存的访问权限。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtr | 输入 | 虚拟内存的起始地址。<br>必须与[aclrtMapMem](#aclrtMapMem)接口的virPtr地址相同。 |
| size | 输入 | 虚拟内存的长度。<br>必须与[aclrtMapMem](#aclrtMapMem)接口的size相同。 |
| desc | 输入 | 内存访问的配置信息，包含内存访问保护标志、内存所在位置等。类型定义请参见[aclrtMemAccessDesc](25-04_Structs.md#aclrtMemAccessDesc)。 |
| count | 输入 | desc数组长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemGetAccess"></a>

## aclrtMemGetAccess

```c
aclError aclrtMemGetAccess(void *virPtr, aclrtMemLocation *location, uint64_t *flag)
```

### 产品支持情况

<!-- npu="950" id2675 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2675 -->
<!-- npu="A3" id2676 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2676 -->
<!-- npu="910b" id2677 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2677 -->
<!-- npu="310b" id2678 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2678 -->
<!-- npu="310p" id2679 -->
- Atlas 推理系列产品：支持
<!-- end id2679 -->
<!-- npu="910" id2680 -->
- Atlas 训练系列产品：支持
<!-- end id2680 -->
<!-- npu="IPV350" id2681 -->
- IPV350：不支持
<!-- end id2681 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id16 -->

### 功能说明

获取内存的访问权限。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtr | 输入 | 虚拟内存的起始地址。<br>必须与[aclrtMapMem](#aclrtMapMem)接口的virPtr地址相同。 |
| location | 输入 | 内存所在位置。类型定义请参见[aclrtMemLocation](25-04_Structs.md#aclrtMemLocation)。<br>当前仅支持将aclrtMemLocation.type设置为ACL_MEM_LOCATION_TYPE_HOST或ACL_MEM_LOCATION_TYPE_DEVICE。当aclrtMemLocation.type为ACL_MEM_LOCATION_TYPE_HOST时，[aclrtMemLocation](25-04_Structs.md#aclrtMemLocation).id无效，固定设置为0即可。 |
| flag | 输出 | 内存访问保护标志。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemRetainAllocationHandle"></a>

## aclrtMemRetainAllocationHandle

```c
aclError aclrtMemRetainAllocationHandle(void* virPtr, aclrtDrvMemHandle *handle)
```

### 产品支持情况

<!-- npu="950" id2626 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2626 -->
<!-- npu="A3" id2627 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2627 -->
<!-- npu="910b" id2628 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2628 -->
<!-- npu="310b" id2629 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2629 -->
<!-- npu="310p" id2630 -->
- Atlas 推理系列产品：支持
<!-- end id2630 -->
<!-- npu="910" id2631 -->
- Atlas 训练系列产品：支持
<!-- end id2631 -->
<!-- npu="IPV350" id2632 -->
- IPV350：不支持
<!-- end id2632 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id17 -->

### 功能说明

根据虚拟内存地址获取物理内存信息的handle。

若多次调用本接口，则需相应地调用相同次数的aclrtFreePhysical来释放物理内存handle。

若调用接口时返回ACL_ERROR_RT_FEATURE_NOT_SUPPORT，这表示底层驱动不支持该特性，需将驱动包升级到26.0.RC1或更高版本。您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers/commercial)，在“固件与驱动”页面下载对应版本的驱动安装包，并参照其文档进行安装和升级。
 
### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtr | 输入 | “已分配的虚拟内存地址的指针”的指针。<br>必须与[aclrtMapMem](#aclrtMapMem)接口的virPtr地址相同。 |
| handle | 输出 | 存放物理内存信息的handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310b" id25 -->
### 约束说明

Atlas 200I/500 A2 推理产品上，Ascend RC形态不支持调用本接口。
<!-- end id25 -->

<br>
<br>
<br>

<a id="aclrtMemGetAllocationPropertiesFromHandle"></a>

## aclrtMemGetAllocationPropertiesFromHandle

```c
aclError aclrtMemGetAllocationPropertiesFromHandle(aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop)
```

### 产品支持情况

<!-- npu="950" id2437 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2437 -->
<!-- npu="A3" id2438 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2438 -->
<!-- npu="910b" id2439 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2439 -->
<!-- npu="310b" id2440 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2440 -->
<!-- npu="310p" id2441 -->
- Atlas 推理系列产品：支持
<!-- end id2441 -->
<!-- npu="910" id2442 -->
- Atlas 训练系列产品：支持
<!-- end id2442 -->
<!-- npu="IPV350" id2443 -->
- IPV350：不支持
<!-- end id2443 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id18 -->

### 功能说明

根据物理内存信息的handle查询其内存属性信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 存放物理内存信息的handle。类型定义请参见[aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle)。<br>查询通过aclrtMallocPhysical接口申请的物理内存属性信息。 |
| prop | 输出 | 物理内存属性信息。类型定义请参见[aclrtPhysicalMemProp](25-04_Structs.md#aclrtPhysicalMemProp)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310b" id26 -->
### 约束说明

Atlas 200I/500 A2 推理产品上，Ascend RC形态不支持调用本接口。
<!-- end id26 -->

<br>
<br>
<br>

<a id="aclrtMemGetAddressRange"></a>

## aclrtMemGetAddressRange

```c
aclError aclrtMemGetAddressRange(void *ptr, void **pbase, size_t *psize)
```

### 产品支持情况

<!-- npu="950" id974 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id974 -->
<!-- npu="A3" id975 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id975 -->
<!-- npu="910b" id976 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id976 -->
<!-- npu="310b" id977 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id977 -->
<!-- npu="310p" id978 -->
- Atlas 推理系列产品：支持
<!-- end id978 -->
<!-- npu="910" id979 -->
- Atlas 训练系列产品：支持
<!-- end id979 -->
<!-- npu="IPV350" id980 -->
- IPV350：不支持
<!-- end id980 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id19 -->

### 功能说明

获取待查询地址所属内存块的起始地址以及内存块大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ptr | 输入 | 待查询的内存地址。 |
| pbase | 输出 | 返回待查询地址所属内存块的起始地址。 |
| psize | 输出 | 返回待查询地址所属内存块的大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 参考信息

| 使用场景 | aclrtMemGetAddressRange接口行为 |
| --- | --- |
| 查询通过aclrtMalloc接口或aclrtMallocWithCfg接口返回的Device内存 | 返回内存块的起始地址和内存大小 |
| 查询通过aclrtMallocHost接口或aclrtMallocHostWithCfg接口返回的Host内存 | 返回内存块的起始地址和内存大小。 |
| 查询通过aclrtReserveMemAddress、aclrtMallocPhysical、aclrtMapMem等接口映射过的虚拟内存地址 | 返回经过映射的内存块的起始地址和内存大小 |

<br>
<br>
<br>

<a id="aclrtMemMapSelectedLink"></a>

## aclrtMemMapSelectedLink

```c
aclError aclrtMemMapSelectedLink(void *virPtrDst, size_t size, void *virPtrSrc, uint32_t linkIdx)
```

### 产品支持情况

<!-- npu="950" id652 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id652 -->
<!-- npu="A3" id653 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id653 -->
<!-- npu="910b" id654 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id654 -->
<!-- npu="310b" id655 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id655 -->
<!-- npu="310p" id656 -->
- Atlas 推理系列产品：不支持
<!-- end id656 -->
<!-- npu="910" id657 -->
- Atlas 训练系列产品：不支持
<!-- end id657 -->
<!-- npu="IPV350" id658 -->
- IPV350：不支持
<!-- end id658 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id20 -->

### 功能说明

将虚拟地址 virPtrDst 映射到虚拟地址 virPtrSrc 对应的物理地址，可以通过 linkIdx 选择 HCCS 链路或者 SIO 链路。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| virPtrDst | 输入 | 待映射的虚拟内存地址。<br> 需要通过aclrtReserveMemAddress接口提前预留虚拟地址内存，然后将虚拟内存的首地址作为入参传入本接口。不支持将虚拟内存首地址进行偏移后再传入本接口。|
| size | 输入 | 虚拟内存大小，单位Byte。<br> virPtrDst与virPtsSrc处的虚拟内存大小需保持一致，且与size相等。 |
| virPtrSrc | 输入 | 已与物理内存建立映射关系的虚拟内存地址。<br> 需提前通过aclrtMapMem接口完成虚拟内存与物理内存的映射，然后将虚拟内存的首地址作为入参传入本接口。不支持对虚拟内存首地址进行偏移后再传入本接口。|
| linkIdx | 输入 | 链路标识。<br> -  ACL_RT_MEM_LINK_IDX_0：SIO（Small Input Output），表示片内连接方式，两个DIE之间通过该方式连接。<br> -  ACL_RT_MEM_LINK_IDX_1：HCCS（Huawei Cache Coherence System），HCCS是华为缓存一致性系统，用于CPU/NPU之间的高速互联。 <br> <br> 宏定义如下：<br> ``` #define ACL_RT_MEM_LINK_IDX_0 0U    // SIO ``` <br> ```#define ACL_RT_MEM_LINK_IDX_1 1U    // HCCS``` | 

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

若virPtrSrc虚拟内存的首地址在偏移后映射至多个不同的物理内存，则在调用aclrtMemMapSelectedLink接口将virPtrDst与virPtrSrc进行映射时，virPtrDst同样会映射至这些不同的物理内存，且virPtrDst与virPtrSrc的地址偏移量保持一致。在此场景下，需多次调用aclrtUnmapMem接口取消virPtrDst与多个物理地址之间的映射关系。
