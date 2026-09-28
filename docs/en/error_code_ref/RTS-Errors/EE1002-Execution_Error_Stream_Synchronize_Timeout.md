# EE1002 Execution\_Error\_Stream\_Synchronize\_Timeout

## Symptom

The following is error format. The placeholder %s indicates the error cause.

```text
Stream synchronization timeout. %s
```

Error example:

```text
Stream synchronization timeout. rtModelExecute execution failed.
```

## Possible Cause

The timeout interval may be improperly set.

## Solution

1. Check whether the timeout interval is properly set.
2. Check whether the network is normal.
