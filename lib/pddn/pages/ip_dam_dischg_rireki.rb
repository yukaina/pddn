module Pddn
  module Pages
    class IpDamDischgRireki
      attr_reader :doc, :discharge_announcements

      def initialize(page_doc)
        @doc = page_doc
        @discharge_announcements = []

        doc.xpath('//div[5]/table[1]/tr').each do |tr|
          announcement = Pddn::Announcement.new(tr)
          @discharge_announcements << announcement unless announcement.nil?
        end

        doc.xpath('//div[7]/table/tr').zip(@discharge_announcements).each do |tr, announcement|
          tr.xpath('td').each do |td|
            notice = Pddn::Notice.new(td)
            unless notice.dam_dischg_code.nil?
              announcement.discharge_notices << notice
              # announcement.dam_dischg_code = notice.dam_dischg_code
            end
          end
        end
      end
    end
  end
end
