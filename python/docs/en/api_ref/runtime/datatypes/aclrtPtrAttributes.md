# aclrtPtrAttributes

| Name| Description|
| --- | --- |
| location | Dict, memory location. For details, see [aclrtMemLocation](aclrtMemLocation.md).<br>When `type` is set to `ACL_MEM_LOCATION_TYPE_HOST`, `id` is invalid.|
| page_size | Int, page size in bytes. |
| host_ptr | Int, host memory address. The value is `0` when the C API returns a null pointer for this field. |
| device_ptr | Int, device memory address. The value is `0` when the C API returns a null pointer for this field. |
