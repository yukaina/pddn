require 'spec_helper'

describe 'IpYokeihoText' do
  let(:ip_yokeiho_text_doc) do
    Nokogiri::HTML(File.open('spec/html/IpYokeihoText.html', 'r+:utf-8', &:read))
  end

  let(:reports) do
    File.open('spec/docments/report_tsuruta.txt', 'r+:utf-8', &:read)
  end

  context do
    subject { Pddn::Pages::IpYokeihoText.new(ip_yokeiho_text_doc) }
    # header
    it { expect(subject.dam_name).to eq('鶴田ダム') }
    it { expect(subject.rever_system_name).to eq('川内川') }
    it { expect(subject.rever_name).to eq('川内川') }
    it { expect(subject.report_article).to eq('第3号') }
    it { expect(subject.report_at).to eq('2016/07/08 10:50') }

    # body
    it { expect(subject.publisher).to eq('鶴田ダム管理所発表') }
    it { expect(subject.title).to eq('放流量増加による急激な河川水位上昇の通知') }
    it { expect(subject.document).to eq(reports) }
  end
end