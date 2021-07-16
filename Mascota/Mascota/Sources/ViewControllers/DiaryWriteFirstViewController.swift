//
//  DiaryWriteFirstViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/10.
//

import UIKit
import Moya

class DiaryWriteFirstViewController: UIViewController {
    
    var pets: [PetImageModel] = []
    var selectedPets: [Int] = [-1, -1, -1, -1]
    var selected: [Int] = []
    
    var characters: [Character] = []
    
    var customLabelAlertView = CustomLabelAlertView()
    
    let petsService = MoyaProvider<PetsAPI>(plugins: [MoyaLoggingPlugin]())
    
    let diaryWriteCollectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                                      collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.showsVerticalScrollIndicator = false
                                                                        $0.backgroundColor = UIColor.macoIvory
                                                                        $0.allowsMultipleSelection = true
    }
    
    let nextButton: UIButton = UIButton().then() {
        $0.setAttributedTitle("다음".convertColorFont(color: UIColor.macoWhite, fontSize: 20, type: .medium), for: .normal)
        $0.layer.cornerRadius = 3
        $0.setBackgroundColor(UIColor.macoOrange, for: .normal)
        $0.setAttributedTitle("다음".convertColorFont(color: UIColor.macoDarkGray,
                                                    fontSize: 20,
                                                    type: .medium),
                                                    for: .disabled)
        $0.setBackgroundColor(UIColor.macoLightGray, for: .disabled)
        $0.isEnabled = false
    }
    
    let navigationTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .medium, size: 17)
        $0.textAlignment = .center
        $0.textColor = UIColor.macoBlack
    }
    
    let navigiationRightView: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 14)
        $0.textColor = UIColor.darkGray
        $0.textAlignment = .center
        $0.text = "1/2"
    }
    
    let leftProgressBar: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoOrange
    }
    
    let rightProgressBar: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoLightGray
    }
    
    let stackView: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 0
        $0.axis = .horizontal
    }
    
    @objc
    private func touchBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(leftProgressBar)
        layoutComponents()
        initializeNavigationItems()
        registerCollectionView()
        registerCollectionViewCell()
        setViews()
        initializeNavigationBarColor()
        addNextButtonTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getPetsInfo()
    }
    
    private func addNextButtonTarget() {
        self.nextButton.addTarget(self, action: #selector(touchNextButton), for: .touchUpInside)
    }
    
    private func getPetsInfo() {
        petsService.request(.getPetsInfo) { [weak self] result in
            switch result {
            case .success(let response):
                print("success")
                do {
                    let value = try JSONDecoder().decode(GenericModel<PetsImageModel>.self, from: response.data)
                    guard let images = value.data?.pets else {
                        return
                    }
                    print(images)
                    self?.updateServerData(pets: images)
                } catch (let err) {
                    print(err.localizedDescription)
                }
            
            case .failure(let err):
                print("fail")
                print(err.localizedDescription)
            }
        }
    }
    
    private func updateServerData(pets: [PetImageModel]) {
        self.pets = pets
        self.selectedPets = [Int].init(repeating: -1, count: self.pets.count)
        self.reloadEmotions()
    }
    
    @objc func touchNextButton() {
        pushToDiaryWriteSecond()
    }
    

    private func pushToDiaryWriteSecond() {
        let storyboard = UIStoryboard(name: AppConstants.Storyboard.diaryWriteSecond, bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: AppConstants.ViewController.diaryWriteSecond) as? DiaryWriteSecondViewController else {
            return
        }
        vc.characters = self.characters
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func initializeNavigationBarColor() {
        self.navigationController?.navigationBar.barTintColor = .macoIvory
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func initializeNavigationItems() {
        navigationTitleLabel.text = "이야기 작성"
        self.navigationItem.titleView = navigationTitleLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btnIconBack"), style: .plain, target: self, action: #selector(touchBackButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigiationRightView)
    }
    
    private func setViews() {
        self.view.backgroundColor = UIColor.macoIvory
    }
    
    private func registerCollectionView() {
        self.diaryWriteCollectionView.dataSource = self
        self.diaryWriteCollectionView.delegate = self
    }
    
    private func findSelected() {
        selected = []
        selectedPets.enumerated().forEach {
            if $1 >= 0 {
                selected.append($0)
            }
        }
    }
    
    private func isButtonAvailable() {
        self.characters = []
        if selected.isEmpty {
            nextButton.isEnabled = false
            return
        }
        for idx in selected {
            let pet = pets[idx]
            characters.append(Character(id: pet.id, feeling: selectedPets[idx]))
            if self.selectedPets[idx] == 100 || self.selectedPets[idx] == -1 {
                nextButton.isEnabled = false
                return
            }
        }
        nextButton.isEnabled = true
    }
    
    private func registerCollectionViewCell() {
        self.diaryWriteCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.characterCollectionViewCell,
                                                     bundle: nil),
                                               forCellWithReuseIdentifier: AppConstants.CollectionViewCells.characterCollectionViewCell)
        self.diaryWriteCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.petEmotionCollectionViewCell, bundle: nil),
                                               forCellWithReuseIdentifier: AppConstants.CollectionViewCells.petEmotionCollectionViewCell)
        
        self.diaryWriteCollectionView.register(UINib(nibName: AppConstants.CollectionViewHeaders.characterMoodCollectionReusableView,
                                                     bundle: nil),
                                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                               withReuseIdentifier: AppConstants.CollectionViewHeaders.characterMoodCollectionReusableView)
        self.diaryWriteCollectionView.register(UINib(nibName: AppConstants.CollectionViewHeaders.emptyCollectionReusableView, bundle: nil),
                                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                               withReuseIdentifier: AppConstants.CollectionViewHeaders.emptyCollectionReusableView)
        
    }

    private func layoutComponents() {
        stackView.addArrangedSubviews(leftProgressBar, rightProgressBar)
        
        self.view.addSubviews(diaryWriteCollectionView, nextButton, stackView)
        
        leftProgressBar.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.top)
            $0.leading.equalTo(stackView.snp.leading)
            $0.bottom.equalTo(stackView.snp.bottom)
        }

        rightProgressBar.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.top)
            $0.trailing.equalTo(stackView.snp.trailing)
            $0.leading.equalTo(leftProgressBar.snp.trailing)
            $0.bottom.equalTo(stackView.snp.bottom)
        }
        
        diaryWriteCollectionView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(28)
            $0.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
        }
    }
    
    private func reloadEmotions() {
        self.diaryWriteCollectionView.reloadData()
    }

}

