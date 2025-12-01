# frozen_string_literal: true

module SudokuSolver
  module Files
    class FileReader
      PUZZLE_SIZE = 81

      # Reads a puzzle file and returns a normalized puzzle string
      def self.read(file_path)
        raise ArgumentError, 'File not found' unless File.exist?(file_path)

        content = File.read(file_path)
        raise ArgumentError, 'File is empty' if content.strip.empty?

        parse(content, strict: true)
      end

      # Parses a puzzle string (single-line or multi-line format)
      # Formats accepted:
      # 1. Single-line: the first line has 81 characters (rest of file is ignored)
      #    - Digits 1-9 represent filled cells
      #    - Any other character (0, spaces, letters, etc.) represents empty cells (converted to '0')
      # 2. Multi-line: the first 9 lines with at most 9 characters each (rest of file is ignored)
      #    - Digits 1-9 represent filled cells
      #    - Any other character (0, spaces, letters, etc.) represents empty cells (converted to '0')
      #    - Lines with fewer than 9 characters are padded with '0'
      def self.parse(puzzle_string, strict: false)
        raise ArgumentError, 'Puzzle string is empty' if puzzle_string.strip.empty?

        # Split into lines
        lines = puzzle_string.split("\n")

        # Determine format: single-line (first line has 81 chars) or multi-line (9 lines)
        first_line = lines.first

        if first_line.length == PUZZLE_SIZE
          # Single-line format: only process the first line, ignore the rest
          normalized = first_line.gsub(/[^1-9]/, '0')
        else
          # Multi-line format: process first 9 lines, ignore the rest
          # Take only the first 9 lines
          puzzle_lines = lines.take(9)

          # Process each line: convert non-1-9 digits to '0' and pad to 9 characters
          normalized_lines = puzzle_lines.map do |line|
            # Convert non-1-9 digits to '0'
            converted = line.gsub(/[^1-9]/, '0')
            # Pad with '0' to reach 9 characters if needed
            converted.ljust(9, '0')
          end

          # Join all lines into a single string
          normalized = normalized_lines.join
        end

        if strict && normalized.length != PUZZLE_SIZE
          raise ArgumentError, "Puzzle must be exactly #{PUZZLE_SIZE} digits after parsing, got #{normalized.length}"
        end

        normalized
      end
    end
  end
end
