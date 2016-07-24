require 'spec_helper'

describe 'IpYokeihoZenkokuMap' do

  let(:ip_yokeiho_zenkoku_map_doc) do
    Nokogiri::HTML(File.open('spec/html/ipYokeihoZenkokuMap.html', 'r+:utf-8', &:read))
  end

  context do
    subject { Pddn::Pages::IpYokeihoZenkokuMap.new(ip_yokeiho_zenkoku_map_doc) }
    it { expect(subject.doc).to eq(ip_yokeiho_zenkoku_map_doc) }
    it { expect(subject.discharge_uris.first.to_s).to eq 'ipDamhoMap.do?areaCd=81&gamenId=01-0601&fldCtlParty=no' }
  end
end