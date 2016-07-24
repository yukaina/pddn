module Pddn
  module Pages
    # ダムの放流通知発表文
    class IpYokeihoText
      attr_reader :dam_name, :rever_system_name, :rever_name, :report_article, :report_at
      attr_reader :publisher, :title, :document

      def initialize(page_doc)
        @doc = page_doc
        extract_headers_from_(
          page_doc.xpath('/html/body/div[2]/div[2]/table/tbody/tr/td/table/tbody/tr[1]/td').first.text
                  .encode('utf-8', invalid: :replace, undef: :replace)
                  .tr('　', ' ')
                  .split(' ')
        )

        @publisher = extract_form_('/html/body/div[2]/div[2]/table/tbody/tr/td/table/tbody/tr[2]/td') # 発表者
        @title = extract_form_('/html/body/div[2]/div[2]/table/tbody/tr/td/table/tbody/tr[3]/td/span') # タイトル
        @document = extract_form_('/html/body/div[2]/div[2]/table/tbody/tr/td/table/tbody/tr[4]/td') # 本文
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

      def extract_headers_from_(headers)
        @dam_name          = headers.first.strip           # ダム名
        @rever_system_name = headers[1].strip              # 水系
        @rever_name        = headers[2].strip              # 河川名
        @report_article    = headers[3].strip              # 記事番号
        @report_at         = headers[4..5].join(' ').strip # 発表日時
      end

      def extract_form_(alarm_xpath)
        @doc.xpath(alarm_xpath).first.text
            .encode('utf-8', invalid: :replace, undef: :replace)
            .tr('　', ' ')
            .gsub(/("|\t)/, '')
            .gsub(/([\ ]+\n[\ ]+|[\ ]+\n|\n[\ ]+)/, "\n")
            .strip
      end
    end
  end
end
