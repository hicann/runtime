# EK0202 Resource\_Error\_Insufficient\_Host\_Memory

## Symptom

The following is error format. The placeholder %s indicates the memory size.

```text
Failed to allocate host memory by %s.
```

Error example:

```text
Failed to allocate host memory by std::make_shared.
```

## Possible Cause

Allocation failed due to insufficient host memory.

## Solution

Stop unnecessary processes and ensure that the required memory is available.
