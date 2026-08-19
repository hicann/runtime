# EK0204 Resource\_Error

## Symptom

The following is error format. The placeholder %s indicates the error cause.

```text
Insufficient disk space. Reason: %s.
```

Error example:

```text
Insufficient disk space. Reason: The remaining disk space of the system is 19MB, which is less than 20MB.
```

## Solution

At least 20MB storage space is required for Profiling flushing. Delete redundant files or change the flushing path.
