//
//  ViewController.swift
//  CollectionNews
//
//  Created by Анастасия Рыбакова on 25.09.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {


// MARK: - User Interface
// 2.1 -> 2.1.2
// Создаем интерфейс
    
    private lazy var topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Interesting Articles (CollectionView)"
        label.textAlignment = .center
        label.backgroundColor = .systemYellow
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
    private lazy var articleCollectionView: UICollectionView = {
        
        let viewLayout = UICollectionViewFlowLayout()
        // Примерный размер ячейки
        viewLayout.estimatedItemSize = CGSize(
            width: UIScreen.main.bounds.width - 40,
            height: 40)
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout)
        
        collectionView.backgroundColor = .systemGray4
        return collectionView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD ARTICLE", for: .normal)
        button.backgroundColor = .systemYellow
        button.tintColor = .black
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
// 1.2 -> 2.1
// В коллекцию будем передавать данные из структуры (массив статей)
// MARK: - Private propertiew
    private var articles = Article.makeMockData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupCollectionView()
    }
    
    
    
// MARK: - private methodes
    
    // 2.2 -> 2.3 (cell)
    // Настройка экрана
    private func setupView() {
        view.backgroundColor = .systemGray4
        view.addSubview(topTitleLabel)
        view.addSubview(articleCollectionView)
        view.addSubview(addButton)
    }
    
    // 2.6 -> 3.1
    // Настройка коллекции
    private func setupCollectionView() {
        
        // Регистрируем ячейку коллекции (идентификатор ячейки задаем в файле, где ее определяем)
        articleCollectionView.register(
            CollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        
        // Назначаем VC ответсвенным за работу с коллекцией
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        
    }
    
    
    // 3.3
    // Кнопка = добавление статьи
    @objc private func addButtonTapped(_ sender: UIButton) {
        
        // Добавляем статью в массив на 0ю позицию
        self.articles.insert(
            Article(title: String.random(lenght: Int.random(in: 10...50)),
                    content: String.random(lenght: Int.random(in: 50...200))),
            at: 0)
        
        // Добавляем ячейку в коллецию на экране (одновременно поднимаем экран до первой строки с помощью механизма CATransaction)
        // performBatchUpdates = метод для обновления коллекции
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.articleCollectionView.scrollToItem(
                at: IndexPath(row: 0, section: 0),
                at: .top,
                animated: true)
        }
        
        self.articleCollectionView.performBatchUpdates {
            self.articleCollectionView.insertItems(
                at: [IndexPath(row: 0, section: 0)])
        }
        
        CATransaction.commit()
        
    }

}


// MARK: - UICollectionViewDataSource
// 3.1 -> 3.2
// Заполнение коллекции данными

extension ViewController: UICollectionViewDataSource {
    
    // Количество ячеек в секции (по умолчнию секция одна)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    // Заполняем ячейки данными
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.reuseIdentifier,
            for: indexPath) as? CollectionViewCell else {
                let cell = CollectionViewCell()
            return cell
        }
        
        let article = articles[indexPath.row]
        cell.setup(withTitle: article.title,
                   andContent: article.content)
        return cell
    }

}


// MARK: - UICollectionViewDelegateFlowLayout
// 3.2 -> 3.3
// Настраиваем внешний вид коллекции

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // Указываем отступ между секциями
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 70, right: 20)
    }
    
    // Снизу указываем отступ 70, чтобы кнопка не перекрывала тектс
    
}


// MARK: - Setup Constraints
// 2.1.2 -> 2.2
// Настраиваем констрейнты

extension ViewController {
    private func setupConstraints() {
        
        topTitleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        articleCollectionView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp_bottomMargin).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        addButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

