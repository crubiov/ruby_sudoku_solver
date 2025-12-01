# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SudokuSolver::Domain::Cell do
  describe '#initialize' do
    it 'creates an empty cell with candidates 1-9' do
      cell = described_class.new(row: 0, col: 0)

      expect(cell.value).to be_nil
      expect(cell.candidates).to contain_exactly(1, 2, 3, 4, 5, 6, 7, 8, 9)
      expect(cell.row).to eq(0)
      expect(cell.col).to eq(0)
      expect(cell.box).to eq(0)
    end

    it 'creates a given cell with a value and no candidates' do
      cell = described_class.new(row: 0, col: 0, value: 5)

      expect(cell.value).to eq(5)
      expect(cell.candidates).to be_empty
      expect(cell).to be_given
    end

    it 'raises error for invalid value (< 1)' do
      expect do
        described_class.new(row: 0, col: 0, value: 0)
      end.to raise_error(ArgumentError, 'Value must be between 1 and 9')
    end

    it 'raises error for invalid value (> 9)' do
      expect do
        described_class.new(row: 0, col: 0, value: 10)
      end.to raise_error(ArgumentError, 'Value must be between 1 and 9')
    end

    it 'calculates box correctly for various positions' do
      expect(described_class.new(row: 0, col: 0).box).to eq(0)
      expect(described_class.new(row: 0, col: 8).box).to eq(2)
      expect(described_class.new(row: 4, col: 4).box).to eq(4)
      expect(described_class.new(row: 8, col: 8).box).to eq(8)
    end
  end

  describe '#given?' do
    it 'returns true for cells initialized with a value' do
      cell = described_class.new(row: 0, col: 0, value: 5)
      expect(cell).to be_given
    end

    it 'returns false for cells initialized empty' do
      cell = described_class.new(row: 0, col: 0)
      expect(cell).not_to be_given
    end
  end

  describe '#solved?' do
    it 'returns true when cell has a value' do
      cell = described_class.new(row: 0, col: 0, value: 5)
      expect(cell).to be_solved
    end

    it 'returns false when cell has no value' do
      cell = described_class.new(row: 0, col: 0)
      expect(cell).not_to be_solved
    end
  end

  describe '#empty?' do
    it 'returns true when cell has no value' do
      cell = described_class.new(row: 0, col: 0)
      expect(cell).to be_empty
    end

    it 'returns false when cell has a value' do
      cell = described_class.new(row: 0, col: 0, value: 5)
      expect(cell).not_to be_empty
    end
  end

  describe '#candidate?' do
    let(:cell) { described_class.new(row: 0, col: 0) }

    it 'returns true when candidate exists' do
      expect(cell.candidate?(5)).to be true
    end

    it 'returns false when candidate does not exist' do
      cell.remove_candidate(5)
      expect(cell.candidate?(5)).to be false
    end

    it 'returns false for solved cells' do
      solved_cell = described_class.new(row: 0, col: 0, value: 5)
      expect(solved_cell.candidate?(5)).to be false
    end
  end

  describe '#remove_candidate' do
    let(:cell) { described_class.new(row: 0, col: 0) }

    it 'removes a candidate from the set' do
      cell.remove_candidate(5)
      expect(cell.candidates).not_to include(5)
      expect(cell.candidates.size).to eq(8)
    end

    it 'returns true when candidate was removed' do
      expect(cell.remove_candidate(5)).to be_truthy
    end

    it 'returns false when candidate was not present' do
      cell.remove_candidate(5)
      expect(cell.remove_candidate(5)).to be_falsey
    end

    it 'raises error when trying to remove from given cell' do
      given_cell = described_class.new(row: 0, col: 0, value: 5)
      expect do
        given_cell.remove_candidate(5)
      end.to raise_error(SudokuSolver::Domain::ImmutableCellError, 'Cannot modify given cell')
    end
  end

  describe '#value=' do
    let(:cell) { described_class.new(row: 0, col: 0) }

    it 'sets the value and clears candidates' do
      cell.value = 5
      expect(cell.value).to eq(5)
      expect(cell.candidates).to be_empty
    end

    it 'raises error when setting value on given cell' do
      given_cell = described_class.new(row: 0, col: 0, value: 3)
      expect do
        given_cell.value = 5
      end.to raise_error(SudokuSolver::Domain::ImmutableCellError, 'Cannot modify given cell')
    end

    it 'raises error for invalid value' do
      expect do
        cell.value = 10
      end.to raise_error(ArgumentError, 'Value must be between 1 and 9')
    end
  end

  describe '#to_s' do
    it 'returns the value as string for solved cells' do
      cell = described_class.new(row: 0, col: 0, value: 5)
      expect(cell.to_s).to eq('5')
    end

    it 'returns a dot for empty cells' do
      cell = described_class.new(row: 0, col: 0)
      expect(cell.to_s).to eq('.')
    end
  end

  describe '#position' do
    it 'returns a string representation of the position' do
      cell = described_class.new(row: 2, col: 5)
      expect(cell.position).to eq('R2C5')
    end
  end
end
