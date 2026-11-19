# Compatibility Handling

<!-- md-trans-meta sourceCommit=9ccea1168b84683602dcb3e78ec03a3fe4b2b8c7 translatedAt=2026-11-11T06:24:09.224Z pushedAt=2026-11-16T03:07:58.622Z nl=2 -->

CANN Runtime follows semantic versioning specifications and provides a version query mechanism and deprecated API handling policies to help you build applications with forward and backward compatibility.

<br>
<br>

## 1. Version Query Mechanism

Runtime provides multi-level version query APIs to help applications obtain environment information at runtime and implement compatibility adaptation.

### 1.1 Runtime Version Query

Use the `aclsysGetVersionNum` API to query the Runtime version number by passing the package name `"runtime"`:

```c
char pkgName[] = "runtime";
int32_t versionNum;
aclsysGetVersionNum(pkgName, &versionNum);

printf("Runtime Version Num: %d\n", versionNum);
```

**Version Number Calculation Rules**

The return value of `versionNum` is an integer that follows the semantic versioning encoding rules for easy version comparison.

| Version Section | Weight   | Description                          |
| --------------- | -------- | ------------------------------------ |
| major           | 10000000 | Incompatible API changes             |
| minor           | 100000   | Backward-compatible feature additions |
| patch           | 1000     | Backward-compatible issue resolutions        |

**Formula for calculating an official version:**

```text
versionNum = major × 10000000 + minor × 100000 + patch × 1000
```

**Calculation example**

| Version String | Calculation Process                | versionNum |
| -------------- | ---------------------------------- | ---------- |
| 9.0.0          | 9 × 10000000 + 0 × 100000 + 0 × 1000     | 90000000   |
| 8.5.1          | 8 × 10000000 + 5 × 100000 + 1 × 1000     | 80501000   |

<br>

### 1.2 Driver Version Query

Runtime depends on driver capabilities. For some features, you need to also check the driver version number for compatibility handling. You can query the driver version number by passing the "driver" package name.

```c
char pkgName[] = "driver";  // Query the driver version using "driver".
int32_t versionNum;
aclsysGetVersionNum(pkgName, &versionNum);
printf("Package Version Num: %d\n", versionNum);
```

<br>

### 1.3 Runtime Feature Query

Use `aclrtGetDeviceCapability` to query the feature capabilities supported by the device, so as to implement conditional adaptation of functional features:

```c
int32_t deviceId = 0;
aclrtSetDevice(deviceId);

// Query whether a feature is supported.
int32_t isSupported = 0;
aclrtGetDeviceCapability(deviceId, ACL_FEATURE_XXX, &isSupported);

if (isSupported) {
    // Use the new feature.
} else {
    // Use the compatible solution.
}
```

<br>
<br>

## 2. Application Compatibility Handling

When developing an application, reserve extension capabilities for forward compatibility (adapting to new versions), or implement backward compatibility (supporting earlier versions) when a new-version application needs to run in an earlier-version environment. The following approaches can be adopted:

* **Runtime version check**: Obtain version information at program startup, record logs, or perform adaptation determination.

```c
// Execute the version conditionally.
int32_t versionNum;
aclsysGetVersionNum("runtime", &versionNum);

int32_t major = 8;
int32_t minor = 5;

if (versionNum >= major * 10000000 + minor * 100000) {
    // Use the new-version feature APIs.
    aclrtQueryEventStatus(event, &status);
} else {
    // Use the earlier-version compatible APIs.
    aclrtQueryEvent(event, &status);
}
```

* **Feature capability detection**: Use feature query APIs instead of hard-coded version numbers for determination.

```c
// Query feature support.
int32_t isSupported = 0;
aclrtGetDeviceCapability(deviceId, ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV, &isSupported);

if (isSupported) {
    // Use the new feature to implement the efficient path.
    useNewFeaturePath();
} else {
    // Fall back to the compatible implementation.
    useLegacyPath();
}
```

<br>
<br>

## 3. CANN Runtime Compatibility Policy

### 3.1 Compatibility Principles

CANN Runtime adheres to the following compatibility principles.

