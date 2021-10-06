# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

def flutter_libs

  flutter_application_path = 'Flutter/flutterengineexample_module'
  #Use Flutter Mudule
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
  install_all_flutter_pods(flutter_application_path)

end

target 'FlutterEngineExample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  flutter_libs

  # Pods for FlutterEngineExample

  target 'FlutterEngineExampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FlutterEngineExampleUITests' do
    # Pods for testing
  end

end
