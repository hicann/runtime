# aclrtPlaceHolderInfo

## 定义

```python
place_holder_list = [{"addrOffset": addr_offset, "dataOffset": data_offset}]
```

说明：placeholder机制信息。

| 成员名称 | 说明 |
| --- | --- |
| addrOffset | 待刷新的位置偏移。launch时，Runtime会申请Device内存并将该Device内存地址刷新到hostArgs中，该参数用于指定需刷新的位置偏移。 |
| dataOffset | 数据区的偏移。placeholder指向的数据区需拷贝到Device侧，该参数用于指定数据区基于hostArgs的地址偏移。 |
