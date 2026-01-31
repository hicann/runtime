# aclrtReserveMemAddressNoUCMemory

**须知：由用户指定起始地址是试验特性，后续版本可能存在变更，不支持应用于商用产品中**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

预留虚拟内存。

本接口与aclrtReserveMemAddress接口的使用方法相同，区别在于：根据环境变量AUTO\_USE\_UC\_MEMORY决定是否允许数据搬移不经过L2 Cache的算子，本接口预留的虚拟内存不能用作此类算子的输入或输出内存，否则可能会导致算子精度问题或异常。AUTO\_USE\_UC\_MEMORY环境变量的详细说明请参见《环境变量参考》。

另外，本接口中的虚拟内存起始地址不支持由系统自动分配，只能由用户指定，且地址建议在40T-224T范围内。

## 函数原型

```
aclError aclrtReserveMemAddressNoUCMemory(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| virPtr | 输出 | “已分配的虚拟内存地址的指针”的指针。 |
| size | 输入 | 虚拟内存大小，单位Byte。<br>size不能为0，只能为1G的整数倍，最小为1G。 |
| alignment | 输入 | 虚拟地址对齐值，预留，当前只能设置为0。 |
| expectPtr | 输入 | 指定期望返回的虚拟内存起始地址。<br>由用户指定起始地址，地址建议在40T-224T范围内。用户需确保指定的地址未被占用，否则预留虚拟内存失败，接口返回错误。 |
| flags | 输入 | 大页/普通页标志，预留参数，建议固定配置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

