# EE1025 Initialization\_Error

## Symptom

The following is the error format. The two %s placeholders represent the dynamic library name and failure reason, respectively.

```text
Failed to load dynamic library %s. Reason: %s.
```

Error example:

```text
Failed to load dynamic library libruntime_v100.so. Reason: /usr/local/Ascend/cann-9.2.0/lib64/libruntime_v100.so: undefined symbol: ConstructRuntimeImpl.
```

## Solution

1. Use the correct dynamic library path.
2. Ensure that the required dynamic library has been correctly installed.
