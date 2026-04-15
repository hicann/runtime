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

# acltdtAllocBuf

```c
aclError acltdtAllocBuf(size_t size, uint32_t type, acltdtBuf *buf)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

申请共享Buffer内存。

使用acltdtAllocBuf接口申请内存后，数据区的长度为size参数的大小，在用户还未填入有效数据前，该内存的有效数据长度初始值为0，可在用户向内存中填入有效数据后，再通过[acltdtSetBufDataLen](#acltdtSetBufDataLen)接口设置有效数据长度。

使用acltdtAllocBuf接口申请的内存，需要通过[acltdtFreeBuf](#acltdtFreeBuf)接口释放内存。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| size | 输入 | 用于指定数据区的内存大小，单位Byte，不能超过4G。 |
| type | 输入 | 共享Buffer内存类型，支持设置如下枚举值。<br>typedef enum {<br>   ACL_TDT_NORMAL_MEM = 0,<br>   ACL_TDT_DVPP_MEM<br>} acltdtAllocBufType;<br>当前仅支持设置ACL_TDT_NORMAL_MEM。 |
| buf | 输出 | 申请成功，输出共享Buffer。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtFreeBuf"></a>

# acltdtFreeBuf

```c
aclError acltdtFreeBuf(acltdtBuf buf)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

释放通过[acltdtAllocBuf](#acltdtAllocBuf)接口申请的mbuf。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 指定要释放的mbuf。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtGetBufData"></a>

# acltdtGetBufData

```c
aclError acltdtGetBufData(const acltdtBuf buf, void **dataPtr, size_t *size)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

获取共享Buffer的数据区指针和数据区长度，用户可以使用此指针填入数据。

接口调用顺序：调用[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请到共享Buffer后，因此需由用户调用[acltdtGetBufData](#acltdtGetBufData)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用[acltdtSetBufDataLen](#acltdtSetBufDataLen)接口设置共享Buffer中有效数据的长度，且长度必须小于[acltdtGetBufData](#acltdtGetBufData)获取到的size大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| dataPtr | 输出 | 数据区指针（Device侧地址）。 |
| size | 输出 | 数据区的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtSetBufUserData"></a>

# acltdtSetBufUserData

```c
aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr, size_t size, size_t offset)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

设置共享Buffer的私有数据区数据，从用户内存拷贝到共享内存的私有数据区的指定偏移位置，用于设置控制信息作为上下文传递。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输出 | 共享Buffer指针。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。 |
| dataPtr | 输入 | 存放用户数据的内存地址指针。 |
| size | 输入 | 用户数据的长度，单位为Byte。<br>数据长度小于或等于96Byte。 |
| offset | 输入 | 地址偏移，单位为Byte。<br>偏移量小于或等于96Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtGetBufUserData"></a>

# acltdtGetBufUserData

```c
aclError acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr, size_t size, size_t offset)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

获取共享Buffer的私有数据区数据，偏移offset后，拷贝至用户申请的内存区域。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| dataPtr | 输入 | 存放用户数据的内存地址指针。 |
| size | 输入 | 用户数据的长度，单位为Byte。<br>数据长度小于或等于96Byte。 |
| offset | 输入 | 地址偏移，单位为Byte。<br>偏移量小于或等于96Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtSetBufDataLen"></a>

# acltdtSetBufDataLen

```c
aclError acltdtSetBufDataLen(acltdtBuf buf, size_t len)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

设置共享Buffer中有效数据的长度。

接口调用顺序：调用[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请到共享Buffer后，因此需由用户调用[acltdtGetBufData](#acltdtGetBufData)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用acltdtSetBufDataLen接口设置共享Buffer中有效数据的长度，且长度必须小于[acltdtGetBufData](#acltdtGetBufData)获取到的size大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| len | 输入 | 有效数据的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtGetBufDataLen"></a>

# acltdtGetBufDataLen

```c
aclError acltdtGetBufDataLen(acltdtBuf buf, size_t *len)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

获取共享Buffer中有效数据的长度。

通过[acltdtSetBufDataLen](#acltdtSetBufDataLen)接口设置共享Buffer中有效数据的长度后，可调用本接口获取有效数据的长度，否则，通过本接口获取到的长度为0。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer指针。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| len | 输出 | 有效数据的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtCopyBufRef"></a>

# acltdtCopyBufRef

```c
aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *newBuf)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

对共享Buffer数据区的引用拷贝，创建并返回一个新的Buffer管理结构指向相同的数据区。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| newBuf | 输出 | 返回一个新的共享Buffer，指向相同的数据区。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtAppendBufChain"></a>

# acltdtAppendBufChain

```c
aclError acltdtAppendBufChain(acltdtBuf headBuf, acltdtBuf buf)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

将某个共享Buffer内存添加到共享Buffer链表中。共享Buffer链最大支持128个共享Buffer。共享Buffer可通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | 共享Buffer链头部的第一个共享Buffer。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。 |
| buf | 输入 | 待添加的共享Buffer。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtGetBufChainNum"></a>

# acltdtGetBufChainNum

```c
aclError acltdtGetBufChainNum(acltdtBuf headBuf, uint32_t *num)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

获取共享Buffer链中的共享Buffer数量。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | 共享Buffer链头部的第一个共享Buffer。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| num | 输出 | 共享Buffer链中的共享Buffer数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtGetBufFromChain"></a>

# acltdtGetBufFromChain

```c
aclError acltdtGetBufFromChain(acltdtBuf headBuf, uint32_t index, acltdtBuf *buf)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

获取Mbuf链中第index个Mbuf。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | 共享Buffer链头部的第一个共享Buffer。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。<br>须通过[acltdtAllocBuf](#acltdtAllocBuf)或[acltdtCopyBufRef](#acltdtCopyBufRef)接口申请获得。 |
| index | 输入 | 共享Buffer链中的共享Buffer序号（从0开始计数）。 |
| buf | 输出 | 输出第index个共享Buffer。类型定义请参见[acltdtBuf](25_数据类型及其操作接口.md#acltdtBuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。