extension DiaryWriteFirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.characterCollectionViewCell,
                                                                for: indexPath) as? CharacterCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.characterCollectionViewCellProtocol = self
            cell.updateVariable(pets: pets, selectedCell: selectedPets)
            return cell

        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.petEmotionCollectionViewCell,
                                                                for: indexPath) as? PetEmotionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.tag = selected[indexPath.section - 1]
            cell.updateData(petImageModel: pets[selected[indexPath.section - 1]])
            cell.updateSelectedCell(selcted: selectedPets[selected[indexPath.section - 1]])
            cell.petEmotionCollectionViewCellProtocol = self
            return cell
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return selected.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if indexPath.section == 0 {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppConstants.CollectionViewHeaders.characterMoodCollectionReusableView, for: indexPath) as? CharacterMoodCollectionReusableView else {
                return UICollectionReusableView()
            }
            return header
        } else {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                               withReuseIdentifier: AppConstants.CollectionViewHeaders.emptyCollectionReusableView, for: indexPath) as? EmptyCollectionReusableView else {
                return UICollectionReusableView()
            }
            return header
        }
    }
    
}

extension DiaryWriteFirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 160)
        case selected.count:
            return CGSize(width: collectionView.frame.width, height: 200)
        default:
            return CGSize(width: collectionView.frame.width, height: 130)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 86)
        } else {
            return CGSize(width: 0, height: 0)
        }
        
    }
}

extension DiaryWriteFirstViewController: CharacterCollectionViewCellProtocol {
    func seletedCell(index: Int) {
        guard let container = self.diaryWriteCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? CharacterCollectionViewCell,
              let cell = container.characterCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) else {
            return
        }
        if cell.isSelected {
            presentUnselectCustomAlert(index: index)
        } else {
            cell.isSelected = true
            selectedPets[index] = 100
            findSelected()
            reloadEmotions()
            isButtonAvailable()
        }
    }
    
}

extension DiaryWriteFirstViewController {
    func presentUnselectCustomAlert(index: Int) {
        
        self.customLabelAlertView.setTitle(text: "기분 삭제")
        self.customLabelAlertView.setAttributedDescription(attributedText: (pets[index].name + "(이)가 주인공에서 해제됩니다.\n기분을 삭제하시겠어요?").convertSomeColorFont(color: UIColor.macoBlack,
                                               fontSize: 14,
                                               type: .medium,
                                               start: 0,
                                               length: pets[index].name.count))

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let tempViewController = UIViewController()
        
        let confirmAction: UIAlertAction = UIAlertAction(title: "취소", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        let deleteAction: UIAlertAction = UIAlertAction(title: "삭제", style: .default) { _ in
            guard let container = self.diaryWriteCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? CharacterCollectionViewCell,
                  let cell = container.characterCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) else {
                return
            }
            cell.isSelected = false
            self.selectedPets[index] = -1
            self.findSelected()
            self.reloadEmotions()
            self.isButtonAvailable()
        }
        
        confirmAction.setValue(UIColor.macoLightGray, forKey: "titleTextColor")
        deleteAction.setValue(UIColor.macoOrange, forKey: "titleTextColor")

        tempViewController.view = customLabelAlertView
        tempViewController.preferredContentSize = CGSize(width: 270, height: 127)
        
        if let bgView = alert.view.subviews.first,
                    let groupView = bgView.subviews.first,
                    let contentView = groupView.subviews.first {
                    contentView.backgroundColor = UIColor.macoWhite
                }
        
        alert.addAction(confirmAction)
        alert.addAction(deleteAction)
        
        alert.setValue(tempViewController, forKey: "contentViewController")
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

extension DiaryWriteFirstViewController: PetEmotionCollectionViewCellProtocol {
    func selectEmotion(section: Int, item: Int) {
        print(section, item)
        selectedPets[section] = item
        isButtonAvailable()
    }
}
