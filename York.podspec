#
# Be sure to run `pod lib lint York.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "York"
  s.version          = "0.3.1"
  s.summary          = "Foundation classes used to eliminate boiler-plate code and provide an accelerated startup time."
  s.homepage         = "https://github.com/inacioferrarini/York"

  s.license      = {
  :type => 'MIT',
  :text => <<-LICENSE
Copyright (c) 2016 Inácio Ferrarini
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    LICENSE
}
  s.author           = { "Inácio Ferrarini" => "inacio.ferrarini@gmail.com" }
  s.source           = { :git => "https://github.com/inacioferrarini/York.git", :tag => s.version.to_s }

  s.frameworks = 'UIKit', 'CoreData'
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.dependency 'York-Swift-Try-Catch', '0.1.1'
  s.dependency 'JLRoutes', '1.6'

  s.resources = 'Classes/**/*.xcdatamodeld'

#  s.subspec 'Classes' do |ss|
#    ss.source_files = 'Classes/**/*.swift'
#  end

  s.subspec 'Context' do |ss|
    ss.source_files = 'Classes/Context/**/*.swift'
  end

  s.subspec 'DataSource' do |ss|
    ss.source_files = 'Classes/DataSource/**/*.swift'
  end

  s.subspec 'DataSyncRules' do |ss|
    ss.source_files = 'Classes/DataSyncRules/**/*.swift'
  end

  s.subspec 'DeepLinkingNavigation' do |ss|
    ss.source_files = 'Classes/DeepLinkingNavigation/**/*.swift'
  end

  s.subspec 'Extensions' do |ss|
    ss.source_files = 'Classes/Extensions/**/*.swift'
  end

  s.subspec 'Logging' do |ss|
    ss.source_files = 'Classes/Logging/**/*.swift'
  end

  s.subspec 'Persistence' do |ss|
    ss.source_files = 'Classes/Persistence/**/*.swift'
  end

  s.subspec 'Presenter' do |ss|
    ss.source_files = 'Classes/Presenter/**/*.swift'
  end

  s.subspec 'TableViewDelegate' do |ss|
    ss.source_files = 'Classes/TableViewDelegate/**/*.swift'
  end

  s.subspec 'ViewController' do |ss|
    ss.source_files = 'Classes/ViewController/**/*.swift'
  end

  s.subspec 'Views' do |ss|
    ss.source_files = 'Classes/Views/**/*.swift'
  end

end
