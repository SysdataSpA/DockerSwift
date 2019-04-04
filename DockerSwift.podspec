#
# Be sure to run `pod lib lint DockerSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                    = 'DockerSwift'
  s.version                 = '1.0.0'
  s.platform                = :ios
  s.ios.deployment_target   = '9.0'
  s.swift_version           = '4.2'
  s.social_media_url        =  'https://www.facebook.com/sysdata.it/'
  s.summary                 = 'DockerSwift handles in some easy steps all connections with your remote servers. Offers you some classes to call Web Services defining http method, request, response, .... and some classes to handle resources download.'
  s.description             = <<-DESC
DockerSwift handles in some easy steps all connections with your remote servers. Offers you some classes to call Web Services defining http method, request, response, .... and some classes to handle resources download.
                       DESC
  s.homepage                = 'https://github.com/SysdataSpA/DockerSwift'
  s.license                 = { :type => 'APACHE', :file => 'LICENSE' }
  s.author                  = { 'Sysdata SpA' => 'team.mobile@sysdata.it' }
  s.source                  = { :git => 'https://github.com/SysdataSpA/DockerSwift.git', :tag => s.version.to_s }

  s.subspec 'Core' do |co|
    co.source_files = 'DockerSwift/Classes/**/*'
    co.dependency 'Alamofire', '~> 4'
  end

  s.subspec 'Blabber' do |bl|
     bl.dependency 'DockerSwift/Core'
     bl.dependency 'Blabber'
     bl.xcconfig = { 'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) BLABBER' }
  end

  s.default_subspec = 'Core'

end
