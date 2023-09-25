//
//  ProfileCell.swift
//  CollectionProfiles
//
//  Created by Анастасия Рыбакова on 20.09.2023.
//

import UIKit
import SnapKit

// 3.2 -> 3.3
// Протокол для определения идентификатора ячейки
protocol Reusable {
    static var reuseIdentifier: String {get}
}

// 3.1 -> 3.2
// Настраиваем ячейку коллекции
class ProfileCell: UICollectionViewCell {
    
// 3.4 -> 3.5
// MARK: - User Interface
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel = UILabel(color: .black, size: 18)
    private let locationLabel = UILabel(color: .black, size: 18)
    private let subjectLabel = UILabel(color: .black, size: 18)
    

// 3.5 -> 3.6
// MARK: - Life cycle
    
    // Переопределяем инициализатор ячейки
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.setupViewCell()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Переиспользование ячейки
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        locationLabel.text = nil
        subjectLabel.text = nil
    }
    
    

// MARK: - Private Methodes
    
    // 3.6 -> 3.7
    private func setupViewCell() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = CellConstants.contentViewRadius
        contentView.backgroundColor = .systemRed
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        self.addSubview(subjectLabel)
    }
    
    // 3.7 -> 4.1
    // Заполняем ячейку информацией, передавая в метод обхект Profile
    func setupCell(with profile: Profile) {
        profileImageView.image = UIImage(named: profile.imageName)
        nameLabel.text = profile.name
        locationLabel.text = profile.location
        subjectLabel.text = profile.subject
    }
    
}

// MARK: - setup Constraints
extension ProfileCell {
    private func setupConstraints() {
        
        profileImageView.snp.makeConstraints {
            $0.height.equalTo(CellConstants.imageHeight)
            $0.leading.top.trailing.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(CellConstants.horizontalPadding)
            $0.top.equalTo(profileImageView.snp_bottomMargin).offset(CellConstants.verticalPadding)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(CellConstants.horizontalPadding)
            $0.top.equalTo(nameLabel.snp.bottom).offset(CellConstants.verticalPadding)
        }
        
        subjectLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(CellConstants.horizontalPadding)
            $0.top.equalTo(locationLabel.snp.bottom).offset(CellConstants.verticalSpacing)
            $0.bottom.equalToSuperview().inset(CellConstants.verticalPadding)
        }
        
    }
}

// 3.3 -> 3.4
// Расширение для реализации протокола, чтобы у ячейки был идентификатор = название класса
extension ProfileCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    
}
