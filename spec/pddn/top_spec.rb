require 'spec_helper'

describe 'Top' do
  let(:top_page_doc) do
    Nokogiri::HTML(File.open('spec/html/ipYokeihoZenkokuMap.html', 'r+:utf-8', &:read))
  end

  context do
    subject { Pddn::Top.new(top_page_doc) }
    it { expect(subject.doc).to eq(top_page_doc) }
    it { expect(subject.somewhere_discharge?).to be_truthy }
    it { expect(subject.discharge_uris.first.to_s).to eq 'ipDamDischgRireki.do?areaCd=81&gamenId=01-0602&fldCtlParty=no' }
  end
end
