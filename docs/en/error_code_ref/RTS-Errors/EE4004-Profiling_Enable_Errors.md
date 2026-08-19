# EE4004 Profiling\_Enable\_Errors

## Symptom

The following is error format. The placeholder %s indicates the error cause.

```text
Failed to enable profiling.  %s
```

Error example:

```text
Failed to enable profiling. Reason: sample based profiling is ongoing.
```

## Solution

Do not enable profiling repeatedly.
