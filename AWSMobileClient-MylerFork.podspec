Pod::Spec.new do |s|
   s.name         = 'AWSMobileClient-MylerFork'
   s.version      = '2.30.4'
   s.summary      = 'Amazon Web Services SDK for iOS.'

   s.description  = 'The AWS SDK for iOS provides a library, code samples, and documentation for developers to build connected mobile applications using AWS.'

   s.homepage     = 'https://aws.amazon.com/amplify/'
   s.license      = 'Apache License, Version 2.0'
   s.author       = { 'Amazon Web Services' => 'amazonwebservices' }
   s.platform     = :ios, '11.0'
   s.source       = { :git => 'https://github.com/developers-mylermedia/aws-sdk-ios.git',
                      :tag => s.version}
   s.requires_arc = true

   s.dependency 'AWSAuthCore-MylerFork', '2.30.4'
   s.dependency 'AWSCognitoIdentityProvider-MylerFork', '2.30.4'

   # Include transitive dependencies to help CocoaPods resolve deeply nested
   # dependency graphs; without this we get sporadic failures compiling when a
   # project relies on AWSMobileClient
   s.dependency 'AWSCore-MylerFork', '2.30.4'
   s.dependency 'AWSCognitoIdentityProviderASF-MylerFork', '2.30.4'

   s.source_files = 'AWSAuthSDK/Sources/AWSMobileClient/*.{h,m}', 'AWSAuthSDK/Sources/AWSMobileClient/Internal/*.{h,m}', 'AWSAuthSDK/Sources/AWSMobileClient/**/*.swift', 'AWSCognitoAuth/**/*.{h,m,c}'
   s.public_header_files = 'AWSAuthSDK/Sources/AWSMobileClient/AWSMobileClient.h','AWSAuthSDK/Sources/AWSMobileClient/AWSMobileClient_MylerFork.h', 'AWSAuthSDK/Sources/AWSMobileClient/Internal/_AWSMobileClient.h', 'AWSCognitoAuth/*.h', 'AWSAuthSDK/Sources/AWSMobileClient/Internal/AWSCognitoAuth+Extensions.h', 'AWSAuthSDK/Sources/AWSMobileClient/Internal/AWSCognitoCredentialsProvider+Extension.h', 'AWSAuthSDK/Sources/AWSMobileClient/Internal/AWSCognitoIdentityUserPool+Extension.h'
 end
