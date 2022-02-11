//
//  MenuViewController.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 01.02.2022.
//

import SnapKit

final class MenuViewController: UIViewController {

    private let playButton = UIButton()
    private let resultButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupViews()
    }

    private func setupViews() {
        setupNavigationBar()
        setupPlayButton()
        setupResultButton()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonDidTap))

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }

    private func setupPlayButton() {
        playButton.setTitle("Новая игра", for: .normal)
        playButton.addTarget(self, action: #selector(playButtonDidTap), for: .touchUpInside)
        view.addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalToSuperview().inset(200)
        }
    }

    private func setupResultButton() {
        resultButton.setTitle("Результаты", for: .normal)
        resultButton.addTarget(self, action: #selector(resultButtonDidTap), for: .touchUpInside)
        view.addSubview(resultButton)
        resultButton.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(playButton.snp.bottom).offset(20)
        }
    }

    @objc private func settingsButtonDidTap() {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }

    @objc private func playButtonDidTap() {
        let gameViewController = GameViewController()
        gameViewController.modalPresentationStyle = .fullScreen
        present(gameViewController, animated: true, completion: nil)
    }

    @objc private func resultButtonDidTap() {
        let resultViewController = ResultViewController()
        present(resultViewController, animated: true, completion: nil)
    }
}
