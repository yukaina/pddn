require 'spec_helper'

describe 'Announcement' do
  let(:announcements) do
    doc = area_doc

    discharge_announcements = []
    doc.xpath('//table[1]/tr[position()>1]').each do |tr|
      # puts tr.to_s.encode('utf-8', invalid: :replace, undef: :replace).gsub(160.chr("UTF-8"), '')
      discharge_announcements << Pddn::Announcement.new(tr)
    end
    discharge_announcements
  end

  context 'Announcement has 9 Notices.' do
    let(:area_doc) { Nokogiri::HTML(File.open('spec/html/area/shikoku.html', 'r+:shift_jis', &:read)) }

    subject { announcements.first }

    it { expect(subject.discharge_notices.size).to eq(3) }
    it { expect(subject.discharge_notices.first.class).to eq(Pddn::Notice) }
    it { expect(subject.dam_name).to eq('野村ダム') }
    it { expect(subject.river_system_name).to eq('肱川') }
    it { expect(subject.river_name).to eq('肱川') }
    it { expect(subject.target_municipality).to eq('西予市') }
  end

  context 'Announcement has 1 Notices.' do
    let(:area_doc) { Nokogiri::HTML(File.open('spec/html/area/touhoku.html', 'r+:shift_jis', &:read)) }

    subject { announcements }

    it { expect(subject.size).to eq(2) }
    it { expect(subject.first.discharge_notices.size).to eq(1) }
    it { expect(subject[1].discharge_notices.size).to eq(1) }
    it { expect(subject.first.discharge_notices.first.class).to eq(Pddn::Notice) }
    it { expect(subject.first.dam_name).to eq('釜房ダム') }
    it { expect(subject.first.river_system_name).to eq('名取川') }
    it { expect(subject.first.river_name).to eq('碁石川') }
    it { expect(subject.first.target_municipality).to eq('仙台市、名取市、柴田郡川崎町') }
  end
end
