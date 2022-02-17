//
//  ResultCell.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 08.02.2022.
//

import UIKit

final class ResultCell: UITableViewCell {

    struct ViewModel {
        let title: String
        let subtitle: String
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with viewModel: ViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.subtitle
    }
}
