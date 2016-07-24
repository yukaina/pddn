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
                               .gsub(/(\t|\n|\ )/, '').sub(/#{13.chr('UTF-8')}/, ',').gsub(/#{13.chr('UTF-8')}/, '')
    end

    def dam_dischg_code
      return nil if discharge_notices.nil? || discharge_notices == []
      @dam_dischg_code ||= discharge_notices.first.dam_dischg_code
    end
    # def to_h
    #   {
    #     dam_name:            dam_name,
    #     river_system_name:   river_system_name,
    #     river_name:          river_name,
    #     target_municipality: target_municipality,
    #     dam_dischg_code:     dam_dischg_code
    #   }
    # end

    def nil?
      dam_name.nil? || dam_name == ''
    end

    # private
    #
    # def discharge_params_from_(notice)
    #   @discharge_params = {}
    #
    #   params = notice.attributes['onclick'].value.gsub(/(\(|\)|#{JS_METHOD_NAME}|\ |\')/o,'').split(',')
    #
    #   path             = params[0] # 遷移先URLの最初の部分 (EX:/kawabou/suiiKobetu.do)
    #   @dam_dischg_code = params[1] # 観測所ID
    #   gamen_id         = params[2] # 遷移先の画面ID
    #   fld_ctl_party    = params[3] # 水防関係者フラグ
    #   new_open_flag    = params[4] # 新ブラウザフラグ(true:新ブラウザ表示、false:画面遷移)
    #
    #   # ?init=init&obsrvId=2281500700006&gamenId=01-1004&timeType=60&requestType=1&fldCtlParty=no
    #   @dam_uri = "#{path}?init=init&obsrvId=#{@dam_dischg_code}&gamenId=#{gamen_id}&timeType=60&requestType=1&fldCtlParty=#{fld_ctl_party}#"
    # end
  end
end
