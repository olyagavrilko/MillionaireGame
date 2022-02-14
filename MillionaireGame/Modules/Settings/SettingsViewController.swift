//
//  SettingsViewController.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 10.02.2022.
//

import UIKit

final class SettingsViewController: UIViewController {

    private let sequenceControl = UISegmentedControl(items: ["sequentially", "randomly"])
    private let addQuestionButton = UIButton()

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
        setupAddQuestionButton()
    }

    private func setupSegmentControl() {
        sequenceControl.selectedSegmentIndex = Game.shared.strategy.index
        view.addSubview(sequenceControl)
        sequenceControl.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
    }

    private func setupAddQuestionButton() {
        addQuestionButton.setTitle("Добавить новый вопрос", for: .normal)
        addQuestionButton.addTarget(self, action: #selector(addQuestionButtonDidTap), for: .touchUpInside)
        view.addSubview(addQuestionButton)
        addQuestionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sequenceControl.snp.bottom).offset(24)
        }
    }

    @objc private func addQuestionButtonDidTap() {
        let vc = AddQuestionViewController()
        present(vc, animated: true)
    }
}
