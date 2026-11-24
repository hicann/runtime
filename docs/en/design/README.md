# Runtime Architecture Documents

This document set introduces the CANN Runtime architecture design and **targets developers who want to contribute code to Runtime**.

## Architecture Overview

| Document | Description |
|------|------|
| [architecture.md](architecture.md) | System architecture overview, introducing the overall Runtime design and core components |

## Module Architecture Documents

| Document | Description |
|------|------|
| [modules/runtime/runtime.md](modules/runtime/runtime.md) | Runtime global management, singleton mode, and resource management |
| [modules/device/device.md](modules/device/device.md) | Device management, device initialization, status management, and error handling |
| [modules/stream/stream.md](modules/stream/stream.md) | Stream management, task queue, and synchronization mechanism |
| [modules/task/task.md](modules/task/task.md) | Task management, task types, and execution flow |
| [modules/context/context.md](modules/context/context.md) | Context management and its relationship with Device/Stream |
| [modules/memory/memory.md](modules/memory/memory.md) | Memory management, memory pool, and allocation policy |
| [modules/kernel/kernel.md](modules/kernel/kernel.md) | Kernel management, binary loading and execution |
| [modules/event/event.md](modules/event/event.md) | Event management and synchronization mechanism |

## Feature Documents

| Document | Description |
|------|------|
| [features/aclgraph.md](features/aclgraph.md) | ACL Graph feature, stream capture, and model construction |
| [features/snapshot.md](features/snapshot.md) | Snapshot feature, process status save and restore |
| [features/fusion.md](features/fusion.md) | Fusion feature, operator fusion execution |
| [features/cc_mode.md](features/cc_mode.md) | CC Mode feature, data encryption and decryption transfer in confidential computing scenarios |

---

## How to Use These Documents

### Recommended Reading Order

1. **Beginners**: read [architecture.md](architecture.md) first to understand the overall architecture
2. **Module development**: read the corresponding module document based on your interest
3. **Feature development**: refer to the feature documents in the features/ directory

### Reading Paths for Different Roles

- **Runtime core developers**: architecture → runtime → device → stream → task
- **Driver adaptation developers**: architecture → device → stream
- **Performance optimization developers**: memory → stream → task
- **Feature developers**: architecture → corresponding feature document

---

## Project Structure

```
runtime/
├── api/                    # API interface layer
│   ├── api.hpp             # Runtime API definitions
│   ├── api_c_*.cc          # C language interface implementation
│   └── impl/               # API internal implementation
├── core/
│   ├── inc/                # Internal header files
│   └── src/                # Core implementation
│       ├── runtime.cc      # Runtime global management
│       ├── device/         # Device module
│       ├── stream/         # Stream module
│       ├── task/           # Task module
│       ├── context/        # Context module
│       ├── kernel/         # Kernel module
│       ├── event/          # Event module
│       ├── engine/         # Engine scheduling
│       ├── memory/         # Memory module
│       ├── profiler/       # Profiler performance analysis
│       ├── launch/         # Kernel Launch
│       ├── notify/         # Notify notification
│       └── dfx/            # DFX functions
├── driver/                 # Driver adaptation layer
│   ├── v100/               # v100 version driver
│   ├── v200/               # v200 version driver
│   └── v201/               # v201 version driver
├── feature/                # Feature function implementation
│   ├── aclgraph/           # ACL Graph stream capture
│   ├── snapshot/           # Snapshot process snapshot
│   ├── model/              # Model model management
│   ├── soma/               # SOMA feature
│   ├── ccu/                # CCU feature
│   ├── cntnotify/          # Count Notify
│   ├── xpu/                # XPU feature
│   ├── fusion/             # Fusion fusion
│   ├── dqs/                # DQS feature
│   └── ffts/               # FFTS feature
├── config/                 # Hardware difference configuration
│   ├── as31xm1/            # AS31XM1 chip configuration
│   ├── bs9sx1a/            # BS9SX1A chip configuration
│   ├── 910_B_93/           # 910B chip configuration
│   └── ...                 # Other chip configurations
├── inc/                    # Public header files
│   ├── device/             # Device related header files
│   └── sqe/                # SQE related header files
└── cmake/                  # Build configuration
```

---

_This document follows the format of the open-source repository architecture document template._
