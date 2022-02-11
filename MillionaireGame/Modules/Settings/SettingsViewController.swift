//
//  SettingsViewController.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 10.02.2022.
//

import UIKit

final class SettingsViewController: UIViewController {

    private let sequenceControl = UISegmentedControl(items: ["sequentially", "randomly"])

    private var strategy: Strategy {
        switch self.sequenceControl.selectedSegmentIndex {
        case 0:
            return SequentialStrategy()
        case 1:
            return RandomStrategy()
        default:
            return SequentialStrategy()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupViews()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Game.shared.strategy = strategy
    }

    private func setupViews() {
        setupSegmentControl()
    }

    private func setupSegmentControl() {
        sequenceControl.selectedSegmentIndex = Game.shared.strategy.index
        view.addSubview(sequenceControl)
        sequenceControl.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
    }
}
