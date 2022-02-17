//
//  GameAnswerCell.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 01.02.2022.
//

import UIKit

final class GameAnswerCell: UICollectionViewCell {

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        label.textAlignment = .center
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(10)
        }
    }

    func update(with text: String) {
        label.text = text
    }
}
