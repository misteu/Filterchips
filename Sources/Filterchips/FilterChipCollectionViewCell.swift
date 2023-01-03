//
//  FilterChipCollectionViewCell.swift
//  
//
//  Created by Michael Steudter on 02.01.23.
//

import UIKit

class FilterChipCollectionViewCell: UICollectionViewCell {

    /// The images used for selected or non selected state.
    enum Images {
        static let selected = UIImage(systemName: "checkmark.circle.fill")
        static let notSelected = UIImage(systemName: "circle")
    }

    static let identifier = "FilterChipCollectionViewCell"

    let titleLabel = Label(style: .buttonText)

    let checkmarkView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(textStyle: .body)
        let view = UIImageView(image: Images.notSelected?.withConfiguration(configuration))
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }

    override var isSelected: Bool {
        didSet {
            updateForSelectionState(isSelected: isSelected)
        }
    }

    private func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        contentView.addSubview(checkmarkView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([

            checkmarkView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            checkmarkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.defaultMargin / 2),
            checkmarkView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -Layout.defaultMargin / 4),
            checkmarkView.widthAnchor.constraint(equalToConstant: checkmarkView.intrinsicContentSize.width),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.defaultMargin / 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.defaultMargin / 2),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.defaultMargin / 2)
        ])
    }

    func configure(with model: FilterChipModel) {
        self.titleLabel.text = model.title
        layer.borderWidth = 2
        layer.cornerRadius = 16
        updateForSelectionState(isSelected: model.isSelected)
    }

    /// Updates the checkmark based on selection state.
    private func updateForSelectionState(isSelected: Bool) {
        checkmarkView.image = isSelected ? Images.selected : Images.notSelected
        let stateColor = isSelected ? UIColor.systemGreen : .lightGray.withAlphaComponent(0.7)
        checkmarkView.tintColor = stateColor
        titleLabel.textColor = isSelected ? .systemGreen : UIColor.label.withAlphaComponent(0.7)
        layer.borderColor = stateColor.cgColor
    }
}
