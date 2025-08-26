//
//  CompositionView.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation
import SnapKit

class CompositionView: UIView, WeahterPresenterProtocol {
    
    // MARK: - Private properties and methods.
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont(name: "AlNile", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    //    private let anyLable = UILabel().then {
    //        then посторонняя библиотека, которая позволяет сразу приступить к настройке объекта после инициализации.
    //    }
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont(name: "STIXTwoText", size: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont(name: "AlNile", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
//    open lazy var tabBar: UITabBar = {
//        let bar = UITabBar()
//        bar.translatesAutoresizingMaskIntoConstraints = false
//        
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(red: 70/255, green: 100/255, blue: 180/255, alpha: 1.0)
//        
//        appearance.stackedLayoutAppearance.selected.iconColor = .white
//        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.stackedLayoutAppearance.normal.iconColor = .white.withAlphaComponent(0.6)
//        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
//        
//        bar.standardAppearance = appearance
//        
//        if #available(iOS 15.0, *) {
//            bar.scrollEdgeAppearance = appearance
//        }
//        return bar
//    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 15
        collectionView.layer.masksToBounds = true
        collectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FirstCollectionViewCell.self))
        collectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SecondCollectionViewCell.self))
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderSupplementaryView.self))
        collectionView.register(SeparatorCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SeparatorCollectionViewCell.self))
        collectionView.backgroundColor = .red.withAlphaComponent(0.3)
        return collectionView
    }()
    
    // MARK: - Model.
    
    private var collectionModel: CollectionModel = CollectionModel(sections: [])


    // MARK: - Setup Delegates.
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Life Cycle.
    
    init() {
        super.init(frame: .zero)
        setDelegates()
        setup()
        fonts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fonts() {
        for family in UIFont.familyNames.sorted() {
            print("📁 Сімейство шрифтов: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   🔤 \(name)")
            }
        }
    }
}


extension CompositionView {
    
    // MARK: - Setup Model.
    
    func updateTemperature(param: CompositionModel) {
        countryLabel.text = param.country
        temperatureLabel.text = "\(param.temperature ?? 0)"
        conditionLabel.text = param.condition
    }
    
    func setCollectionModel(param: CollectionModel) {
        collectionModel = param
        collectionView.reloadData()
//        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - Create Compositionlayout.

extension CompositionView {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            switch sectionIndex {
            case 0:
                return self.createFirstSection()
            case 1:
                return self.createSecondSection()
            default:
                return nil
            }
        }
    }
}


// MARK: - Extension setup Layout Section.

extension CompositionView {
    
    private func createLayoutSection(
        group: NSCollectionLayoutGroup,
        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem]) -> NSCollectionLayoutSection {
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = behavior
            section.interGroupSpacing = interGroupSpacing
            section.boundarySupplementaryItems = supplementaryItems
            return section
        }
    
    private func createFirstSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(65), heightDimension: .fractionalHeight(0.2)), subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: -10,
                                          supplementaryItems: [supplementaryHeaderItem()])
        section.contentInsets = .init(top: 0, leading: 0, bottom: 25, trailing: 0)
        return section
    }
    
    private func createSecondSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), subitems: [item])
        //        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
//        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 0, bottom: 25, trailing: 0)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        header.extendsBoundary = true
        //        header.zIndex = 1
        return header
    }
}

// MARK: - Setup Collection Cells.

extension CompositionView: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionModel.sections[indexPath.section].items[indexPath.item].id, for: indexPath)
    
        switch cell {
        case let cell as FirstCollectionViewCell:
            cell.configuredCell(by: collectionModel.sections[indexPath.section].items[indexPath.item].cellModel)
            return cell
            
        case let cell as SecondCollectionViewCell:
            cell.configuredCell(by: collectionModel.sections[indexPath.section].items[indexPath.item].cellModel)
            return cell
            
        case let cell as SeparatorCollectionViewCell:
           
//            let isLast = indexPath.item == collectionModel.sections[indexPath.section].items.count - 1
//            cell.setSeparatorHidden(isLast)
            
//            (cell as SeparatorDisplayable).setSeparatorHidden((isLast))
            return cell
        default:
            return cell
        }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: HeaderSupplementaryView.self), for: indexPath) as? HeaderSupplementaryView
            else {
                return UICollectionReusableView()
            }
            header.configureHeader(categoryName: collectionModel.sections[indexPath.section].title)
            header.backgroundColor = UIColor(red: 35/255, green: 51/255, blue: 98/255, alpha: 15)
            header.layer.cornerRadius = 15
            header.layer.masksToBounds = true
            header.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        
        // Диапазон смещения, в границах которого хедер будет прятаться.
        let hideStartOffset: CGFloat = 0
        let hideEndOffset: CGFloat = 80 // Тут хедер полностью пропадает.
        
        // Висчитываем процесс спрятывания.
        let offsetY = scrollView.contentOffset.y
        let progress = max(0, min(1, (offsetY - hideStartOffset) / (hideEndOffset - hideStartOffset)))
        
        // Для всех видимых хедеров используем эффекты.
        let headers = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader)
        
        // Альф от 1 до 0
        headers.first?.alpha = 1 - progress
        
        // Смещение вверх для эффекта "сдвига".
        headers.first?.transform = CGAffineTransform(translationX: 0, y: -progress * 10)
        
    }
}

// MARK: - Setup Constraints.
extension CompositionView {
    func setup() {
        setupView()
        setConstraints()
    }
    
    func setupBackGround() {
        let animatedBackground = AnimatedWeatherBackgroundView(frame: bounds)
        addSubview(animatedBackground)
        sendSubviewToBack(animatedBackground)  // фон находится сзади UICollectionView
    }
    
    func setupView() {
        addSubview(collectionView)
        addSubview(countryLabel)
        addSubview(temperatureLabel)
        addSubview(conditionLabel)
    }
    
    
// MARK: - Set Constraints.
    func setConstraints() {
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            countryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 2),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 3),
            conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 350),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

        ])
    }
}
//
//extension CompositionView: UITabBarDelegate {
//    
//    func setupTabBar() {
//        let item1 = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
//        item1.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -6, right: 0)
//        item1.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
//        let item2 = UITabBarItem(title: "", image: UIImage(systemName: "cloud.sun"), tag: 1)
//        item2.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
//        item2.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
//
//        tabBar.items = [item1, item2]
//        tabBar.selectedItem = tabBar.items?.first
//        tabBar.delegate = self
//        tabBar.backgroundColor = .white
//        tabBar.tintColor = .white
//        tabBar.layer.shadowColor = UIColor.black.cgColor
//        tabBar.layer.shadowOpacity = 0.1
//        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
//        tabBar.layer.shadowRadius = 8
//    }
//}
//
