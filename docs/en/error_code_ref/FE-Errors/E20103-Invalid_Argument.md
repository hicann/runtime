# E20103 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: parameter value, parameter name, expected value.

```text
Value %s for parameter %s is invalid. The value must be in the range of (0, %s].
```

Error example:

```text
Value 256 for parameter --aicore_num is invalid. The value must be in the range of (0, 8].
```

## Solution

Please adjust the parameter value as prompted in the error message.
