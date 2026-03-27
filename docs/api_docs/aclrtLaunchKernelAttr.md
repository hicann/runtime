# aclrtLaunchKernelAttr

```
typedef struct aclrtLaunchKernelAttr {
    aclrtLaunchKernelAttrId id;
    aclrtLaunchKernelAttrValue value;
} aclrtLaunchKernelAttr;
```

Launch Kernel时，每个属性是由属性标识aclrtLaunchKernelAttr.id及其对应的属性值aclrtLaunchKernelAttr.value组成，例如，aclrtLaunchKernelAttr.id为ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_SCHEM\_MODE时，aclrtLaunchKernelAttr.value需根据schemMode的取值来配置。

aclrtLaunchKernelAttr.id的定义请参见[aclrtLaunchKernelAttrId](aclrtLaunchKernelAttrId.md)。

aclrtLaunchKernelAttr.value的定义请参见[aclrtLaunchKernelAttrValue](aclrtLaunchKernelAttrValue.md)。

