//
//  AddQuestionViewController.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 14.02.2022.
//

import UIKit

final class AddQuestionViewController: UIViewController {

    private let stackView = UIStackView()

    private lazy var questionTextField = makeTextField(placeholder: "Вопрос")

    private lazy var answerTextFields = [
        makeTextField(placeholder: "Правильный ответ"),
        makeTextField(placeholder: "Неправильный ответ"),
        makeTextField(placeholder: "Неправильный ответ"),
        makeTextField(placeholder: "Неправильный ответ")
    ]

    private let saveButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        setupView()
        setupStackView()
        setupSaveButton()
    }

    private func setupView() {
        view.backgroundColor = .systemPurple
    }

    private func setupStackView() {
        stackView.spacing = 8
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        stackView.addArrangedSubview(questionTextField)

        answerTextFields.forEach {
            stackView.addArrangedSubview($0)
        }
    }

    private func setupSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.tintColor = .white
        view.addSubview(saveButton)
        saveButton.addTarget(
            self,
            action: #selector(saveButtonDidTap),
            for: .touchUpInside)
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stackView.snp.bottom).offset(48)
        }
    }

    private func makeTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        return textField 
    }

    @objc private func saveButtonDidTap() {

        guard let questionText = questionTextField.text else {
            return
        }

        var answers: [Answer] = []

        for (index, textField) in answerTextFields.enumerated() {

            guard let text = textField.text else {
                return
            }

            if index == 0 {
                answers.append(Answer.right(text))
            } else {
                answers.append(Answer.wrong(text))
            }
        }

        let question = Question(text: questionText, answers: answers)
        Game.shared.add(question: question)

        questionTextField.text = nil
        answerTextFields.forEach {
            $0.text = nil
        }
    }
}
