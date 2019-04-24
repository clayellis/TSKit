Pod::Spec.new do |spec|
  spec.name                 = "TSKit"
  spec.version              = "0.0.1"
  spec.summary              = "iOS TeamSpeak client"
  spec.license              = "None"
  spec.homepage             = "https://github.com/JanC/TSKit"
  spec.author               = "Jan C"
  spec.platform             = :ios
  # TODO: Update the source to point to Jan's repo once this is working
  spec.source               = { :git => "https://github.com/clayellis/TSKit.git", :tag => "#{spec.version}" }
  spec.source_files         = "TSKit/**/*.{h,m,mm,a,cpp}", "TSKit/include/**/*.h"
  spec.vendored_libraries   = "TSKit/lib/libts3client.a"
  spec.libraries            = "ts3client"
  spec.requires_arc         = true
end
