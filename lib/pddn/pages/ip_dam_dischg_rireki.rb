module Pddn
  module Pages
    # 地域ごとのダム放流通知発表状況のページ
    class IpDamDischgRireki
      attr_reader :doc, :discharge_announcements

      def initialize(page_doc)
        @doc = page_doc
        @discharge_announcements = []

        build_discharge_announcements(doc)
        build_discharge_notices(doc)
      end

      private

      def build_discharge_announcements(doc)
        doc.xpath('//div[5]/table[1]/tr').each do |tr|
          announcement = Pddn::Announcement.new(tr)
          @discharge_announcements << announcement unless announcement.nil?
        end
      end

      def build_discharge_notices(doc)
        doc.xpath('//div[7]/table/tr').zip(@discharge_announcements).each do |tr, announcement|
          tr.xpath('td').each do |td|
            notice = Pddn::Notice.new(td)
            announcement.discharge_notices << notice unless notice.dam_dischg_code.nil?
          end
        end
      end
    end
  end
end
