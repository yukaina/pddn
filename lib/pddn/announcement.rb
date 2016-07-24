module Pddn
  # ダム放流通知発表状況表(〇〇地方)のtableのtr(ダム毎の放流通知の行)
  # noticeは、第N号で複数ある「ダム放流通知文」へのリンク
  class Announcement
    attr_reader :dam_name, :river_system_name, :river_name, :target_municipality
    attr_accessor :discharge_notices
    # JS_METHOD_NAME = 'goIpObsrvKobetuNoTime'
    TD_DISCHARGE_NOTICE = 5

    def initialize(tr)
      @dam_name = Pddn::Utils::Discharge.text_strip(tr.xpath('td[1]/span/a'))
      return nil if @dam_name == ''
      # discharge_params_from_(tr.xpath('td[1]/span/a').first)
      @discharge_notices = []
      @river_system_name   = Pddn::Utils::Discharge.text_strip(tr.xpath('td[2]'))
      @river_name          = Pddn::Utils::Discharge.text_strip(tr.xpath('td[3]'))
      @target_municipality = Pddn::Utils::Discharge.text_strip(tr.xpath('td[4]'))
                                                   .gsub(/(\t|\n|\ )/, '')
                                                   .sub(/#{13.chr('UTF-8')}/, ',')
                                                   .gsub(/#{13.chr('UTF-8')}/, '')
    end

    def dam_dischg_code
      return nil if discharge_notices.nil? || discharge_notices == []
      @dam_dischg_code ||= discharge_notices.first.dam_dischg_code
    end

    def nil?
      dam_name.nil? || dam_name == ''
    end
  end
end
