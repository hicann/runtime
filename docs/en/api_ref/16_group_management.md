# 16. Computing Power Group Query and Settings

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:27:33.786Z pushedAt=2026-11-09T09:20:26.188Z nl=2 -->

This section describes CANN Runtime's computing power group APIs, which are used to set, query, and obtain information about AI Core groups.

- [`aclError aclrtSetGroup(int32_t groupId)`](#aclrtSetGroup): Specifies which group's computing power is used for the current operation. This API must be called after the context is specified.
- [`aclError aclrtGetGroupCount(uint32_t *count)`](#aclrtGetGroupCount): Queries the number of groups available in the current context.
- [`aclError aclrtGetAllGroupInfo(aclrtGroupInfo *groupInfo)`](#aclrtGetAllGroupInfo): Queries the detailed computing power information of all groups available in the current context.
- [`aclError aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize)`](#aclrtGetGroupInfoDetail): Queries the computing power information of a specified group in the current context.
- [`aclrtGroupInfo *aclrtCreateGroupInfo()`](#aclrtCreateGroupInfo): Creates a contiguous memory block of the aclrtGroupInfo type based on the number of groups actually supported, and returns the corresponding pointer.
- [`aclError aclrtDestroyGroupInfo(aclrtGroupInfo *groupInfo)`](#aclrtDestroyGroupInfo): Destroys data of the aclrtGroupInfo type and releases the associated memory.

<a class="method_anchor" id="aclrtSetGroup"></a>

## aclrtSetGroup

```c
aclError aclrtSetGroup(int32_t groupId)
```

### Applicable Products

<!-- npu="950" id190 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id190 -->
<!-- npu="A3" id191 -->
- Atlas A3 products: Not supported
<!-- end id191 -->
<!-- npu="910b" id192 -->
- Atlas A2 products: Not supported
<!-- end id192 -->
<!-- npu="310b" id193 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id193 -->
<!-- npu="310p" id194 -->
- Atlas inference products: Supported
<!-- end id194 -->
<!-- npu="910" id195 -->
- Atlas training products: Not supported
<!-- end id195 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id1 -->

### Function

Specifies which group's computing power is used for the current computation. This API must be called after a context is specified.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| groupId | Input | ID of the group, used to specify the group for the current computation.<br>You need to call the [aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail) API in advance to obtain the group ID. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310p" id1 -->
### Constraints

This API can be called only in the control CPU open form of Atlas inference products. It cannot be called in the Ascend EP form of Atlas inference products.

**acl API call sequence**: Call [aclrtSetDevice](04_device_management.md#aclrtSetDevice) to specify the computing device --\> call [aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo) to obtain all group information --\> call [aclrtGetGroupCount](#aclrtGetGroupCount) to obtain the number of groups --\> call [aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail) to obtain the information of a specified group --\> call [aclrtSetGroup](#aclrtSetGroup) to set the group --\> execute other tasks --\> call [aclrtResetDevice](04_device_management.md#aclrtResetDevice) to release the computing device.

Before calling the acl API to set a computing power group, you must first call the driver-provided DCMI API dcmi\_create\_capability\_group to create a group. If groups are updated (for example, adding a group by calling dcmi\_create\_capability\_group, or deleting a group by calling dcmi\_delete\_capability\_group), you must restart the service process.
<!-- end id1 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id7 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetGroupCount"></a>

## aclrtGetGroupCount

```c
aclError  aclrtGetGroupCount(uint32_t *count)
```

### Applicable Products

<!-- npu="950" id694 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id694 -->
<!-- npu="A3" id695 -->
- Atlas A3 products: Not supported
<!-- end id695 -->
<!-- npu="910b" id696 -->
- Atlas A2 products: Not supported
<!-- end id696 -->
<!-- npu="310b" id697 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id697 -->
<!-- npu="310p" id698 -->
- Atlas inference products: Supported
<!-- end id698 -->
<!-- npu="910" id699 -->
- Atlas training products: Not supported
<!-- end id699 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id2 -->

### Function

Queries the number of groups available in the current context.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| count | Output | Pointer to the number of groups available in the current context. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310p" id2 -->
### Constraints

This API can be called only in the control CPU open form of Atlas inference products. It cannot be called in the Ascend EP form of Atlas inference products.

**acl API call sequence**: Call [aclrtSetDevice](04_device_management.md#aclrtSetDevice) to specify the computing device --\> call [aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo) to obtain all group information --\> call [aclrtGetGroupCount](#aclrtGetGroupCount) to obtain the number of groups --\> call [aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail) to obtain the information of a specified group --\> call [aclrtSetGroup](#aclrtSetGroup) to set the group --\> execute other tasks --\> call [aclrtResetDevice](04_device_management.md#aclrtResetDevice) to release the computing device.

Before calling the acl API to set a computing power group, you must first call the driver-provided DCMI API dcmi\_create\_capability\_group to create a group. If groups are updated (for example, adding a group by calling dcmi\_create\_capability\_group, or deleting a group by calling dcmi\_delete\_capability\_group), you must restart the service process.
<!-- end id2 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id8 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetAllGroupInfo"></a>

## aclrtGetAllGroupInfo

```c
aclError  aclrtGetAllGroupInfo(aclrtGroupInfo *groupInfo)
```

### Applicable Products

<!-- npu="950" id1261 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1261 -->
<!-- npu="A3" id1262 -->
- Atlas A3 products: Not supported
<!-- end id1262 -->
<!-- npu="910b" id1263 -->
- Atlas A2 products: Not supported
<!-- end id1263 -->
<!-- npu="310b" id1264 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1264 -->
<!-- npu="310p" id1265 -->
- Atlas inference products: Supported
<!-- end id1265 -->
<!-- npu="910" id1266 -->
- Atlas training products: Not supported
<!-- end id1266 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id3 -->

### Function

Queries the detailed computing power information of all groups available in the current context.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| groupInfo | Output | Pointer to the detailed computing power information of all groups.<br>Call the [aclrtCreateGroupInfo](#aclrtCreateGroupInfo) API in advance to create data of the aclrtGroupInfo type. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310p" id3 -->
### Constraints

This API can be called only in the control CPU open form of Atlas inference products. It cannot be called in the Ascend EP form of Atlas inference products.

**acl API call sequence**: Call [aclrtSetDevice](04_device_management.md#aclrtSetDevice) to specify the computing device --\> call [aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo) to obtain all group information --\> call [aclrtGetGroupCount](#aclrtGetGroupCount) to obtain the number of groups --\> call [aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail) to obtain the information of a specified group --\> call [aclrtSetGroup](#aclrtSetGroup) to set the group --\> execute other tasks --\> call [aclrtResetDevice](04_device_management.md#aclrtResetDevice) to release the computing device.

Before calling the acl API to set a computing power group, you must first call the driver-provided DCMI API dcmi\_create\_capability\_group to create a group. If groups are updated (for example, adding a group by calling dcmi\_create\_capability\_group, or deleting a group by calling dcmi\_delete\_capability\_group), you must restart the service process.
<!-- end id3 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id9 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetGroupInfoDetail"></a>

## aclrtGetGroupInfoDetail

```c
aclError  aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize)
```

### Applicable Products

<!-- npu="950" id890 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id890 -->
<!-- npu="A3" id891 -->
- Atlas A3 products: Not supported
<!-- end id891 -->
<!-- npu="910b" id892 -->
- Atlas A2 products: Not supported
<!-- end id892 -->
<!-- npu="310b" id893 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id893 -->
<!-- npu="310p" id894 -->
- Atlas inference products: Supported
<!-- end id894 -->
<!-- npu="910" id895 -->
- Atlas training products: Not supported
<!-- end id895 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id4 -->

### Function

Queries the computing power information of a specified group in the current context.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| groupInfo | Input | Pointer to the start address of the specified computing power details.<br>Call [aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo) in advance to obtain the computing power information of all groups. |
| groupIndex | Input | group index for accessing the contiguous memory block of groupInfo.<br>The value range of the group index is [0, (number of groups - 1)]. You can call [aclrtGetGroupCount](#aclrtGetGroupCount) to obtain the number of groups. |
| attr | Input | Specifies the computing power attribute whose value is to be obtained. See [aclrtGroupAttr](25-02_Enumerations.md#aclrtGroupAttr) for the type definition. |
| attrValue | Output | Pointer to the computing power value corresponding to the specified computing power attribute.<br>You need to allocate memory of the appropriate size based on the data type of each attribute value to store the attribute value. |
| valueLen | Input | Maximum length of attrValue, in bytes. |
| paramRetSize | Output | Pointer to the actual size of attrValue returned, in bytes. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310p" id4 -->
### Constraints

This API can be called only in the control CPU open form of Atlas inference products. It cannot be called in the Ascend EP form of Atlas inference products.

**acl API call sequence**: Call [aclrtSetDevice](04_device_management.md#aclrtSetDevice) to specify the computing device --\> call [aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo) to obtain all group information --\> call [aclrtGetGroupCount](#aclrtGetGroupCount) to obtain the number of groups --\> call [aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail) to obtain the information of a specified group --\> call [aclrtSetGroup](#aclrtSetGroup) to set the group --\> execute other tasks --\> call [aclrtResetDevice](04_device_management.md#aclrtResetDevice) to release the computing device.

Before calling the acl API to set a computing power group, you must first call the driver-provided DCMI API dcmi\_create\_capability\_group to create a group. If groups are updated (for example, adding a group by calling dcmi\_create\_capability\_group, or deleting a group by calling dcmi\_delete\_capability\_group), you must restart the service process.
<!-- end id4 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id10 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateGroupInfo"></a>

## aclrtCreateGroupInfo

```c
aclrtGroupInfo *aclrtCreateGroupInfo()
```

### Applicable Products

<!-- npu="950" id2346 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2346 -->
<!-- npu="A3" id2347 -->
- Atlas A3 products: Not supported
<!-- end id2347 -->
<!-- npu="910b" id2348 -->
- Atlas A2 products: Not supported
<!-- end id2348 -->
<!-- npu="310b" id2349 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2349 -->
<!-- npu="310p" id2350 -->
- Atlas inference products: Supported
<!-- end id2350 -->
<!-- npu="910" id2351 -->
- Atlas training products: Not supported
<!-- end id2351 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id5 -->

### Function

Creates a contiguous memory block of the aclrtGroupInfo type based on the actual number of supported groups, and returns the corresponding pointer.

To destroy data of the aclrtGroupInfo type, see [aclrtDestroyGroupInfo](#aclrtDestroyGroupInfo).

### Parameters

None

### Return Values

Returns a pointer of the aclrtGroupInfo type, or nullptr if no group exists or groups are not supported.

<!-- npu="310p" id5 -->
### Constraints

This API can be called only in the control CPU open form of Atlas inference products. It cannot be called in the Ascend EP form of Atlas inference products.
<!-- end id5 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyGroupInfo"></a>

## aclrtDestroyGroupInfo

```c
aclError aclrtDestroyGroupInfo(aclrtGroupInfo *groupInfo)
```

### Applicable Products

<!-- npu="950" id1765 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1765 -->
<!-- npu="A3" id1766 -->
- Atlas A3 products: Not supported
<!-- end id1766 -->
<!-- npu="910b" id1767 -->
- Atlas A2 products: Not supported
<!-- end id1767 -->
<!-- npu="310b" id1768 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1768 -->
<!-- npu="310p" id1769 -->
- Atlas inference products: Supported
<!-- end id1769 -->
<!-- npu="910" id1770 -->
- Atlas training products: Not supported
<!-- end id1770 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id6 -->

### Function

Destroys data of the aclrtGroupInfo type and releases the associated memory. Only the aclrtGroupInfo type created by the [aclrtCreateGroupInfo](#aclrtCreateGroupInfo) API can be destroyed.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| groupInfo | Input | Pointer to the aclrtGroupInfo type data to be destroyed. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310p" id6 -->
### Constraints

This API can be called only in the control CPU open form of Atlas inference products. It cannot be called in the Ascend EP form of Atlas inference products.
<!-- end id6 -->
