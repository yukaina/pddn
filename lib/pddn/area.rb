module Pddn
  # for 国土交通省【川の防災情報】ダム放流通知発表状況表(〇〇地方)
  # (http://川の防災情報URL?areaCode=NN, NN=81〜90)
  class Area
    attr_reader :doc, :discharge_announcements

    def initialize(page_doc)
      @doc = page_doc
      @discharge_announcements = []

      doc.xpath('//table[1]/tr[position()>1]').each do |tr|
        announcement = Pddn::Announcement.new(tr)
        discharge_announcements << announcement
      end
    end
  end
end
