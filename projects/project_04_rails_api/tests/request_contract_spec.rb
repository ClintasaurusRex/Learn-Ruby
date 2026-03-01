# frozen_string_literal: true

RSpec.describe 'rails api scaffold output' do
  let(:app_root) { File.expand_path('../src/rails_api_app', __dir__) }

  it 'contains request spec directory and API app structure after scaffold script runs' do
    expect(Dir.exist?(File.join(app_root, 'app', 'controllers'))).to be(true)
    expect(Dir.exist?(File.join(app_root, 'app', 'models'))).to be(true)
    expect(Dir.exist?(File.join(app_root, 'spec'))).to be(true)
  end
end
