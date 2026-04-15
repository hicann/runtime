# 9. CntNotify管理

本章节描述 CANN Runtime 的 CntNotify（计数型通知）管理接口，用于 CntNotify 的创建、记录、等待及销毁。

- [`aclError aclrtCntNotifyCreate(aclrtCntNotify *cntNotify, uint64_t flag)`](#aclrtCntNotifyCreate)：创建CntNotify。
- [`aclError aclrtCntNotifyRecord(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo *info)`](#aclrtCntNotifyRecord)：在指定Stream上记录一个CntNotify。异步接口。
- [`aclError aclrtCntNotifyWaitWithTimeout(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo *info)`](#aclrtCntNotifyWaitWithTimeout)：阻塞指定Stream的运行，直到指定的CntNotify完成。异步接口。
- [`aclError aclrtCntNotifyReset(aclrtCntNotify cntNotify, aclrtStream stream)`](#aclrtCntNotifyReset)：复位一个CntNotify，将CntNotify的计数值清空为0。异步接口。
- [`aclError aclrtCntNotifyGetId(aclrtCntNotify cntNotify, uint32_t *notifyId)`](#aclrtCntNotifyGetId)：获取CntNotify的ID。
- [`aclError aclrtCntNotifyDestroy(aclrtCntNotify cntNotify)`](#aclrtCntNotifyDestroy)：销毁CntNotify。


<a id="aclrtCntNotifyCreate"></a>

# aclrtCntNotifyCreate

```c
aclError aclrtCntNotifyCreate(aclrtCntNotify *cntNotify, uint64_t flag)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

创建CntNotify。

CntNotify通常也用于Device与Device之间的状态/动作通信通知。但CntNotify是利用计数值实现任务间的同步，跟Notify的区别是，Notify的计数值仅支持1，CntNotify的计数值支持\[1\~uint32\_t最大值\]。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输出 | CntNotify的指针。类型定义请参见[aclrtCntNotify](25_数据类型及其操作接口.md#aclrtCntNotify)。 |
| flag | 输入 | 预留参数，当前固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCntNotifyRecord"></a>

# aclrtCntNotifyRecord

```c
aclError aclrtCntNotifyRecord(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo *info)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

在指定Stream上记录一个CntNotify。异步接口。

aclrtCntNotifyRecord接口与aclrtCntNotifyWaitWithTimeout接口配合使用时，主要用于多Stream之间同步等待的场景。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | 需记录的CntNotify。类型定义请参见[aclrtCntNotify](25_数据类型及其操作接口.md#aclrtCntNotify)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>如果使用默认Stream，此处设置为NULL。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream1。 |
| info | 输入 | 控制Record的行为模式。类型定义请参见[aclrtCntNotifyRecordInfo](25_数据类型及其操作接口.md#aclrtCntNotifyRecordInfo)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCntNotifyWaitWithTimeout"></a>

# aclrtCntNotifyWaitWithTimeout

```c
aclError aclrtCntNotifyWaitWithTimeout(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo *info)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

阻塞指定Stream的运行，直到指定的CntNotify完成。异步接口。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | 需等待的CntNotify。类型定义请参见[aclrtCntNotify](25_数据类型及其操作接口.md#aclrtCntNotify)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>如果使用默认Stream，此处设置为NULL。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream2。 |
| info | 输入 | 控制Wait的行为模式。类型定义请参见[aclrtCntNotifyWaitInfo](25_数据类型及其操作接口.md#aclrtCntNotifyWaitInfo)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCntNotifyReset"></a>

# aclrtCntNotifyReset

```c
aclError aclrtCntNotifyReset(aclrtCntNotify cntNotify, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

复位一个CntNotify，将CntNotify的计数值清空为0。异步接口。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | CntNotify的指针。类型定义请参见[aclrtCntNotify](25_数据类型及其操作接口.md#aclrtCntNotify)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。<br>如果使用默认Stream，此处设置为NULL。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream2。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCntNotifyGetId"></a>

# aclrtCntNotifyGetId

```c
aclError aclrtCntNotifyGetId(aclrtCntNotify cntNotify, uint32_t *notifyId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

获取CntNotify的ID。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | cntNotify的指针。类型定义请参见[aclrtCntNotify](25_数据类型及其操作接口.md#aclrtCntNotify)。 |
| notifyId | 输出 | cntNotify ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCntNotifyDestroy"></a>

# aclrtCntNotifyDestroy

```c
aclError aclrtCntNotifyDestroy(aclrtCntNotify cntNotify)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

销毁CntNotify。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | CntNotify的指针。类型定义请参见[aclrtCntNotify](25_数据类型及其操作接口.md#aclrtCntNotify)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。
