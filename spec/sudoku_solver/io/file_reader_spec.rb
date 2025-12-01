# frozen_string_literal: true

require 'spec_helper'
require 'tmpdir'
require 'fileutils'

RSpec.describe SudokuSolver::IO::FileReader do
  let(:temp_dir) { Dir.mktmpdir }

  after { FileUtils.rm_rf(temp_dir) }

  describe '.read' do
    it 'reads single-line puzzle file' do
      file_path = File.join(temp_dir, 'single_line.txt')
      File.write(file_path, '530070000600195000098000060800060003400803001700020006060000280000419005000080079')

      puzzle = described_class.read(file_path)

      expect(puzzle).to eq('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
      expect(puzzle.length).to eq(81)
    end

    it 'reads multi-line puzzle file' do
      file_path = File.join(temp_dir, 'multi_line.txt')
      File.write(file_path, <<~PUZZLE)
        530070000
        600195000
        098000060
        800060003
        400803001
        700020006
        060000280
        000419005
        000080079
      PUZZLE

      puzzle = described_class.read(file_path)

      expect(puzzle).to eq('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
      expect(puzzle.length).to eq(81)
    end

    it 'ignores lines after the puzzle data in single-line file' do
      file_path = File.join(temp_dir, 'single_line_with_comments.txt')
      File.write(file_path, <<~PUZZLE)
        530070000600195000098000060800060003400803001700020006060000280000419005000080079
        This is a comment
        Another comment line
      PUZZLE

      puzzle = described_class.read(file_path)
      expect(puzzle).to eq('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
    end

    it 'ignores lines after the puzzle data in multi-line file' do
      file_path = File.join(temp_dir, 'multi_line_with_comments.txt')
      File.write(file_path, <<~PUZZLE)
        530070000
        600195000
        098000060
        800060003
        400803001
        700020006
        060000280
        000419005
        000080079
        This is a comment
        Another comment line
      PUZZLE

      puzzle = described_class.read(file_path)
      expect(puzzle).to eq('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
    end

    it 'raises error if file does not exist' do
      expect do
        described_class.read('non_existent.txt')
      end.to raise_error(ArgumentError, /File not found/)
    end

    it 'raises error if file is empty' do
      file_path = File.join(temp_dir, 'empty.txt')
      File.write(file_path, '')

      expect do
        described_class.read(file_path)
      end.to raise_error(ArgumentError, 'File is empty')
    end

    it 'raises error if puzzle is invalid length' do
      file_path = File.join(temp_dir, 'invalid.txt')
      File.write(file_path, '12345')

      expect do
        described_class.read(file_path)
      end.to raise_error(ArgumentError, /must be exactly 81/)
    end
  end

  describe '.parse' do
    it 'parses single-line puzzle string' do
      puzzle_string = '530070000600195000098000060800060003400803001700020006060000280000419005000080079'
      result = described_class.parse(puzzle_string)

      expect(result).to eq(puzzle_string)
      expect(result.length).to eq(81)
    end

    it 'parses multi-line puzzle string' do
      puzzle_string = <<~PUZZLE
        530070000
        600195000
        098000060
        800060003
        400803001
        700020006
        060000280
        000419005
        000080079
      PUZZLE

      result = described_class.parse(puzzle_string)
      expect(result).to eq('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
    end

    it 'ignores lines after the first 9 in multi-line format' do
      puzzle_string = <<~PUZZLE
        530070000
        600195000
        098000060
        800060003
        400803001
        700020006
        060000280
        000419005
        000080079
        This is a comment line
        Another comment
      PUZZLE

      result = described_class.parse(puzzle_string)
      expect(result).to eq('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
    end

    it 'converts non-1-9 characters to empty cells in single-line format' do
      # Create an 81-character string with non-1-9 characters mixed in
      puzzle_string = '5a3b0c0d0e0f6a0a1a9a5b0c0d9e8f0a0b0c6d0e8f0a0b0c6d0e0f0a0b3c4d0a8e0f3g0a1h7i0a2j0'
      result = described_class.parse(puzzle_string, strict: true)
      expect(result.length).to eq(81)
      expect(result).to match(/\A[0-9]{81}\z/)
    end

    it 'pads lines with fewer than 9 characters' do
      puzzle_string = "5 3 0\n6 0 0\n0 9 8"
      result = described_class.parse(puzzle_string, strict: false)
      expect(result.length).to eq(27)
      # "5 3 0" -> "50300" -> "503000000"
      # "6 0 0" -> "60000" -> "600000000"
      # "0 9 8" -> "00908" -> "009080000"
      expect(result).to eq('503000000600000000009080000')
    end

    it 'raises error for empty string' do
      expect do
        described_class.parse('')
      end.to raise_error(ArgumentError, 'Puzzle string is empty')
    end

    it 'raises error for invalid length after parsing' do
      expect do
        described_class.parse('12345', strict: true)
      end.to raise_error(ArgumentError, /must be exactly 81/)
    end
  end
end
