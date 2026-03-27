# aclrtMemAllocManaged

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

申请统一虚拟内存（Unified Virtual Memory, UVM），通过\*ptr返回已申请内存的指针，且申请的内存大小会根据用户指定的size向上按2M对齐。使用本接口申请的内存，若需释放内存，需调用[aclrtFree](aclrtFree.md)接口。

通过本接口申请的内存仅在实际访问时才会建立虚拟内存到物理内存的页表映射关系。如果内存访问发生在Host上，则映射Host的物理内存；如果内存访问发生在Device上，则映射Device的物理内存。后续使用该内存时，每当访问内存的对象发生变更，例如，从Host变更为Device，从一个Device变更为另一个Device等，在新的访问对象上会触发缺页中断，需要将内存数据迁移到新的访问对象上，并重新建立虚拟内存到物理内存的页表映射关系，此时前一个访问对象上的页表映射关系将失效、物理内存也会释放。若频繁的更换访问对象，则会频繁触发缺页中断、频繁迁移内存数据和重新建立页表映射关系，影响性能。

## 函数原型

```
aclError aclrtMemAllocManaged(void **ptr, uint64_t size, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输出 | “已分配内存的指针”的指针，由于Host和Device虚拟地址统一编址，该参数不区分申请位置。 |
| size | 输入 | 内存大小，单位Byte。<br>size不能为0，单个应用进程最大可申请3T UVM类型的虚拟内存。 |
| flag | 输入 | 内存标识。<br>当前flag仅支持设置为ACL_RT_MEM_ATTACH_GLOBAL，所对应数值为1。设置为ACL_RT_MEM_ATTACH_GLOBAL后，通过本接口申请的内存在Device和Host侧都可以被访问。<br>宏定义如下：<br>#define ACL_RT_MEM_ATTACH_GLOBAL (0x01U) |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

本接口分配的内存不会进行对内容进行初始化，建议在使用内存前先调用[aclrtMemset](aclrtMemset.md)接口先初始化内存，清除内存中的随机数。

