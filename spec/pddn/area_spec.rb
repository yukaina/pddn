require 'spec_helper'

describe 'Area' do
  let(:area_doc) { Nokogiri::HTML(File.open('spec/html/area/touhoku.html', 'r+:shift_jis', &:read)) }

  context do
    subject do
      Pddn::Area.new(area_doc)
    end

    it { expect(subject.doc).to eq(area_doc) }
    it { expect(subject.discharge_announcements.nil?).to be_falsey }
    it { expect(subject.discharge_announcements.size).to eq 2 }
    it { expect(subject.discharge_announcements.first.class).to eq Pddn::Announcement }
  end
end
