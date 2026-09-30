# 函数：ptr\_to\_bytes

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

将void\*数据转换为bytes对象，可以使Python代码直接访问。

## 函数原型

```python
bytes_out = acl.util.ptr_to_bytes(ptr, size)
```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| ptr | int，C语言中的指针地址，能够访问的数据的首地址。 |
| size | int，数据的大小，单位Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| bytes_out | bytes对象。 |

## 注意事项

修改示例如下：

```python
bytes_out = acl.util.ptr_to_bytes(bytes_ptr, size)
```

由于**acl.util.ptr\_to\_bytes**会导致数据性能下降，更建议使用函数：[acl.util.bytes\_to\_ptr](function-bytes_to_ptr.md)的数据进行后续运算。
