# EE1015 Package\_Error\_Incorrect\_Driver\_Version

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), detailed reason.

```text
%s failed. Reason: The driver version capacity is insufficient. %s
```

Error example:

```text
rtsIpcMemImportByKey failed. Reason: The driver version capacity is insufficient. The driver interface halShmemInfoGet does not exist.
```

## Solution

Upgrade the driver software version.
