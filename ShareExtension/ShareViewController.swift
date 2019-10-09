//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Georgy Khaydenko on 06/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        for item: Any in extensionContext!.inputItems {
            
            if let inputItem = item as? NSExtensionItem {
                for provider: Any in inputItem.attachments! {
                    
                    if let itemProvider = provider as? NSItemProvider {
                        if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
                            itemProvider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { text, error in
                                
                                if  let ud = UserDefaults(suiteName: "group.Jesterix.ShareExtensionDemo"),
                                    let text = text {
                                    NSLog("🐸🐸🐸 \(text)")
                                    ud.set(text, forKey: "text")
                                }
                            })
                        }
                    }
                }
            }
        }
        
        if let url = URL(string: "DZ10AppShare://text") {
            _ = self.openURL(url)
        }

    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    
    @objc func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }

}
