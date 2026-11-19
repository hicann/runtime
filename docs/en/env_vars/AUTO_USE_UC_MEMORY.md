# AUTO\_USE\_UC\_MEMORY

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:29:32.351Z pushedAt=2026-11-16T03:20:35.752Z nl=2 -->

## Description

Controls whether the system allows operator migration data to bypass the L2 Cache.

The value can be:

- **0** or other values: No. All operator migration data must pass through the L2 Cache.
- **1**: Yes. Operator migration data is allowed to bypass the L2 Cache. Whether the data actually passes through the L2 Cache is determined by the logic in the operator kernel code. The default value is **1**.

    When this variable is set to **1**, the performance of some operators can be improved, but there may be a risk of AI Core Error.

>**Caution:**
>This environment variable is an experimental feature. It may change in later versions and is not supported for use in production environments.

## Configuration Example

```bash
export AUTO_USE_UC_MEMORY=0
```

## Constraints

When the aclInit API is called for initialization, this environment variable is read.

<!-- npu="A3,910b,310p" id1 -->
## Supported Models

<!-- npu="310p" id2 -->
Atlas inference products
<!-- end id2 -->

<!-- npu="910b" id3 -->
Atlas A2 products
<!-- end id3 -->

<!-- npu="A3" id4 -->
Atlas A3 products
<!-- end id4 -->
<!-- end id1 -->
