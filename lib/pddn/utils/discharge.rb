module Pddn
  module Utils
    # for discharge_documents strip.
    module Discharge
      def self.text_strip(td)
        td.text.encode('utf-8', invalid: :replace, undef: :replace, replace: '').gsub(160.chr('UTF-8'), '').strip
      end
    end
  end
end
