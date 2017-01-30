//
//  ViewControllerExtension.swift
//  rappi
//
//  Created by Leonardo Simoza on 28/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UILabel {
    func from(html: String) {
        if let htmlData = html.data(using: String.Encoding.unicode) {
            do {
                self.attributedText = try NSAttributedString(data: htmlData,
                                                             options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                             documentAttributes: nil)
            } catch let e as NSError {
                print("Couldn't parse \(html): \(e.localizedDescription)")
            }
        }
    }
}
