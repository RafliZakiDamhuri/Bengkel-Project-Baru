# Flutter Project Refactoring Guidelines

## 1. Project Overview

This is a Flutter application that uses **GetX** as its primary state management and dependency injection solution.

The purpose of this document is to define the rules and workflow for refactoring and cleaning up the existing Flutter project.

The primary goal is to improve:

* Code readability
* Maintainability
* Project structure
* Separation of concerns
* GetX implementation
* Code consistency
* Reusability

### Critical Requirement

**Do NOT rewrite the application from scratch.**

Refactoring must be performed incrementally while preserving the existing application's behavior.

---

# 2. Core Rules

The following rules are mandatory.

### DO

* Preserve existing business logic.
* Preserve existing application behavior.
* Preserve existing UI/UX.
* Preserve existing API contracts.
* Preserve existing database schemas.
* Preserve existing backend response structures.
* Reuse existing implementations where appropriate.
* Prefer simple solutions over unnecessary abstractions.
* Refactor incrementally.
* Run static analysis after significant changes.
* Run tests after significant changes.
* Verify that changes do not introduce regressions.

### DO NOT

* Do not replace GetX.
* Do not introduce Riverpod.
* Do not introduce Bloc.
* Do not introduce Provider.
* Do not introduce another state management framework.
* Do not rewrite the entire application.
* Do not change API contracts.
* Do not change database schemas.
* Do not change backend response models unless absolutely necessary.
* Do not redesign UI.
* Do not change UX behavior.
* Do not delete code unless it is confirmed to be unused.
* Do not create abstractions only for the sake of "clean architecture".
* Do not introduce unnecessary interfaces.
* Do not introduce unnecessary repositories/services.
* Do not make large unrelated changes in a single refactoring step.

---

# 3. Required Workflow

Refactoring MUST follow this workflow.

## Phase 1 — Project Audit

Before modifying any code:

1. Inspect the entire project structure.
2. Inspect `pubspec.yaml`.
3. Inspect `lib/`.
4. Inspect existing GetX controllers.
5. Inspect GetX bindings.
6. Inspect routes.
7. Inspect models.
8. Inspect services/providers.
9. Inspect repositories if they exist.
10. Inspect shared widgets.
11. Inspect utilities/helpers.
12. Identify duplicated code.
13. Identify dead code.
14. Identify oversized widgets.
15. Identify oversized controllers.
16. Identify tightly coupled dependencies.
17. Identify inappropriate GetX usage.
18. Identify inconsistent naming and folder structures.

### Important

During this phase:

**DO NOT MODIFY CODE.**

Only analyze the project.

Produce an audit report containing:

```text
1. Current Architecture
2. Folder Structure Problems
3. GetX Problems
4. Controller Problems
5. UI Problems
6. Data/API Layer Problems
7. Code Duplication
8. Dead Code Candidates
9. Naming Inconsistencies
10. Dependency Problems
11. Refactoring Risks
12. Recommended Refactoring Order
```

---

# 4. Phase 2 — Refactoring Plan

After the audit, create a prioritized refactoring plan.

Prioritize changes using:

### Priority 1 — Safe

Examples:

* Remove unused imports.
* Fix naming inconsistencies.
* Extract duplicated constants.
* Format code.
* Remove confirmed dead code.
* Simplify obvious duplicated code.

### Priority 2 — Low Risk

Examples:

* Extract widgets.
* Extract helper functions.
* Move models.
* Move shared utilities.
* Improve controller organization.

### Priority 3 — Medium Risk

Examples:

* Introduce repositories.
* Separate API logic from controllers.
* Improve dependency injection.
* Reorganize module structure.

### Priority 4 — High Risk

Examples:

* Large architectural changes.
* Changing lifecycle management.
* Changing dependency injection strategy.
* Changing state ownership.

High-risk changes must be clearly explained before implementation.

---

# 5. Phase 3 — Incremental Refactoring

Refactor one logical area at a time.

Recommended order:

```text
1. Formatting / imports
2. Constants
3. Utilities / helpers
4. Shared widgets
5. Models
6. Services / API providers
7. Repositories
8. GetX Controllers
9. GetX Bindings
10. Routes
11. Module structure
12. Final cleanup
```

Do not refactor unrelated modules simultaneously.

After every significant refactoring step:

```bash
flutter analyze
flutter test
```

If `flutter analyze` or `flutter test` fails because of the refactoring:

1. Stop.
2. Identify the cause.
3. Fix the issue.
4. Run the validation again.
5. Only continue after validation passes.

---

# 6. GetX Architecture Rules

GetX must remain the project's state management solution.

## Controllers

Controllers should primarily handle:

