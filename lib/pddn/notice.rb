# frozen_string_literal: true
module Pddn
  # ダム放流通知発表状況表(〇〇地方)のtableのtr(ダム毎の放流通知の行)内にある「発表状況」
  # Noticeは、第N号で複数ある「ダム放流通知文」へのリンク
  class Notice
    attr_reader :dam_dischg_code, :discharge_report_path, :discharge_report_query, :report_no, :report_time
    JS_METHOD_NAME = 'goIpYokeihoText'.freeze

    def initialize(td)
      notice = td.xpath('a').first
      return nil unless notice
      discharge_params_from_(notice)
      @dam_dischg_code = @discharge_params[:rvr_sct_cd]
      @report_no =       @discharge_params[:rep_no]
      @report_time =     @discharge_params[:rep_time]
      @discharge_report_path = URI.parse(@discharge_params[:report_uri]).path
      @discharge_report_query = URI.parse(@discharge_params[:query]).query
    end

    def to_h
      {
        dam_dischg_code: dam_dischg_code,
        report_no:       report_no,
        report_time:     report_time
      }
    end

    private

    def discharge_params_from_(notice)
      @discharge_params = {}

      params = extract_params_from_(notice)

      @discharge_params[:report_uri]    = params[0]
      @discharge_params[:wrn_type]      = params[1]
      @discharge_params[:rvr_sct_cd]    = params[2]
      @discharge_params[:rep_time]      = params[3]
      @discharge_params[:rep_no]        = params[4]
      @discharge_params[:gamen_id]      = params[5]
      @discharge_params[:fld_ctl_party] = params[6]

      @discharge_params[:query] = build_discharge_params_query
    end

    def extract_params_from_(notice)
      notice.attributes['onclick'].value.gsub(/(\(|\)|#{JS_METHOD_NAME}|\ |\')/o, '').split(',')
    end

    def build_discharge_params_query
      # rubocop:disable Style/LineLength
      # wrnType=3&rvrSctCd=1869218694&repTime=201605231200&repNo=1&gamenId=01-0603&fldCtlParty=no
      "?wrnType=#{@discharge_params[:wrn_type]}&rvrSctCd=#{@discharge_params[:rvr_sct_cd]}&repTime=#{@discharge_params[:rep_time]}&repNo=#{@discharge_params[:rep_no]}&gamenId=#{@discharge_params[:gamen_id]}&fldCtlParty=#{@discharge_params[:fld_ctl_party]}"
      # rubocop:enable Style/LineLength
    end
  end
end
