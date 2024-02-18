# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DemoBaldevApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DemoBaldevApp
  pod 'FacebookCore'
  pod 'FacebookLogin'

  # AWS Mobile Client SDK
  pod 'AWSMobileClient'
  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'SwiftMessages'
  pod 'SDWebImage', '~> 4.4.2'
  pod 'IQKeyboardManagerSwift'
  pod 'NVActivityIndicatorView'
  pod 'UITextView+Placeholder'
  pod 'Firebase/Auth'
  pod 'Firebase/Messaging'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
#  pod 'Starscream', '~> 3.0.2'
  pod 'Socket.IO-Client-Swift'
  pod 'TLPhotoPicker'
#  pod 'iRecordView'
  pod 'EmojiPicker'
  pod 'SwiftyGif'
  pod 'DropDown', '~> 2.3.13'

  target 'DemoBaldevAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DemoBaldevAppUITests' do
    # Pods for testing
  end
  
  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
              end
          end
      end
  end

end
