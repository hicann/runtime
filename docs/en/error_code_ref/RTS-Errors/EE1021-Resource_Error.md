# EE1021 Resource\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: resource type, API name.

```text
The runtime module failed to create host %s through API %s.
```

Error example:

```text
The runtime module failed to create host semaphore through API sem_init.
```

## Possible Cause

Failed to create resources such as semaphores, locks, or threads due to insufficient system resources.

## Solution

Stop unnecessary threads and ensure that the required resource is available.
