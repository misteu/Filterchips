//
//  UIView+Extensions.swift
//  Filterchips
//
//  Created by misteu on 26.01.22.
//

import UIKit

extension UIView {
    var preferredSize: CGSize {
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width,
                                height: UIView.layoutFittingCompressedSize.height)
        return systemLayoutSizeFitting(targetSize)
    }
}