* Reactive state
* User interaction logic
* Screen-level business/UI interaction
* Calling repositories/services
* Coordinating application state

Controllers should NOT become "God Controllers".

Avoid controllers containing:

* HTTP implementation details
* Large JSON parsing logic
* Database implementation details
* Large reusable utility functions
* Large widget-building functions
* Unrelated feature logic

If a controller becomes too large, identify logical responsibilities and extract them into appropriate services/repositories/helpers.

---

# 7. GetX Reactive State

Use reactive variables only when reactive behavior is actually required.

Prefer:

```dart
final isLoading = false.obs;
```

when the UI genuinely needs to react to changes.

Avoid unnecessary:

```dart
final someValue = ''.obs;
```

if the value does not need to trigger UI updates.

Do not convert every variable into `Rx`.

---

# 8. Obx Usage

Avoid wrapping large widget trees with `Obx`.

Prefer small reactive sections.

Bad:

```dart
Obx(
  () => Scaffold(
    body: HugeWidgetTree(),
  ),
);
```

Prefer:

```dart
Scaffold(
  body: Column(
    children: [
      Obx(
        () => LoadingWidget(
          isLoading: controller.isLoading.value,
        ),
      ),
      OtherWidget(),
    ],
  ),
);
```

The goal is to minimize unnecessary widget rebuilds.

---

# 9. Get.find()

Avoid excessive usage of:

```dart
Get.find<T>();
```

If dependencies can be passed explicitly or accessed through a clear dependency structure, prefer the clearer approach.

However, do NOT perform a large-scale dependency injection rewrite merely to eliminate every `Get.find()`.

Existing working patterns should only be changed when there is a meaningful maintainability or lifecycle benefit.

---

# 10. GetX Bindings

Use bindings to manage feature dependencies and controller lifecycle.

Example:

```dart
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        repository: Get.find<AuthRepository>(),
      ),
    );
  }
}
```

Prefer lazy initialization where appropriate.

Avoid registering unnecessary global dependencies.

Consider lifecycle carefully before changing:

```dart
Get.put()
```

to:

```dart
Get.lazyPut()
```

because lifecycle changes can affect application behavior.

---

# 11. Dependency Injection

Dependencies should follow a clear direction:

```text
View
  ↓
Controller
  ↓
Repository / Service
  ↓
Provider / API / Database
```

Avoid:

```text
View → API
View → Database
View → Repository → UI
Repository → Controller
Service → Widget
```

Dependencies should not create circular relationships.

---

# 12. Architecture

A preferred structure is:

```text
lib/
├── app/
│   ├── bindings/
│   ├── config/
│   ├── routes/
│   └── theme/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── helpers/
│   ├── services/
│   └── utils/
│
├── data/
│   ├── models/
│   ├── providers/
│   └── repositories/
│
├── modules/
│   ├── auth/
│   │   ├── bindings/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── views/
│   │   └── widgets/
│   │
│   ├── home/
│   │   ├── bindings/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── views/
│   │   └── widgets/
│   │
│   └── ...
│
└── main.dart
```

However:

**This structure is a guideline, not an absolute requirement.**

If the existing project already has a structure that is reasonable and maintainable, do not move files simply to match this example.

Avoid unnecessary file movement.

---

# 13. UI Rules

Do not change the application's UI/UX.

Refactoring UI code means improving code organization without changing the visual result.

Allowed:

* Extract widget.
* Extract reusable component.
* Extract constants.
* Simplify widget tree where behavior remains identical.
* Move reusable widgets into appropriate folders.

Not allowed:

* Changing spacing.
* Changing colors.
* Changing typography.
* Changing navigation behavior.
* Changing animations.
* Changing user interaction.
* Changing responsive behavior.

Unless the existing implementation contains an obvious bug and the fix is necessary.

---

# 14. Large Widgets

Identify widgets that contain excessive responsibilities.

For example:

```dart
class SomePage extends StatelessWidget {
  // hundreds of lines
}
```

Consider extracting:

```text
SomePage
├── HeaderWidget
├── FilterWidget
├── ContentWidget
├── LoadingWidget
└── EmptyStateWidget
```

Extract widgets based on logical responsibility.

Do not split every small widget into a separate file unnecessarily.

---

# 15. Large Functions

Functions with excessive responsibilities should be split.

Example:

```dart
Future<void> submit() async {
  // validation
  // API call
  // parsing
  // state update
  // navigation
  // notification
}
```

Prefer separating responsibilities where appropriate:

```text
validate()
submitRequest()
handleResponse()
updateState()
navigate()
```

Do not blindly split functions if doing so makes the code harder to understand.

---

# 16. Models

Models should primarily represent data.

Avoid putting:

* API calls
* Navigation
* UI logic
* GetX controller logic

