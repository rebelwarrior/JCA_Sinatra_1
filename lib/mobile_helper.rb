module MobileHelper
  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|\
  symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|\
  upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|\
  sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone\
  |portalmmm|sagem|mot-|sie-|ipod|up\.b|webos|amoi|novarra|cdm|alcatel|\
  pocket|ipad|iphone|mobileexplorer|mobile' 
  def is_mobile_device?(agent)
      if agent =~ Regexp.new(MOBILE_USER_AGENTS)
        return false
      else
        return true
      end
    end
  MOBILIE_SMALL_AGENTS = 'blackberry|nokia|mobi|symbian|android|ipod|webos|ipad|iphone|mobileexplorer|mobile'
end
