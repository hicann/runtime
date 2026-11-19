# How to Understand the Default Device and Default Stream

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T10:06:36.806Z pushedAt=2026-10-23T06:57:47.626Z -->

## Symptoms

**Symptom 1: Calling other APIs directly without calling aclrtSetDevice fails**

When **aclrtMalloc** and other APIs are called directly without calling **aclrtSetDevice** to configure the device, the calls fail.

Error code example:

```c
aclInit(nullptr);
aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);  // Failed: no device specified.
```

**Symptom 2: Unclear about the creation timing and usage of the default stream**

It is unclear when the default stream is automatically created and destroyed, and how it differs from an explicitly created stream.

Typical confusion:

```c
aclrtSetDevice(0);  // Automatically create the default stream.
aclrtMemcpyAsync(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);  // Is nullptr the default stream?
```

**Symptom 3: Confusion on the usage scenarios of an explicitly created stream and the default stream**

It is unclear about when to pass **nullptr** (the default stream) and when to pass an explicitly created stream.

## Possible Causes

1. **The defaultDevice feature of aclInit is not configured**: aclInit does not set **defaultDevice** by default. You need to explicitly call **aclrtSetDevice**.
2. **The usage scenarios of the default stream and an explicitly created stream are confused**: The automatic creation mechanism and destruction timing of the default stream are not understood.
3. **The stream parameter passing rules are not understood**: For APIs that require a stream parameter, pass **nullptr** for the default stream and pass the actual object for an explicitly created stream.

## Handling

### Cause 1: defaultDevice of aclInit Not Configured

**Solution**:

- Configure **defaultDevice**: Set **defaultDevice** in the JSON configuration file of aclInit.
- Understand the role of **defaultDevice**: After it is enabled, you do not need to explicitly call **aclrtSetDevice**. The API automatically performs implicit **aclrtSetDevice** internally.

Configuration example:

```json
{
    "defaultDevice":{
        "default_device":"0"
    }
}
```

Usage example:

```c
// After defaultDevice is enabled
aclError ret = aclInit("../acl.json");  // defaultDevice=0 is configured in the JSON file.

// You can directly call runtime APIs without explicitly calling aclrtSetDevice.
aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);  // Success

// Deinitialize
aclrtResetDeviceForce(0);
aclFinalize();
```

### Cause 2: Confusing the Usage Scenarios of the Default Stream and an Explicitly Created Stream

**Solution**:

- Understand when the default stream is created: It is automatically created when **aclrtSetDevice** or **aclrtCreateContext** is called.
- Understand when the default stream is destroyed: It is automatically destroyed when **aclrtResetDevice** or **aclrtResetDeviceForce** is called.
- Distinguish the two types of streams: An explicitly created stream must be destroyed by calling **aclrtDestroyStream**, whereas the default stream cannot be explicitly destroyed.

Usage example of the default stream:

```c
aclrtSetDevice(0);  // Automatically create the default stream.

// Pass nullptr for the default stream.
aclrtMemcpyAsync(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);

// Synchronize the default stream.
aclrtSynchronizeStream(nullptr);  // nullptr indicates the default stream.

aclrtResetDevice(0);  // Automatically destroy the default stream.
```

Example of an explicitly created stream:

```c
aclrtSetDevice(0);
aclrtStream stream;
aclrtCreateStream(&stream);  // Explicitly create a stream.

// Pass the actual object to the explicitly created stream.
aclrtMemcpyAsync(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);

// Destroy the explicitly created stream.
aclrtDestroyStream(stream);  // Must be explicitly destroyed.
aclrtResetDevice(0);
```

### Cause 3: Not Understanding the Stream Parameter Passing Rules

**Solution**:

- For APIs that require a stream parameter (such as **aclrtMemcpyAsync**): pass **nullptr** for the default stream, and pass the actual object for an explicitly created stream.
- For APIs that do not require a stream parameter (such as **aclrtMemcpy**): the default stream is not used, and these are synchronous APIs.

Summary of parameter passing rules:

```c
// Asynchronous API: requires a stream parameter.
aclrtMemcpyAsync(..., nullptr);   // Use the default stream.
aclrtMemcpyAsync(..., stream);    // Use the explicitly created stream.

// Synchronous API: does not require a stream parameter
aclrtMemcpy(..., ACL_MEMCPY_HOST_TO_DEVICE);  // Does not use a stream; executes synchronously.
```

## Related Issues

- [Issue #344: Consultation on the Relationship Among the Device, Context, and Stream](https://gitcode.com/cann/runtime/issues/344)
