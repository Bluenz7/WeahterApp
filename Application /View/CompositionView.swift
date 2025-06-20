//
//  CompositionView.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation
import SnapKit

class CompositionView: UIViewController {
    
    //MARK: - Private properties and methods.
    private let firstLabel: UILabel = {
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
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont(name: "STIXTwoText", size: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont(name: "AlNile", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 15
        collectionView.layer.masksToBounds = true
        collectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FirstCollectionViewCell.self))
        collectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SecondCollectionViewCell.self))
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderSupplementaryView.self))
        return collectionView
    }()
    
    // MARK: - Presenter.
    private lazy var presenter: WeatherPresenter = {
        return WeatherPresenter(view: self, weatherPresenter: self)
    }()
    
    //MARK: - Calling BackgorundView.
    private var weatherBackgroundView: AnimatedWeatherBackgroundView?
    
    // MARK: - Model.
    private var collectionModel: CollectionModel = CollectionModel(sections: [])
    
    //MARK: - Setup Delegates.
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Life Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setup()
        presenter.loadWeather()
        fonts()
    }
    
    func fonts() {
        for family in UIFont.familyNames.sorted() {
            print("📁 Сімейство шрифтов: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   🔤 \(name)")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if weatherBackgroundView == nil {
            let bg = AnimatedWeatherBackgroundView(frame: view.bounds)
            weatherBackgroundView = bg
            view.addSubview(bg)
            view.sendSubviewToBack(bg)
        }
    }
    
    //MARK: - Setup Model.
    func setCollectionModel(param: CollectionModel) {
        collectionModel = param
        collectionView.reloadData()
    }
}

extension CompositionView: WeahterPresenterProtocol {
    func updateTemperature(country: String, temperature: Double, condition: String) {
        firstLabel.text = country
        secondLabel.text = "\(temperature)º"
        thirdLabel.text = condition
    }
}

//MARK: - Create Compositionlayout.
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


//MARK: - Extension setup Layout Section.
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
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
        //        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        section.interGroupSpacing = 20
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

//MARK: - Setup Collection Cells.
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
        default:
            return cell
        }
        
//        switch collectionModel[indexPath.section] {
//            
//        case .firstCollection(let data):
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FirstCollectionViewCell.self), for: indexPath) as? FirstCollectionViewCell
//            else {
//                return UICollectionViewCell()
//            }
//            
//            // После
//            let timeString = data.hourSection[indexPath.item].time ?? ""
//            let hourOnly = extractHour(from: timeString)
//            let iconPath = String(data.hourSection[indexPath.item].condition.icon ?? "")
//            let fullIconURL = URL(string: "http:" + iconPath)
//            
//            cell.configuredCell(firstText: hourOnly, url: fullIconURL, thirdText: Double(data.hourSection[indexPath.item].temp_c ?? 0))
            // До
//            let timeString = data.forecast.forecastday.first?.hour[indexPath.item].time ?? ""
//            let hourOnly = extractHour(from: timeString)
//            let iconPath = String(data.forecast.forecastday.first?.hour[indexPath.item].condition.icon ?? "")
//            let fullIconURL = URL(string: "http:" + iconPath)
//            
//            cell.configuredCell(firstText: hourOnly, url: fullIconURL, thirdText: Double(data.forecast.forecastday.first?.hour[indexPath.item].temp_c ?? 0))

//            return cell
//            
//        case .secondCollection(let data):
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SecondCollectionViewCell.self), for: indexPath) as? SecondCollectionViewCell
//            else {
//                return UICollectionViewCell()
//            }
//            
//            let dayString = String(data.forecast.forecastday[indexPath.item].hour[indexPath.item].time ?? "")
//            let dayOnly = extractDay(from: dayString)
//            let iconPath = String(data.current.condition.icon ?? "")
//            let fullIconURL = URL(string: "http:" + iconPath)
//            cell.configuredCell(firstText: dayOnly, image: fullIconURL, minTemp: data.forecast.forecastday[indexPath.item].day.mintemp_c, maxTemp: data.forecast.forecastday[indexPath.item].day.maxtemp_c)
//            
//            let temperature = data.forecast.forecastday[indexPath.item].day.mintemp_c ?? 0
//            cell.updateTemperature(temperature)
//            let isLast = indexPath.item == data.forecast.forecastday.count - 1
//            (cell as SeparatorDisplayable).setSeparatorHidden(isLast)
//
//            return cell
//        }
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

//MARK: - Setup Constraints.
extension CompositionView {
    func setup() {
        setupView()
        setConstraints()
    }
    
    func setupBackGround() {
        let animatedBackground = AnimatedWeatherBackgroundView(frame: view.bounds)
        view.addSubview(animatedBackground)
        view.sendSubviewToBack(animatedBackground)  // фон находится сзади UICollectionView
    }
    
    func setupView() {
        view.addSubview(collectionView)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(thirdLabel)
    }
    //MARK: - Set Constraints.
    func setConstraints() {
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            firstLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 2),
            secondLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            thirdLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 3),
            thirdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1)
        ])
    }
}


