require 'spec_helper'

describe 'IpDamDischgRireki' do
  let(:ip_dam_dischg_rireki_doc) do
    Nokogiri::HTML(File.open('spec/html/IpDamDischgRireki.html', 'r+:utf-8', &:read))
  end

  context do
    subject { Pddn::Pages::IpDamDischgRireki.new(ip_dam_dischg_rireki_doc) }
    it { expect(subject.doc).to eq(ip_dam_dischg_rireki_doc) }
  end
end
