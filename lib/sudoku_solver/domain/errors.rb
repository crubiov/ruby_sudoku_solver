# frozen_string_literal: true

module SudokuSolver
  module Domain
    # Base exception for domain errors
    class DomainError < StandardError; end

    # Raised when attempting to modify an immutable (given) cell
    class ImmutableCellError < DomainError; end

    # Raised when an invalid value is provided to a cell
    class InvalidValueError < DomainError; end
  end
end
