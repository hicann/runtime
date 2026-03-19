# aclrtMemAllocManaged

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

申请size大小的统一虚拟内存（Unified Virtual Memory, UVM），并通过\*ptr返回已申请内存的指针。

本接口申请的内存会根据用户指定的size，将申请的内存大小向上按2M对齐。

通过本接口申请的内存，需要通过[aclrtFree](aclrtFree.md)接口释放内存。

## 函数原型

```
aclError aclrtMemAllocManaged(void **ptr, uint64_t size, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输出 | “已分配内存的指针”的指针，由于Host侧和Device侧虚拟地址统一编址，该参数不区分申请位置。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0，单个应用进程最大可申请3T UVM类型虚拟内存。 |
| flag | 输入 | 申请内存的标识。<br>当前flag仅支持设置为ACL_RT_MEM_ATTACH_GLOBAL，所对应数值为1。设置ACL_RT_MEM_ATTACH_GLOBAL时，通过本接口申请的内存在Device和Host侧都可以被访问。<br>宏定义如下：<br>#define ACL_RT_MEM_ATTACH_GLOBAL  (0x01U)|

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

本接口分配的内存不会进行对内容进行初始化，建议在使用内存前先调用[aclrtMemset](aclrtMemset.md)接口先初始化内存，清除内存中的随机数。
