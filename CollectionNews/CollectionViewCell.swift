//
//  CollectionViewCell.swift
//  CollectionNews
//
//  Created by Анастасия Рыбакова on 25.09.2023.
//

import UIKit
import SnapKit

// 2.4 -> 2.5
// Протокол для определения идентификатора ячейки
protocol Reusable {
    static var reuseIdentifier: String {get}
}


// 2.3 -> 2.4
// Настраиваем ячейку таблицы
class CollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    
    
// MARK: - cell initialization
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.setupCell()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // При переиспользовании ячейки ее надо очистить в методе prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.contentLabel.text = nil
    }
    
    // настраиваем вид ячейки
    private func setupCell() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    // Метод, который заполняет заголовок и текст ячейки данными
    func setup(withTitle title: String, andContent content: String) {
        self.titleLabel.text = title
        self.contentLabel.text = content
    }
    
    
    // Метод, который автоматически определяет размер ячейки в зависимости от ее наполнения
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {

        // Задаем целевой размер
        // Высота будет меняться в зависимости от AutoLayout
        var targetSize = targetSize
        targetSize.height = CGFloat.greatestFiniteMagnitude

        // Вызываем метод суперкласса и указываем, что ширина = EstimatedItemSize, высота будет подстраиваться под рассчитанный за счет AutoLayout фрейм
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size
    }
    
    
}


// Настраиваем контсрейнты
extension CollectionViewCell {
    
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
    
}


// MARK: - Impliment Reusable protocol for inebtifier
// 2.5 -> 2.6
// В расширении указываем идентификатор ячейки

extension CollectionViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
