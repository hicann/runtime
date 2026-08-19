# EE1006 Not\_Supported

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), unsupported parameter or parameter value, error cause.

```text
%s failed. %s is not supported. Reason: %s.
```

Error example:

```text
StreamWaitEvent failed. Parameter evt.eventFlag_ value 0x10 is not supported. Reason: Device-only events can be called only on the device.
```

## Solution

This feature is not supported. Code logic needs to be adjusted.
