//
//  UIDevice+Extensions.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 06/06/21.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let key = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            if (key?.safeAreaInsets.top ?? 0) >= 44 {
                return true
            }
        }
        return false
    }
}
