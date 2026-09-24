# 函数：ptr\_to\_numpy

>[!NOTE] 须知
>该接口即将废弃，建议使用[acl.util.ptr\_to\_bytes](function-ptr_to_bytes.md)接口。

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
output = acl.util.ptr_to_numpy(ptr, shape, type)
```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| ptr | int，C语言中的指针地址，是能够访问的数据的首地址。 |
| shape | tuple，需要构造的numpy的Shape。 |
| type | int，表示ptr中数据的数据类型。<br>下面举例一些常用的类型：<br>0：NPY_BOOL<br>1：NPY_BYTE，NPY_INT8<br>2：NPY_UINT8<br>3：NPY_SHORT，NPY_INT16<br>4：NPY_USHORT，NPY_UINT16<br>5：NPY_INT，NPY_INT32<br>6：NPY_UINT，NPY_UINT32<br>7：NPY_INT64<br>8：NPY_UINT64<br>9：NPY_LONGLONG<br>10：NPY_ULONGLONG<br>11：NPY_FLOAT32<br>12：NPY_DOUBLE<br>23：NPY_HALF，NPY_FLOAT16 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| output | numpy类型。 |

## 注意事项

- 修改示例如下：

    ```python
    np_arr_out = acl.util.ptr_to_numpy(host_ptr, np_arr_in.shape, NPY_INT32)
    ```

    修改后使用：

    ```python
    bytes_out = acl.util.ptr_to_bytes(ptr, size)
    np_arr_out = np.frombuffer(bytes_out, dtype=np.int32).reshape(np_arr_in.shape)
    ```

- 若要继续使用该接口，需要运行环境为python≥3.8且numpy≥1.22.0。
