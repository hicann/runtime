# EH0012 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), parameter name, error cause.

```text
%s failed. Parameter %s is invalid. Reason: %s.
```

Error example:

```text
aclrtAllocatorGetByStream failed. Parameter stream is invalid. Reason: The stream is not registered with any allocator.
```

## Solution

Please adjust your parameter value based on the prompts in the Reason.
