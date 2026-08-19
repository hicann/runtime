# EE1019 Execution\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), error cause.

```text
%s failed. Reason: %s.
```

Error example:

```text
Allocating task info failed. Reason: The number of pending tasks in the stream exceeds the limit.
```

## Solution

1. Reduce the number of tasks delivered to the same stream.

2.Use multiple streams to submit tasks in parallel.