| Version Change Type | Compatibility Guarantee | Example |
| ------------------- | ----------------------- | ------- |
| Patch version upgrade | Full backward compatibility | Issues are resolved and performance is optimized. |
| Minor version upgrade | API backward compatibility | New APIs and features are added. |
| Major version upgrade | No compatibility guarantee | Deprecated APIs are deleted and the architecture is adjusted. |

### 3.2 Handling Policy for Deprecated APIs

Runtime marks deprecated APIs using the `ACL_DEPRECATED_MESSAGE` macro, keeping them available throughout the deprecation period while indicating the replacement APIs (if any).

#### Method of Marking Deprecated APIs

```c
// Example of a deprecated API declaration
ACL_DEPRECATED_MESSAGE("aclrtQueryEvent is deprecated, use aclrtQueryEventStatus instead")
ACL_FUNC_VISIBILITY aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status);
```

During compilation, a warning message is generated.

```text
warning: 'aclrtQueryEvent' is deprecated: aclrtQueryEvent is deprecated, use aclrtQueryEventStatus instead [-Wdeprecated-declarations]
```

#### Deprecated API Lifecycle

| Phase | Status | Recommendation |
| ------------ | ------------------ | ------------------ |
| Deprecation notice released | API available, with a compilation warning | Start migrating to the replacement API |
| Deprecation transition period | API available, with a persistent warning | Complete the migration |
| Officially removed | API unavailable | Use the replacement API |

### 3.3 Deprecation of Enum/Struct Members

Enums and struct members may also be deprecated.

```c
typedef enum aclrtLaunchKernelAttrId {
    ACL_RT_LAUNCH_KERNEL_ATTR_LOCAL_MEMORY_SIZE
        ACL_DEPRECATED_MESSAGE("Use ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE instead") = 2,
    ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE = 2,  // Replacement value, with the same number
    ...
} aclrtLaunchKernelAttrId;

typedef union aclrtLaunchKernelAttrValue {
    ACL_DEPRECATED_MESSAGE("Use dynUbufSize instead")
    uint32_t localMemorySize;  // Deprecated member
    uint32_t dynUBufSize;      // Replacement member
    ...
} aclrtLaunchKernelAttrValue;
```

Handling recommendations:

- Use the replacement enum value/member name.
- Note that the replacement value may have the same number as the deprecated value to maintain compatibility.

<br>
<br>

## 4. Migrating Deprecated APIs

### 4.1 Migration Process

1. **Identify deprecated APIs**: View deprecation warnings at compile time and identify the replacement APIs.
2. **Assess the migration impact**: Analyze the differences in API parameters, return values, and semantics.
3. **Write migration code**: Replace the deprecated API calls and adapt the parameters to the new APIs.
4. **Test and verify**: Ensure that the features after the migration work correctly and the performance meets expectations.

### 4.2 Migration Example

#### aclrtQueryEvent -> aclrtQueryEventStatus

```c
// Deprecated API (old code)
aclrtEventStatus status;
aclrtQueryEvent(event, &status);
if (status == ACL_EVENT_STATUS_COMPLETE) {
    // ...
}

// Replacement API (new code)
aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
if (status == ACL_EVENT_RECORDED_STATUS_COMPLETE) {
    // ...
}
```

### 4.3 Recommended Practices

1. **Check compilation warnings regularly**: Handle deprecated API warnings in a timely manner to prevent them from accumulating.
2. **Prioritize new APIs**: New APIs generally offer better semantics, performance, or functionality.
3. **Record version information**: Record the Runtime version when the application starts to facilitate issue locating.
4. **Prefer feature detection over version determination**: Use feature query API to determine capabilities, instead of using hard-coded version numbers.
5. **Encapsulate version adaptation logic**: Centralize compatibility logic in an adaptation layer for easier maintenance.

### 4.4 Practices to Avoid

1. **Do not ignore deprecation warnings**: Deprecated APIs may be removed in future versions, causing compilation failures.
2. **Do not use hard-coded version numbers for checks**: Version number checks lack flexibility. Use feature detection instead.
3. **Do not mix old and new APIs**: Use either the new or the old APIs consistently within the same functional module to avoid confusion.
4. **Do not assume API semantics remain unchanged**: When migrating, carefully read the documentation of the new APIs to confirm semantic consistency.
