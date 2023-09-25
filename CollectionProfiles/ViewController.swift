//
//  ViewController.swift
//  CollectionProfiles
//
//  Created by Анастасия Рыбакова on 20.09.2023.
//

import UIKit

class ViewController: UIViewController {

// MARK: - User Interface
    
    // 2.1 -> 2.2
    // Создаем коллекцию
    private lazy var profileCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout)
        return collectionView
    }()
    
// MARK: - private properties
    
    // 2.2 -> 2.3
    // В коллекцию будем передавать данные из структуры
    private let profiles = Profile.makeMockData()
    
    
// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupNavigationBar()
    }

    
// MARK: - private methodes
    
    // 2.3 -> 2.4
    // Настройка экрана
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(profileCollectionView)
        profileCollectionView.backgroundColor = .systemGray4
        
        // Регистрируем ячейку коллекции (идентификатор ячейки задаем в файле, где ее определяем)
        profileCollectionView.register(
            ProfileCell.self,
            forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
        
        // Назначаем VC ответсвенным за работу с коллекцией
        profileCollectionView.dataSource = self
        profileCollectionView.delegate = self
    }
    
    // 2.4 -> 2.5
    // Настройка NavigationBar
    private func setupNavigationBar() {
        self.navigationItem.title = "Profiles"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}



// MARK: - Protocols for CollectionView

// Заполняем коллекцию данными
extension ViewController: UICollectionViewDataSource {
    
    // 4.1 -> 4.2
    // Количество ячеек в секции (по умолчнию секция одна)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.profiles.count
    }
    
    // 4.2 -> 4.3
    // Заполняем ячейки данными
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Объявляем ячейку и кастим ее до типа ProfileCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as? ProfileCell
        
        // Передаем в ячейку данные с помощью метода setupCell
        let profile = profiles[indexPath.row]
        cell?.setupCell(with: profile)
        
        return cell ?? ProfileCell()
    }
    
    
}

// Настраиваем внешний вид коллекции
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // 4.3 -> 4.4
    // Задаем размер ячейки (ширину рассчитывааем, высота фиксированная)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = itemWidth(
            for: self.view.frame.width,
            spacing: LayoutConstant.spacing)
        
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    // 4.4 -> 4.5
    // метод для расчета ширины
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemInRow: CGFloat = 2
        
        let totalSpasing: CGFloat = (itemInRow + 1) * spacing
        let itemWidth: CGFloat = (width - totalSpasing) / itemInRow
        
        return itemWidth
    }
    
    // 4.5 -> 4.6
    // Задаем наружные отступы для коллекции относительно вью (не для ячеек вутри)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing)
    }
    
    // 4.6 -> 4.7
    // Расстояние между последовательными строками или столбцами раздела
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstant.spacing
    }
    
    // 4.7 -> 5.1
    //Расстояние между последовательными элементами одной строки или столбца.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstant.spacing
    }
    
    // 5.1 -> 5.2
    // При нажатии на ячейку показыватся второй экран
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destinationVC = SecondViewController()
        let profile = profiles[indexPath.row]
        destinationVC.giveDataToSecondVC(with: profile)
        
        if indexPath.row % 2 == 0 {
            present(destinationVC, animated: true)
        } else {
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
        
        
    }
}




// MARK: - setup Constraints

// 2.5 -> 3.1
// Настраиваем контсрейнты коллекции
extension ViewController {
    
    private func setupConstraints() {
        
        profileCollectionView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    
    }
}
