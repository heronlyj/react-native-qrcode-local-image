#
#  Be sure to run `pod spec lint react-native-qrcode-local-image.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|

  s.name         = "react-native-qrcode-local-image"
  s.version = package['version']
  s.summary = "load local qr image"

  s.author  = { "heronlyj" => "heronlyj@gmail.com" }
  s.homepage = "http://EXAMPLE/react-native-qrcode-local-image"
  s.license = "MIT"
  
  s.platform = :ios, "8.0"
  s.framework    = 'UIKit'
  s.requires_arc = true
  
  s.source       = { :git => "https://github.com/heronlyj/react-native-qrcode-local-image.git", :tag => "#{s.version}" }
  s.source_files = "ios/**/*.{h,m}"

  s.dependency 'React'

end
