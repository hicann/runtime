# aclrtGetGroupInfoDetail

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

查询当前Context下指定Group的算力信息。

## 函数原型

```
aclError  aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| groupInfo | 输入 | 指定算力详细信息的首地址的指针。<br>需提前调用[aclrtGetAllGroupInfo](aclrtGetAllGroupInfo.md)接口获取所有Group的算力信息。 |
| groupIndex | 输入 | 访问groupInfo连续内存块的Group索引。<br>Group索引的取值范围：[0, (Group数量-1)]，用户可调用[aclrtGetGroupCount](aclrtGetGroupCount.md)接口获取Group数量。 |
| attr | 输入 | 指定要获取其算力值的算力属性。 |
| attrValue | 输出 | 获取指定算力属性所对应的算力值的指针。<br>用户需根据每个属性的属性值数据类型申请对应大小的内存，用于存放属性值。 |
| valueLen | 输入 | 表示attrValue的最大长度，单位为Byte。 |
| paramRetSize | 输出 | 实际返回的attrValue大小的指针，单位为Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

