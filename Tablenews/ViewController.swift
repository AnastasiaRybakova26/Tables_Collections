//
//  ViewController.swift
//  TableNews
//
//  Created by Анастасия Рыбакова on 19.09.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

// 2.1 -> 2.1.2
// Создаем UI элементы
// MARK: - User Interface
    
    private lazy var topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Interesting Articles (TableView)"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.backgroundColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var articleTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD ARTICLE", for: .normal)
        button.tintColor = .black
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemYellow
        
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
// 1.2 -> 2.1
// В таблицу будем передавать данные из структуры (массив статей)
// MARK: - Private propertiew
    private var articles = Article.makeMockData()
    
    
// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupTableView()
    }

    
    
// MARK: - Private methodes
 
    // 2.2 -> 2.3 (cell)
    // Настройка view
    private func setupView() {
        view.backgroundColor = .systemGray5
        view.addSubview(topTitleLabel)
        view.addSubview(articleTableView)
        view.addSubview(addButton)
    }
    
    // 2.6 -> 3.1
    // Настройка таблицы
    private func setupTableView() {
        articleTableView.dataSource = self
        articleTableView.delegate = self
        
        // Регистрация кастомной ячейки
        articleTableView.register(
            TableViewCell.self,
            forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        
        //  Доп настройки таблицы: отступ в скрольВью снизу и приблизительная высота ячейки
        articleTableView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 60,
            right: 0)
        
        articleTableView.estimatedRowHeight = 44
    }
    
    // 3.3
    // Кнопка = добавление статьи
    @objc private func addButtonTapped(_ sender: UIButton) {
        
        // Добавляем новую статью в массив на нулевую позицию
        self.articles.insert(
            Article(
                title: String.random(lenght: Int.random(in: 5...50)),
                content: String.random(lenght: Int.random(in: 50...300))),
            at: 0)
        
        // Обновляем таблицу, одновременно перемещаемся наверх. Объединяем обе операции с помощью CATransaction
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.articleTableView.scrollToRow(
                at: IndexPath(row: 0, section: 0),
                at: .top,
                animated: true)
        }
        
        articleTableView.beginUpdates()
        articleTableView.insertRows( at: [IndexPath(row: 0, section: 0)], with: .right)
        articleTableView.endUpdates()
        CATransaction.commit()
    }

}


// MARK: - UITableViewDataSourse
// 3.1 -> 3.2
// Заполнение таблицы данными
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.articles.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // метод переиспользования ячейки, касим ее до необходимого типа
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {
            let cell = TableViewCell()
            return cell
        }
        
        // Передаем в ячейку данные из мессива articles
        let article = self.articles[indexPath.row]
        cell.setup(withTitle: article.title, andContent: article.content)
        return cell
    }
}




// MARK: - UITableViewDelegate
// 3.2 -> 3.3
extension ViewController: UITableViewDelegate {
    
    // Высоту ячейки определяем автоматически в зависимости от размера контента
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    // Обработчик свайпа справо-налево = удаляем ячейку таблицы
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Создаем действие
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            // Удаляем статью из массива
            self.articles.remove(at: indexPath.row)
            
            // Удаляем строку из таблицы
            self.articleTableView.beginUpdates()
            self.articleTableView.deleteRows(at: [indexPath], with: .left)
            self.articleTableView.endUpdates()
        }
        
        action.image = UIImage(systemName: "xmark.bin")
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    
    // Обработчик свайпа слева-направо = пересылаем ячейку
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Send") { _, _, _ in
            if let link = NSURL(string: "some_url_String") {
                let title = self.articles[indexPath.row].title
                let message = self.articles[indexPath.row].content
                let objectToShare = [title, message, link] as [Any]
                let activityVC = UIActivityViewController(
                    activityItems: objectToShare,
                    applicationActivities: nil)
                self.present(activityVC, animated: true, completion: nil)
            }
        }
        
        action.image = UIImage(systemName: "arrowshape.turn.up.forward.fill")
        action.backgroundColor = .systemGreen
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
}


// MARK: - Setup Constraints
// 2.1.2 -> 2.2
extension ViewController {
    
    // SnapKit
    private func setupConstraints() {
        
        topTitleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        articleTableView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp_bottomMargin).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        addButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // NSLayoutConstraint
//    private func setupConstraints() {
//
//        let constraints: [NSLayoutConstraint] = [
//
//            topTitleLabel.heightAnchor.constraint(equalToConstant: 60),
//            topTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            topTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//
//            tableView.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
//            addButton.heightAnchor.constraint(equalToConstant: 50),
//            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//    }
}
