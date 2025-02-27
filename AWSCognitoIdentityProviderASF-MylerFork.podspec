Pod::Spec.new do |s|
  s.name         = 'AWSCognitoIdentityProviderASF-MylerFork'
  s.version      = '2.33.4.1'
  s.summary      = 'Amazon Cognito Identity Provider Advanced Security Features library (Beta)'

  s.description  = 'Amazon Cognito Identity Provider ASF provides the information necessary to support adaptive authentication'

  s.homepage     = 'https://aws.amazon.com/amplify/'
  s.license      = 'Apache License, Version 2.0'
  s.author       = { 'Amazon Web Services' => 'amazonwebservices' }
  s.platform     = :ios, '11.0'
  s.source       = { :git => 'https://github.com/developers-mylermedia/aws-sdk-ios.git',
                     :tag => s.version}
  s.requires_arc = true
  s.dependency 'AWSCore-MylerFork', '2.33.4.1'
  s.public_header_files = 'AWSCognitoIdentityProviderASF/*.h'
  s.source_files = 'AWSCognitoIdentityProviderASF/**/*.{h,m,c}'
  s.private_header_files = 'AWSCognitoIdentityProviderASF/Internal/*.h'
end
