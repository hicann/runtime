# 10. Label管理

本章节描述 CANN Runtime 的 Label 管理接口，用于 Label 的创建、设置、销毁及条件分支控制。

- [`aclError aclrtCreateLabel(aclrtLabel *label)`](#aclrtCreateLabel)：创建标签。每个进程最多创建65535个标签。
- [`aclError aclrtSetLabel(aclrtLabel label, aclrtStream stream)`](#aclrtSetLabel)：在Stream上设置标签。
- [`aclError aclrtDestroyLabel(aclrtLabel label)`](#aclrtDestroyLabel)：销毁标签。
- [`aclError aclrtCreateLabelList(aclrtLabel *labels, size_t num, aclrtLabelList *labelList)`](#aclrtCreateLabelList)：创建标签列表。
- [`aclError aclrtDestroyLabelList(aclrtLabelList labelList)`](#aclrtDestroyLabelList)：销毁标签列表。
- [`aclError aclrtSwitchLabelByIndex(void *ptr, uint32_t maxValue, aclrtLabelList labelList, aclrtStream stream)`](#aclrtSwitchLabelByIndex)：根据标签索引跳转到相应的标签位置，执行该标签所在Stream上的任务，同时当前Stream上的任务停止执行。异步接口。


<a id="aclrtCreateLabel"></a>

# aclrtCreateLabel

```c
aclError aclrtCreateLabel(aclrtLabel *label)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建标签。每个进程最多创建65535个标签。

调用本接口创建标签后，再依次配合[aclrtCreateLabelList](#aclrtCreateLabelList)接口（创建标签列表）、[aclrtSetLabel](#aclrtSetLabel)接口（在Stream上设置标签）、[aclrtSwitchLabelByIndex](#aclrtSwitchLabelByIndex)接口（跳转到指定Stream）使用，实现Stream之间的跳转。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| label | 输出 | 标签的指针。类型定义请参见[aclrtLabel](24_数据类型及其操作接口.md#aclrtLabel)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSetLabel"></a>

# aclrtSetLabel

```c
aclError aclrtSetLabel(aclrtLabel label, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在Stream上设置标签。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| label | 输入 | 标签。类型定义请参见[aclrtLabel](24_数据类型及其操作接口.md#aclrtLabel)。<br>通过aclrtCreateLabel接口创建的标签作为此处的输入。 |
| stream | 输入 | 需设置标签的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>此处只支持通过[aclmdlRIBindStream](15_模型运行实例管理.md#aclmdlRIBindStream)接口绑定过模型运行实例的Stream。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtDestroyLabel"></a>

# aclrtDestroyLabel

```c
aclError aclrtDestroyLabel(aclrtLabel label)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁标签。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| label | 输入 | 通过[aclrtCreateLabel](#aclrtCreateLabel)接口创建的标签。类型定义请参见[aclrtLabel](24_数据类型及其操作接口.md#aclrtLabel)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCreateLabelList"></a>

# aclrtCreateLabelList

```c
aclError aclrtCreateLabelList(aclrtLabel *labels, size_t num, aclrtLabelList *labelList)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建标签列表。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| labels | 输入 | 标签数组。类型定义请参见[aclrtLabel](24_数据类型及其操作接口.md#aclrtLabel)。<br>数组中的标签需通过[aclrtCreateLabel](#aclrtCreateLabel)接口创建。 |
| num | 输入 | 标签数组长度，取值(0, 65535]。 |
| labelList | 输出 | 标签列表。类型定义请参见[aclrtLabelList](24_数据类型及其操作接口.md#aclrtLabelList)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtDestroyLabelList"></a>

# aclrtDestroyLabelList

```c
aclError aclrtDestroyLabelList(aclrtLabelList labelList)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁标签列表。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| labelList | 输入 | 通过接口创建的标签列表。类型定义请参见[aclrtLabelList](24_数据类型及其操作接口.md#aclrtLabelList)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSwitchLabelByIndex"></a>

# aclrtSwitchLabelByIndex

```c
aclError aclrtSwitchLabelByIndex(void *ptr, uint32_t maxValue, aclrtLabelList labelList, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据标签索引跳转到相应的标签位置，执行该标签所在Stream上的任务，同时当前Stream上的任务停止执行。异步接口。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ptr | 输入 | 标签索引。<br>存放目标标签索引值的Device内存地址，索引值的数据类型uint32，长度4字节，索引值从0开始。<br>当目标标签索引大于labelList数组的最大索引值时，跳转到最大标签。 |
| maxValue | 输入 | 标签列表中的标签个数。 |
| labelList | 输入 | 标签列表。类型定义请参见[aclrtLabelList](24_数据类型及其操作接口.md#aclrtLabelList)。<br>通过[aclrtCreateLabelList](#aclrtCreateLabelList)接口创建的标签列表作为此处的输入。 |
| stream | 输入 | 执行跳转任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。
