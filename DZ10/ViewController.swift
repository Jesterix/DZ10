//
//  ViewController.swift
//  DZ10
//
//  Created by Georgy Khaydenko on 06/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sharedTextLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var sharedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIScene.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToForeground(){
        if let ud = UserDefaults(suiteName: "group.Jesterix.ShareExtensionDemo") {
            if let textFromUD = ud.object(forKey: "text") as? String {
                sharedText = textFromUD
                sharedTextLabel.text = sharedText
            }
        }
    }
    
    func parseAndDetect(dataFormatter: DateFormatter){
        var textToDetect = sharedText
        let types: NSTextCheckingResult.CheckingType = [.date]
        let detector = try! NSDataDetector(types: types.rawValue)
        let matches = detector.matches(in: textToDetect, options: [], range: NSRange(location: 0, length: textToDetect.utf16.count))
        for match in matches {
            guard let range = Range(match.range, in: textToDetect) else { continue }
            
            switch match.resultType {
            case .date:
                if let date = match.date {
                    textToDetect = textToDetect.replacingCharacters(in: range, with: dataFormatter.string(from: date))
                    sharedTextLabel.text = textToDetect
                }
            default:
                return
            }
        }
    }

    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        let temp = "dMMMMyEEEE"
        let us = Locale(identifier: "en_US")
        let fr = Locale(identifier: "fr")
        let zh = Locale(identifier: "zh_CN")
        let dateFormatter = DateFormatter()
        
        switch sender.selectedSegmentIndex {
        case 0:
            dateFormatter.locale = us
        case 1:
            dateFormatter.locale = fr
        default:
            dateFormatter.locale = zh
        }
        
        dateFormatter.setLocalizedDateFormatFromTemplate(temp)
        parseAndDetect(dataFormatter: dateFormatter)
    }
}
