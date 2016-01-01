module Pddn
  # ダム放流通知発表状況表(〇〇地方)のtableのtr(ダム毎の放流通知の行)内にある「発表状況」
  # Noticeは、第N号で複数ある「ダム放流通知文」へのリンク
  class Notice
    attr_reader :dam_dischg_code, :discharge_report_path, :discharge_report_query, :report_no, :report_time

    def initialize(td)
      notice = td.xpath('a').first
      return nil unless notice
      discharge_params_from_(notice)
      @dam_dischg_code = @discharge_params[:dam_dischg_code]
      @report_no =       @discharge_params[:report_no]
      @report_time =     @discharge_params[:report_time]
      @discharge_report_path = URI.parse(notice[:href]).path
      @discharge_report_query = URI.parse(notice[:href]).query
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
      CGI.parse(underscore(URI.parse(notice[:href]).query)).each { |k, v| @discharge_params[k.to_sym] = v.first }
    end

    def underscore(word)
      duplicated_word = word.dup
      duplicated_word.gsub!(/::/, '/')
      duplicated_word.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      duplicated_word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      duplicated_word.tr!('-', '_')
      duplicated_word.downcase!
      duplicated_word
    end
  end
end
