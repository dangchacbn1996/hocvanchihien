# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'HocVanChiHien' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HocVanChiHien

pod 'Alamofire', '~> 4.7'
  pod 'JGProgressHUD', '~> 2.0'
  pod 'Toast-Swift', '~> 3.0'
  pod 'M13Checkbox', '~> 3.2'
  pod 'IQKeyboardManager', '~> 6.2.0'
  pod 'DropDown'
  pod 'Localize-Swift', '~> 2.0'
  pod 'SideMenu'
  pod 'YouTubePlayer'
  pod 'Firebase/Core'
  pod 'Firebase/Storage'

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if ['SwiftyJSON', 'Toast-Swift', 'YouTubePlayer'].include? target.name
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4'
              end
          end
      end
  end

  target 'HocVanChiHienTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HocVanChiHienUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
