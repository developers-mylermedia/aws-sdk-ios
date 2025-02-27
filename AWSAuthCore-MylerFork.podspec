Pod::Spec.new do |s|
   s.name         = 'AWSAuthCore-MylerFork'
   s.version      = '2.33.4.1'
   s.summary      = 'Amazon Web Services SDK for iOS.'

   s.description  = 'The AWS SDK for iOS provides a library, code samples, and documentation for developers to build connected mobile applications using AWS.'

   s.homepage     = 'https://aws.amazon.com/amplify/'
   s.license      = 'Apache License, Version 2.0'
   s.author       = { 'Amazon Web Services' => 'amazonwebservices' }
   s.platform     = :ios, '11.0'
   s.source       = { :git => 'https://github.com/developers-mylermedia/aws-sdk-ios.git',
                      :tag => s.version}
   s.requires_arc = true
   s.dependency 'AWSCore-MylerFork', '2.33.4.1'
   s.source_files = 'AWSAuthSDK/Sources/AWSAuthCore/*.{h,m}'
   s.public_header_files = 'AWSAuthSDK/Sources/AWSAuthCore/*.h'
 end

