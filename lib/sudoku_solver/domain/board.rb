# frozen_string_literal: true

require_relative 'cell'

module SudokuSolver
  module Domain
    # Represents a 9x9 Sudoku board with 81 cells
    class Board
      attr_reader :cells

      def initialize(puzzle = nil)
        @cells = create_cells(puzzle)
      end

      # Get cell at specific row and column
      def cell(row, col)
        validate_index!(row, 'Row')
        validate_index!(col, 'Column')
        @cells[(row * 9) + col]
      end

      # Get all cells in a specific row (0-8)
      def row(index)
        validate_index!(index, 'Row')
        @cells.select { |c| c.row == index }
      end

      # Get all cells in a specific column (0-8)
      def column(index)
        validate_index!(index, 'Column')
        @cells.select { |c| c.col == index }
      end

      # Get all cells in a specific box (0-8)
      def box(index)
        validate_index!(index, 'Box')
        @cells.select { |c| c.box == index }
      end

      # Get all cells that see the given cell (same row, column, or box)
      def peers_of(cell)
        peers = []
        peers += row(cell.row)
        peers += column(cell.col)
        peers += box(cell.box)
        peers.uniq.reject { |c| c == cell }
      end

      # Check if board is completely solved
      def solved?
        @cells.all?(&:solved?)
      end

      # Check if board is in a valid state (no duplicates in rows, columns, or boxes)
      def valid?
        validate_houses(0..8, method(:row)) &&
          validate_houses(0..8, method(:column)) &&
          validate_houses(0..8, method(:box))
      end

      # String representation of the board
      def to_s
        lines = []
        (0..8).each do |row_idx|
          row_cells = row(row_idx)
          line = row_cells.each_slice(3).map do |slice|
            slice.map(&:to_s).join(' ')
          end.join(' | ')
          lines << line
          lines << '------+-------+------' if [2, 5].include?(row_idx)
        end
        lines.join("\n")
      end

      private

      def create_cells(puzzle)
        if puzzle.nil?
          # Create empty board
          81.times.map { |i| Cell.new(row: i / 9, col: i % 9) }
        else
          # Validate puzzle string
          validate_puzzle!(puzzle)
          # Create cells from puzzle string
          puzzle.chars.each_with_index.map do |char, i|
            value = char == '0' ? nil : char.to_i
            Cell.new(row: i / 9, col: i % 9, value: value)
          end
        end
      end

      def validate_puzzle!(puzzle)
        raise ArgumentError, 'Puzzle must be exactly 81 characters' unless puzzle.length == 81
        return if puzzle.match?(/\A[0-9]+\z/)

        raise ArgumentError, 'Puzzle must contain only digits 0-9'
      end

      def validate_index!(index, name)
        raise ArgumentError, "#{name} must be between 0 and 8" unless (0..8).cover?(index)
      end

      def validate_houses(range, house_method)
        range.all? do |index|
          cells = house_method.call(index)
          values = cells.map(&:value).compact
          values.size == values.uniq.size
        end
      end
    end
  end
end
