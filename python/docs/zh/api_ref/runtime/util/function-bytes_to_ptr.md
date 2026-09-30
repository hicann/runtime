# 函数：bytes\_to\_ptr

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

将bytes对象转换成为void\*数据，可以将转换好的数据传递给C函数直接使用。

## 函数原型

```python
ptr = acl.util.bytes_to_ptr(data)
```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data | bytes类型数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ptr | int，可以被C语言访问的数据。 |

## 约束说明

该函数输入的生命周期需要大于输出的生命周期，否则可能会产生未定义行为。

## 注意事项

修改示例如下：

```python
bytes_in = np_arr_in.tobytes()
bytes_ptr = acl.util.bytes_to_ptr(bytes_in)
```
