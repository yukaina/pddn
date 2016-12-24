require 'spec_helper'

describe 'Top' do
  let(:top_page_doc) do
    Nokogiri::HTML(File.open('spec/html/ipYokeihoZenkokuMap.html', 'r+:utf-8', &:read))
  end

  describe '#doc' do
    subject { Pddn::Top.new(top_page_doc).doc }
    it { expect(subject).to eq(top_page_doc) }
  end

  describe '#somewhere_discharge?' do
    subject { Pddn::Top.new(top_page_doc).somewhere_discharge? }
    it { expect(subject).to eq true }
  end

  describe '#discharge_uris' do
    subject { Pddn::Top.new(top_page_doc).discharge_uris }
    it { expect(subject.first).to eq 'ipDamDischgRireki.do?areaCd=81&gamenId=01-0602&fldCtlParty=no' }
    it { expect(subject.last).to eq 'ipDamDischgRireki.do?areaCd=90&gamenId=01-0602&fldCtlParty=no' }
  end
end
