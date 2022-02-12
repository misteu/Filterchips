//
//  UIView+Extensions.swift
//  Filterchips
//
//  Created by skrr on 26.01.22.
//  Copyright © 2022 mic. All rights reserved.
//

import UIKit

extension UIView {
    var preferredSize: CGSize {
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width,
                                height: UIView.layoutFittingCompressedSize.height)
        return systemLayoutSizeFitting(targetSize)
    }
}
