#
# Module to get the external ip address
#

require 'open-uri'

module RCS
module Collector

class MyIp
  extend RCS::Tracer

  def self.get
    # don't perform resolution if not wanted
    return '' unless Config.instance.global['RESOLVE_IP']

    address = ''
    
    Timeout::timeout(2) do
      address = open("http://automation.whatismyip.com/n09230945.asp") {|f| f.read}
    end

    trace :info, "External ip address is: #{address}"
    return address

  rescue Exception => e
    trace :warn, "Cannot get external ip address: #{e.message}"
    return ''
  end

end

end # Collector::
end # RCS::