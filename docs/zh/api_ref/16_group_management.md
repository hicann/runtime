# 16. 算力Group查询与设置

本章节描述 CANN Runtime 的算力 Group 接口，用于 AI Core 分组的设置、查询及信息获取。

- [`aclError aclrtSetGroup(int32_t groupId)`](#aclrtSetGroup)：指定当前运算使用哪个Group的算力，该接口必须在指定Context后调用。
- [`aclError aclrtGetGroupCount(uint32_t *count)`](#aclrtGetGroupCount)：查询当前Context下可以使用的Group个数。
- [`aclError aclrtGetAllGroupInfo(aclrtGroupInfo *groupInfo)`](#aclrtGetAllGroupInfo)：查询当前Context下可以使用的所有Group的详细算力信息。
- [`aclError aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize)`](#aclrtGetGroupInfoDetail)：查询当前Context下指定Group的算力信息。
- [`aclrtGroupInfo *aclrtCreateGroupInfo()`](#aclrtCreateGroupInfo)：根据实际支持的Group数量创建aclrtGroupInfo类型的连续内存块，并返回对应指针。
- [`aclError aclrtDestroyGroupInfo(aclrtGroupInfo *groupInfo)`](#aclrtDestroyGroupInfo)：销毁aclrtGroupInfo类型的数据，释放相关的内存。

<a id="aclrtSetGroup"></a>

## aclrtSetGroup

```c
aclError aclrtSetGroup(int32_t groupId)
```

### 产品支持情况

<!-- npu="950" id190 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id190 -->
<!-- npu="A3" id191 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id191 -->
<!-- npu="910b" id192 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id192 -->
<!-- npu="310b" id193 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id193 -->
<!-- npu="310p" id194 -->
- Atlas 推理系列产品：支持
<!-- end id194 -->
<!-- npu="910" id195 -->
- Atlas 训练系列产品：不支持
<!-- end id195 -->
<!-- npu="IPV350" id196 -->
- IPV350：不支持
<!-- end id196 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id1 -->

### 功能说明

指定当前运算使用哪个Group的算力，该接口必须在指定Context后调用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| groupId | 输入 | 表示Group的ID，用于指定当前计算要使用的Group。<br>您需要提前调用[aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail)接口获取Group的ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310p" id1 -->
### 约束说明

仅支持在Atlas 推理系列产品的Control CPU开放形态下调用本接口。不支持在Atlas 推理系列产品Ascend EP形态下调用本接口。

**acl接口调用顺序**：调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口指定计算设备--\>调用[aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo)接口获取所有Group信息--\>调用[aclrtGetGroupCount](#aclrtGetGroupCount)接口获取Group数量--\>调用[aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail)接口获取指定Group信息--\>调用[aclrtSetGroup](#aclrtSetGroup)接口设置分组--\>执行其它任务--\>调用[aclrtResetDevice](04_device_management.md#aclrtResetDevice)接口释放计算设备。

在调用acl接口设置算力Group前，需先调用驱动提供的DCMI接口dcmi\_create\_capability\_group创建分组。若刷新分组（例如调用dcmi\_create\_capability\_group接口新增分组、调用dcmi\_delete\_capability\_group接口删除分组等），需重启业务进程。
<!-- end id1 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id7 -->

<br>
<br>
<br>

<a id="aclrtGetGroupCount"></a>

## aclrtGetGroupCount

```c
aclError  aclrtGetGroupCount(uint32_t *count)
```

### 产品支持情况

<!-- npu="950" id694 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id694 -->
<!-- npu="A3" id695 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id695 -->
<!-- npu="910b" id696 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id696 -->
<!-- npu="310b" id697 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id697 -->
<!-- npu="310p" id698 -->
- Atlas 推理系列产品：支持
<!-- end id698 -->
<!-- npu="910" id699 -->
- Atlas 训练系列产品：不支持
<!-- end id699 -->
<!-- npu="IPV350" id700 -->
- IPV350：不支持
<!-- end id700 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id2 -->

### 功能说明

查询当前Context下可以使用的Group个数。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| count | 输出 | 当前Context下可用Group个数的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310p" id2 -->
### 约束说明

仅支持在Atlas 推理系列产品的Control CPU开放形态下调用本接口。不支持在Atlas 推理系列产品Ascend EP形态下调用本接口。

**acl接口调用顺序**：调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口指定计算设备--\>调用[aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo)接口获取所有Group信息--\>调用[aclrtGetGroupCount](#aclrtGetGroupCount)接口获取Group数量--\>调用[aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail)接口获取指定Group信息--\>调用[aclrtSetGroup](#aclrtSetGroup)接口设置分组--\>执行其它任务--\>调用[aclrtResetDevice](04_device_management.md#aclrtResetDevice.接口释放计算设备。

在调用acl接口设置算力Group前，需先调用驱动提供的DCMI接口dcmi\_create\_capability\_group创建分组。若刷新分组（例如调用dcmi\_create\_capability\_group接口新增分组、调用dcmi\_delete\_capability\_group接口删除分组等），需重启业务进程。
<!-- end id2 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id8 -->

<br>
<br>
<br>

<a id="aclrtGetAllGroupInfo"></a>

## aclrtGetAllGroupInfo

```c
aclError  aclrtGetAllGroupInfo(aclrtGroupInfo *groupInfo)
```

### 产品支持情况

<!-- npu="950" id1261 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id1261 -->
<!-- npu="A3" id1262 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id1262 -->
<!-- npu="910b" id1263 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id1263 -->
<!-- npu="310b" id1264 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1264 -->
<!-- npu="310p" id1265 -->
- Atlas 推理系列产品：支持
<!-- end id1265 -->
<!-- npu="910" id1266 -->
- Atlas 训练系列产品：不支持
<!-- end id1266 -->
<!-- npu="IPV350" id1267 -->
- IPV350：不支持
<!-- end id1267 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id3 -->

### 功能说明

查询当前Context下可以使用的所有Group的详细算力信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| groupInfo | 输出 | 获取所有Group对应的详细算力信息的指针。<br>需提前调用[aclrtCreateGroupInfo](#aclrtCreateGroupInfo)接口创建aclrtGroupInfo类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310p" id3 -->
### 约束说明

仅支持在Atlas 推理系列产品的Control CPU开放形态下调用本接口。不支持在Atlas 推理系列产品Ascend EP形态下调用本接口。

**acl接口调用顺序**：调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口指定计算设备--\>调用[aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo)接口获取所有Group信息--\>调用[aclrtGetGroupCount](#aclrtGetGroupCount)接口获取Group数量--\>调用[aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail)接口获取指定Group信息--\>调用[aclrtSetGroup](#aclrtSetGroup)接口设置分组--\>执行其它任务--\>调用[aclrtResetDevice](04_device_management.md#aclrtResetDevice)接口释放计算设备。

在调用acl接口设置算力Group前，需先调用驱动提供的DCMI接口dcmi\_create\_capability\_group创建分组。若刷新分组（例如调用dcmi\_create\_capability\_group接口新增分组、调用dcmi\_delete\_capability\_group接口删除分组等），需重启业务进程。
<!-- end id3 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id9 -->

<br>
<br>
<br>

<a id="aclrtGetGroupInfoDetail"></a>

## aclrtGetGroupInfoDetail

```c
aclError  aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize)
```

### 产品支持情况

<!-- npu="950" id890 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id890 -->
<!-- npu="A3" id891 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id891 -->
<!-- npu="910b" id892 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id892 -->
<!-- npu="310b" id893 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id893 -->
<!-- npu="310p" id894 -->
- Atlas 推理系列产品：支持
<!-- end id894 -->
<!-- npu="910" id895 -->
- Atlas 训练系列产品：不支持
<!-- end id895 -->
<!-- npu="IPV350" id896 -->
- IPV350：不支持
<!-- end id896 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id4 -->

### 功能说明

查询当前Context下指定Group的算力信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| groupInfo | 输入 | 指定算力详细信息的首地址的指针。<br>需提前调用[aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo)接口获取所有Group的算力信息。 |
| groupIndex | 输入 | 访问groupInfo连续内存块的Group索引。<br>Group索引的取值范围：[0, (Group数量-1)]，用户可调用[aclrtGetGroupCount](#aclrtGetGroupCount)接口获取Group数量。 |
| attr | 输入 | 指定要获取其算力值的算力属性。类型定义请参见[aclrtGroupAttr](25-02_Enumerations.md#aclrtGroupAttr)。 |
| attrValue | 输出 | 获取指定算力属性所对应的算力值的指针。<br>用户需根据每个属性的属性值数据类型申请对应大小的内存，用于存放属性值。 |
| valueLen | 输入 | 表示attrValue的最大长度，单位为Byte。 |
| paramRetSize | 输出 | 实际返回的attrValue大小的指针，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310p" id4 -->
### 约束说明

仅支持在Atlas 推理系列产品的Control CPU开放形态下调用本接口。不支持在Atlas 推理系列产品Ascend EP形态下调用本接口。

**acl接口调用顺序**：调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口指定计算设备--\>调用[aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo)接口获取所有Group信息--\>调用[aclrtGetGroupCount](#aclrtGetGroupCount)接口获取Group数量--\>调用[aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail)接口获取指定Group信息--\>调用[aclrtSetGroup](#aclrtSetGroup)接口设置分组--\>执行其它任务--\>调用[aclrtResetDevice](04_device_management.md#aclrtResetDevice)接口释放计算设备。

在调用acl接口设置算力Group前，需先调用驱动提供的DCMI接口dcmi\_create\_capability\_group创建分组。若刷新分组（例如调用dcmi\_create\_capability\_group接口新增分组、调用dcmi\_delete\_capability\_group接口删除分组等），需重启业务进程。
<!-- end id4 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id10 -->

<br>
<br>
<br>

<a id="aclrtCreateGroupInfo"></a>

## aclrtCreateGroupInfo

```c
aclrtGroupInfo *aclrtCreateGroupInfo()
```

### 产品支持情况

<!-- npu="950" id2346 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2346 -->
<!-- npu="A3" id2347 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2347 -->
<!-- npu="910b" id2348 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2348 -->
<!-- npu="310b" id2349 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2349 -->
<!-- npu="310p" id2350 -->
- Atlas 推理系列产品：支持
<!-- end id2350 -->
<!-- npu="910" id2351 -->
- Atlas 训练系列产品：不支持
<!-- end id2351 -->
<!-- npu="IPV350" id2352 -->
- IPV350：不支持
<!-- end id2352 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id5 -->

### 功能说明

根据实际支持的Group数量创建aclrtGroupInfo类型的连续内存块，并返回对应指针。

如需销毁aclrtGroupInfo类型的数据，请参见[aclrtDestroyGroupInfo](#aclrtDestroyGroupInfo)。

### 参数说明

无

### 返回值说明

返回aclrtGroupInfo类型的指针，如果无Group或不支持Group则返回nullptr。

<!-- npu="310p" id5 -->
### 约束说明

仅支持在Atlas 推理系列产品的Control CPU开放形态下调用本接口。不支持在Atlas 推理系列产品Ascend EP形态下调用本接口。
<!-- end id5 -->

<br>
<br>
<br>

<a id="aclrtDestroyGroupInfo"></a>

## aclrtDestroyGroupInfo

```c
aclError aclrtDestroyGroupInfo(aclrtGroupInfo *groupInfo)
```

### 产品支持情况

<!-- npu="950" id1765 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id1765 -->
<!-- npu="A3" id1766 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id1766 -->
<!-- npu="910b" id1767 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id1767 -->
<!-- npu="310b" id1768 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1768 -->
<!-- npu="310p" id1769 -->
- Atlas 推理系列产品：支持
<!-- end id1769 -->
<!-- npu="910" id1770 -->
- Atlas 训练系列产品：不支持
<!-- end id1770 -->
<!-- npu="IPV350" id1771 -->
- IPV350：不支持
<!-- end id1771 -->
<!-- @ref: runtime/res/docs/zh/api_ref/16_group_management_res.md#id6 -->

### 功能说明

销毁aclrtGroupInfo类型的数据，释放相关的内存。只能销毁通过[aclrtCreateGroupInfo](#aclrtCreateGroupInfo)接口创建的aclrtGroupInfo类型。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| groupInfo | 输入 | 待销毁的aclrtGroupInfo类型数据的指针。 |

### 返回值说明

返回0表示成功，非零表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310p" id6 -->
### 约束说明

仅支持在Atlas 推理系列产品的Control CPU开放形态下调用本接口。不支持在Atlas 推理系列产品Ascend EP形态下调用本接口。
<!-- end id6 -->
