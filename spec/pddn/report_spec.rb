require 'spec_helper'

describe 'Report' do
  let(:ip_yokeiho_text_doc) do
    Nokogiri::HTML(File.open('spec/html/ipYokeihoText.html', 'r+:utf-8', &:read))
  end

  let(:reports) do
    File.open('spec/docments/report_tsuruta.txt', 'r+:utf-8', &:read)
  end

  let(:discharge_report) do
    return Pddn::Report.new(ip_yokeiho_text_doc)
  end

  context 'should do something' do
    subject { discharge_report }
    it { expect(subject.dam_name).to eq('鶴田ダム') }
    it { expect(subject.rever_system_name).to eq('川内川') }
    it { expect(subject.rever_name).to eq('川内川') }
    it { expect(subject.report_article).to eq('第3号') }
    it { expect(subject.report_at.to_s).to eq('2016/07/08 10:50') }
    it { expect(subject.publisher).to eq('鶴田ダム管理所発表') }
    it { expect(subject.title).to eq('放流量増加による急激な河川水位上昇の通知') }
    it { expect(subject.document).to eq(reports) }
    it do
      expect(subject.to_h).to eq(
        dam_name:          '鶴田ダム',
        rever_system_name: '川内川',
        rever_name:        '川内川',
        report_article:    '第3号',
        report_at:         '2016/07/08 10:50',
        publisher:         '鶴田ダム管理所発表',
        title:             '放流量増加による急激な河川水位上昇の通知',
        document:          reports
      )
    end
  end
end
