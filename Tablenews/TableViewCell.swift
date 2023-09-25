//
//  TableViewCell.swift
//  TableNews
//
//  Created by Анастасия Рыбакова on 19.09.2023.
//

import UIKit

// 2.4 -> 2.5
// Протокол для определения идентификатора ячейки
protocol Reusable {
    static var reuseIdentifier: String {get}
}



// 2.3 -> 2.4
// Настраиваем ячейку таблицы
class TableViewCell: UITableViewCell {
    
// MARK: - User Interface
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
// MARK: - cell initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

// MARK: - setup Cell
    private func setupCell() {
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    
    // метод переиспользования ячейки
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        contentLabel.text = nil
    }
    
    
    // Метод, который в ячейке прописывает тект в заголовок и контент
    func setup(withTitle title: String, andContent content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }

}


// MARK: - setup constraints
extension TableViewCell {
    
    // SnapKit
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(10)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp_bottomMargin).offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    // NSLayoutConstraint
//    private func setupConstraints() {
//
//        let constraints: [NSLayoutConstraint] = [
//            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//
//            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//    }
}


// MARK: - Impliment Reusable protocol for inebtifier
// 2.5 -> 2.6
// В расширении указываем идентификатор ячейки (реализация протокола)
extension TableViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
