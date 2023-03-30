Pod::Spec.new do |s|
  s.name         = 'AWSCognitoIdentityProvider-MylerFork'
  s.version      = '2.30.4'
  s.summary      = 'Amazon Cognito Identity Provider SDK for iOS (Beta)'

  s.description  = 'Amazon Cognito Identity Provider enables sign up and authentication of your end users'

  s.homepage     = 'https://aws.amazon.com/amplify/'
  s.license      = 'Apache License, Version 2.0'
  s.author       = { 'Amazon Web Services' => 'amazonwebservices' }
  s.platform     = :ios, '11.0'
  s.source       = { :git => 'https://github.com/developers-mylermedia/aws-sdk-ios.git',
                     :tag => s.version}
  s.requires_arc = true
  s.frameworks   = 'Security', 'UIKit'
  s.dependency 'AWSCore-MylerFork', '2.30.4'
  s.dependency 'AWSCognitoIdentityProviderASF-MylerFork', '2.30.4'

  s.source_files = 'AWSCognitoIdentityProvider/**/*.{h,m,c}'
  s.public_header_files = 'AWSCognitoIdentityProvider/*.h'
  s.private_header_files = 'AWSCognitoIdentityProvider/Internal/*.h'
end
