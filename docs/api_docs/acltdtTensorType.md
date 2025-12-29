# acltdtTensorType

```
enum acltdtTensorType {
    ACL_TENSOR_DATA_UNDEFINED = -1,
    ACL_TENSOR_DATA_TENSOR,           // 正常tensor数据标识
    ACL_TENSOR_DATA_END_OF_SEQUENCE,  // end数据标识
    ACL_TENSOR_DATA_ABNORMAL,         // 异常数据标识
    ACL_TENSOR_DATA_SLICE_TENSOR,     // tensor分片场景下的tensor数据
    ACL_TENSOR_DATA_END_TENSOR        // tensor分片场景下标识最后一个tensor
};
```