inside models.

Example:

```dart
class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
}
```

Keep serialization logic consistent with the existing project.

Do not change backend field names without a strong reason.

---

# 17. Services / Providers

Network and external-service implementation should not be embedded directly inside UI widgets.

Avoid:

```dart
Widget build(BuildContext context) {
  final response = await api.get(...);
}
```

Prefer:

```text
Controller
    ↓
Repository / Service
    ↓
API Provider
```

However, do not introduce a repository/service layer for trivial operations if it would only add unnecessary complexity.

---

# 18. Code Duplication

Identify repeated:

* API calls
* validation
* formatting
* constants
* UI components
* error handling
* conversion logic
* utility functions

Extract duplicated logic only when the abstraction is genuinely reusable.

Avoid creating generic helpers such as:

```dart
CommonHelper
Utils
GlobalManager
BaseController
BaseService
```

unless they have a clear and meaningful responsibility.

---

# 19. Dead Code

Potential dead code must NOT be deleted immediately.

Before deleting:

1. Search the entire project for references.
2. Check imports.
3. Check route references.
4. Check dependency injection.
5. Check reflection/dynamic usage if applicable.
6. Check generated code implications.
7. Confirm that the code is genuinely unused.

If uncertain:

**Keep it and report it as a dead-code candidate.**

---

# 20. Naming Convention

Use consistent Dart naming conventions.

### Classes

```dart
UserController
UserRepository
UserModel
UserService
UserPage
UserWidget
```

### Variables

```dart
userName
isLoading
selectedUser
```

### Methods

```dart
getUser()
fetchUsers()
updateUser()
deleteUser()
validateForm()
```

Avoid ambiguous names such as:

```dart
data
data2
temp
x
obj
manager
helper
doSomething()
```

unless the context makes the meaning obvious.

---

# 21. Error Handling

Do not silently swallow exceptions.

Avoid:

```dart
try {
  ...
} catch (_) {}
```

Prefer meaningful handling:

```dart
try {
  ...
} catch (e) {
  // Existing project error handling strategy
}
```

Do not introduce a completely new error-handling architecture unless necessary.

Preserve the project's existing error behavior.

---

# 22. Comments

Do not add comments explaining obvious code.

Avoid:

```dart
// Set loading to true
isLoading.value = true;
```

Prefer comments only when explaining:

* Why something is necessary.
* Non-obvious business rules.
* Workarounds.
* External API limitations.
* Important lifecycle decisions.

---

# 23. Formatting

Follow standard Dart formatting.

Use:

```bash
dart format lib/
```

Do not rely on manually formatted code.

Do not introduce custom formatting conventions unless the existing project explicitly requires them.

---

# 24. Validation

After refactoring, run:

```bash
flutter analyze
flutter test
```

If tests do not exist, do not create a large test suite solely for the refactoring unless specifically requested.

At minimum ensure:

```text
flutter analyze → PASS
flutter test → PASS
```

If there are pre-existing errors, identify them separately from errors introduced by the refactoring.

---

# 25. Git Safety

Before making large changes:

Check the current Git state:

```bash
git status
```

Do not overwrite or discard existing uncommitted user changes.

Never execute destructive commands such as:

```bash
git reset --hard
git clean -fd
git checkout -- .
```

unless explicitly instructed by the user.

Do not modify unrelated files.

---

# 26. Change Tracking

For every refactoring phase, provide a summary:

```text
## Changes

- Moved X to Y
- Extracted X widget
- Simplified X controller
- Removed confirmed unused import
- Extracted duplicated logic

## Validation

flutter analyze: PASS
flutter test: PASS

## Risk

Low / Medium / High
```

---

# 27. Final Refactoring Report

After all requested refactoring is complete, provide:

```text
# Refactoring Summary

## Architecture
...

## GetX
...

## Controllers
...

## UI
...

## Services / Repositories
...

## Code Duplication
...

## Dead Code
...

## Files Changed
...

## Validation
flutter analyze: PASS/FAIL
flutter test: PASS/FAIL

## Remaining Technical Debt
...

## Recommendations
...
```

---

# 28. Most Important Principle

The goal is **not** to make the project look architecturally impressive.

The goal is to make the existing Flutter project:

* Easier to understand
* Easier to maintain
* Easier to debug
* Easier to extend
* Safer to modify

while preserving existing behavior.

When choosing between:

```text
More abstraction
```

and:

```text
Simpler code
```

**Prefer simpler code.**

When choosing between:

```text
Large refactor
```

and:

```text
Small incremental refactor
```

**Prefer small incremental refactoring.**

When uncertain whether a change can affect behavior:

**Do not make the change silently. Identify the risk and report it first.**
