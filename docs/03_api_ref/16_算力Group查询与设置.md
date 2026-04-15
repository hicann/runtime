# 16. 算力Group查询与设置

本章节描述 CANN Runtime 的算力 Group 接口，用于 AI Core 分组的设置、查询及信息获取。

- [`aclError aclrtSetGroup(int32_t groupId)`](#aclrtSetGroup)：指定当前运算使用哪个Group的算力，该接口必须在指定Context后调用。
- [`aclError aclrtGetGroupCount(uint32_t *count)`](#aclrtGetGroupCount)：查询当前Context下可以使用的Group个数。
- [`aclError aclrtGetAllGroupInfo(aclrtGroupInfo *groupInfo)`](#aclrtGetAllGroupInfo)：查询当前Context下可以使用的所有Group的详细算力信息。
- [`aclError aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize)`](#aclrtGetGroupInfoDetail)：查询当前Context下指定Group的算力信息。
- [`aclrtGroupInfo *aclrtCreateGroupInfo()`](#aclrtCreateGroupInfo)：根据实际支持的Group数量创建aclrtGroupInfo类型的连续内存块，并返回对应指针。
- [`aclError aclrtDestroyGroupInfo(aclrtGroupInfo *groupInfo)`](#aclrtDestroyGroupInfo)：销毁aclrtGroupInfo类型的数据，释放相关的内存。


<a id="aclrtSetGroup"></a>

# aclrtSetGroup

```c
aclError aclrtSetGroup(int32_t groupId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

指定当前运算使用哪个Group的算力，该接口必须在指定Context后调用。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| groupId | 输入 | 表示Group的ID，用于指定当前计算要使用的Group。<br>您需要提前调用[aclrtGetGroupInfoDetail](#aclrtGetGroupInfoDetail)接口获取Group的ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetGroupCount"></a>

# aclrtGetGroupCount

```c
aclError  aclrtGetGroupCount(uint32_t *count)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

查询当前Context下可以使用的Group个数。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| count | 输出 | 当前Context下可用Group个数的指针。 |


<br>
<br>
<br>



<a id="aclrtGetAllGroupInfo"></a>

# aclrtGetAllGroupInfo

```c
aclError  aclrtGetAllGroupInfo(aclrtGroupInfo *groupInfo)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

查询当前Context下可以使用的所有Group的详细算力信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| groupInfo | 输出 | 获取所有Group对应的详细算力信息的指针。<br>需提前调用[aclrtCreateGroupInfo](#aclrtCreateGroupInfo)接口创建aclrtGroupInfo类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetGroupInfoDetail"></a>

# aclrtGetGroupInfoDetail

```c
aclError  aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

查询当前Context下指定Group的算力信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| groupInfo | 输入 | 指定算力详细信息的首地址的指针。<br>需提前调用[aclrtGetAllGroupInfo](#aclrtGetAllGroupInfo)接口获取所有Group的算力信息。 |
| groupIndex | 输入 | 访问groupInfo连续内存块的Group索引。<br>Group索引的取值范围：[0, (Group数量-1)]，用户可调用[aclrtGetGroupCount](#aclrtGetGroupCount)接口获取Group数量。 |
| attr | 输入 | 指定要获取其算力值的算力属性。类型定义请参见[aclrtGroupAttr](25_数据类型及其操作接口.md#aclrtGroupAttr)。 |
| attrValue | 输出 | 获取指定算力属性所对应的算力值的指针。<br>用户需根据每个属性的属性值数据类型申请对应大小的内存，用于存放属性值。 |
| valueLen | 输入 | 表示attrValue的最大长度，单位为Byte。 |
| paramRetSize | 输出 | 实际返回的attrValue大小的指针，单位为Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCreateGroupInfo"></a>

# aclrtCreateGroupInfo

```c
aclrtGroupInfo *aclrtCreateGroupInfo()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

根据实际支持的Group数量创建aclrtGroupInfo类型的连续内存块，并返回对应指针。

如需销毁aclrtGroupInfo类型的数据，请参见[aclrtDestroyGroupInfo](#aclrtDestroyGroupInfo)。

### 参数说明

无

### 返回值说明

返回aclrtGroupInfo类型的指针，如果无Group或不支持Group则返回nullptr。


<br>
<br>
<br>



<a id="aclrtDestroyGroupInfo"></a>

# aclrtDestroyGroupInfo

```c
aclError aclrtDestroyGroupInfo(aclrtGroupInfo *groupInfo)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

销毁aclrtGroupInfo类型的数据，释放相关的内存。只能销毁通过[aclrtCreateGroupInfo](#aclrtCreateGroupInfo)接口创建的aclrtGroupInfo类型。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| groupInfo | 输入 | 待销毁的aclrtGroupInfo类型数据的指针。 |

### 返回值说明

返回0表示成功，非零表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。
