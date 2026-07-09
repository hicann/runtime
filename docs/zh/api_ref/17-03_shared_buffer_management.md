# 17-03 共享Buffer管理

本章节描述共享 Buffer 管理接口，用于 Buffer 的分配、释放、数据操作及 Buffer 链管理。

- [`aclError acltdtAllocBuf(size_t size, uint32_t type, acltdtBuf *buf)`](#acltdtAllocBuf)：申请共享Buffer内存。
- [`aclError acltdtFreeBuf(acltdtBuf buf)`](#acltdtFreeBuf)：释放通过[acltdtAllocBuf](#acltdtAllocBuf)接口申请的mbuf。
- [`aclError acltdtGetBufData(const acltdtBuf buf, void **dataPtr, size_t *size)`](#acltdtGetBufData)：获取共享Buffer的数据区指针和数据区长度，用户可以使用此指针填入数据。
- [`aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr, size_t size, size_t offset)`](#acltdtSetBufUserData)：设置共享Buffer的私有数据区数据，从用户内存拷贝到共享内存的私有数据区的指定偏移位置，用于设置控制信息作为上下文传递。
- [`aclError acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr, size_t size, size_t offset)`](#acltdtGetBufUserData)：获取共享Buffer的私有数据区数据，偏移offset后，拷贝至用户申请的内存区域。
- [`aclError acltdtSetBufDataLen(acltdtBuf buf, size_t len)`](#acltdtSetBufDataLen)：设置共享Buffer中有效数据的长度。
- [`aclError acltdtGetBufDataLen(acltdtBuf buf, size_t *len)`](#acltdtGetBufDataLen)：获取共享Buffer中有效数据的长度。
- [`aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *newBuf)`](#acltdtCopyBufRef)：对共享Buffer数据区的引用拷贝，创建并返回一个新的Buffer管理结构指向相同的数据区。
- [`aclError acltdtAppendBufChain(acltdtBuf headBuf, acltdtBuf buf)`](#acltdtAppendBufChain)：将某个共享Buffer内存添加到共享Buffer链表中。
- [`aclError acltdtGetBufChainNum(acltdtBuf headBuf, uint32_t *num)`](#acltdtGetBufChainNum)：获取共享Buffer链中的共享Buffer数量。
- [`aclError acltdtGetBufFromChain(acltdtBuf headBuf, uint32_t index, acltdtBuf *buf)`](#acltdtGetBufFromChain)：获取Mbuf链中第index个Mbuf。

<a id="acltdtAllocBuf"></a>

## acltdtAllocBuf

```c
aclError acltdtAllocBuf(size_t size, uint32_t type, acltdtBuf *buf)
```

### 产品支持情况

<!-- npu="950" id2423 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2423 -->
<!-- npu="A3" id2424 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2424 -->
<!-- npu="910b" id2425 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2425 -->
<!-- npu="310b" id2426 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2426 -->
<!-- npu="310p" id2427 -->
- Atlas 推理系列产品：不支持
<!-- end id2427 -->
<!-- npu="910" id2428 -->
- Atlas 训练系列产品：不支持
<!-- end id2428 -->
<!-- npu="IPV350" id2429 -->
- IPV350：不支持
<!-- end id2429 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id1 -->

### 功能说明

申请共享Buffer内存。

使用acltdtAllocBuf接口申请内存后，数据区的长度为size参数的大小，在用户还未填入有效数据前，该内存的有效数据长度初始值为0，可在用户向内存中填入有效数据后，再通过[acltdtSetBufDataLen](#acltdtSetBufDataLen)接口设置有效数据长度。

使用acltdtAllocBuf接口申请的内存，需要通过[acltdtFreeBuf](#acltdtFreeBuf)接口释放内存。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| size | 输入 | 用于指定数据区的内存大小，单位Byte，不能超过4G。 |
| type | 输入 | 共享Buffer内存类型，支持设置如下枚举值。<br>typedef enum {<br>   ACL_TDT_NORMAL_MEM = 0,<br>   ACL_TDT_DVPP_MEM<br>} acltdtAllocBufType;<br>当前仅支持设置ACL_TDT_NORMAL_MEM。 |
| buf | 输出 | 申请成功，输出共享Buffer。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310b" id1 -->
### 约束说明

对于Atlas 200I/500 A2 推理产品，仅支持在Ascend RC形态下使用该接口。
<!-- end id1 -->

<br>
<br>
<br>

<a id="acltdtFreeBuf"></a>

## acltdtFreeBuf

```c
aclError acltdtFreeBuf(acltdtBuf buf)
```

### 产品支持情况

<!-- npu="950" id3228 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id3228 -->
<!-- npu="A3" id3229 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3229 -->
<!-- npu="910b" id3230 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id3230 -->
<!-- npu="310b" id3231 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3231 -->
<!-- npu="310p" id3232 -->
- Atlas 推理系列产品：不支持
<!-- end id3232 -->
<!-- npu="910" id3233 -->
- Atlas 训练系列产品：不支持
<!-- end id3233 -->
<!-- npu="IPV350" id3234 -->
- IPV350：不支持
<!-- end id3234 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id2 -->

### 功能说明

释放通过[acltdtAllocBuf](#acltdtAllocBuf)接口申请的mbuf。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 指定要释放的mbuf。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtGetBufData"></a>

## acltdtGetBufData

```c
aclError acltdtGetBufData(const acltdtBuf buf, void **dataPtr, size_t *size)
```

### 产品支持情况

<!-- npu="950" id1289 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id1289 -->
<!-- npu="A3" id1290 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id1290 -->
<!-- npu="910b" id1291 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id1291 -->
<!-- npu="310b" id1292 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1292 -->
<!-- npu="310p" id1293 -->
- Atlas 推理系列产品：不支持
<!-- end id1293 -->
<!-- npu="910" id1294 -->
- Atlas 训练系列产品：不支持
<!-- end id1294 -->
<!-- npu="IPV350" id1295 -->
- IPV350：不支持
<!-- end id1295 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id3 -->

### 功能说明

获取共享Buffer的数据区指针和数据区长度，用户可以使用此指针填入数据。

接口调用顺序：调用[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请到共享Buffer后，因此需由用户调用[acltdtGetBufData](#acltdtGetBufData)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用[acltdtSetBufDataLen](#acltdtSetBufDataLen)接口设置共享Buffer中有效数据的长度，且长度必须小于[acltdtGetBufData](#acltdtGetBufData)获取到的size大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| dataPtr | 输出 | 数据区指针（Device侧地址）。 |
| size | 输出 | 数据区的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtSetBufUserData"></a>

## acltdtSetBufUserData

```c
aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr, size_t size, size_t offset)
```

### 产品支持情况

<!-- npu="950" id638 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id638 -->
<!-- npu="A3" id639 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id639 -->
<!-- npu="910b" id640 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id640 -->
<!-- npu="310b" id641 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id641 -->
<!-- npu="310p" id642 -->
- Atlas 推理系列产品：不支持
<!-- end id642 -->
<!-- npu="910" id643 -->
- Atlas 训练系列产品：不支持
<!-- end id643 -->
<!-- npu="IPV350" id644 -->
- IPV350：不支持
<!-- end id644 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id4 -->

### 功能说明

设置共享Buffer的私有数据区数据，从用户内存拷贝到共享内存的私有数据区的指定偏移位置，用于设置控制信息作为上下文传递。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输出 | 共享Buffer指针。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。 |
| dataPtr | 输入 | 存放用户数据的内存地址指针。 |
| size | 输入 | 用户数据的长度，单位为Byte。<br>数据长度小于或等于96Byte。 |
| offset | 输入 | 地址偏移，单位为Byte。<br>偏移量小于或等于96Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtGetBufUserData"></a>

## acltdtGetBufUserData

```c
aclError acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr, size_t size, size_t offset)
```

### 产品支持情况

<!-- npu="950" id78 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id78 -->
<!-- npu="A3" id79 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id79 -->
<!-- npu="910b" id80 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id80 -->
<!-- npu="310b" id81 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id81 -->
<!-- npu="310p" id82 -->
- Atlas 推理系列产品：不支持
<!-- end id82 -->
<!-- npu="910" id83 -->
- Atlas 训练系列产品：不支持
<!-- end id83 -->
<!-- npu="IPV350" id84 -->
- IPV350：不支持
<!-- end id84 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id5 -->

### 功能说明

获取共享Buffer的私有数据区数据，偏移offset后，拷贝至用户申请的内存区域。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| dataPtr | 输入 | 存放用户数据的内存地址指针。 |
| size | 输入 | 用户数据的长度，单位为Byte。<br>数据长度小于或等于96Byte。 |
| offset | 输入 | 地址偏移，单位为Byte。<br>偏移量小于或等于96Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtSetBufDataLen"></a>

## acltdtSetBufDataLen

```c
aclError acltdtSetBufDataLen(acltdtBuf buf, size_t len)
```

### 产品支持情况

<!-- npu="950" id3375 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id3375 -->
<!-- npu="A3" id3376 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3376 -->
<!-- npu="910b" id3377 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id3377 -->
<!-- npu="310b" id3378 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3378 -->
<!-- npu="310p" id3379 -->
- Atlas 推理系列产品：不支持
<!-- end id3379 -->
<!-- npu="910" id3380 -->
- Atlas 训练系列产品：不支持
<!-- end id3380 -->
<!-- npu="IPV350" id3381 -->
- IPV350：不支持
<!-- end id3381 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id6 -->

### 功能说明

设置共享Buffer中有效数据的长度。

接口调用顺序：调用[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请到共享Buffer后，因此需由用户调用[acltdtGetBufData](#acltdtGetBufData)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用acltdtSetBufDataLen接口设置共享Buffer中有效数据的长度，且长度必须小于[acltdtGetBufData](#acltdtGetBufData)获取到的size大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| len | 输入 | 有效数据的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtGetBufDataLen"></a>

## acltdtGetBufDataLen

```c
aclError acltdtGetBufDataLen(acltdtBuf buf, size_t *len)
```

### 产品支持情况

<!-- npu="950" id3473 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id3473 -->
<!-- npu="A3" id3474 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3474 -->
<!-- npu="910b" id3475 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id3475 -->
<!-- npu="310b" id3476 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3476 -->
<!-- npu="310p" id3477 -->
- Atlas 推理系列产品：不支持
<!-- end id3477 -->
<!-- npu="910" id3478 -->
- Atlas 训练系列产品：不支持
<!-- end id3478 -->
<!-- npu="IPV350" id3479 -->
- IPV350：不支持
<!-- end id3479 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id7 -->

### 功能说明

获取共享Buffer中有效数据的长度。

通过[acltdtSetBufDataLen](#acltdtSetBufDataLen)接口设置共享Buffer中有效数据的长度后，可调用本接口获取有效数据的长度，否则，通过本接口获取到的长度为0。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| len | 输出 | 有效数据的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtCopyBufRef"></a>

## acltdtCopyBufRef

```c
aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *newBuf)
```

### 产品支持情况

<!-- npu="950" id176 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id176 -->
<!-- npu="A3" id177 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id177 -->
<!-- npu="910b" id178 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id178 -->
<!-- npu="310b" id179 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id179 -->
<!-- npu="310p" id180 -->
- Atlas 推理系列产品：不支持
<!-- end id180 -->
<!-- npu="910" id181 -->
- Atlas 训练系列产品：不支持
<!-- end id181 -->
<!-- npu="IPV350" id182 -->
- IPV350：不支持
<!-- end id182 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id8 -->

### 功能说明

对共享Buffer数据区的引用拷贝，创建并返回一个新的Buffer管理结构指向相同的数据区。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| newBuf | 输出 | 返回一个新的共享Buffer，指向相同的数据区。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310b" id2 -->
### 约束说明

对于Atlas 200I/500 A2 推理产品，仅支持在Ascend RC形态下使用该接口。
<!-- end id2 -->

<br>
<br>
<br>

<a id="acltdtAppendBufChain"></a>

## acltdtAppendBufChain

```c
aclError acltdtAppendBufChain(acltdtBuf headBuf, acltdtBuf buf)
```

### 产品支持情况

<!-- npu="950" id967 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id967 -->
<!-- npu="A3" id968 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id968 -->
<!-- npu="910b" id969 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id969 -->
<!-- npu="310b" id970 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id970 -->
<!-- npu="310p" id971 -->
- Atlas 推理系列产品：不支持
<!-- end id971 -->
<!-- npu="910" id972 -->
- Atlas 训练系列产品：不支持
<!-- end id972 -->
<!-- npu="IPV350" id973 -->
- IPV350：不支持
<!-- end id973 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id9 -->

### 功能说明

将某个共享Buffer内存添加到共享Buffer链表中。共享Buffer链最大支持128个共享Buffer。共享Buffer可通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | 共享Buffer链头部的第一个共享Buffer。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。 |
| buf | 输入 | 待添加的共享Buffer。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtGetBufChainNum"></a>

## acltdtGetBufChainNum

```c
aclError acltdtGetBufChainNum(acltdtBuf headBuf, uint32_t *num)
```

### 产品支持情况

<!-- npu="950" id491 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id491 -->
<!-- npu="A3" id492 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id492 -->
<!-- npu="910b" id493 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id493 -->
<!-- npu="310b" id494 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id494 -->
<!-- npu="310p" id495 -->
- Atlas 推理系列产品：不支持
<!-- end id495 -->
<!-- npu="910" id496 -->
- Atlas 训练系列产品：不支持
<!-- end id496 -->
<!-- npu="IPV350" id497 -->
- IPV350：不支持
<!-- end id497 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id10 -->

### 功能说明

获取共享Buffer链中的共享Buffer数量。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | 共享Buffer链头部的第一个共享Buffer。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| num | 输出 | 共享Buffer链中的共享Buffer数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtGetBufFromChain"></a>

## acltdtGetBufFromChain

```c
aclError acltdtGetBufFromChain(acltdtBuf headBuf, uint32_t index, acltdtBuf *buf)
```

### 产品支持情况

<!-- npu="950" id2290 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2290 -->
<!-- npu="A3" id2291 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2291 -->
<!-- npu="910b" id2292 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2292 -->
<!-- npu="310b" id2293 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2293 -->
<!-- npu="310p" id2294 -->
- Atlas 推理系列产品：不支持
<!-- end id2294 -->
<!-- npu="910" id2295 -->
- Atlas 训练系列产品：不支持
<!-- end id2295 -->
<!-- npu="IPV350" id2296 -->
- IPV350：不支持
<!-- end id2296 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id11 -->

### 功能说明

获取Mbuf链中第index个Mbuf。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | 共享Buffer链头部的第一个共享Buffer。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| index | 输入 | 共享Buffer链中的共享Buffer序号（从0开始计数）。 |
| buf | 输出 | 输出第index个共享Buffer。类型定义请参见[acltdtBuf](25-05_Typedefs.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
