//
//  GameViewController.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 01.02.2022.
//

import UIKit

final class GameViewController: UIViewController {

    private let session = GameSession()

    private let questionLabel = UILabel()
    private let collectionViewLayout = UICollectionViewFlowLayout()

    private var question: Question?

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout)

    init() {
        super.init(nibName: nil, bundle: nil)
        session.view = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        session.viewDidLoad()
    }

    private func setupViews() {
        setupView()
        setupQuestionLabel()
        setupCollectionView()
    }

    private func setupView() {
        view.backgroundColor = .systemTeal
    }

    private func setupQuestionLabel() {
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupCollectionView() {
        collectionViewLayout.minimumLineSpacing = 20
        collectionViewLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.size.width - 32,
            height: 50)

        collectionView.backgroundColor = .systemTeal
        collectionView.register(cellClass: GameAnswerCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(280)
            $0.top.equalTo(questionLabel.snp.bottom).offset(40)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

extension GameViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let question = question else {
            return
        }
        session.answerWasTapped(question.answers[indexPath.row])
    }
}

extension GameViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return question?.answers.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(GameAnswerCell.self, for: indexPath)
        cell.update(with: question?.answers[indexPath.row].text ?? "")
        cell.backgroundColor = .systemIndigo
        return cell
    }
}

extension GameViewController: GameSessionView {

    func update(with question: Question) {
        questionLabel.text = question.text
        self.question = question
        collectionView.reloadData()
    }

    func update(with text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .cancel) { _ in
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
        questionLabel.text = nil
        question = nil
        collectionView.reloadData()
    }
}
