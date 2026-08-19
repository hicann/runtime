# EK0001 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: parameter value, parameter name, error cause.

```text
Value %s for parameter %s is invalid. Reason: %s.
```

Error example:

```text
Value 64 for parameter device id is invalid. Reason: The device id should be in range [0, 1)
```

## Solution

Please enter the correct parameter value as prompted in the Reason, or refer to the official documentation for usage instructions of relevant parameters.
