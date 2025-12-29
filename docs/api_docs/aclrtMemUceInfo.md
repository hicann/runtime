# aclrtMemUceInfo

```
#define MAX_MEM_UCE_INFO_ARRAY_SIZE 128 
#define UCE_INFO_RESERVED_SIZE 14

typedef struct aclrtMemUceInfo {
    void* addr;
    size_t len;
    size_t reserved[UCE_INFO_RESERVED_SIZE];
} aclrtMemUceInfo;
```


| 成员名称 | 描述 |
| --- | --- |
| addr | 内存UCE的错误虚拟起始地址。 |
| len | 内存大小，单位Byte。<br>从addr开始的len大小范围内的内存都是异常的。 |
| reserved | 预留参数。 |

