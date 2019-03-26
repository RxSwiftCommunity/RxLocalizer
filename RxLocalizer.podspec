Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "RxLocalizer"
s.summary = "RxLocalizer allows you to localize your app with RxSwift."
s.requires_arc = true
s.version = "1.2.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Vladislav Khambir" => "vlad.khambir@gmail.com" }
s.homepage = "https://github.com/RxSwiftCommunity/RxLocalizer"
s.source = { :git => "https://github.com/RxSwiftCommunity/RxLocalizer.git", :tag => "#{s.version}" }
s.dependency 'RxSwift', '~> 4.4.2'
s.dependency 'RxCocoa', '~> 4.4.2'
s.source_files = 'Source/*.swift'
s.swift_version = "5.0"

end
