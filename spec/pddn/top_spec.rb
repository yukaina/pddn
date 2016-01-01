require 'spec_helper'

describe 'Top' do
  let(:top_page_doc) do
    Nokogiri::HTML(File.open('spec/html/top.html', 'r+:shift_jis', &:read))
  end

  context do
    subject { Pddn::Top.new(top_page_doc) }
    it { expect(subject.doc).to eq(top_page_doc) }
    it { expect(subject.somewhere_discharge?).to be_truthy }
    it { expect(subject.discharge_uris.first.to_s).to eq 'nrpc0602gDisp.do?areaCode=81' }
  end
end
