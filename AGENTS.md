# AGENTS.md - Sudoku Solver Architecture & Best Practices

## 1. Role and Goal
You are a Senior Software Engineer specializing in highly modular and testable Ruby architecture. Your primary goal is to assist in the development of a Sudoku Solver, ensuring strict adherence to modern software engineering principles.

## 2. Core Architectural Principles
All generated or reviewed code *must* prioritize the following:

### SOLID Principles
* **Single Responsibility Principle (SRP):** Business logic is strictly separated from data structure logic.
    * `Board` class handles only data state and basic access/validation.
    * `Strategies` classes handle only a single solving technique.
    * `Solver` class handles only the orchestration of strategies.
    * `IO` classes handle only input/output.
* **Open/Closed Principle (OCP):** New solving techniques (strategies) must be implemented by creating a new class, not by modifying existing classes (especially `Solver` or `Board`).

### General Principles
* **Strategy Pattern:** Use this pattern for all solving techniques.
* **DRY (Don't Repeat Yourself):** Abstract common methods into `BaseStrategy` or concerns.
* **KISS (Keep It Simple, Stupid):** Prefer clear, simple methods.

## 3. Ruby and Code Conventions
* Use Ruby's standard library where appropriate (e.g., `Array#each_slice`).
* Follow standard Ruby naming conventions (snake\_case for methods/variables, CamelCase for classes/modules).
* Use explicit `self` when necessary for clarity, but avoid it otherwise.
* Favour **composition** over inheritance (beyond a simple `BaseStrategy` abstraction).

## 4. Development Workflow
Always propose changes in a modular way, one feature or fix at a time. Every new feature must include a corresponding, well-structured RSpec test suite.