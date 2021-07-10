//
//  DiaryWriteFirstViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/10.
//

import UIKit

class DiaryWriteFirstViewController: UIViewController {
    
    var pets: [String] = ["워렌 버핏", "빌 게이츠", "머스크", "팀쿡"]
    var seletedPets: [Int] = [-1,-1,-1,-1]
    var selected: [Int] = []
    
    var customLabelAlertView = CustomLabelAlertView()
    
    let diaryWriteCollectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                                      collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.showsVerticalScrollIndicator = false
                                                                        $0.backgroundColor = UIColor.macoIvory
                                                                        $0.allowsMultipleSelection = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutComponents()
        registerCollectionView()
        registerCollectionViewCell()
    }
    
    private func registerCollectionView() {
        self.diaryWriteCollectionView.dataSource = self
        self.diaryWriteCollectionView.delegate = self
    }
    
    private func findSelected() {
        selected = []
        seletedPets.enumerated().forEach {
            if $1 >= 0 {
                selected.append($0)
            }
        }
    }
    
    private func isButtonAvailable() {
        for idx in selected {
            if self.seletedPets[idx] == 100 {
                //button disable
                return
            }
        }
//        button enable
    }
    
    private func registerCollectionViewCell() {
        self.diaryWriteCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.characterCollectionViewCell,
                                                     bundle: nil),
                                               forCellWithReuseIdentifier: AppConstants.CollectionViewCells.characterCollectionViewCell)
        
        self.diaryWriteCollectionView.register(UINib(nibName: AppConstants.CollectionViewHeaders.characterMoodCollectionReusableView,
                                                     bundle: nil),
                                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                               withReuseIdentifier: AppConstants.CollectionViewHeaders.characterMoodCollectionReusableView)
        
    }

    private func layoutComponents() {
        self.view.addSubview(diaryWriteCollectionView)
        diaryWriteCollectionView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(12)
        }
    }

}

extension DiaryWriteFirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.characterCollectionViewCell,
                                                            for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.characterCollectionViewCellProtocol = self
        cell.pets = self.pets
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                               withReuseIdentifier: AppConstants.CollectionViewHeaders.characterMoodCollectionReusableView,
                                                                               for: indexPath) as? CharacterMoodCollectionReusableView else {
                return UICollectionReusableView()
            }
            return header
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
        
        default:
            return UICollectionReusableView()
        }
        
    }
    
}

extension DiaryWriteFirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 86)
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
            seletedPets[index] = 100
            findSelected()
            
        }
        

    }
    
}

extension DiaryWriteFirstViewController {
    func presentUnselectCustomAlert(index: Int) {
        
        self.customLabelAlertView.setTitle(text: "기분 삭제")
        self.customLabelAlertView.setAttributedDescription(attributedText: (pets[index] + "(이)가 주인공에서 해제됩니다.\n기분을 삭제하시겠어요?").convertSomeColorFont(color: UIColor.macoBlack,
                                               fontSize: 14,
                                               type: .medium,
                                               start: 0,
                                               length: pets[index].count))

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
            self.seletedPets[index] = -1
            self.findSelected()
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
