# W40012 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: parameter value, parameter name, value range, default value.

```text
Value %s for parameter %s is invalid. The value must be in the range of %s and defaults to %s.
```

Error example:

```text
Value -2 for parameter ASCEND_MAX_OP_CACHE_SIZE is invalid. The value must be in the range of [1, 2147483647) or -1 and defaults to 500.
```

## Possible Cause

This parameter is not effective in the current value range.

## Solution

Modify the parameter according to the effective value range.
