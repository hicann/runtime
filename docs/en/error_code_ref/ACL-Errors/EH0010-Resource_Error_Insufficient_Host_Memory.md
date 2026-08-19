# EH0010 Resource\_Error\_Insufficient\_Host\_Memory

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: memory size, memory allocation API.

```text
Failed to allocate %s bytes of host memory via %s to ACL.
```

Error example:

```text
Failed to allocate 1024 bytes host memory for ACL.
```

## Possible Cause

Allocation failed due to insufficient host memory.

## Solution

Ensure that there is sufficient memory available. You can stop unnecessary processes to free up memory.
