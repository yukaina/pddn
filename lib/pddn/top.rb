module Pddn
  # for 国土交通省【川の防災情報】ダム放流通知全国地図
  class Top
    TD_DISCHARGE_NUM = 2

    attr_reader :doc, :discharge_uris

    def initialize(page_doc)
      @doc = page_doc
      @discharge_uris = []

      init_discharge_uri(page_doc)
    end

    def somewhere_discharge?
      !!@somewhere_discharge
    end

    private

    def init_discharge_uri(doc)
      doc.xpath('//table[2]/tr[position()>1]').each do |tr|
        # 放流通知がある地域のリンクを取得
        if discharge?(tr)
          @somewhere_discharge = true
          discharge_uris << discharge_link_from_tr(tr)
        end
      end
    end

    def discharge?(tr)
      Pddn::Utils::Discharge.text_strip(tr.xpath("td[position()=#{TD_DISCHARGE_NUM}]")).to_i > 0
    end

    def discharge_link_from_tr(tr)
      return nil if tr.name != 'tr'
      discharge_link = tr.search('td/a').first
      href = discharge_link[:href]
      URI.parse(href)
    end
  end
end
