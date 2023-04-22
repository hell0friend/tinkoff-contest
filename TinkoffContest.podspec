#
#  Be sure to run `pod spec lint designsystem.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "TinkoffContest"

  s.version      = "1.0.0"

  s.summary      = "Модуль дизайн системы"

  s.swift_version = '5.0'

  s.description  = "Модуль дизайн системы для Tinkoff Contest"

  s.homepage     = "https://github.com/hell0friend/tinkoff-contest"

  s.license      = {
    :type => "Custom",
    :text => <<-LICENSE,
    Copyright 2023
    Permission is granted to Tinkoff-Contest
    LICENSE
  }

  s.author       = { "Alex Mironov" => "alex.mir812@gmail.com" }

  s.pod_target_xcconfig = {
    "SWIFT_INSTALL_OBJC_HEADER" => "NO"
  }

  s.platform     = :ios, "14.0"

  s.source       = { :git => "git@github.com:hell0friend/tinkoff-contest.git", :tag => "#{s.version}" }

  s.source_files = "Tinkoff-Contest/Sources/**/*"
  s.resources    = "Tinkoff-Contest/Resources/**/*.{xcassets,otf}"

end
