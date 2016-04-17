module Pddn
  # for 国土交通省【川の防災情報】ダム放流通知全国地図
  class IpYokeihoZenkokuMap
    attr_reader :doc, :discharge_uris
    AREA_MAP_URI = 'ipDamhoMap.do'.freeze
    URL_PARAM_AREA_CD = 'areaCd'.freeze
    URL_PARAM_GAMEN_ID_ETC = 'gamenId=01-0601&fldCtlParty=no'.freeze

    def initialize(page_doc)
      @doc = page_doc
      @discharge_uris = []
      init_discharge_uri(page_doc)
    end

    private

    def init_discharge_uri(doc)
      doc.xpath('/html/map[@name="smplMap"]/area').each do |area|
        puts area.inspect
        discharge_uris << discharge_link_from_area(area)
      end
    end

    def discharge_link_from_area(area)
      return nil if area.name != 'area'
      area_cd = area.attributes['onmouseover'].value.gsub(/msOverSubmenu/,'').gsub(/[^0-9]/,'')
      href = "#{AREA_MAP_URI}?#{URL_PARAM_AREA_CD}=#{area_cd}&#{URL_PARAM_GAMEN_ID_ETC}"
      URI.parse(href)
    end
  end
end
