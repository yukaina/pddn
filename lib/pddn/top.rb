module Pddn
  # for 国土交通省【川の防災情報】ダム放流通知全国地図
  class Top
    TD_DISCHARGE_NUM = 2

    attr_reader :doc, :discharge_uris

    def initialize(page_doc)
      @doc = page_doc
      @discharge_uris = []

      init_discharge_uri
    end

    def somewhere_discharge?
      !!@somewhere_discharge
    end

    private

    def init_discharge_uri
      10.times.each do |i|
        discharge_uris << "ipDamhoMap.do?areaCd=#{81 + i}&gamenId=01-0601&fldCtlParty=no"
      end
      @somewhere_discharge = true
    end
  end
end
