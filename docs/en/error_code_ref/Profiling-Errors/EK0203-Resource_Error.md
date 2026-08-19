# EK0203 Resource\_Error

## Symptom

The following is error format. The placeholder %s indicates the error cause.

```text
Failed to create host thread for Profiling. Reason: %s.
```

Error example:

```text
Failed to create host thread for Profiling. Reason: 11 returned when the pthread_create API is called.
```

## Possible Cause

New thread cannot be created due to insufficient system thread resources.

## Solution

Stop unnecessary threads and ensure that the required resource is available.
