# aclrtMemManagedRangeAttribute

```
typedef enum aclrtMemManagedRangeAttribute {
    ACL_MEM_RANGE_ATTRIBUTE_READ_MOSTLY  = 1,
    ACL_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION,
    ACL_MEM_RANGE_ATTRIBUTE_ACCESSED_BY,
    ACL_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION_TYPE,
    ACL_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION_ID,
    ACL_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION,
    ACL_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION_TYPE,
    ACL_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION_ID
} aclrtMemManagedRangeAttribute;
```

枚举项说明如下：

-   **ACL\_MEM\_RANGE\_ATTRIBUTE\_READ\_MOSTLY**

    查询指定内存是否设置了read mostly属性。

    对于通过aclrtMemManagedAdvise接口设置ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY或ACL\_MEM\_ADVISE\_UNSET\_READ\_MOSTLY策略属性的情况，可以通过ACL\_MEM\_RANGE\_ATTRIBUTE\_READ\_MOSTLY选项查询read mostly属性值。

    当指定内存范围内所有内存页都设置了read mostly属性，则返回1，否则返回0。由于属性值为整数，因此dataSize必须设置为4。

-   **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION**

    查询指定内存是否设置了preferred location属性。

    对于通过aclrtMemManagedAdvise接口设置ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION或ACL\_MEM\_ADVISE\_UNSET\_PREFERRED\_LOCATION策略属性的情况，可以通过ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION选项查询preferred location属性值。

    属性值说明如下：

    -   如果指定内存范围内所有内存页都设置了将某个Device或NUMA节点作为首选位置，则返回结果为该Device的ID或NUMA节点ID，否则返回-2。
    -   如果指定内存范围内所有内存页都设置了将Host作为首选位置，则返回结果为-1，否则返回-2。

    由于属性值为整数，因此dataSize必须设置为4。

-   **ACL\_MEM\_RANGE\_ATTRIBUTE\_ACCESSED\_BY**

    查询指定内存是否设置了accessed by属性。

    对于通过aclrtMemManagedAdvise接口设置ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY或ACL\_MEM\_ADVISE\_UNSET\_ACCESSED\_BY策略属性的情况，可以通过ACL\_MEM\_RANGE\_ATTRIBUTE\_ACCESSED\_BY选项查询accessed by属性值。

    属性值为对指定内存范围设置了ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY属性的Host或Device或NUMA节点ID列表，但需注意：

    -   如果用户申请的data数组大小大于设置了accessed by属性的Host或Device或NUMA节点数量时，则超出部分将返回-2。
    -   如果用户申请的data数组大小小于设置了accessed by属性的Host或Device或NUMA节点数量时，则以data数组大小为准，但无法保证存放的是哪些节点的ID。

    由于属性值为整数，dataSize必须设置为4的非零整数倍。

-   **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION\_TYPE**

    查询指定内存的首选位置的类型。需要注意的是，待查询的内存页的实际位置类型可能与首选位置类型不同。

    如果指定内存范围内的所有内存页都设置Host或相同Device或相同NUMA节点作为其首选位置，则分别返回ACL\_MEM\_LOCATIONTYPE\_HOST、ACL\_MEM\_LOCATIONTYPE\_DEVICE或ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA，否则返回ACL\_MEM\_LOCATIONTYPE\_INVALID。

    dataSize必须为sizeof\(aclrtMemManagedLocationType\)，data会被解析为aclrtMemManagedLocationType类型。

-   **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION\_ID**

    查询指定内存的首选位置的ID。

    如果指定内存范围内的所有内存页都设置相同Device或相同NUMA节点作为其首选位置，则分别返回Device ID或NUMA节点ID；否则ID无效。

    由于属性值为整数，因此dataSize必须设置为4。

-   **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION**（预留属性）

    查询指定内存最后一次通过预取接口显式预取到的位置。该返回值仅表示应用程序最后一次请求预取内存范围的位置，并不表示预取操作是否已经完成。

    属性值说明如下：

    -   如果指定内存范围内所有内存页最后一次预取的位置为某个Device或NUMA节点，则返回结果为该Device的ID或NUMA节点ID，否则返回-2。
    -   如果指定内存范围内所有内存页最后一次预取的位置为Host，则返回结果为-1，否则返回-2。

    由于属性值为整数，因此dataSize必须设置为4。

-   **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION\_TYPE**（预留属性）

    查询指定内存最后一次通过内存预取接口显式预取到的位置类型。该返回值仅表示应用程序最后一次请求预取内存范围的位置，并不表示预取操作是否已经完成。

    如果指定内存范围内的所有内存页最后一次预取的位置都是Host或相同Device或相同NUMA节点，则分别返回ACL\_MEM\_LOCATIONTYPE\_HOST、ACL\_MEM\_LOCATIONTYPE\_DEVICE或ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA，否则返回ACL\_MEM\_LOCATIONTYPE\_INVALID。

    dataSize必须为sizeof\(aclrtMemManagedLocationType\)，data会被解析为aclrtMemManagedLocationType类型。

-   **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION\_ID**（预留属性）

    查询指定内存最后一次通过预取接口显式预取到的位置的ID。

    如果指定内存范围内的所有内存页最后一次预取的位置为相同Device或相同NUMA节点，则分别返回Device ID或NUMA节点ID；否则ID无效。

    由于属性值为整数，因此dataSize必须设置为4。
