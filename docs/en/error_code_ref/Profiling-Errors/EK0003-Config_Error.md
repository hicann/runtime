# EK0003 Config\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: parameter value, parameter name, error cause.

```text
Value %s for %s is invalid. Reason: %s.
```

Error example:

```text
Value /home/prof_path for output is invalid. Reason: The operation on directory /home/prof_path is abnormal. [Error 13] Permission denied.
```

## Solution

Please enter the correct parameter value as prompted in the Reason, or refer to the official documentation for usage instructions of relevant parameters.
