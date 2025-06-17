# 🧠 Temporal & Orchestration Notes

  - [🏗️ Core Concepts](#core-concepts)
    - [⚙️ Execution Architecture](#execution-architecture)
    - [🧩 Namespace vs Task Queue](#namespace-vs-task-queue)
- [Quickstart + Command ref](#quickstart--command-ref)
  - [✅ Start Local Dev Server](#start-local-dev-server)
  - [🏷️ Create a Namespace (with `temporal` CLI)](#create-a-namespace)
    - [📝 Example](#example)
  - [🔍 List Namespaces](#list-namespaces)

## 🏗️ Core Concepts

* **Temporal** is a workflow orchestration engine that handles state, retries, and task distribution across a system.
* It operates with the following building blocks:

  * **Workflows**: Define high-level business logic; deterministic; long-lived.
  * **Activities**: Perform actual work (API calls, DB writes, etc); non-deterministic and retryable.
  * **Workers**: Run code that executes workflows and activities. They poll task queues for work to perform.
  * **Temporal Server**: Central coordinator that manages state, retries, timeouts, and task assignment.
  * **UI Triggering**:

    * **Workflow ID**: A unique identifier you assign (e.g., `payment-xyz-123`)
    * **Task Queue**: Name of the queue your worker is polling (must match exactly)
    * **Workflow Type**: The Python/Go/Java class name (e.g., `MoneyTransfer`), case-sensitive

### Execution Architecture

* **Workers run in a Kubernetes cluster** (or other compute platform).
* Temporal handles coordination of retries, state, failures—workers are stateless and disposable.

---

### Namespace vs Task Queue

| Feature                            | **Namespace**                                             | **Task Queue**                                            |
| ---------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- |
| **What it is**                     | A logical partition/environment in Temporal               | A named queue used to route work to the right worker(s)   |
| **Purpose**                        | Isolate workflows, configs, permissions per app/team/env  | Control load distribution and workflow routing to workers |
| **Examples**                       | `prod`, `dev`, `payments-app`, `audit-team`               | `payments-transfer-tq`, `reporting-tq`, `default-tq`      |
| **Used by**                        | The Temporal **server** to scope workflows and visibility | The **worker** to poll for assigned work                  |
| **Analogy**                        | Like a "project" or "environment" in cloud services       | Like a "channel" or "topic" that workers subscribe to     |
| **Set In**                         | Code config + Temporal CLI / UI                           | Code config in both workflow and worker setup             |
| **One Workflow Can Use Multiple?** | No. One namespace per workflow execution.                 | No. One task queue per workflow at a time.                |

# Quickstart + Command ref

## Start Local Dev Server

```bash
temporal server dev start
```

* This runs Temporal locally with:

  * In-memory persistence
  * UI at `http://localhost:8233`
  * gRPC at `localhost:7233`
  * Default namespace `default`

---

## Create a Namespace 
_(with `temporal` CLI)_

```bash
temporal namespace create \
  --namespace your-namespace-name \
  --description "your description" \
  --retention 24h
```

### Example

```bash
temporal namespace create \
  --namespace dev-payments \
  --description "Payments dev namespace" \
  --retention 1h
```

* `--retention` must be specified in hours or as a duration string (e.g., `1h`, `24h`)
* No need to set archival options unless you want persistence across restarts (usually not needed for dev)

---

## List Namespaces

```bash
temporal namespace list
```

---

Let me know if you also want to register a task queue or how to run a worker against this namespace.
