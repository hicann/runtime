# aclrtMemAccessDesc

```
typedef struct {
    aclrtMemAccessFlags flags;   
    aclrtMemLocation location;   
    uint8_t rsv[12];             
} aclrtMemAccessDesc;
```


| 成员名称 | 描述 |
| --- | --- |
| flags | 内存访问保护标志。<br>当前仅支持ACL_RT_MEM_ACCESS_FLAGS_READWRITE，表示地址范围可读可写。 |
| location | 内存所在位置。<br>当前仅支持将aclrtMemLocation.type设置为ACL_MEM_LOCATION_TYPE_HOST或ACL_MEM_LOCATION_TYPE_DEVICE。当aclrtMemLocation.type为ACL_MEM_LOCATION_TYPE_HOST时，aclrtMemLocation.id无效，固定设置为0即可。 |
| rsv | 预留参数，当前固定配置为0。 |

