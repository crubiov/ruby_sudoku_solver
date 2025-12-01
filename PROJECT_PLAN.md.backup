# Ruby Sudoku Solver - Project Plan

**Project Goal**: Build a well-structured Sudoku solver in Ruby that uses logical solving techniques (no brute force) and provides explanations for each solving step.

**Learning Objectives**: Master Ruby programming while applying SOLID principles and software engineering best practices.

---

## Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Development Phases](#development-phases)
3. [Technical Specifications](#technical-specifications)
4. [Implementation Checklist](#implementation-checklist)
5. [Testing Strategy](#testing-strategy)
6. [Code Quality Standards](#code-quality-standards)

---

## Architecture Overview

### Core Components

```
┌─────────────────────────────────────────────────────────┐
│                    CLI Interface                        │
│                   (bin/solve)                           │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│                  Solver Engine                          │
│     Orchestrates strategies & manages solving loop      │
└────────────────────┬────────────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
┌───────▼──────┐ ┌───▼───────┐ ┌──▼─────────────────────┐
│   Board      │ │ Strategy  │ │  Parser/Formatter      │
│   Manager    │ │ Registry  │ │                        │
└──────┬───────┘ └───────────┘ └────────────────────────┘
       │              │
┌──────▼──────┐ ┌─────▼────────────────────────────────┐
│   Cell      │ │  Solving Strategies (70+ techniques) │
│   Model     │ │  - Basic (Singles)                   │
└─────────────┘ │  - Easy (Pairs, Pointing)            │
                │  - Medium (Triples, Quads)           │
                │  - Hard (Fish, Wings)                │
                │  - Expert (Coloring, Chains, ALS)    │
                └──────────────────────────────────────┘
```

### Design Principles Applied

- **Single Responsibility Principle**: Each class has one clear purpose
- **Open/Closed Principle**: Strategy pattern allows extension without modification
- **Liskov Substitution Principle**: All strategies are interchangeable
- **Interface Segregation Principle**: Small, focused interfaces
- **Dependency Inversion Principle**: Depend on abstractions, not concretions
- **DRY**: Extract common logic to shared methods/modules
- **KISS**: Start simple, refactor when needed
- **YAGNI**: Build what's needed now

---

## Development Phases

### Phase 1: Foundation & Core Models ⏱️ (Est: 3-5 hours)

**Goal**: Set up project structure and implement core data models

#### Tasks:
- [x] Initialize project structure
- [ ] Configure development tools (RuboCop, RSpec)
- [ ] Implement `Cell` class
  - Store value, candidates, position (row, col, box)
  - Track if given (immutable) or derived
  - Manage candidate elimination
- [ ] Implement `Board` class
  - Manage 9x9 grid of cells
  - Provide access by row, column, box
  - Calculate peer relationships (cells that see each other)
  - Implement board validation
- [ ] Implement `Parser` class
  - Read puzzle from text file
  - Support multiple input formats
  - Validate input data
- [ ] Write comprehensive tests for above

**Deliverables**:
- `lib/sudoku_solver/cell.rb`
- `lib/sudoku_solver/board.rb`
- `lib/sudoku_solver/parser.rb`
- `lib/sudoku_solver/models/house.rb` (Row/Column/Box abstraction)
- `lib/sudoku_solver/models/candidate_set.rb`
- Complete test coverage (spec files)

**Success Criteria**:
- Can load a puzzle from a file
- Can represent board state correctly
- All tests passing
- RuboCop violations: 0

---

### Phase 2: Solver Engine & Basic Strategies ⏱️ (Est: 4-6 hours)

**Goal**: Build the solving engine and implement fundamental techniques

#### Tasks:
- [ ] Implement `BaseStrategy` abstract class
  - Define strategy interface
  - Common utility methods
  - Difficulty level tracking
- [ ] Implement `StrategyRegistry`
  - Register strategies
  - Provide strategies by difficulty
  - Find applicable strategy
- [ ] Implement `Solver` class
  - Apply strategies iteratively
  - Track solving steps
  - Detect completion and deadlock
- [ ] Implement `Step` class (records solving actions)
- [ ] Implement **Naked Single** strategy
  - Cell with only one candidate
  - Difficulty: Simple (Level 1)
- [ ] Implement **Hidden Single** strategy
  - Candidate appears only once in a house
  - Difficulty: Simple (Level 1)
- [ ] Implement candidate generation
- [ ] Write tests for all components

**Deliverables**:
- `lib/sudoku_solver/solver.rb`
- `lib/sudoku_solver/strategy_registry.rb`
- `lib/sudoku_solver/strategies/base_strategy.rb`
- `lib/sudoku_solver/strategies/naked_single.rb`
- `lib/sudoku_solver/strategies/hidden_single.rb`
- `lib/sudoku_solver/models/step.rb`
- Test files

**Success Criteria**:
- Can solve "easy" puzzles using only Singles
- Solver provides step-by-step explanations
- All tests passing

---

### Phase 3: Easy/Medium Strategies ⏱️ (Est: 6-8 hours)

**Goal**: Implement intermediate solving techniques

#### Tasks:
- [ ] **Naked Pairs** (Difficulty: Easy - Level 2)
  - Two cells in same house with same 2 candidates
  - Eliminate those candidates from peers
- [ ] **Hidden Pairs** (Difficulty: Easy - Level 2)
  - Two candidates appearing only in same 2 cells in house
- [ ] **Pointing Pairs** (Difficulty: Easy - Level 2)
  - Candidates in box pointing to same row/column
- [ ] **Pointing Triples** (Difficulty: Medium - Level 3)
- [ ] **Naked Triples** (Difficulty: Medium - Level 3)
  - Three cells with same 3 candidates
- [ ] **Naked Quads** (Difficulty: Medium - Level 3)
- [ ] **Hidden Triples** (Difficulty: Medium - Level 3)
- [ ] **Hidden Quads** (Difficulty: Medium - Level 3)
- [ ] **Box/Line Reduction (Claiming)** (Difficulty: Medium - Level 3)
  - Candidates in row/column only in one box
- [ ] Refactor common subset logic (DRY principle)
- [ ] Write comprehensive tests

**Deliverables**:
- `lib/sudoku_solver/strategies/naked_subset.rb` (handles pairs/triples/quads)
- `lib/sudoku_solver/strategies/hidden_subset.rb`
- `lib/sudoku_solver/strategies/pointing_pair.rb`
- `lib/sudoku_solver/strategies/box_line_reduction.rb`
- Test files

**Success Criteria**:
- Can solve "medium" difficulty puzzles
- Proper candidate elimination tracking
- Clear explanations for each technique
- All tests passing

---

### Phase 4: Hard Strategies (Fish & Wings) ⏱️ (Est: 8-10 hours)

**Goal**: Implement advanced pattern-matching techniques

#### Tasks:
- [ ] **X-Wing** (Difficulty: Hard - Level 4)
  - 2 rows/columns with candidate in exactly 2 positions
  - Forms rectangle pattern
- [ ] **Swordfish** (Difficulty: Hard - Level 4)
  - Extension of X-Wing to 3 rows/columns
- [ ] **Jellyfish** (Difficulty: Hard - Level 4)
  - Extension to 4 rows/columns
- [ ] **XY-Wing** (Difficulty: Hard - Level 4)
  - Pattern with pivot and pincers
- [ ] **XYZ-Wing** (Difficulty: Hard - Level 4)
  - XY-Wing variant with triple in pivot
- [ ] Refactor common fish logic
- [ ] Write comprehensive tests

**Deliverables**:
- `lib/sudoku_solver/strategies/basic_fish.rb` (X-Wing, Swordfish, Jellyfish)
- `lib/sudoku_solver/strategies/xy_wing.rb`
- `lib/sudoku_solver/strategies/xyz_wing.rb`
- Test files

**Success Criteria**:
- Can solve "hard" difficulty puzzles
- Accurate pattern detection
- Clear visual explanations
- All tests passing

---

### Phase 5: Expert Strategies ⏱️ (Est: 10-15 hours)

**Goal**: Implement advanced coloring and chaining techniques

#### Tasks:
- [ ] **Simple Coloring** (Difficulty: Expert - Level 5)
  - Color candidates in conjugate pairs
- [ ] **Multi-Coloring** (Difficulty: Expert - Level 5)
- [ ] **Y-Wing** (Difficulty: Expert - Level 5)
- [ ] **W-Wing** (Difficulty: Expert - Level 5)
- [ ] **Forcing Chains** (Difficulty: Advanced - Level 6)
  - Follow candidate implications
- [ ] **X-Chains** (Difficulty: Advanced - Level 6)
- [ ] **XY-Chains** (Difficulty: Advanced - Level 6)
- [ ] **ALS (Almost Locked Sets)** (Difficulty: Advanced - Level 6)
  - N+1 candidates in N cells
- [ ] **ALS-XZ** technique
- [ ] Write comprehensive tests

**Deliverables**:
- `lib/sudoku_solver/strategies/simple_coloring.rb`
- `lib/sudoku_solver/strategies/y_wing.rb`
- `lib/sudoku_solver/strategies/w_wing.rb`
- `lib/sudoku_solver/strategies/forcing_chains.rb`
- `lib/sudoku_solver/strategies/als.rb`
- Test files

**Success Criteria**:
- Can solve "expert" and "diabolical" puzzles
- Correct chain detection and following
- All tests passing

---

### Phase 6: Last Resort & Backtracking ⏱️ (Est: 3-4 hours)

**Goal**: Implement fallback solving method

#### Tasks:
- [ ] **Backtracking/Brute Force** (Difficulty: Last Resort - Level 7)
  - Try candidate values recursively
  - Only when logical methods exhausted
  - Track that backtracking was used
- [ ] Optimize backtracking performance
- [ ] Write tests

**Deliverables**:
- `lib/sudoku_solver/strategies/backtracking.rb`
- Test files

**Success Criteria**:
- Can solve ANY valid puzzle
- Clearly indicates when backtracking used
- Acceptable performance (< 1 second for most puzzles)

---

### Phase 7: CLI Interface & User Experience ⏱️ (Est: 4-6 hours)

**Goal**: Create polished command-line interface

#### Tasks:
- [ ] Implement `Formatter` class
  - Pretty-print board with colors
  - Format step explanations
  - Highlight affected cells
- [ ] Implement `Validator` class
  - Check puzzle validity
  - Detect multiple solutions
- [ ] Implement `DifficultyRater` class
  - Rate puzzle based on techniques needed
- [ ] Create `bin/solve` executable
  - Parse command-line arguments
  - Implement modes: solve, hint, validate, rate
  - Handle errors gracefully
- [ ] Add colored terminal output (using gems like `colorize`)
- [ ] Write integration tests

**Deliverables**:
- `lib/sudoku_solver/formatter.rb`
- `lib/sudoku_solver/validator.rb`
- `lib/sudoku_solver/difficulty_rater.rb`
- `bin/solve` (executable)
- Integration tests

**CLI Usage Examples**:
```bash
# Solve completely
./bin/solve puzzles/easy/puzzle1.txt

# Solve with step-by-step explanation
./bin/solve puzzles/medium/puzzle2.txt --explain

# Show only next hint
./bin/solve puzzles/hard/puzzle3.txt --hint

# Validate puzzle
./bin/solve puzzles/expert/puzzle4.txt --validate

# Rate difficulty
./bin/solve puzzles/puzzle5.txt --rate

# Interactive mode
./bin/solve puzzles/puzzle6.txt --interactive
```

**Success Criteria**:
- Intuitive CLI interface
- Beautiful, colored output
- Comprehensive help documentation
- All integration tests passing

---

### Phase 8: Documentation & Polish ⏱️ (Est: 3-4 hours)

**Goal**: Complete documentation and final refinements

#### Tasks:
- [ ] Write comprehensive README.md
  - Installation instructions
  - Usage examples
  - Architecture overview
  - Contributing guidelines
- [ ] Add YARD documentation to all public methods
- [ ] Create example puzzles for each difficulty
- [ ] Generate code coverage report
- [ ] Final RuboCop cleanup
- [ ] Create CHANGELOG.md
- [ ] Add LICENSE file (if not exists)
- [ ] Create tutorial/walkthrough document

**Deliverables**:
- Updated README.md
- YARD documentation
- Example puzzles in `puzzles/` directory
- Code coverage report
- Clean RuboCop run
- CHANGELOG.md

**Success Criteria**:
- Documentation complete and clear
- Code coverage > 95%
- Zero RuboCop violations
- Professional, production-ready codebase

---

## Technical Specifications

### File Format Support

**Format 1: Compact (9 lines, 9 chars each)**
```
530070000
600195000
098000060
800060003
400803001
700020006
060000280
000419005
000080079
```

**Format 2: Formatted with separators**
```
5 3 0 | 0 7 0 | 0 0 0
6 0 0 | 1 9 5 | 0 0 0
0 9 8 | 0 0 0 | 0 6 0
------+-------+------
8 0 0 | 0 6 0 | 0 0 3
4 0 0 | 8 0 3 | 0 0 1
7 0 0 | 0 2 0 | 0 0 6
------+-------+------
0 6 0 | 0 0 0 | 2 8 0
0 0 0 | 4 1 9 | 0 0 5
0 0 0 | 0 8 0 | 0 7 9
```

**Format 3: Single line**
```
530070000600195000098000060800060003400803001700020006060000280000419005000080079
```

- `0` or `.` represents empty cells
- Ignore whitespace, pipes, dashes
- Validate: exactly 81 digits, valid sudoku rules

---

### Strategy Difficulty Levels

| Level | Rating | Strategies |
|-------|--------|------------|
| 1 | Simple | Naked Single, Hidden Single |
| 2 | Easy | Naked Pair, Hidden Pair, Pointing Pairs |
| 3 | Medium | Naked Triple/Quad, Hidden Triple/Quad, Pointing Triples, Box/Line Reduction |
| 4 | Hard | X-Wing, Swordfish, Jellyfish, XY-Wing, XYZ-Wing |
| 5 | Expert | Simple Coloring, Multi-Coloring, Y-Wing, W-Wing |
| 6 | Advanced | Forcing Chains, X-Chains, XY-Chains, ALS techniques |
| 7 | Last Resort | Backtracking (Brute Force) |

---

### Class Responsibilities

#### `Cell`
- Store value or candidates
- Track position (row, col, box)
- Manage candidate elimination
- Know if it's a given or derived value

#### `Board`
- Manage 9x9 grid
- Provide row/column/box access
- Calculate peer relationships
- Validate board state
- Track changes

#### `House` (Row/Column/Box)
- Represent a group of 9 cells
- Provide cell iteration
- Find cells with specific candidates

#### `BaseStrategy`
- Define strategy interface
- Track difficulty level
- Provide common utilities
- Return `Step` or `nil`

#### `Solver`
- Orchestrate solving process
- Apply strategies in order
- Track all steps taken
- Detect completion/deadlock
- Support step-by-step or complete solve

#### `StrategyRegistry`
- Register all strategies
- Provide strategies by difficulty
- Find next applicable strategy

#### `Step`
- Record what was done (value set or candidates eliminated)
- Store explanation
- Track affected cells
- Reference strategy used

#### `Parser`
- Read puzzle files
- Support multiple formats
- Validate input
- Create Board instance

#### `Formatter`
- Pretty-print board
- Format step explanations
- Highlight cells
- Colored output

#### `Validator`
- Check puzzle validity
- Detect multiple solutions
- Verify solved state

#### `DifficultyRater`
- Analyze puzzle
- Rate based on techniques needed
- Provide difficulty report

---

## Implementation Checklist

### Setup
- [ ] RSpec configuration
- [ ] RuboCop configuration (.rubocop.yml)
- [ ] Gemfile with dependencies
- [ ] Git ignore file
- [ ] CI setup (optional: GitHub Actions)

### Core Models (Phase 1)
- [ ] Cell class with tests
- [ ] Board class with tests
- [ ] House class with tests
- [ ] CandidateSet class with tests
- [ ] Parser class with tests

### Solver Engine (Phase 2)
- [ ] BaseStrategy with tests
- [ ] StrategyRegistry with tests
- [ ] Solver with tests
- [ ] Step class with tests
- [ ] Naked Single strategy with tests
- [ ] Hidden Single strategy with tests

### Easy/Medium Strategies (Phase 3)
- [ ] Naked Pairs with tests
- [ ] Hidden Pairs with tests
- [ ] Pointing Pairs with tests
- [ ] Pointing Triples with tests
- [ ] Naked Triples with tests
- [ ] Naked Quads with tests
- [ ] Hidden Triples with tests
- [ ] Hidden Quads with tests
- [ ] Box/Line Reduction with tests

### Hard Strategies (Phase 4)
- [ ] X-Wing with tests
- [ ] Swordfish with tests
- [ ] Jellyfish with tests
- [ ] XY-Wing with tests
- [ ] XYZ-Wing with tests

### Expert Strategies (Phase 5)
- [ ] Simple Coloring with tests
- [ ] Multi-Coloring with tests
- [ ] Y-Wing with tests
- [ ] W-Wing with tests
- [ ] Forcing Chains with tests
- [ ] X-Chains with tests
- [ ] XY-Chains with tests
- [ ] ALS techniques with tests

### Last Resort (Phase 6)
- [ ] Backtracking with tests

### CLI & UX (Phase 7)
- [ ] Formatter with tests
- [ ] Validator with tests
- [ ] DifficultyRater with tests
- [ ] bin/solve executable
- [ ] Command-line argument parsing
- [ ] Integration tests

### Documentation (Phase 8)
- [ ] README.md complete
- [ ] YARD docs for all public methods
- [ ] Example puzzles (all difficulties)
- [ ] Code coverage report
- [ ] CHANGELOG.md
- [ ] Tutorial document

---

## Testing Strategy

### Unit Tests
- Test each class in isolation
- Mock dependencies
- Cover edge cases
- Test both success and failure paths
- Aim for 100% code coverage of business logic

### Integration Tests
- Test strategies on real puzzles
- Verify solver can solve puzzles of each difficulty
- Test CLI commands end-to-end
- Verify file I/O works correctly

### Test Data
- Collect puzzles of each difficulty level
- Include edge cases (minimal givens, symmetric, etc.)
- Test invalid puzzles
- Test unsolvable puzzles

### TDD Approach
1. Write failing test
2. Implement minimal code to pass
3. Refactor
4. Repeat

---

## Code Quality Standards

### Ruby Style Guide
- Follow community Ruby Style Guide
- Use RuboCop for enforcement
- 2-space indentation
- Max 80-100 character lines
- Meaningful names (no abbreviations unless obvious)

### Naming Conventions
- Classes: `CamelCase`
- Methods/Variables: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`
- Predicate methods: `?` suffix (e.g., `solved?`)
- Dangerous methods: `!` suffix (e.g., `solve!`)

### Documentation
- YARD-style comments for public APIs
- Inline comments only for complex logic
- Self-documenting code (clear names)
- README with examples

### Idiomatic Ruby
- Use `attr_reader`, `attr_writer`, `attr_accessor`
- Prefer blocks over loops
- Use enumerables (`map`, `select`, `each`, etc.)
- Leverage Ruby idioms (e.g., `||=`, `&.`, `=>`)
- Use symbols for hash keys
- Prefer keyword arguments for clarity

### Performance Considerations
- Avoid premature optimization
- Profile before optimizing
- Use efficient data structures
- Cache expensive computations
- Lazy evaluation where appropriate

### Error Handling
- Use exceptions for exceptional cases
- Create custom exception classes
- Fail fast on invalid input
- Provide clear error messages

---

## Resources & References

### Solving Techniques
- [Sudoku Solutions](https://www.sudoku-solutions.com/) - Comprehensive techniques
- [HoDoKu](https://hodoku.sourceforge.net/en/tech_intro.php) - 70+ techniques
- [Sudopedia](http://www.sudopedia.org/wiki/Main_Page) - Sudoku encyclopedia
- [Andrew Stuart's Solver](https://www.sudokuwiki.org/) - Strategy explanations

### Ruby Resources
- [Ruby Style Guide](https://rubystyle.guide/)
- [RSpec Documentation](https://rspec.info/)
- [RuboCop](https://rubocop.org/)
- [YARD Documentation](https://yardoc.org/)
- [Ruby API Documentation](https://ruby-doc.org/)

### Design Patterns
- Strategy Pattern (for solving techniques)
- Factory Pattern (for creating strategies)
- Observer Pattern (for tracking changes)
- Command Pattern (for undo/redo if needed)

---

## Progress Tracking

**Total Estimated Time**: 45-65 hours

**Current Phase**: Phase 1 - Foundation & Core Models

**Last Updated**: October 31, 2025

---

## Notes & Decisions

### Architectural Decisions
1. **Strategy Pattern**: Chosen for flexibility in adding new solving techniques
2. **No Brute Force First**: Focus on logical solving; backtracking only as last resort
3. **Step Recording**: Track every step for explanation and educational value
4. **Immutable Givens**: Given cells cannot be modified
5. **Test-Driven**: Write tests first for all components

### Future Enhancements (Post-MVP)
- Web interface
- Puzzle generator
- Puzzle difficulty estimator
- Visual step-by-step solver
- Export solving steps to PDF/HTML
- Sudoku variants (X-Sudoku, Killer Sudoku, etc.)
- Performance benchmarking suite
- Parallel solving strategies

---

## Questions & Blockers

_(Document any questions or blockers as they arise)_

- None currently

---

**Let's build something great! 🚀**
