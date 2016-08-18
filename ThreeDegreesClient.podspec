Pod::Spec.new do |s|
  s.name = 'ThreeDegreesClient'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.version = '0.0.20'
  s.source = { :git => 'git@github.com:swagger-api/swagger-mustache.git', :tag => 'v1.0.0' }
  s.authors = 'rlmartin@gmail.com'
  s.license = 'Apache License, Version 2.0'
  s.homepage = 'https://api.threedegreesapp.com'
  s.summary = 'Generated client'
  s.source_files = 'ThreeDegreesClient/Classes/Swaggers/**/*.swift'
  s.dependency 'Alamofire', '~> 3.1.5'
end
