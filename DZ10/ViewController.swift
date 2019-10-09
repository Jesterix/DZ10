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

    func formateUnitLengths(measurementFormatter: MeasurementFormatter){
        var textToDetect = sharedText
        let templates = MeasureRegex().createRegexArray()
        
        for template in templates {
            if let regex = try? NSRegularExpression(pattern: template.0, options: []){
                let matches = regex.matches(in: textToDetect, options: [], range: NSRange(location: 0, length: textToDetect.utf16.count))
                for match in matches.reversed() {
                    guard let range = Range(match.range, in: textToDetect) else { continue }
                    let measureString = textToDetect[range].filter("0123456789.,".contains).replacingOccurrences(of: ",", with: ".")
                    if let measureDouble = Double(measureString) {
                        let measure = Measurement(value: measureDouble, unit: template.1)
                        textToDetect = textToDetect.replacingCharacters(in: range, with: measurementFormatter.string(from: measure))
                        sharedTextLabel.text = textToDetect
                    }
                }
            }

        }
    }
    
    func formateDates(dataFormatter: DateFormatter){
        var textToDetect = sharedText
        let types: NSTextCheckingResult.CheckingType = [.date]
        if let detector = try? NSDataDetector(types: types.rawValue) {
            let matches = detector.matches(in: textToDetect, options: [], range: NSRange(location: 0, length: textToDetect.utf16.count))
            for match in matches.reversed() {
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
    }

    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        let temp = "dMMMMyEEEE"
        let us = Locale(identifier: "en_US")
        let fr = Locale(identifier: "fr")
        let zh = Locale(identifier: "zh_CN")
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate(temp)
        let measurementFormatter = MeasurementFormatter()
        
        switch sender.selectedSegmentIndex {
        case 0:
            dateFormatter.locale = us
            measurementFormatter.locale = us
        case 1:
            dateFormatter.locale = fr
            measurementFormatter.locale = fr
        default:
            dateFormatter.locale = zh
            measurementFormatter.locale = zh
        }
        
        formateDates(dataFormatter: dateFormatter)
        formateUnitLengths(measurementFormatter: measurementFormatter)
    }
}
