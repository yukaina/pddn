require 'spec_helper'

describe 'Discharge' do
  describe ',text_strip' do
    context 'when normal td tags' do
      let(:td) do
        Nokogiri::HTML('                    <td align="center" class="spread" nowrap>
                        16</td>')
      end
      subject { Pddn::Utils::Discharge.text_strip(td) }
      it { expect(subject).to eq '16' }
    end

    context 'when include invalid unicode tags' do
      # \x80~
      # puts "\x80".scrub('?')
      let(:td) { Nokogiri::HTML("不正文字\x80がなくなる") }
      subject { Pddn::Utils::Discharge.text_strip(td) }
      it { expect(subject).to eq '不正文字がなくなる' }
    end

    context 'when include  td tags' do
      let(:td) { Nokogiri::HTML('&#160;第4号'.encode('Shift_JIS')) }
      subject { Pddn::Utils::Discharge.text_strip(td) }
      it { expect(subject).to eq '第4号' }
    end
  end
end
