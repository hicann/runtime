# 兼容性处理

CANN Runtime 遵循语义化版本规范，提供版本查询机制和废弃接口处理策略，帮助开发者构建前后向兼容的应用程序。

<br>
<br>

## 1. 版本查询机制

Runtime提供多层次的版本查询接口，帮助应用在运行时获取环境信息，实现兼容性适配。

### 1.1 Runtime版本查询

使用`aclsysGetVersionNum`接口查询Runtime版本号，传入包名`"runtime"`：

```c
char pkgName[] = "runtime";
int32_t versionNum;
aclsysGetVersionNum(pkgName, &versionNum);

printf("Runtime Version Num: %d\n", versionNum);
```

**版本号计算规则**

返回的`versionNum`是一个整数值，遵循语义化版本编码规则，便于版本比较。

| 版本部分          | 权重     | 说明               |
| ----------------- | -------- | ------------------ |
| major（主版本号） | 10000000 | 不兼容的API变更    |
| minor（次版本号） | 100000   | 向后兼容的功能新增 |
| patch（修订号）   | 1000     | 向后兼容的问题修复 |

**正式版本计算公式：**

```
versionNum = major × 10000000 + minor × 100000 + patch × 1000
```

**计算示例：**

| 版本字符串 | 计算过程                          | versionNum |
| ---------- | --------------------------------- | ---------- |
| 9.0.0      | 9×10000000 + 0×100000 + 0×1000 | 90000000   |
| 8.5.1      | 8×10000000 + 5×100000 + 1×1000 | 80501000   |

<br>

### 1.2 Driver版本查询

Runtime依赖驱动能力，部分特性功能需要同时判断驱动版本号以做兼容性处理，传入"driver"包名可查询驱动版本号。

```c
char pkgName[] = "driver";  // 查询驱动版本，使用"driver"
int32_t versionNum;
aclsysGetVersionNum(pkgName, &versionNum);
printf("Package Version Num: %d\n", versionNum);
```

<br>

### 1.3 运行时特性查询

使用`aclrtGetDevFeature`查询设备支持的特性能力，实现功能特性的条件适配：

```c
int32_t deviceId = 0;
aclrtSetDevice(deviceId);

// 查询是否支持某特性
int32_t isSupported = 0;
aclrtGetDevFeature(deviceId, ACL_FEATURE_XXX, &isSupported);

if (isSupported) {
    // 使用新特性
} else {
    // 使用兼容方案
}
```

<br>
<br>

## 2. 应用兼容性处理

应用开发时预留扩展能力便于前向兼容（适配新版本）或者新版本应用需在旧版本环境运行时做后向兼容（支持旧版本），可采用如下处理方式：

* **运行时版本检测**：程序启动时获取版本信息，记录日志或进行适配判断。

```c
// 版本条件执行
int32_t versionNum;
aclsysGetVersionNum("runtime", &versionNum);

int32_t major = 8;
int32_t minor = 5;

if (versionNum >= major * 10000000 + minor * 100000) {
    // 使用新版本特性接口
    aclrtQueryEventStatus(event, &status);
} else {
    // 使用旧版本兼容接口
    aclrtQueryEvent(event, &status);
}
```

* **特性能力探测**：使用特性查询接口而非硬编码版本号判断。

```c
// 查询特性支持情况
int32_t isSupported = 0;
aclrtGetDevFeature(deviceId, ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV, &isSupported);

if (isSupported) {
    // 使用新特性实现高效路径
    useNewFeaturePath();
} else {
    // 降级到兼容实现
    useLegacyPath();
}
```
<br>
<br>

## 3. CANN Runtime兼容性策略

### 3.1 兼容原则

CANN Runtime遵循以下兼容性原则：

| 版本变更类型  | 兼容性保证   | 示例                   |
| ------------- | ------------ | ---------------------- |
| Patch版本升级 | 完全向后兼容 | Bug修复、性能优化      |
| Minor版本升级 | API向后兼容  | 新增接口、新增特性     |
| Major版本升级 | 不保证兼容   | 删除废弃接口、架构调整 |

### 3.2 废弃接口处理策略

Runtime使用`ACL_DEPRECATED_MESSAGE`宏标记废弃接口，在废弃周期内保持可用，同时提示替换接口（如有）。

#### 废弃接口标记方式

```c
// 废弃接口声明示例
ACL_DEPRECATED_MESSAGE("aclrtQueryEvent is deprecated, use aclrtQueryEventStatus instead")
ACL_FUNC_VISIBILITY aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status);
```

编译时将产生警告信息：

```
warning: 'aclrtQueryEvent' is deprecated: aclrtQueryEvent is deprecated, use aclrtQueryEventStatus instead [-Wdeprecated-declarations]
```

#### 废弃接口生命周期

| 阶段         | 状态               | 建议               |
| ------------ | ------------------ | ------------------ |
| 发布废弃通知 | 接口可用，编译警告 | 开始迁移到替代接口 |
| 废弃过渡期   | 接口可用，持续警告 | 完成迁移           |
| 正式移除     | 接口不可用         | 必须使用替代接口   |

### 3.3 枚举/结构体成员废弃处理

枚举值和结构体成员也可能被废弃：

```c
typedef enum aclrtLaunchKernelAttrId {
    ACL_RT_LAUNCH_KERNEL_ATTR_LOCAL_MEMORY_SIZE 
        ACL_DEPRECATED_MESSAGE("Use ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE instead") = 2,
    ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE = 2,  // 替代值，同编号
    ...
} aclrtLaunchKernelAttrId;

typedef union aclrtLaunchKernelAttrValue {
    ACL_DEPRECATED_MESSAGE("Use dynUbufSize instead")
    uint32_t localMemorySize;  // 废弃成员
    uint32_t dynUBufSize;      // 替代成员
    ...
} aclrtLaunchKernelAttrValue;
```

处理建议：

- 使用替代枚举值/成员名。
- 注意替代值可能与废弃值编号相同，保持兼容。

<br>
<br>

## 4. 迁移废弃接口

### 4.1 迁移流程

1. **识别废弃接口**：编译时查看废弃警告，确认替代接口。
2. **评估迁移影响**：分析接口参数、返回值、语义差异。
3. **编写迁移代码**：替换废弃接口调用，适配新接口参数。
4. **测试验证**：确保迁移后功能正确、性能符合预期。

### 4.2 迁移示例

#### aclrtQueryEvent -> aclrtQueryEventStatus

```c
// 废弃接口（旧代码）
aclrtEventStatus status;
aclrtQueryEvent(event, &status);
if (status == ACL_EVENT_STATUS_COMPLETE) {
    // ...
}

// 替代接口（新代码）
aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
if (status == ACL_EVENT_RECORDED_STATUS_COMPLETE) {
    // ...
}
```

### 4.3 推荐做法

1. **定期检查编译警告**：及时处理废弃接口警告，避免积累。
2. **优先使用新接口**：新接口通常有更好的语义、性能或功能。
3. **版本信息记录**：应用启动时记录Runtime版本，便于问题定位。
4. **特性探测优于版本判断**：使用特性查询接口判断能力，而非硬编码版本号。
5. **封装版本适配逻辑**：将兼容性逻辑集中在适配层，便于维护。

### 4.4 避免的做法

1. **不要忽略废弃警告**：废弃接口可能在未来版本移除，导致编译失败。
2. **不要硬编码版本判断**：版本号判断缺乏灵活性，应使用特性探测。
3. **不要混用新旧接口**：同一功能模块统一使用新或旧接口，避免混乱。
4. **不要假设接口语义不变**：迁移时仔细阅读新接口文档，确认语义一致。
