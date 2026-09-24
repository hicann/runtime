# 函数：numpy\_contiguous\_to\_ptr

>[!NOTE] 须知
>该接口即将废弃，建议使用[acl.util.bytes\_to\_ptr](function-bytes_to_ptr.md)接口。

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

获取numpy.ndarray数组的内存数据指针地址。

若传入的numpy.ndarray数组在内存上是非行连续的，则先将其内存转为行连续，然后再获取转换后的numpy.ndarray数组转换成为内存数据指针地址。

## 函数原型

```python
ptr, data_out = acl.util.numpy_contiguous_to_ptr(data_in)
```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data_in | numpy类型数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ptr | int，可以被C语言访问的数据。 |
| data_out | numpy类型数据，若传入的numpy数组“data_in”内存非行连续，则返回值“data_out”即为其内存转为行连续后的numpy数组。 |

## 约束说明

访问的是int类型的数据，需要将numpy.ndarray对象的内存数据指针地址转换为int。

## 注意事项

- 修改示例如下：

    ```python
    np_ptr, data_out = acl.util.numpy_contiguous_to_ptr(np_arr_in)
    ```

    修改后使用：

    ```python
    bytes_in = np_arr_in.tobytes()
    bytes_ptr = acl.util.bytes_to_ptr(bytes_in)
    ```

- 若要继续使用该接口，需要运行环境为python≥3.8且numpy≥1.22.0。
- 使用本函数返回的指针地址前，需要确保传入的numpy.ndarray对象生命周期还没有结束（没有被删除或被Python的GC回收），否则将会产生未定义行为。
