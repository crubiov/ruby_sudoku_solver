# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SudokuSolver::Domain::DomainError do
  it 'is a subclass of StandardError' do
    expect(described_class).to be < StandardError
  end

  it 'can be raised and caught' do
    expect do
      raise SudokuSolver::Domain::DomainError, 'test error'
    end.to raise_error(SudokuSolver::Domain::DomainError, 'test error')
  end
end

RSpec.describe SudokuSolver::Domain::ImmutableCellError do
  it 'is a subclass of DomainError' do
    expect(described_class).to be < SudokuSolver::Domain::DomainError
  end

  it 'can be raised and caught' do
    expect do
      raise SudokuSolver::Domain::ImmutableCellError,
            'cell is immutable'
    end.to raise_error(SudokuSolver::Domain::ImmutableCellError, 'cell is immutable')
  end
end

RSpec.describe SudokuSolver::Domain::InvalidValueError do
  it 'is a subclass of DomainError' do
    expect(described_class).to be < SudokuSolver::Domain::DomainError
  end

  it 'can be raised and caught' do
    expect do
      raise SudokuSolver::Domain::InvalidValueError,
            'invalid value'
    end.to raise_error(SudokuSolver::Domain::InvalidValueError, 'invalid value')
  end
end
