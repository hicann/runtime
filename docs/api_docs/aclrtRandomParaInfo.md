# aclrtRandomParaInfo

```
typedef struct {
    uint8_t isAddr;
    uint8_t valueOrAddr[8];
    uint8_t size;
    uint8_t rsv[6];
} aclrtRandomParaInfo;
```


| 成员名称 | 说明 |
| --- | --- |
| isAddr | 取值：0，表示存放参数值；1，表示存放指向参数值的内存地址。 |
| valueOrAddr | 存放参数值或者存放指向参数值的内存地址。<br>当isAddr=0，请根据数据类型填充相应字节数，例如fp16,、bf16，填充前2个字节；fp32、uint32、int32，填充前4个字节；uint64、int64，填充8个字节。<br>当isAddr=1时，则填充8字节的内存地址值。 |
| size | 对valueOrAddr实际填充的字节数。 |
| rsv | 预留参数。当前固定配置为0。 |

