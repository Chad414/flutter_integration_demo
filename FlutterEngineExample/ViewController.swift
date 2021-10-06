//
//  ViewController.swift
//  FlutterEngineExample
//
//  Created by Chad Hamdan on 10/5/21.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    @IBOutlet weak var buttonLabel: UILabel!
    
    static var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update button label
        buttonLabel.text = "You pushed the button \(ViewController.count) times!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func showFlutterVC(_ sender: UIButton) {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        
        navigationController?.pushViewController(flutterViewController, animated: true)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
