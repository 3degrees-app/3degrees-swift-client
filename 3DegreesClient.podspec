Pod::Spec.new do |s|
  s.name = '3DegreesClient'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.version = '0.0.9'
  s.source = { :git => 'git@github.com:swagger-api/swagger-mustache.git', :tag => 'v1.0.0' }
  s.license = 'Apache License, Version 2.0'
  s.source_files = 'SwaggerClient/Classes/Swaggers/**/*.swift'
  s.dependency 'Alamofire', '~> 3.1.4'
  s.authors = 'rlmartin@gmail.com'
  s.homepage = 'https://api.threedegreesapp.com'
  s.summary = 'Automatically generated'
end
