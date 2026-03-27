# aclrtBinaryLoadOption

```
typedef struct {
    aclrtBinaryLoadOptionType type;
    aclrtBinaryLoadOptionValue value;
} aclrtBinaryLoadOption;
```

加载算子二进制文件时，每个参数是由参数类型aclrtBinaryLoadOption.type及其对应的参数值aclrtBinaryLoadOption.value组成，例如，aclrtBinaryLoadOption.type为ACL\_RT\_BINARY\_LOAD\_OPT\_LAZY\_LOAD时，aclrtBinaryLoadOption.value需根据isLazyLoad的取值来配置。

aclrtBinaryLoadOption.type的定义请参见[aclrtBinaryLoadOptionType](aclrtBinaryLoadOptionType.md)。

aclrtBinaryLoadOption.value的定义请参见[aclrtBinaryLoadOptionValue](aclrtBinaryLoadOptionValue.md)。

