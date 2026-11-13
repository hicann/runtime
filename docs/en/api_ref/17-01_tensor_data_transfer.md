# 17-01 Tensor Data Transfer

<!-- md-trans-meta sourceCommit=592d153befca8bbb9089ee4e63722c39aabe7552 translatedAt=2026-11-06T11:28:49.601Z pushedAt=2026-11-09T10:30:40.765Z nl=2 -->

This chapter describes the tensor data transfer APIs, which are used to create channels and send and receive tensor data between the host and the device.

- [`acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)`](#acltdtCreateChannel): Creates an acltdtChannelHandle object, which indicates a channel that can be used to send data to the device or receive data from the device.
- [`acltdtChannelHandle *acltdtCreateChannelWithCapacity(uint32_t deviceId, const char *name, size_t capacity)`](#acltdtCreateChannelWithCapacity): Creates an acltdtChannelHandle object, which indicates a channel that can be used to send data to the device or receive data from the device. The channel has a capacity.
- [`aclError acltdtSendTensor(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout)`](#acltdtSendTensor): Sends preprocessed data from the host to the device.
- [`aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)`](#acltdtReceiveTensor): Receives data sent from the device to the host.
- [`aclError acltdtStopChannel(acltdtChannelHandle *handle)`](#acltdtStopChannel): When sending data by calling the acltdtSendTensor API or receiving data by calling the acltdtReceiveTensor API, the user thread may be stuck when there is no data. If the thread needs to exit in this case, it must be woken up first. This API is used to wake up a thread that is in the blocking state.
- [`aclError acltdtDestroyChannel(acltdtChannelHandle *handle)`](#acltdtDestroyChannel): Destroys an acltdtChannelHandle object. Only the acltdtChannelHandle type created by the [acltdtCreateChannel](#acltdtCreateChannel) API or the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API can be destroyed.
- [`aclError acltdtQueryChannelSize(const acltdtChannelHandle *handle, size_t *size)`](#acltdtQueryChannelSize): Queries the number of messages in the queue channel.
- [`aclError acltdtGetSliceInfoFromItem(const acltdtDataItem *dataItem, size_t *sliceNum, size_t* sliceId)`](#acltdtGetSliceInfoFromItem): Outputs tensor shard information.
- [`aclError acltdtCleanChannel(acltdtChannelHandle *handle)`](#acltdtCleanChannel): Clears all data in the channel.

<a class="method_anchor" id="acltdtCreateChannel"></a>

## acltdtCreateChannel

```c
acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)
```

### Applicable Products

<!-- npu="950" id3284 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3284 -->
<!-- npu="A3" id3285 -->
- Atlas A3 products: Not supported
<!-- end id3285 -->
<!-- npu="910b" id3286 -->
- Atlas A2 products: Not supported
<!-- end id3286 -->
<!-- npu="310b" id3287 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3287 -->
<!-- npu="310p" id3288 -->
- Atlas inference products: Not supported
<!-- end id3288 -->
<!-- npu="910" id3289 -->
- Atlas training products: Supported
<!-- end id3289 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id1 -->

### Description

Creates data of the acltdtChannelHandle type, which indicates a channel that can be used to send data to or receive data from the device. After you finish using the channel, call [acltdtStopChannel](#acltdtStopChannel) and then [acltdtDestroyChannel](#acltdtDestroyChannel) in sequence to release the channel resources.

<!-- npu="910" id1 -->
For Atlas training products, this API can be used only in Ascend virtualization instance scenarios.
<!-- end id1 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>After you call [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (number of available devices - 1)]. |
| name | Input | Pointer to the queue channel name. |

### Return Values

- Pointer of the acltdtChannelHandle type: success.
- `nullptr`: failure.

<br>
<br>
<br>

<a class="method_anchor" id="acltdtCreateChannelWithCapacity"></a>

## acltdtCreateChannelWithCapacity

```c
acltdtChannelHandle *acltdtCreateChannelWithCapacity(uint32_t deviceId, const char *name, size_t capacity)
```

### Applicable Products

<!-- npu="950" id2087 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2087 -->
<!-- npu="A3" id2088 -->
- Atlas A3 products: Supported
<!-- end id2088 -->
<!-- npu="910b" id2089 -->
- Atlas A2 products: Supported
<!-- end id2089 -->
<!-- npu="310b" id2090 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2090 -->
<!-- npu="310p" id2091 -->
- Atlas inference products: Not supported
<!-- end id2091 -->
<!-- npu="910" id2092 -->
- Atlas training products: Supported
<!-- end id2092 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id2 -->

### Description

Creates data of the acltdtChannelHandle type, which indicates a channel with a capacity that can be used to send data to or receive data from the device.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>After you call [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (number of available devices - 1)]. |
| name | Input | Pointer to the queue channel name. |
| capacity | Input | Queue channel capacity, ranging from [2, 8192]. |

### Return Values

- Pointer of the acltdtChannelHandle type: success.
- `nullptr`: failure.

<br>
<br>
<br>

<a class="method_anchor" id="acltdtSendTensor"></a>

## acltdtSendTensor

```c
aclError acltdtSendTensor(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id2696 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2696 -->
<!-- npu="A3" id2697 -->
- Atlas A3 products: Supported
<!-- end id2697 -->
<!-- npu="910b" id2698 -->
- Atlas A2 products: Supported
<!-- end id2698 -->
<!-- npu="310b" id2699 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2699 -->
<!-- npu="310p" id2700 -->
- Atlas inference products: Not supported
<!-- end id2700 -->
<!-- npu="910" id2701 -->
- Atlas training products: Supported
<!-- end id2701 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id3 -->

### Description

Sends preprocessed data.

<!-- npu="950,A3,910b,910,310p,310b" id2 -->
Sends preprocessed data from the host to the device.
<!-- end id2 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Specified channel.<br>Call [acltdtCreateChannel](#acltdtCreateChannel) API or the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API in advance to create data of the acltdtChannelHandle type. |
| dataset | Input | Pointer to the data sent to the device. See [acltdtDataset](25-03_Operation_APIs.md#acltdtDataset) for the type definition. |
| timeout | Input | Timeout duration for waiting.<br>For a channel created through the [acltdtCreateChannel](#acltdtCreateChannel) API, only -1 (blocking mode, wait indefinitely) is supported. Passing any other value returns ACL_ERROR_INVALID_PARAM.<br>For a channel created through the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API, the value range of this parameter is as follows:<br>  - -1: blocking mode: wait indefinitely until data sending is complete.<br>  - 0: non-blocking mode. When the channel is full, the channel-full error is returned directly, and the user can set the retry interval.<br>  - >0: specific timeout duration, in milliseconds. When the channel is full, an error is returned after the timeout duration is reached. The timeout duration is affected by the operating system and generally deviates within one time slice of the operating system. For example, if one time slice of the operating system is 4 ms and the user sets the timeout duration to 1 ms, the actual timeout duration ranges from 1 ms to 5 ms. Under high CPU load, the timeout duration may still fluctuate. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtReceiveTensor"></a>

## acltdtReceiveTensor

```c
aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id2206 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2206 -->
<!-- npu="A3" id2207 -->
- Atlas A3 products: Supported
<!-- end id2207 -->
<!-- npu="910b" id2208 -->
- Atlas A2 products: Supported
<!-- end id2208 -->
<!-- npu="310b" id2209 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2209 -->
<!-- npu="310p" id2210 -->
- Atlas inference products: Not supported
<!-- end id2210 -->
<!-- npu="910" id2211 -->
- Atlas training products: Supported
<!-- end id2211 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id4 -->

### Description

Receives data.

<!-- npu="950,A3,910b,910,310p,310b" id4 -->
Receives data sent from the device to the host.
<!-- end id4 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Specified channel.<br>Call the [acltdtCreateChannel](#acltdtCreateChannel) API or the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API in advance to create data of the acltdtChannelHandle type. |
| dataset | Output | Pointer to the received device data. See [acltdtDataset](25-03_Operation_APIs.md#acltdtDataset) for the type definition. |
| timeout | Input | Timeout duration for waiting.<br>For a channel created through the [acltdtCreateChannel](#acltdtCreateChannel) API, only -1 (blocking mode, wait indefinitely) is supported. Passing any other value returns ACL_ERROR_INVALID_PARAM.<br>For a channel created through the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API, the value range of this parameter is as follows:<br>  - -1: blocking mode: wait indefinitely until data reception is complete.<br>  - 0: non-blocking mode. When the channel is empty, the channel-empty error is returned directly, and the user can set the retry interval.<br>  - >0: specific timeout duration, in milliseconds. When the channel is empty, an error is returned after the timeout duration is reached. The timeout duration is affected by the operating system and generally deviates within one time slice of the operating system. For example, if one time slice of the operating system is 4 ms and the user sets the timeout duration to 1 ms, the actual timeout duration ranges from 1 ms to 5 ms. Under high CPU load, the timeout duration may still fluctuate. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtStopChannel"></a>

## acltdtStopChannel

```c
aclError acltdtStopChannel(acltdtChannelHandle *handle)
```

### Applicable Products

<!-- npu="950" id918 -->
- Ascend 950PR&950DT products: Supported
<!-- end id918 -->
<!-- npu="A3" id919 -->
- Atlas A3 products: Supported
<!-- end id919 -->
<!-- npu="910b" id920 -->
- Atlas A2 products: Supported
<!-- end id920 -->
<!-- npu="310b" id921 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id921 -->
<!-- npu="310p" id922 -->
- Atlas inference products: Not supported
<!-- end id922 -->
<!-- npu="910" id923 -->
- Atlas training products: Supported
<!-- end id923 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id5 -->

### Description

When sending data by calling the acltdtSendTensor API or receiving data by calling the acltdtReceiveTensor API, the user thread may be stuck when there is no data. If the thread needs to exit in this case, you must first wake up the thread. This API is used to wake up a thread that is in the blocking state. You need to call this function in a thread other than the sending/receiving thread to wake up the blocked sending/receiving thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Specified channel.<br>Call [acltdtCreateChannel](#acltdtCreateChannel) API or the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API in advance to create data of the acltdtChannelHandle type. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtDestroyChannel"></a>

## acltdtDestroyChannel

```c
aclError acltdtDestroyChannel(acltdtChannelHandle *handle)
```

### Applicable Products

<!-- npu="950" id792 -->
- Ascend 950PR&950DT products: Supported
<!-- end id792 -->
<!-- npu="A3" id793 -->
- Atlas A3 products: Supported
<!-- end id793 -->
<!-- npu="910b" id794 -->
- Atlas A2 products: Supported
<!-- end id794 -->
<!-- npu="310b" id795 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id795 -->
<!-- npu="310p" id796 -->
- Atlas inference products: Not supported
<!-- end id796 -->
<!-- npu="910" id797 -->
- Atlas training products: Supported
<!-- end id797 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id6 -->

### Description

Destroys data of the acltdtChannelHandle type. Only the acltdtChannelHandle type created by the [acltdtCreateChannel](#acltdtCreateChannel) API or the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API can be destroyed.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Pointer to the acltdtChannelHandle to be destroyed. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtQueryChannelSize"></a>

## acltdtQueryChannelSize

```c
aclError acltdtQueryChannelSize(const acltdtChannelHandle *handle, size_t *size)
```

### Applicable Products

<!-- npu="950" id2178 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2178 -->
<!-- npu="A3" id2179 -->
- Atlas A3 products: Supported
<!-- end id2179 -->
<!-- npu="910b" id2180 -->
- Atlas A2 products: Supported
<!-- end id2180 -->
<!-- npu="310b" id2181 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2181 -->
<!-- npu="310p" id2182 -->
- Atlas inference products: Not supported
<!-- end id2182 -->
<!-- npu="910" id2183 -->
- Atlas training products: Supported
<!-- end id2183 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id7 -->

### Description

Queries the number of messages in the queue channel.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Specified channel.<br>Call the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API in advance to create data of the acltdtChannelHandle type. |
| size | Output | Pointer to the message count. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtGetSliceInfoFromItem"></a>

## acltdtGetSliceInfoFromItem

```c
aclError acltdtGetSliceInfoFromItem(const acltdtDataItem *dataItem, size_t *sliceNum, size_t* sliceId)
```

### Applicable Products

<!-- npu="950" id2871 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2871 -->
<!-- npu="A3" id2872 -->
- Atlas A3 products: Supported
<!-- end id2872 -->
<!-- npu="910b" id2873 -->
- Atlas A2 products: Supported
<!-- end id2873 -->
<!-- npu="310b" id2874 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2874 -->
<!-- npu="310p" id2875 -->
- Atlas inference products: Not supported
<!-- end id2875 -->
<!-- npu="910" id2876 -->
- Atlas training products: Supported
<!-- end id2876 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id8 -->

### Description

Outputs tensor shard information.

**Usage scenario:** The OutfeedEnqueueOpV2 operator needs to allocate a large block of memory on the device to store data due to its functional requirements. When device memory is insufficient, memory allocation may fail, which in turn prevents some operators from executing properly. In this scenario, you can call this API to obtain the tensor shard information (shard count and shard index), and then assemble the operator's tensor data based on the shard information.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| dataItem | Input | Pointer to the acltdtDataItem type. acltdtDataItem identifies a tensor in a service. See [acltdtDataItem](25-03_Operation_APIs.md#acltdtDataItem) for the type definition.<br>Call the [acltdtCreateDataItem](25-03_Operation_APIs.md#acltdtCreateDataItem) API in advance to create data of the acltdtDataItem type. |
| sliceNum | Output | Number of shards into which a single tensor is divided. |
| sliceId | Output | Data segment index of the sharded tensor. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtCleanChannel"></a>

## acltdtCleanChannel

```c
aclError acltdtCleanChannel(acltdtChannelHandle *handle)
```

### Applicable Products

<!-- npu="950" id2451 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2451 -->
<!-- npu="A3" id2452 -->
- Atlas A3 products: Supported
<!-- end id2452 -->
<!-- npu="910b" id2453 -->
- Atlas A2 products: Supported
<!-- end id2453 -->
<!-- npu="310b" id2454 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2454 -->
<!-- npu="310p" id2455 -->
- Atlas inference products: Not supported
<!-- end id2455 -->
<!-- npu="910" id2456 -->
- Atlas training products: Supported
<!-- end id2456 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-01_tensor_data_transfer_res.md#id9 -->

### Description

Clears all data in the channel.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Specified channel.<br>Must be called in advance to create data of the acltdtChannelHandle type using the [acltdtCreateChannelWithCapacity](#acltdtCreateChannelWithCapacity) API. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).
