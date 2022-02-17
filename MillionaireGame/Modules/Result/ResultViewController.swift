//
//  ResultViewController.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 01.02.2022.
//

import UIKit

final class ResultViewController: UIViewController {

    private let tableView = UITableView()
    private var records: [GameRecord]

    init() {
        records = Game.shared.loadRecords()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(ResultCell.self, forCellReuseIdentifier: "ResultCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }

    private func makeCellViewModel(using record: GameRecord) -> ResultCell.ViewModel {
        let date = dateStringFrom(date: record.date)

        return ResultCell.ViewModel(
            title: "Правильных ответов: \(record.rightQuestionCount) из \(record.questionCount), \(record.rightQuestionCount * 100 / record.questionCount)%",
            subtitle: "Дата: \(date)")
    }

    private func dateStringFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, HH:mm"

        dateFormatter.locale = Locale(identifier: "ru_RU")
        return (dateFormatter.string(from: date as Date))
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
            return UITableViewCell()
        }
        let viewModel = makeCellViewModel(using: records[indexPath.row])
        cell.update(with: viewModel)

        return cell
    }
}
