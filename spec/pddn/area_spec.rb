require 'spec_helper'

describe 'Area' do
  let(:area_doc) { Nokogiri::HTML(File.open('spec/html/ipYokeihoZenkokuMap.html', 'r+:utf-8', &:read)) }

  context do
    subject do
      Pddn::Area.new(area_doc)
    end

    it { expect(subject.doc).to eq(area_doc) }
    it { expect(subject.discharge_uris.nil?).to eq false }
    it { expect(subject.discharge_uris.size).to eq 10 }
    it { expect(subject.discharge_uris.first.class).to eq URI::Generic }
    it { expect(subject.discharge_uris.first.to_s).to eq 'ipDamhoMap.do?areaCd=81&gamenId=01-0601&fldCtlParty=no' }
    it { expect(subject.discharge_uris.last.to_s).to eq 'ipDamhoMap.do?areaCd=90&gamenId=01-0601&fldCtlParty=no' }
  end
end
