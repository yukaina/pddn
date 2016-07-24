require 'spec_helper'

describe 'Notice' do
  let(:td) do
    Nokogiri::HTML.parse(
      <<-TD
<td class="ykh-data" width="96px" bgcolor="#FFFFFF" style="color:#0000EE; font-size: 100%;">
									<a href="#" onclick="goIpYokeihoText('/kawabou/ipYokeihoText.do', '3', '2073720773', '201604180100', '1', '01-0603', 'no')" onkeypress="goIpYokeihoText('/kawabou/ipYokeihoText.do', '3', '2073720773', '201604180100', '1', '01-0603', 'no')" style="color:#0000EE">
										第1号洪水警戒体制の通知4/18 1:00
									</a>
								</td>
      TD
    ).xpath('//td').first
  end

  context do
# :dam_dischg_code, :discharge_report_path, :discharge_report_query, :report_no, :report_time
    subject { Pddn::Notice.new(td) }
    it { expect(subject.dam_dischg_code).to eq('2073720773') }
    it { expect(subject.report_no).to eq('1') }
    it { expect(subject.report_time).to eq('201604180100') }
    it { expect(subject.discharge_report_path).to eq('/kawabou/ipYokeihoText.do') }
    it { expect(subject.discharge_report_query).to eq('wrnType=3&rvrSctCd=2073720773&repTime=201604180100&repNo=1&gamenId=01-0603&fldCtlParty=no') }
    it { expect(subject.to_h).to eq(dam_dischg_code: '2073720773', report_no: '1', report_time: '201604180100') }
  end
end
