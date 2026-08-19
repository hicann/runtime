# EE1016 Not\_Supported

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), error cause.

```text
%s failed. Reason: %s.
```

Error example:

```text
MemCopySync failed. Reason: The current thread 198840 is in the capture state and the current operation cannot be performed. Check whether the mode set by the aclmdlRICaptureBegin API supports the current operation. This operation is supported only in the RELAXED mode. The mode set using the aclmdlRICaptureBegin API is 1, the capture mode of the current thread is 1, and the mode set using the aclmdlRICaptureThreadExchangeMode API is 1.
```

## Solution

Please adjust the parameter value according to the prompts in the Reason.
