# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SudokuSolver::Domain::Board do
  describe '#initialize' do
    it 'creates an empty 9x9 board' do
      board = described_class.new

      expect(board.cells.size).to eq(81)
      expect(board.cells.all?(&:empty?)).to be true
    end

    it 'creates board from string with given values' do
      puzzle = '530070000600195000098000060800060003400803001700020006060000280000419005000080079'
      board = described_class.new(puzzle)

      expect(board.cell(0, 0).value).to eq(5)
      expect(board.cell(0, 1).value).to eq(3)
      expect(board.cell(0, 2)).to be_empty
      expect(board.cell(0, 0)).to be_given
    end

    it 'raises error for invalid puzzle length' do
      expect do
        described_class.new('12345')
      end.to raise_error(ArgumentError, 'Puzzle must be exactly 81 characters')
    end

    it 'raises error for invalid characters' do
      expect do
        described_class.new('a' * 81)
      end.to raise_error(ArgumentError, 'Puzzle must contain only digits 0-9 or dots')
    end
  end

  describe '#cell' do
    let(:board) { described_class.new }

    it 'returns cell at given row and column' do
      cell = board.cell(0, 0)
      expect(cell.row).to eq(0)
      expect(cell.col).to eq(0)
    end

    it 'raises error for invalid row' do
      expect { board.cell(9, 0) }.to raise_error(ArgumentError, 'Row must be between 0 and 8')
    end

    it 'raises error for invalid column' do
      expect { board.cell(0, 9) }.to raise_error(ArgumentError, 'Column must be between 0 and 8')
    end
  end

  describe '#row' do
    let(:board) do
      described_class.new('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
    end

    it 'returns all cells in a row' do
      row = board.row(0)
      expect(row.size).to eq(9)
      expect(row.map(&:value)).to eq([5, 3, nil, nil, 7, nil, nil, nil, nil])
    end

    it 'raises error for invalid row index' do
      expect { board.row(9) }.to raise_error(ArgumentError, 'Row must be between 0 and 8')
    end
  end

  describe '#column' do
    let(:board) do
      described_class.new('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
    end

    it 'returns all cells in a column' do
      col = board.column(0)
      expect(col.size).to eq(9)
      expect(col.map(&:value)).to eq([5, 6, nil, 8, 4, 7, nil, nil, nil])
    end

    it 'raises error for invalid column index' do
      expect { board.column(9) }.to raise_error(ArgumentError, 'Column must be between 0 and 8')
    end
  end

  describe '#box' do
    let(:board) do
      described_class.new('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
    end

    it 'returns all cells in a box' do
      box = board.box(0)
      expect(box.size).to eq(9)
      expect(box.map(&:value)).to eq([5, 3, nil, 6, nil, nil, nil, 9, 8])
    end

    it 'raises error for invalid box index' do
      expect { board.box(9) }.to raise_error(ArgumentError, 'Box must be between 0 and 8')
    end
  end

  describe '#peers_of' do
    let(:board) { described_class.new }
    let(:target_cell) { board.cell(0, 0) }

    it 'returns all cells that see the target cell' do
      peers = board.peers_of(target_cell)

      # Should have 20 peers: 8 in row + 8 in column + 4 in box (excluding self)
      expect(peers.size).to eq(20)
      expect(peers).not_to include(target_cell)
    end

    it 'includes all cells in same row' do
      peers = board.peers_of(target_cell)
      row_peers = peers.select { |c| c.row == 0 }
      expect(row_peers.size).to eq(8)
    end

    it 'includes all cells in same column' do
      peers = board.peers_of(target_cell)
      col_peers = peers.select { |c| c.col == 0 }
      expect(col_peers.size).to eq(8)
    end

    it 'includes all cells in same box' do
      peers = board.peers_of(target_cell)
      box_peers = peers.select { |c| c.box == 0 && c != target_cell }
      # Cell (0,0) has 8 other cells in same box, but 4 are already counted in row/col
      # So unique box peers (not in row 0 or col 0) should be 4
      unique_box_peers = box_peers.reject { |c| c.row == 0 || c.col == 0 }
      expect(unique_box_peers.size).to eq(4)
    end
  end

  describe '#solved?' do
    it 'returns false for empty board' do
      board = described_class.new
      expect(board).not_to be_solved
    end

    it 'returns false for partially solved board' do
      board = described_class.new('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
      expect(board).not_to be_solved
    end

    it 'returns true for completely solved board' do
      solved = '534678912672195348198342567859761423426853791713924856961537284287419635345286179'
      board = described_class.new(solved)
      expect(board).to be_solved
    end
  end

  describe '#valid?' do
    it 'returns true for valid board' do
      board = described_class.new('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
      expect(board).to be_valid
    end

    it 'returns false when row has duplicates' do
      board = described_class.new('550070000600195000098000060800060003400803001700020006060000280000419005000080079')
      expect(board).not_to be_valid
    end

    it 'returns false when column has duplicates' do
      board = described_class.new('530070000500195000098000060800060003400803001700020006060000280000419005000080079')
      expect(board).not_to be_valid
    end

    it 'returns false when box has duplicates' do
      board = described_class.new('535070000600195000098000060800060003400803001700020006060000280000419005000080079')
      expect(board).not_to be_valid
    end
  end

  describe '#to_s' do
    it 'returns string representation of the board' do
      board = described_class.new('530070000600195000098000060800060003400803001700020006060000280000419005000080079')
      output = board.to_s

      expect(output).to include('5 3 .')
      expect(output).to include('6 . .')
      expect(output.lines.count).to be > 9 # Should have separator lines
    end
  end
end
