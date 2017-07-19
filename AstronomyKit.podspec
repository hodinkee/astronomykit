#
# Be sure to run `pod lib lint TestPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = "AstronomyKit"
  s.version = "1.6.0"
  s.summary = "Compute various aspects of the solar system."

  s.description = <<~DESC
    "Compute various aspects of the solar system. AstronomyKit uses AA+ to perform these computations."
  DESC

  s.homepage = "https://github.com/hodinkee/AstronomyKit"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Caleb Davenport" => "caleb@hodinkee.com" }
  s.source = { :git => "https://github.com/hodinkee/AstronomyKit.git", :tag => "v#{s.version.to_s}", :submodules => true }

  s.ios.deployment_target = "9.0"

  s.source_files = "Vendor/AA+/1.6.3/*.{h,cpp}", "AstronomyKit/*.{h,mm,m}"

  s.exclude_files = "Vendor/AA+/1.6.3/AATest.cpp", "Vendor/AA+/1.6.3/AAEaster.cpp"
  s.public_header_files = "AstronomyKit/AstronomicalCalculations.h", "AstronomyKit/NSCalendar+AstronomyKit.h"
end
