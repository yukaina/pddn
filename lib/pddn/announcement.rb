module Pddn
  # ダム放流通知発表状況表(〇〇地方)のtableのtr(ダム毎の放流通知の行)
  # noticeは、第N号で複数ある「ダム放流通知文」へのリンク
  class Announcement
    attr_reader :discharge_notices
    attr_reader :dam_name, :river_system_name, :river_name, :target_municipality, :dam_dischg_code
    TD_DISCHARGE_NOTICE = 5

    def initialize(tr)
      @discharge_notices = []
      init_discharge_notices(tr.xpath("td[position()>=#{TD_DISCHARGE_NOTICE}]"))
      @dam_name            = Pddn::Utils::Discharge.text_strip(tr.xpath('td[position()=1]'))
      @river_system_name   = Pddn::Utils::Discharge.text_strip(tr.xpath('td[position()=2]'))
      @river_name          = Pddn::Utils::Discharge.text_strip(tr.xpath('td[position()=3]'))
      @target_municipality = Pddn::Utils::Discharge.text_strip(tr.xpath('td[position()=4]')).gsub(/(\t|\n|\ )/, '')
      @dam_dischg_code     = setting_dam_dischg_code
    end

    def setting_dam_dischg_code
      init_discharge_notices(tr.xpath("td[position()>=#{TD_DISCHARGE_NOTICE}]")) unless @discharge_notices
      @discharge_notices.first.dam_dischg_code
    end

    def to_h
      {
        dam_name:            dam_name,
        river_system_name:   river_system_name,
        river_name:          river_name,
        target_municipality: target_municipality,
        dam_dischg_code:     dam_dischg_code
      }
    end

    private

    def init_discharge_notices(tds)
      tds.each do |td|
        notice = Pddn::Notice.new(td)
        @discharge_notices << notice unless notice.dam_dischg_code.nil?
      end
    end
  end
end
