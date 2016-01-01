require 'spec_helper'

describe 'Report' do
  let(:reports) do
    Nokogiri::HTML(File.open('spec/html/reports.html', 'r+:shift_jis', &:read))
  end

  let(:document) do
    File.open('spec/docments/report_moriyoshizan.txt', 'r+:utf-8', &:read)
  end

  let(:discharge_report) do
    reports.xpath('//div[@class="alarm"]').each do |report|
      return Pddn::Report.new(report)
    end
  end

  context 'should do something' do
    subject { discharge_report }
    it { expect(subject.dam_name).to eq('森吉山ダム') }
    it { expect(subject.rever_system_name).to eq('米代川') }
    it { expect(subject.rever_name).to eq('小又川') }
    it { expect(subject.report_article).to eq('第4号') }
    it { expect(subject.report_at.to_s).to eq('2015/04/21 01:10') }
    it { expect(subject.publisher).to eq('森吉山ダム管理支所発表') }
    it { expect(subject.title).to eq('洪水調節の開始の情報') }
    it { expect(subject.document).to eq(document) }
    it do
      expect(subject.to_h).to eq(
        dam_name:          '森吉山ダム',
        rever_system_name: '米代川',
        rever_name:        '小又川',
        report_article:    '第4号',
        report_at:         '2015/04/21 01:10',
        publisher:         '森吉山ダム管理支所発表',
        title:             '洪水調節の開始の情報',
        document:          document
      )
    end
  end
end
