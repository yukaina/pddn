# frozen_string_literal: true
module Pddn
  # for 国土交通省【川の防災情報】ダム放流通知発表状況表(〇〇地方)
  # (http://川の防災情報URL/ipDamDischgRireki.do?init=init&areaCd=NN&gamenId=01-0602&fldCtlParty=no, NN=81〜90)
  class Area < Pages::IpDamDischgRireki
  end
end
