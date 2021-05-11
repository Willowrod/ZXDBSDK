
Pod::Spec.new do |spec|

  spec.name         = "ZXDBSDK"
  spec.version      = "1.0.0"
  spec.summary      = "ZXDB SDK"
  spec.swift_versions = "5"

  spec.description  = <<-DESC
  Swift implementation of an SDK to query the ZXDB API
                   DESC

  spec.homepage     = "https://github.com/Willowrod/ZXDB-SDK"

  spec.license      = { :type => 'AGPLv3', :text => 'AGPLv3' }

  spec.author       = "Mike Hall"

  spec.ios.deployment_target = '12.0'
  spec.macos.deployment_target = '10.15'
    spec.source_files  = "ZXDB-SDK/**/*.swift"

  spec.source = { :git => 'https://github.com/Willowrod/ZXDB-SDK', :branch => 'main'}


end
