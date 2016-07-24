require 'spec_helper'

describe 'Announcement' do
  context 'No Announcement.' do
    let(:tr) do
      Nokogiri::HTML.parse(
        <<-TR
					<tr height="64px">
						<td class="ykh-data" width="80px">
								&nbsp;
						</td>
						<td class="ykh-data" width="80px">
								&nbsp;
						</td>
						<td class="ykh-data" width="80px">
								&nbsp;
						</td>
						<td s class="ykh-data" width="243px">
							<table class="ykhip-tbl3" border="0" cellspacing="0" cellpadding="0"  width="243px">
								<tr>
								<td  align="left" valign="middle" width="218px" style="font-size: 100%;">
								</td>
								<td width="25px">
										<a href="#" class="ykh-link" onclick="goYokeihoRirekiPup('/kawabou/ipYokeihoRirekiPup.do', '', '', '2')"
											onkeypress="goYokeihoRirekiPup('/kawabou/ipYokeihoRirekiPup.do', '', '', '2')">
										</a>
								</td>
							</tr>
							</table>
						</td>
					</tr>
        TR
      ).xpath('//tr').first
    end

    let(:announcement) { Pddn::Announcement.new(tr) }

    subject { announcement }

    it { expect(subject.nil?).to eq(true) }
  end

  context 'Announcement has 1 Notices.' do
    let(:tr) do
      Nokogiri::HTML.parse(
        <<-TR
    <tr height="64px">
      <td class="ykh-data" width="80px">
      &nbsp;
        <span><a href="#" onclick="goIpObsrvKobetuNoTime('/kawabou/ipDamKobetu.do', '2075700700002', '01-1004', 'no', 'true')"
        onkeypress="goIpObsrvKobetuNoTime('/kawabou/ipDamKobetu.do', '2075700700002', '01-1004', no', 'true')" >
        桂沢ダム	</a></span>
      </td>
      <td class="ykh-data" width="80px">
        石狩川
      </td>
      <td class="ykh-data" width="80px">
        幾春別川
      </td>
      <td s class="ykh-data" width="243px">
        <table class="ykhip-tbl3" border="0" cellspacing="0" cellpadding="0"  width="243px">
          <tr>
          <td  align="left" valign="middle" width="218px" style="font-size: 100%;">
                  &nbsp;
                  <span>
                  <a href="#" onclick="goGaikyoMap('/kawabou/ipGaikyoMap.do', '', '', '0104210', '01-0701', 'no')" onkeypress="goGaikyoMap('/kawabou/ipGaikyoMap.do', '', '', '0104210', '01-0701', 'no')">
                  #{13.chr('UTF-8')}#{13.chr('UTF-8')}岩見沢市</a></span>
                  <span>
                  <a href="#" onclick="goGaikyoMap('/kawabou/ipGaikyoMap.do', '', '', '0104222', '01-0701', 'no')" onkeypress="goGaikyoMap('/kawabou/ipGaikyoMap.do', '', '', '0104222', '01-0701', 'no')">
                  #{13.chr('UTF-8')}#{13.chr('UTF-8')}三笠市</a></span>
          </td>
          <td width="25px">
              <a href="#" class="ykh-link" onclick="goYokeihoRirekiPup('/kawabou/ipYokeihoRirekiPup.do', '3', '2073720773', '2')"
                onkeypress="goYokeihoRirekiPup('/kawabou/ipYokeihoRirekiPup.do', '3', '2073720773', '2')">
              </a>
          </td>
        </tr>
        </table>
      </td>
    </tr>
        TR
      ).xpath('//tr').first
    end

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

    let(:announcement) { Pddn::Announcement.new(tr) }
    let(:notice) { Pddn::Notice.new(td) }

    describe 'Announcement#new' do
      before do
        announcement.discharge_notices << notice
      end

      subject { announcement }

      it { expect(subject.discharge_notices.size).to eq(1) }
      it { expect(subject.discharge_notices.first.class).to eq(Pddn::Notice) }
      it { expect(subject.dam_name).to eq('桂沢ダム') }
      it { expect(subject.dam_dischg_code).to eq('2073720773') }
      it { expect(subject.river_system_name).to eq('石狩川') }
      it { expect(subject.river_name).to eq('幾春別川') }
      it { expect(subject.target_municipality).to eq('岩見沢市,三笠市') }
    end
  end
end
