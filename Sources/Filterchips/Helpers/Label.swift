//
//  Label.swift
//  Filterchips
//
//  Created by skrr on 26.01.22.
//  Copyright © 2022 mic. All rights reserved.
//

import UIKit

/// Subclass of UILabel that uses dynamic type with textstyle .body.
class Label: UILabel {

    enum Style {
        case body, buttonText

        var font: UIFont {
            switch self {
            case .body:
                return UIFont.preferredFont(forTextStyle: .body)
            case .buttonText:
                return UIFont.preferredFont(forTextStyle: .body).bold
            }
        }
    }

    init(text: String? = nil, style: Style = .body) {
        super.init(frame: .zero)
        set(text: text, style: style)
        adjustsFontForContentSizeCategory = true
    }

    func set(text: String? = nil, style: Style = .body) {
        self.text = text
        font = style.font
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
