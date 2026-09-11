# 5_runtime_lifecycle_callbacks

This topic demonstrates how application plugins participate in ACL initialization and finalization, and verifies callback registration, unregistration, and reference-counting semantics.

## Sample List

- [0_reference_counted_plugin_lifecycle](./0_reference_counted_plugin_lifecycle/README_en.md): Registers active and cancellable lifecycle callbacks, performs a single-Device operation, and verifies that only the active callbacks run and that the final reference count reaches zero.
