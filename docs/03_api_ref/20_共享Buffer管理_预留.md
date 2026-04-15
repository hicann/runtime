# 20. 共享Buffer管理（预留，暂不支持）

本章节描述预留的共享 Buffer 管理接口（当前版本暂不支持）。

- [`aclError aclrtAllocBuf(aclrtMbuf *buf, size_t size)`](#aclrtAllocBuf)：申请指定大小的共享Buffer。
- [`aclError aclrtFreeBuf(aclrtMbuf buf)`](#aclrtFreeBuf)：释放通过[aclrtAllocBuf](#aclrtAllocBuf)接口申请的共享Buffer。
- [`aclError aclrtGetBufData(const aclrtMbuf buf, void **dataPtr, size_t *size)`](#aclrtGetBufData)：获取共享Buffer的数据区指针和数据区长度，用户可以使用此指针填入数据。
- [`aclError aclrtSetBufUserData(aclrtMbuf buf, const void *dataPtr, size_t size, size_t offset)`](#aclrtSetBufUserData)：设置共享Buffer的私有数据区数据，从用户内存拷贝到共享Buffer的私有数据区的指定偏移位置，用于设置控制信息作为上下文传递。
- [`aclError aclrtGetBufUserData(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset)`](#aclrtGetBufUserData)：获取共享Buffer的私有数据区数据，偏移offset后，拷贝至用户申请的内存区域。
- [`aclError aclrtGetBufDataLen(aclrtMbuf buf, size_t *len)`](#aclrtGetBufDataLen)：获取共享Buffer中有效数据的长度。
- [`aclError aclrtSetBufDataLen(aclrtMbuf buf, size_t len)`](#aclrtSetBufDataLen)：设置共享Buffer中有效数据的长度。
- [`aclError aclrtCopyBufRef(const aclrtMbuf buf, aclrtMbuf *newBuf)`](#aclrtCopyBufRef)：对共享Buffer数据区的引用拷贝，创建并返回一个新的Mbuf管理结构指向相同的数据区。
- [`aclError aclrtAppendBufChain(aclrtMbuf headBuf, aclrtMbuf buf)`](#aclrtAppendBufChain)：将共享Buffer添加到Mbuf链表中。
- [`aclError aclrtGetBufFromChain(aclrtMbuf headBuf, uint32_t index, aclrtMbuf *buf)`](#aclrtGetBufFromChain)：从Mbuf链表中获取第index个共享Buffer。
- [`aclError aclrtGetBufChainNum(aclrtMbuf headBuf, uint32_t *num)`](#aclrtGetBufChainNum)：从Mbuf链表中获取共享Buffer的个数。


<a id="aclrtAllocBuf"></a>

# aclrtAllocBuf

```c
aclError aclrtAllocBuf(aclrtMbuf *buf, size_t size)
```

### 功能说明

申请指定大小的共享Buffer。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输出 | 申请到的共享Buffer。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。 |
| size | 输入 | 用于指定数据区的内存大小，单位Byte，不能超过4G。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtFreeBuf"></a>

# aclrtFreeBuf

```c
aclError aclrtFreeBuf(aclrtMbuf buf)
```

### 功能说明

释放通过[aclrtAllocBuf](#aclrtAllocBuf)接口申请的共享Buffer。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 待释放的共享Buffer。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetBufData"></a>

# aclrtGetBufData

```c
aclError aclrtGetBufData(const aclrtMbuf buf, void **dataPtr, size_t *size)
```

### 功能说明

获取共享Buffer的数据区指针和数据区长度，用户可以使用此指针填入数据。

接口调用顺序：调用[aclrtAllocBuf](#aclrtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请到共享Buffer后，因此需由用户调用[aclrtGetBufData](#aclrtGetBufData)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用[aclrtSetBufDataLen](#aclrtSetBufDataLen)接口设置共享Buffer中有效数据的长度，且长度必须小于[aclrtGetBufData](#aclrtGetBufData)获取到的size大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer，类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。<br>须通过[acltdtAllocBuf](17-03_共享Buffer管理.md#acltdtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请获得。 |
| dataPtr | 输出 | 数据区指针（Device侧地址）。 |
| size | 输出 | 数据区的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSetBufUserData"></a>

# aclrtSetBufUserData

```c
aclError aclrtSetBufUserData(aclrtMbuf buf, const void *dataPtr, size_t size, size_t offset)
```

### 功能说明

设置共享Buffer的私有数据区数据，从用户内存拷贝到共享Buffer的私有数据区的指定偏移位置，用于设置控制信息作为上下文传递。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输出 | 共享Buffer，类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。<br>须通过[aclrtAllocBuf](#aclrtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请获得。 |
| dataPtr | 输入 | 存放用户数据的内存地址指针。 |
| size | 输入 | 用户数据的长度，单位为Byte。<br>数据长度小于或等于96Byte。 |
| offset | 输入 | 地址偏移，单位为Byte。<br>偏移量小于或等于96Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetBufUserData"></a>

# aclrtGetBufUserData

```c
aclError aclrtGetBufUserData(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset)
```

### 功能说明

获取共享Buffer的私有数据区数据，偏移offset后，拷贝至用户申请的内存区域。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer，类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。<br>须通过[aclrtAllocBuf](#aclrtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请获得。 |
| dataPtr | 输出 | 存放用户数据的内存地址指针。 |
| size | 输入 | 用户数据的长度，单位为Byte。<br>数据长度小于或等于96Byte。 |
| offset | 输入 | 地址偏移，单位为Byte。<br>偏移量小于或等于96Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetBufDataLen"></a>

# aclrtGetBufDataLen

```c
aclError aclrtGetBufDataLen(aclrtMbuf buf, size_t *len)
```

### 功能说明

获取共享Buffer中有效数据的长度。

通过[aclrtSetBufDataLen](#aclrtSetBufDataLen)接口设置共享Buffer中有效数据的长度后，可调用本接口获取有效数据的长度，否则，通过本接口获取到的长度为0。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer，类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。<br>须通过[aclrtAllocBuf](#aclrtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请获得。 |
| len | 输出 | 有效数据的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSetBufDataLen"></a>

# aclrtSetBufDataLen

```c
aclError aclrtSetBufDataLen(aclrtMbuf buf, size_t len)
```

### 功能说明

设置共享Buffer中有效数据的长度。

接口调用顺序：调用[aclrtAllocBuf](#aclrtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请到共享Buffer后，因此需由用户调用[aclrtGetBufData](#aclrtGetBufData)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用[aclrtSetBufDataLen](#aclrtSetBufDataLen)接口设置共享Buffer中有效数据的长度，且长度必须小于[aclrtGetBufData](#aclrtGetBufData)获取到的size大小。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer，类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。<br>须通过[aclrtAllocBuf](#aclrtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请获得。 |
| len | 输入 | 有效数据的长度，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCopyBufRef"></a>

# aclrtCopyBufRef

```c
aclError aclrtCopyBufRef(const aclrtMbuf buf, aclrtMbuf *newBuf)
```

### 功能说明

对共享Buffer数据区的引用拷贝，创建并返回一个新的Mbuf管理结构指向相同的数据区。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| buf | 输入 | 共享Buffer。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。<br>共享Buffer可通过[aclrtAllocBuf](#aclrtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请获得。 |
| newBuf | 输出 | 返回一个新的共享Buffer，指向相同的数据区。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtAppendBufChain"></a>

# aclrtAppendBufChain

```c
aclError aclrtAppendBufChain(aclrtMbuf headBuf, aclrtMbuf buf)
```

### 功能说明

将共享Buffer添加到Mbuf链表中。共享Buffer链最大支持128个共享Buffer。共享Buffer可通过[aclrtAllocBuf](#aclrtAllocBuf)或[aclrtCopyBufRef](#aclrtCopyBufRef)接口申请获得。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | Mbuf链表中的第一个共享Buffer。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。 |
| buf | 输入 | 待添加的共享Buffer。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetBufFromChain"></a>

# aclrtGetBufFromChain

```c
aclError aclrtGetBufFromChain(aclrtMbuf headBuf, uint32_t index, aclrtMbuf *buf)
```

### 功能说明

从Mbuf链表中获取第index个共享Buffer。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | Mbuf链表中的第一个共享Buffer。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。 |
| index | 输入 | Mbuf链表中的索引（从0开始计数）。 |
| buf | 输出 | 输出第index个共享Buffer。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetBufChainNum"></a>

# aclrtGetBufChainNum

```c
aclError aclrtGetBufChainNum(aclrtMbuf headBuf, uint32_t *num)
```

### 功能说明

从Mbuf链表中获取共享Buffer的个数。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| headBuf | 输入 | Mbuf链表中的第一个共享Buffer。类型定义请参见[aclrtMbuf](25_数据类型及其操作接口.md#aclrtMbuf)。 |
| num | 输出 | 共享Buffer的个数。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。
