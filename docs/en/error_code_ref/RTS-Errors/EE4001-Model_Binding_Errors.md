# EE4001 Model\_Binding\_Errors

## Symptom

The following is error format. The placeholder %s indicates the error cause.

```text
Failed to bind the stream to the model. %s
```

Error example:

```text
Failed to bind the stream to the model. Stream (stream_id=1) has been bound to model (model_id=2) and failed to be bound to model (model_id=3).
```

## Possible Cause

The stream has been bound to another model.

## Solution

Remove the repeated binding operation on the stream from the code.
