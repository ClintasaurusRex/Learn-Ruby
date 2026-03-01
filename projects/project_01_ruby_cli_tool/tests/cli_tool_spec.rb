# frozen_string_literal: true

require 'tmpdir'
require_relative '../src/cli_tool'

RSpec.describe CliTool do
  it 'returns 1 when input is missing' do
    code = described_class.run(['--output', 'out.txt'])
    expect(code).to eq(1)
  end

  it 'runs in dry-run mode without writing output' do
    Dir.mktmpdir do |dir|
      input = File.join(dir, 'input.txt')
      output = File.join(dir, 'output.txt')
      File.write(input, "hello\n")

      code = described_class.run(['--input', input, '--output', output, '--dry-run'])

      expect(code).to eq(0)
      expect(File.exist?(output)).to be(false)
    end
  end

  it 'writes transformed output in normal mode' do
    Dir.mktmpdir do |dir|
      input = File.join(dir, 'input.txt')
      output = File.join(dir, 'output.txt')
      File.write(input, "hello\n")

      described_class.run(['--input', input, '--output', output, '--mode', 'upcase'])

      expect(File.read(output)).to eq("HELLO\n")
    end
  end
end
