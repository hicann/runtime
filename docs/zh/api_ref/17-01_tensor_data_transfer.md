# 17-01 Tensor数据传输

本章节描述 Tensor 数据传输接口，用于 Host-Device 间 Tensor 数据的通道创建、发送与接收。

- [`acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)`](#acltdtCreateChannel)：创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道。
- [`acltdtChannelHandle *acltdtCreateChannelWithCapacity(uint32_t deviceId, const char *name, size_t capacity)`](#acltdtCreateChannelWithCapacity)：创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道，通道带容量。
- [`aclError acltdtSendTensor(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout)`](#acltdtSendTensor)：从Host向Device发送预处理好的数据。
- [`aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)`](#acltdtReceiveTensor)：在Host接收Device发过来的数据。
- [`aclError acltdtStopChannel(acltdtChannelHandle *handle)`](#acltdtStopChannel)：调用acltdtSendTensor接口发送数据时或调用acltdtReceiveTensor接口接收数据时，用户线程可能在没有数据时会卡住，此时如果需要退出的话，需要先将线程唤醒，该接口用于唤醒处于阻塞状态的线程。
- [`aclError acltdtDestroyChannel(acltdtChannelHandle *handle)`](#acltdtDestroyChannel)：销毁acltdtChannelHandle类型的数据，只能销毁通过[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建的acltdtChannelHandle类型。
- [`aclError acltdtQueryChannelSize(const acltdtChannelHandle *handle, size_t *size)`](#acltdtQueryChannelSize)：查询队列通道内的消息数量。
- [`aclError acltdtGetSliceInfoFromItem(const acltdtDataItem *dataItem, size_t *sliceNum, size_t* sliceId)`](#acltdtGetSliceInfoFromItem)：用于输出Tensor分片信息。
- [`aclError acltdtCleanChannel(acltdtChannelHandle *handle)`](#acltdtCleanChannel)：清空通道中的所有数据。

<a id="acltdtCreateChannel"></a>

## acltdtCreateChannel

```c
acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)
```

### 产品支持情况

<!-- npu="950" id3284 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id3284 -->
<!-- npu="A3" id3285 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3285 -->
<!-- npu="910b" id3286 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id3286 -->
<!-- npu="310b" id3287 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3287 -->
<!-- npu="310p" id3288 -->
- Atlas 推理系列产品：不支持
<!-- end id3288 -->
<!-- npu="910" id3289 -->
- Atlas 训练系列产品：支持
<!-- end id3289 -->
<!-- npu="IPV350" id3290 -->
- IPV350：不支持
<!-- end id3290 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id1 -->

### 功能说明

创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道。通道使用完成后，需及时依次调用[acltdtStopChannel](#acltdtStopChannel)、[acltdtDestroyChannel](#acltdtDestroyChannel)接口释放通道资源。

<!-- npu="910" id1 -->
对于Atlas 训练系列产品，仅支持在昇腾虚拟化实例场景下使用本接口。
<!-- end id1 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| name | 输入 | 队列通道名称的指针。 |

### 返回值说明

- 返回acltdtChannelHandle类型的指针，表示成功。
- 返回nullptr，表示失败。

<br>
<br>
<br>

<a id="acltdtCreateChannelWithCapacity"></a>

## acltdtCreateChannelWithCapacity

```c
acltdtChannelHandle *acltdtCreateChannelWithCapacity(uint32_t deviceId, const char *name, size_t capacity)
```

### 产品支持情况

<!-- npu="950" id2087 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2087 -->
<!-- npu="A3" id2088 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2088 -->
<!-- npu="910b" id2089 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2089 -->
<!-- npu="310b" id2090 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2090 -->
<!-- npu="310p" id2091 -->
- Atlas 推理系列产品：不支持
<!-- end id2091 -->
<!-- npu="910" id2092 -->
- Atlas 训练系列产品：支持
<!-- end id2092 -->
<!-- npu="IPV350" id2093 -->
- IPV350：不支持
<!-- end id2093 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id2 -->

### 功能说明

创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道，通道带容量。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| name | 输入 | 队列通道名称的指针。 |
| capacity | 输入 | 队列通道容量，取值范围：[2, 8192]。 |

### 返回值说明

- 返回acltdtChannelHandle类型的指针，表示成功。
- 返回nullptr，表示失败。

<br>
<br>
<br>

<a id="acltdtSendTensor"></a>

## acltdtSendTensor

```c
aclError acltdtSendTensor(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id2696 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2696 -->
<!-- npu="A3" id2697 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2697 -->
<!-- npu="910b" id2698 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2698 -->
<!-- npu="310b" id2699 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2699 -->
<!-- npu="310p" id2700 -->
- Atlas 推理系列产品：不支持
<!-- end id2700 -->
<!-- npu="910" id2701 -->
- Atlas 训练系列产品：支持
<!-- end id2701 -->
<!-- npu="IPV350" id2702 -->
- IPV350：不支持
<!-- end id2702 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id3 -->

### 功能说明

<!-- npu="950,A3,910b,910,310p,310b" id2 -->
从Host向Device发送预处理好的数据。
<!-- end id2 -->
<!-- npu="IPV350" id3 -->
发送预处理好的数据。
<!-- end id3 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id10 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |
| dataset | 输入 | 向Device发送的数据的指针。类型定义请参见[acltdtDataset](25-03_Operation_APIs.md#acltdtDataset)。 |
| timeout | 输入 | 等待超时时间。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据发送完成。<br>  - 0：非阻塞方式，当通道满时，直接返回通道满这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。通道满时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtReceiveTensor"></a>

## acltdtReceiveTensor

```c
aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id2206 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2206 -->
<!-- npu="A3" id2207 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2207 -->
<!-- npu="910b" id2208 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2208 -->
<!-- npu="310b" id2209 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2209 -->
<!-- npu="310p" id2210 -->
- Atlas 推理系列产品：不支持
<!-- end id2210 -->
<!-- npu="910" id2211 -->
- Atlas 训练系列产品：支持
<!-- end id2211 -->
<!-- npu="IPV350" id2212 -->
- IPV350：不支持
<!-- end id2212 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id4 -->

### 功能说明

<!-- npu="950,A3,910b,910,310p,310b" id4 -->
在Host接收Device发过来的数据。
<!-- end id4 -->
<!-- npu="IPV350" id5 -->
接收数据。
<!-- end id5 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id11 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |
| dataset | 输出 | 接收到的Device数据的指针。类型定义请参见[acltdtDataset](25-03_Operation_APIs.md#acltdtDataset)。 |
| timeout | 输入 | 等待超时时间。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据接收完成。<br>  - 0：非阻塞方式，当通道空时，直接返回通道空这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。通道空时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtStopChannel"></a>

## acltdtStopChannel

```c
aclError acltdtStopChannel(acltdtChannelHandle *handle)
```

### 产品支持情况

<!-- npu="950" id918 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id918 -->
<!-- npu="A3" id919 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id919 -->
<!-- npu="910b" id920 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id920 -->
<!-- npu="310b" id921 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id921 -->
<!-- npu="310p" id922 -->
- Atlas 推理系列产品：不支持
<!-- end id922 -->
<!-- npu="910" id923 -->
- Atlas 训练系列产品：支持
<!-- end id923 -->
<!-- npu="IPV350" id924 -->
- IPV350：不支持
<!-- end id924 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id5 -->

### 功能说明

调用acltdtSendTensor接口发送数据时或调用acltdtReceiveTensor接口接收数据时，用户线程可能在没有数据时会卡住，此时如果需要退出的话，需要先将线程唤醒，该接口用于唤醒处于阻塞状态的线程。需要用户在发送、接收线程之外的一个线程里调用这个函数，来唤醒处于阻塞状态的发送/接收线程。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtDestroyChannel"></a>

## acltdtDestroyChannel

```c
aclError acltdtDestroyChannel(acltdtChannelHandle *handle)
```

### 产品支持情况

<!-- npu="950" id792 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id792 -->
<!-- npu="A3" id793 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id793 -->
<!-- npu="910b" id794 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id794 -->
<!-- npu="310b" id795 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id795 -->
<!-- npu="310p" id796 -->
- Atlas 推理系列产品：不支持
<!-- end id796 -->
<!-- npu="910" id797 -->
- Atlas 训练系列产品：支持
<!-- end id797 -->
<!-- npu="IPV350" id798 -->
- IPV350：不支持
<!-- end id798 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id6 -->

### 功能说明

销毁acltdtChannelHandle类型的数据，只能销毁通过[acltdtCreateChannel](#acltdtCreateChannel)接口或[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建的acltdtChannelHandle类型。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 待销毁的acltdtChannelHandle类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtQueryChannelSize"></a>

## acltdtQueryChannelSize

```c
aclError acltdtQueryChannelSize(const acltdtChannelHandle *handle, size_t *size)
```

### 产品支持情况

<!-- npu="950" id2178 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2178 -->
<!-- npu="A3" id2179 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2179 -->
<!-- npu="910b" id2180 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2180 -->
<!-- npu="310b" id2181 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2181 -->
<!-- npu="310p" id2182 -->
- Atlas 推理系列产品：不支持
<!-- end id2182 -->
<!-- npu="910" id2183 -->
- Atlas 训练系列产品：支持
<!-- end id2183 -->
<!-- npu="IPV350" id2184 -->
- IPV350：不支持
<!-- end id2184 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id7 -->

### 功能说明

查询队列通道内的消息数量。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |
| size | 输出 | 消息数量的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtGetSliceInfoFromItem"></a>

## acltdtGetSliceInfoFromItem

```c
aclError acltdtGetSliceInfoFromItem(const acltdtDataItem *dataItem, size_t *sliceNum, size_t* sliceId)
```

### 产品支持情况

<!-- npu="950" id2871 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2871 -->
<!-- npu="A3" id2872 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2872 -->
<!-- npu="910b" id2873 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2873 -->
<!-- npu="310b" id2874 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2874 -->
<!-- npu="310p" id2875 -->
- Atlas 推理系列产品：不支持
<!-- end id2875 -->
<!-- npu="910" id2876 -->
- Atlas 训练系列产品：支持
<!-- end id2876 -->
<!-- npu="IPV350" id2877 -->
- IPV350：不支持
<!-- end id2877 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id8 -->

### 功能说明

用于输出Tensor分片信息。

**使用场景：**OutfeedEnqueueOpV2算子由于其功能要求需申请Device上的大块内存存放数据，在Device内存不足时，可能会导致内存申请失败，进而导致某些算子无法正常执行，该场景下，用户可以调用本接口获取Tensor分片信息（分片数量、分片索引），再根据分片信息拼接算子的Tensor数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。acltdtDataItem用于标识一个业务上的Tensor。类型定义请参见[acltdtDataItem](25-03_Operation_APIs.md#acltdtDataItem)。<br>需提前调用[acltdtCreateDataItem](25-03_Operation_APIs.md#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |
| sliceNum | 输出 | 单个Tensor被切片的数量。 |
| sliceId | 输出 | 被切片Tensor的数据段索引。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="acltdtCleanChannel"></a>

## acltdtCleanChannel

```c
aclError acltdtCleanChannel(acltdtChannelHandle *handle)
```

### 产品支持情况

<!-- npu="950" id2451 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2451 -->
<!-- npu="A3" id2452 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2452 -->
<!-- npu="910b" id2453 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2453 -->
<!-- npu="310b" id2454 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2454 -->
<!-- npu="310p" id2455 -->
- Atlas 推理系列产品：不支持
<!-- end id2455 -->
<!-- npu="910" id2456 -->
- Atlas 训练系列产品：支持
<!-- end id2456 -->
<!-- npu="IPV350" id2457 -->
- IPV350：不支持
<!-- end id2457 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id9 -->

### 功能说明

清空通道中的所有数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity)接口创建acltdtChannelHandle类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
