//
//  UICollectionView+Extension.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 02.02.2022.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T else {
            return T()
        }
        return cell
    }
}
