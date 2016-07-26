# frozen_string_literal: true
module Pddn
  module Pages
    # for 国土交通省【川の防災情報】ダム放流通知発表地域図
    # path /kawabou/ipDamhoMap.do?areaCd=81&gamenId=01-0601&fldCtlParty=no
    class IpDamhoMap
      attr_reader :doc, :discharge_history_uri
      def initialize(page_doc)
        @doc = page_doc
        init_discharge_uri(page_doc)
      end

      def somewhere_discharge?
        !!@somewhere_discharge
      end

      private

      def init_discharge_uri(doc)
        @somewhere_discharge = !doc.xpath('id("ykh-menu")/div/div[position()>2]/table/tbody/tr').empty?
        discharge_history_a_link = doc.xpath('id("ykh-control2")/table/tr/td/a').first
        @discharge_history_uri = discharge_history_a_link && discharge_history_a_link[:href]
      end
    end
  end
end
