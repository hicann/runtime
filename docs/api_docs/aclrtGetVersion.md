# aclrtGetVersion

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询接口版本号，acl接口版本号命名采用：A.B.C模式，其中，A表示有不兼容修改，B表示新增接口，C表示bug修复。

## 函数原型

```
aclError aclrtGetVersion(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| majorVersion | 输出 | 主版本号的指针，从1开始，如果出现接口的不兼容变更时，加1。 |
| minorVersion | 输出 | 次版本号的指针，从0开始，按照迭代周期，有新增接口时加1。 |
| patchVersion | 输出 | 补丁版本号的指针，从0开始，表示本版本仅解决了问题。<br>在majorVersion、minorVersion不变的情况下加1；但majorVersion、minorVersion增加的时候，patchVersion一般为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

