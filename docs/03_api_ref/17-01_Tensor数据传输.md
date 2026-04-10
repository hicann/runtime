# 17-01 Tensor数据传输

本章节描述 Tensor 数据传输接口，用于 Host-Device 间 Tensor 数据的通道创建、发送与接收。

- [`acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)`](#acltdtCreateChannel)：创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道。
- [`acltdtChannelHandle *acltdtCreateChannelWithCapacity(uint32_t deviceId, const char *name, size_t capacity)`](#acltdtCreateChannelWithCapacity)：创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道，通道带容量。
- [`aclError acltdtSendTensor(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout)`](#acltdtSendTensor)：从Host向Device发送预处理好的数据。
- [`aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)`](#acltdtReceiveTensor)：在Host接收Device发过来的数据。
- [`aclError acltdtStopChannel(acltdtChannelHandle *handle)`](#acltdtStopChannel)：调用acltdtSendTensor接口发送数据时或调用acltdtReceiveTensor接口接收数据时，用户线程可能在没有数据时会卡住，此时如果需要退出的话，需要先将线程唤醒，该接口就是用来唤醒被卡住阻塞的线程用的。
- [`aclError acltdtDestroyChannel(acltdtChannelHandle *handle)`](#acltdtDestroyChannel)：销毁acltdtChannelHandle类型的数据，只能销毁通过[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建的acltdtChannelHandle类型。
- [`aclError acltdtQueryChannelSize(const acltdtChannelHandle *handle, size_t *size)`](#acltdtQueryChannelSize)：查询队列通道内的消息数量。
- [`aclError acltdtGetSliceInfoFromItem(const acltdtDataItem *dataItem, size_t *sliceNum, size_t* sliceId)`](#acltdtGetSliceInfoFromItem)：用于输出Tensor分片信息。
- [`aclError acltdtCleanChannel(acltdtChannelHandle *handle)`](#acltdtCleanChannel)：清空通道中的所有数据。


<a id="acltdtCreateChannel"></a>

# acltdtCreateChannel

```c
acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道。通道使用完成后，需及时依次调用[acltdtStopChannel](#acltdtStopChannel)、[acltdtDestroyChannel](#acltdtDestroyChannel)接口释放通道资源。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_Device管理.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| name | 输入 | 队列通道名称的指针。 |

### 返回值说明

-   返回acltdtChannelHandle类型的指针，表示成功。
-   返回nullptr，表示失败。


<br>
<br>
<br>



<a id="acltdtCreateChannelWithCapacity"></a>

# acltdtCreateChannelWithCapacity

```c
acltdtChannelHandle *acltdtCreateChannelWithCapacity(uint32_t deviceId, const char *name, size_t capacity)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道，通道带容量。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_Device管理.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| name | 输入 | 队列通道名称的指针。 |
| capacity | 输入 | 队列通道容量，取值范围：[2, 8192]。 |

### 返回值说明

-   返回acltdtChannelHandle类型的指针，表示成功。
-   返回nullptr，表示失败。


<br>
<br>
<br>



<a id="acltdtSendTensor"></a>

# acltdtSendTensor

```c
aclError acltdtSendTensor(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

从Host向Device发送预处理好的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |
| dataset | 输入 | 向Device发送的数据的指针。类型定义请参见[acltdtDataset](24_数据类型及其操作接口.md#acltdtDataset)。 |
| timeout | 输入 | 等待超时时间。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据发送完成。<br>  - 0：非阻塞方式，当通道满时，直接返回通道满这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。通道满时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtReceiveTensor"></a>

# acltdtReceiveTensor

```c
aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在Host接收Device发过来的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |
| dataset | 输出 | 接收到的Device数据的指针。类型定义请参见[acltdtDataset](24_数据类型及其操作接口.md#acltdtDataset)。 |
| timeout | 输入 | 等待超时时间。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据接收完成。<br>  - 0：非阻塞方式，当通道空时，直接返回通道空这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。通道空时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtStopChannel"></a>

# acltdtStopChannel

```c
aclError acltdtStopChannel(acltdtChannelHandle *handle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

调用acltdtSendTensor接口发送数据时或调用acltdtReceiveTensor接口接收数据时，用户线程可能在没有数据时会卡住，此时如果需要退出的话，需要先将线程唤醒，该接口就是用来唤醒被卡住阻塞的线程用的。需要用户在发送、接收线程之外的一个线程里调用这个函数，来唤醒处于阻塞状态的发送/接收线程。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtDestroyChannel"></a>

# acltdtDestroyChannel

```c
aclError acltdtDestroyChannel(acltdtChannelHandle *handle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁acltdtChannelHandle类型的数据，只能销毁通过[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建的acltdtChannelHandle类型。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 待销毁的acltdtChannelHandle类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtQueryChannelSize"></a>

# acltdtQueryChannelSize

```c
aclError acltdtQueryChannelSize(const acltdtChannelHandle *handle, size_t *size)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

查询队列通道内的消息数量。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |
| size | 输出 | 消息数量的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtGetSliceInfoFromItem"></a>

# acltdtGetSliceInfoFromItem

```c
aclError acltdtGetSliceInfoFromItem(const acltdtDataItem *dataItem, size_t *sliceNum, size_t* sliceId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

用于输出Tensor分片信息。

**使用场景：**OutfeedEnqueueOpV2算子由于其功能要求需申请Device上的大块内存存放数据，在Device内存不足时，可能会导致内存申请失败，进而导致某些算子无法正常执行，该场景下，用户可以调用本接口获取Tensor分片信息（分片数量、分片索引），再根据分片信息拼接算子的Tensor数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。acltdtDataItem用于标识一个业务上的Tensor。类型定义请参见[acltdtDataItem](24_数据类型及其操作接口.md#acltdtDataItem)。<br>需提前调用[acltdtCreateDataItem](24_数据类型及其操作接口.md#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |
| sliceNum | 输出 | 单个Tensor被切片的数量。 |
| sliceId | 输出 | 被切片Tensor的数据段索引。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="acltdtCleanChannel"></a>

# acltdtCleanChannel

```c
aclError acltdtCleanChannel(acltdtChannelHandle *handle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

清空通道中的所有数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。
