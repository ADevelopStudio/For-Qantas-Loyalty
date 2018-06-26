//
//  Extentions.swift
//  For Qantas Loyalty
//
//  Created by Dmitrii Zverev on 26/6/18.
//  Copyright © 2018 Dmitrii Zverev. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    func tapFeedback(isLight: Bool = true)  {
        if #available(iOS 10.0, *) {
            if !isLight {
                let impact = UIImpactFeedbackGenerator()
                impact.impactOccurred()
            }else{
                let selection = UISelectionFeedbackGenerator()
                selection.selectionChanged()
            }
        }
    }
}


extension UIView {
    func setCorner(cornerRadius: CGFloat = 7, borderWidth: CGFloat = 1, borderColor: UIColor = .clear)  {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
}

extension String {
    var withoutWhiteCrap: String {
        var newStr = Substring(self)
        while newStr.hasPrefix(" ") || newStr.hasPrefix("\n") {
            newStr = newStr.dropFirst()
        }
        while newStr.hasSuffix(" ") || newStr.hasSuffix("\n") {
            newStr = newStr.dropLast()
        }
        return String(newStr)
    }
    
}

extension UIViewController {
    func showError(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

