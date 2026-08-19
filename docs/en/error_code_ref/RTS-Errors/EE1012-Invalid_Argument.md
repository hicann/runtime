# EE1012 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter value, parameter name, expected value.

```text
%s failed. Value %s for %s is invalid. Reason: %s.
```

Error example:

```text
NotifyWait failed. Value 1 for current deviceId is invalid. Reason: The current device cannot deliver Notify Wait, the corresponding Notify Wait must be delivered on the device that creates the IPC Notify.
```

## Solution

Please adjust the parameter value according to the prompts in the Reason.
