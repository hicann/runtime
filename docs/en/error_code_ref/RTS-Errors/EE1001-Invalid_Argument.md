# EE1001 Invalid\_Argument

## Symptom

The following is error format. The placeholder %s indicates the error cause.

```text
The argument is invalid. Reason: %s
```

Error example:

```text
The argument is invalid.Reason: Invalid device ID 8. Set drv devId to 8. The valid device range is [0, 7).
```

## Solution

1. Check the input parameter range of the function.
2. Check the function invocation relationship.
