module Pddn
  # for 国土交通省【川の防災情報】ダム放流通知文
  # (http://川の防災情報URL?damDischgCode=XXXXXXXXXX&reportTime=YYYYMMDDhhmmss&reportNo=N)
  class Report
    attr_reader :dam_name, :rever_system_name, :rever_name, :report_article, :report_at
    attr_reader :publisher, :title, :document

    def initialize(div_alarm)
      extract_headers_from_(
        div_alarm.xpath('div[@class="detail"][position()=1]').first.text.encode(
          'utf-8',
          invalid: :replace,
          undef: :replace
        ).gsub(160.chr('UTF-8'), '').split(' ')
      )

      @publisher = extract_form_(div_alarm.xpath('div[@class="office"]'))               # 発表者
      @title     = extract_form_(div_alarm.xpath('div[position()=3]'))                  # タイトル
      @document  = extract_form_(div_alarm.xpath('div[@class="detail"][position()=2]')) # 本文
    end

    def to_h
      {
        dam_name:          dam_name,
        rever_system_name: rever_system_name,
        rever_name:        rever_name,
        report_article:    report_article,
        report_at:         report_at,
        publisher:         publisher,
        title:             title,
        document:          document
      }
    end

    private

    def extract_headers_from_(div_headers)
      @dam_name          = div_headers.first.strip           # ダム名
      @rever_system_name = div_headers[1].strip              # 水系
      @rever_name        = div_headers[2].strip              # 河川名
      @report_article    = div_headers[3].strip              # 記事番号
      @report_at         = div_headers[4..5].join(' ').strip # 発表日時
    end

    def extract_form_(div_alarm_xpath)
      Utils::Discharge.text_strip(div_alarm_xpath.first)
    end
  end
end
