#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint openlist_background_service.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'openlist_background_service'
  s.version          = '0.0.1'
  s.summary          = 'For OpenList mobile APP background service'
  s.description      = <<-DESC
For OpenList mobile APP background service
                       DESC
  s.homepage         = 'https://github.com/OpenListApp'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'yu@iotserv.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.6'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

#   s.dependency 'AListMobile' , '0.0.3'
#   s.dependency 'AListMobile' , '~> 0.0.3'
  s.dependency 'AListMobile'
  s.static_framework = true
end
