//
//  AppDelegate.swift
//  FlutterEngineExample
//
//  Created by Chad Hamdan on 10/5/21.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

@main
class AppDelegate: FlutterAppDelegate {

    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run();
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
        
        // Setup method channel on flutter view controller
        let controller = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        let batteryChannel = FlutterMethodChannel(name: "main.channel/homepage", binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            
            switch call.method {
            case "getBatteryLevel":
                self?.receiveBatteryLevel(result: result)
                break
            case "popFlutterView":
                let count = (call.arguments! as! [Int])[0]
                self?.popFlutterView(result: result, count: count)
                break
            default:
                result(FlutterMethodNotImplemented)
                return
            }
        })

        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(FlutterError(code: "UNAVAILABLE", message: "Battery info unavailable", details: nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
    
    private func popFlutterView(result: FlutterResult, count: Int) {
        // Get current FlutterViewController from flutterEngine
        let controller = flutterEngine.viewController
        controller!.navigationController?.popViewController(animated: true)
        
        // Set new count
        ViewController.count = count
    }
    
}

