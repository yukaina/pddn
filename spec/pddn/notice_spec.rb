require 'spec_helper'

describe 'Notice' do
  let(:href) do
    'nrpc0603gDisp.do?damDischgCode=2209922129&amp;reportTime=20150403140000&amp;reportNo=1'
  end

  let(:td) do
    Nokogiri::HTML.parse(
      <<-TD
        <td align="center" class="spread" nowrap>
          <a href="#{href}">第1号<br>04/03&#160;14:00</a>
        </td>
      TD
    ).xpath('//td').first
  end

  context do
    subject { Pddn::Notice.new(td) }
    it { expect(subject.dam_dischg_code).to eq('2209922129') }
    it { expect(subject.report_no).to eq('1') }
    it { expect(subject.report_time).to eq('20150403140000') }
    it { expect(subject.discharge_report_path).to eq('nrpc0603gDisp.do') }
    it { expect(subject.discharge_report_query).to eq('damDischgCode=2209922129&reportTime=20150403140000&reportNo=1') }
    it { expect(subject.to_h).to eq(dam_dischg_code: '2209922129', report_no: '1', report_time: '20150403140000') }
  end
end
