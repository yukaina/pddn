require 'spec_helper'

describe 'Area' do
  let(:area_doc) { Nokogiri::HTML(File.open('spec/html/ipDamDischgRireki.html', 'r+:utf-8', &:read)) }

  context do
    subject do
      Pddn::Area.new(area_doc)
    end

    subject { Pddn::Pages::IpDamDischgRireki.new(area_doc) }
    it { expect(subject.doc).to eq(area_doc) }
  end
end
