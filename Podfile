# Uncomment the next line to define a global platform for your project
# platform :ios, '10.2'

target 'rappi' do
# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

# Pods for rappi
    pod 'SwiftyJSON'
    pod 'Alamofire-Gloss'
    pod 'BTNavigationDropdownMenu', :git => 'https://github.com/PhamBaTho/BTNavigationDropdownMenu.git', :branch => 'swift-3.0'
    pod 'SDWebImage', '~>3.8'
    pod 'SVProgressHUD'
    pod 'Hero'
    pod 'GuillotineMenu', '~> 3.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
