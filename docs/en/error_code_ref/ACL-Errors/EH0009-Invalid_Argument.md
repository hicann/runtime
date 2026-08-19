# EH0009 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter value, parameter name, error cause.

```text
%s failed. Value %s for parameter %s is invalid. Reason: %s.
```

Error example:

```text
acltdtGetDataItem failed. Value 5 for parameter index is invalid. Reason: index 5 is greater than or equal to dataset size 10.
```

## Solution

1. Check the input parameter range of the function.
2. Check the function invocation relationship.
