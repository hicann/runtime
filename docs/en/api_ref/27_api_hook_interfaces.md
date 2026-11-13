# 27. API Hook

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:42:10.502Z pushedAt=2026-11-09T10:57:44.624Z nl=2 -->

This chapter describes the API hook APIs of CANN Runtime, which allow performance analysis tools (such as Profiling) to intercept some Runtime APIs (referring to APIs whose names start with aclrt or aclmdlRI, excluding the APIs in this chapter) by injecting hook functions.

- [`aclError aclrtApiInjectionSetFunc(const char* name, aclrtApiFunc func)`](#aclrtApiInjectionSetFunc): Sets the current implementation function pointer of the Runtime API with the specified name to the specified hook function.
- [`aclError aclrtApiInjectionGetFunc(const char* name, aclrtApiFunc* originFunc, aclrtApiFunc* currentFunc)`](#aclrtApiInjectionGetFunc): Obtains the original implementation function pointer and the current implementation function pointer of the Runtime API with the specified name.

<a class="method_anchor" id="aclrtApiInjectionSetFunc"></a>

## aclrtApiInjectionSetFunc

```c
aclError aclrtApiInjectionSetFunc(const char* name, aclrtApiFunc func)
```

### Applicable Products

<!-- npu="950" id3550 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3550 -->
<!-- npu="A3" id3551 -->
- Atlas A3 products: Supported
<!-- end id3551 -->
<!-- npu="910b" id3552 -->
- Atlas A2 products: Supported
<!-- end id3552 -->
<!-- npu="310b" id3553 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3553 -->
<!-- npu="310p" id3554 -->
- Atlas inference products: Supported
<!-- end id3554 -->
<!-- npu="910" id3555 -->
- Atlas training products: Supported
<!-- end id3555 -->
<!-- @ref: runtime/res/docs/zh/api_ref/27_api_hook_interfaces_res.md#id1 -->

### Description

Redirects the Runtime API with the specified name to the corresponding hook function implementation. After this is set, calling the Runtime API jumps to the hook function for execution.

You can inject a hook function through this API to intercept and count Runtime API calls. To restore the original behavior, call this API and pass the original function pointer. The original function pointer can be obtained through [aclrtApiInjectionGetFunc](#aclrtApiInjectionGetFunc).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| name | Input | Runtime API name, which must exactly match the Runtime API name, for example, "aclrtMemcpy". |
| func | Input | Hook function pointer. See [aclrtApiFunc](25-05_Typedefs.md#aclrtApiFunc) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API is recommended to be called before the corresponding Runtime API is called. You must ensure the call sequence.
- When calling the aclrtApiInjectionSetFunc API and the aclrtApiInjectionGetFunc API, you must ensure the multithreaded call sequence.
- The APIs that currently support hooking are APIs starting with aclrt or aclmdlRI. APIs such as aclInit and aclFinalize are not supported.
- For product models that do not support the hook feature, this API returns `ACL_ERROR_FEATURE_UNSUPPORTED`.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtApiInjectionGetFunc"></a>

## aclrtApiInjectionGetFunc

```c
aclError aclrtApiInjectionGetFunc(const char* name, aclrtApiFunc* originFunc, aclrtApiFunc* currentFunc)
```

### Applicable Products

<!-- npu="950" id3557 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3557 -->
<!-- npu="A3" id3558 -->
- Atlas A3 products: Supported
<!-- end id3558 -->
<!-- npu="910b" id3559 -->
- Atlas A2 products: Supported
<!-- end id3559 -->
<!-- npu="310b" id3560 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3560 -->
<!-- npu="310p" id3561 -->
- Atlas inference products: Supported
<!-- end id3561 -->
<!-- npu="910" id3562 -->
- Atlas training products: Supported
<!-- end id3562 -->
<!-- @ref: runtime/res/docs/zh/api_ref/27_api_hook_interfaces_res.md#id2 -->

### Description

Obtains the original implementation function pointer and the current implementation function pointer of the Runtime API with the specified name.

During the runtime initialization phase, the original implementation pointer (`originFunc`) is equal to the current implementation pointer (`currentFunc`). After a hook function is injected by calling [aclrtApiInjectionSetFunc](#aclrtApiInjectionSetFunc), `currentFunc` points to the hook function, while `originFunc` remains unchanged. If the queried `originFunc` and `currentFunc` differ, the implementation of that Runtime API has been replaced by the hook function.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| name | Input | Runtime API name, which must exactly match the Runtime API name, for example, `"aclrtMemcpy"`. |
| originFunc | Output | Original function pointer. Pass `nullptr` if not needed. See [aclrtApiFunc](25-05_Typedefs.md#aclrtApiFunc) for the type definition. |
| currentFunc | Output | Current function pointer. Pass `nullptr` if not needed. See [aclrtApiFunc](25-05_Typedefs.md#aclrtApiFunc) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- For product models that do not support the hook feature, this API returns `ACL_ERROR_FEATURE_UNSUPPORTED`.
- When calling the aclrtApiInjectionSetFunc API and the aclrtApiInjectionGetFunc API, you must ensure the multithreaded call sequence.

<br>
<br>
<br>
