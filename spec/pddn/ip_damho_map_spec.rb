require 'spec_helper'

describe 'IpDamhoMap' do
  let(:ip_damho_map_doc) do
    Nokogiri::HTML(File.open('spec/html/IpDamhoMap.html', 'r+:utf-8', &:read))
  end

  context do
    subject { Pddn::IpDamhoMap.new(ip_damho_map_doc) }
    it { expect(subject.doc).to eq(ip_damho_map_doc) }
    it { expect(subject.somewhere_discharge?).to eq(true)}
  end
end