#
# Be sure to run `pod lib lint TealiumTVOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.author            = { "Jonathan Wong" => "jonathan.wong@tealium.com" }
    s.homepage          = "https://github.com/tealium/tealium-tvos"
    s.frameworks        = 'SystemConfiguration'
    s.license           = { :type => "Commercial", :file => "LICENSE.txt" }
    s.name            = "TealiumTVOS"
    s.version           = "5.6.5"
    s.requires_arc = true
    s.social_media_url  = "https://twitter.com/tealium"
    s.source            = { :git => "https://github.com/tealium/tealium-tvos.git", :tag => s.version.to_s }
    s.summary           = "Framework for adding Tealium services to a tvOS application."
    s.platform          = :tvos, '9.0'
    #s.public_header_files = 'TealiumTVOS.framework/Headers/*.{h}'
    s.vendored_frameworks = 'TealiumTVOS.framework'
    s.xcconfig          = {'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/TealiumTVOS/TealiumTVOS'}

end
