//
//  SecondViewController.swift
//  CollectionProfiles
//
//  Created by Анастасия Рыбакова on 20.09.2023.
//

import UIKit
import SnapKit

// 5.2 Настраиваем второй экран
class SecondViewController: UIViewController {
    
// MARK: - User Interface
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let nameLabel = UILabel(color: .white, size: 50)
    private let locationLabel = UILabel(color: .white, size: 30)
    private let subjectLabel = UILabel(color: .white, size: 30)
    

// MARK: - Life Sycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        
    }
    
// MARK: - private methodes
    private func setupView() {
        view.backgroundColor = .systemGray
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(subjectLabel)
    }
    
    // Передаем данные на второй VC
    func giveDataToSecondVC(with profile: Profile) {
        profileImageView.image = UIImage(named: profile.imageName)
        nameLabel.text = profile.name
        locationLabel.text = profile.location
        subjectLabel.text = profile.subject
    }
    
}


// MARK: - setup constraints

extension SecondViewController {
    
    private func setupConstraints() {

        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(SecondVCConstants.imageHeight)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(SecondVCConstants.verticalPadding)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp_bottomMargin).offset(SecondVCConstants.spacing * 2)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp_bottomMargin).offset(SecondVCConstants.spacing)
        }
        
        subjectLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(locationLabel.snp_bottomMargin).offset(SecondVCConstants.spacing)
        }

        
       
    }
}
