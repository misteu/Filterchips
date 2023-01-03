//
//  FilterChipCollectionViewController.swift
//  
//
//  Created by Michael Steudter on 02.01.23.
//

import UIKit

public class FilterChipCollectionViewController: UICollectionViewController {

    public static let defaultItemHeight: CGFloat = 44.0

    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return layout
    }()

    var viewModel: FilterChipCollectionViewModel

    public init() {
        self.viewModel = .init(data: [])
        super.init(collectionViewLayout: flowLayout)
        setup()
    }

    required init?(coder: NSCoder) { nil }

    private func setup() {
        collectionView.register(FilterChipCollectionViewCell.self, forCellWithReuseIdentifier: FilterChipCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
    }

    public func update(with data: [FilterChipModel]) {
        self.viewModel.data = data
//        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FilterChipCollectionViewController: UICollectionViewDelegateFlowLayout {

    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.data.isEmpty ? 0 : 1
    }

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.data.count
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterChipCollectionViewCell.identifier, for: indexPath)
        guard viewModel.data.indices.contains(indexPath.row),
              let cell = cell as? FilterChipCollectionViewCell else { return cell }
        let model = viewModel.data[indexPath.row]
        if model.isSelected {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        } else {
            collectionView.deselectItem(at: indexPath, animated: false)
        }

        cell.configure(with: model)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fullWidth = collectionView.bounds.width
        guard viewModel.data.indices.contains(indexPath.row) else { return .zero }
        let neededWidth = viewModel.data[indexPath.row].title.width(withConstrainedHeight: Self.defaultItemHeight,
                                                                    font: .preferredFont(forTextStyle: .body))
        let actualWidth = min(neededWidth + 48, fullWidth)
        return CGSize(width: actualWidth, height: Self.defaultItemHeight)
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.data.indices.contains(indexPath.row) else { return }
        viewModel.data[indexPath.row].tapHandler?(true)
        UIDevice.vibrate(.rigid)
    }

    public override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard viewModel.data.indices.contains(indexPath.row) else { return }
        viewModel.data[indexPath.row].tapHandler?(false)
        UIDevice.vibrate(.light)
    }

}
