# frozen_string_literal: true
module Pddn
  module Utils
    # for discharge_documents strip.
    module Discharge
      def self.text_strip(td)
        td.text.encode('UTF-16be', invalid: :replace, undef: :replace, replace: '') \
          .encode('UTF-8').gsub(160.chr('UTF-8'), '').strip
      end
    end
  end
end
