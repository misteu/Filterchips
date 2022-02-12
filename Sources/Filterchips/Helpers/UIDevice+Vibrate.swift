//
//  UIDevice+Vibrate.swift
//  Filterchips
//
//  Created by skrr on 12.02.22.
//

import UIKit

extension UIDevice {
    static func vibrate(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
