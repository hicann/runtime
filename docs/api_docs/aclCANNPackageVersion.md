# aclCANNPackageVersion<a name="ZH-CN_TOPIC_0000002195233514"></a>

```
#define ACL_PKG_VERSION_MAX_SIZE       128
#define ACL_PKG_VERSION_PARTS_MAX_SIZE 64

typedef struct aclCANNPackageVersion {
    char version[ACL_PKG_VERSION_MAX_SIZE];               // 完整版本号
    char majorVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // 主版本号
    char minorVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // 次版本号
    char releaseVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];  // 发布号，如果查询不到，就补0
    char patchVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // 补丁版本号，如果查询不到，就补0
    char reserved[ACL_PKG_VERSION_MAX_SIZE];
} aclCANNPackageVersion;
```

