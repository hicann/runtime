# 函数：numpy\_to\_ptr

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

## 函数原型

```python
ptr = acl.util.numpy_to_ptr(data)
```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data | numpy.ndarray类型数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ptr | int，numpy数组的内存数据指针地址。 |

## 注意事项

- 若要继续使用该接口，需要运行环境为python ≥ 3.8且numpy ≥ 1.22.0。
- 修改示例如下：

    ```python
    np_ptr = acl.util.numpy_to_ptr(np_arr_in)
    ```

    修改后使用：

    ```python
    bytes_in = np_arr_in.tobytes()
    bytes_ptr = acl.util.bytes_to_ptr(bytes_in)
    ```

- 使用本函数返回的指针地址前，需要确保传入的numpy.ndarray对象生命周期还没有结束（没有被删除或被Python的GC回收），否则将会产生未定义行为。
- 若传入的numpy.ndarray数组在内存上是非行连续的，在接口调用时会打印如下提示信息：

    ```text
    Warning:The input ndarray is discontiguous. Please use acl.util.numpy_contiguous_to_ptr instead.
    ```

    请使用[acl.util.numpy\_contiguous\_to\_ptr](function-numpy_contiguous_to_ptr.md)接口获取numpy数组的地址对象，否则在使用[acl.rt.memcpy](../memory/function-memcpy.md)拷贝数据时，由于[acl.rt.memcpy](../memory/function-memcpy.md)拷贝的是连续内存地址，会导致拷贝的数据和目标拷贝数据不一致的问题。

- 可以通过numpy数组的“flags”属性来查看numpy数组在内存上是否连续：

    ```python
    print(data.flags)
    ```

    得到结果如下：

    ```text
    C_CONTIGUOUS : True
    F_CONTIGUOUS : False
    OWNDATA : True
    WRITEABLE : True
    ALIGNED : True
    WRITEBACKIFCOPY : False
    UPDATEIFCOPY : False
    ```

    其中“C\_CONTIGUOUS：True”，则说明numpy数组在内存上行连续。“F\_CONTIGUOUS : False”，则说明numpy数组在内存上列不连续。
