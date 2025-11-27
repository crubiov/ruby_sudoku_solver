# frozen_string_literal: true

module SudokuSolver
  module Domain
    # Represents a single cell in a Sudoku puzzle
    class Cell
      attr_reader :row, :col, :box, :value, :candidates

      def initialize(row:, col:, value: nil)
        @row = row
        @col = col
        @box = calculate_box(row, col)
        @given = !value.nil?

        validate_value!(value) if value

        @value = value
        @candidates = value.nil? ? Set.new(1..9) : Set.new
      end

      # Check if this is a given (immutable) cell
      def given?
        @given
      end

      # Check if cell has been solved (has a value)
      def solved?
        !@value.nil?
      end

      # Check if cell is empty (no value)
      def empty?
        @value.nil?
      end

      # Check if candidate exists in this cell
      def candidate?(candidate)
        @candidates.include?(candidate)
      end

      # Remove a candidate from this cell
      def remove_candidate(candidate)
        raise 'Cannot modify given cell' if given?

        @candidates.delete?(candidate) || false
      end

      # Set the value of this cell
      def value=(new_value)
        raise 'Cannot modify given cell' if given?

        validate_value!(new_value)
        @value = new_value
        @candidates.clear
      end

      # String representation of the cell
      def to_s
        @value&.to_s || '.'
      end

      # Position representation (e.g., "R0C5")
      def position
        "R#{@row}C#{@col}"
      end

      private

      def calculate_box(row, col)
        ((row / 3) * 3) + (col / 3)
      end

      def validate_value!(value)
        return if value.nil?

        raise ArgumentError, 'Value must be between 1 and 9' unless (1..9).cover?(value)
      end
    end
  end
end
