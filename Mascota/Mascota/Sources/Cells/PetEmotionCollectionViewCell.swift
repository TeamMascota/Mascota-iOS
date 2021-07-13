//
//  PetEmotionCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/11.
//

import UIKit

import SnapKit
import Then

protocol PetEmotionCollectionViewCellProtocol {
    func selectEmotion(section: Int, item: Int)
}

class PetEmotionCollectionViewCell: UICollectionViewCell {
    
    var selectedCell: Int = -100
    var petEmotionCollectionViewCellProtocol: PetEmotionCollectionViewCellProtocol?
    
    let topSepartor: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoLightGray
    }
    
    let bottomSepartor: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoLightGray
    }
    
    let titleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .medium, size: 17)
        $0.textColor = UIColor.macoDarkGray
        $0.textAlignment = .left
        $0.text = ""
    }
    
    let deleteButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "icDelete"), for: .normal)
        $0.tintColor = UIColor.macoOrange
    }
    
    let emotionCollectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                                     collectionViewLayout: UICollectionViewFlowLayout().then {
                                                                        $0.scrollDirection = .horizontal
                                                                     }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = UIColor.macoIvory
        $0.allowsSelection = true
                                                                    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectedCell = 100
        titleLabel.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutComponents()
        registerCollectionView()
        registerCollectionViewCell()
    }
    
    private func registerCollectionView() {
        self.emotionCollectionView.delegate = self
        self.emotionCollectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
        self.emotionCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.petsCollectionViewCell,
                                                  bundle: nil),
                                            forCellWithReuseIdentifier: AppConstants.CollectionViewCells.petsCollectionViewCell)
    }
    
    func updateTitle(text: String) {
        print(text)
        titleLabel.text = text
        print(selectedCell)
    }
    
    func updateSelectedCell(selcted: Int) {
        selectedCell = selcted
        self.emotionCollectionView.reloadData()
    }

    private func layoutComponents() {
        self.contentView.addSubviews(topSepartor,
                                     titleLabel,
                                     deleteButton,
                                     emotionCollectionView,
                                     bottomSepartor)
        
        topSepartor.snp.makeConstraints{
            $0.top.equalTo(self.contentView.snp.top)
            $0.leading.equalTo(self.contentView.snp.leading)
            $0.trailing.equalTo(self.contentView.snp.trailing)
            $0.height.equalTo(0.8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.contentView.snp.leading).inset(12)
            $0.top.equalTo(self.topSepartor.snp.bottom).offset(12)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalTo(self.contentView.snp.trailing).inset(5)
//            $0.top.equalTo(self.topSepartor.snp.bottom).offset(7)
            $0.height.equalTo(25)
            $0.width.equalTo(41)
            
        }
        
//        bottomSepartor.snp.makeConstraints {
//            $0.leading.equalTo(self.contentView.snp.leading)
//            $0.trailing.equalTo(self.contentView.snp.trailing)
//            $0.bottom.equalTo(self.contentView.snp.bottom)
//            $0.height.equalTo(0.8)
//        }
        emotionCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.contentView.snp.leading).inset(12)
            $0.trailing.equalTo(self.contentView.snp.trailing).inset(11)
            $0.height.equalTo(70)
        }
        
        bottomSepartor.snp.makeConstraints {
            $0.leading.equalTo(self.contentView.snp.leading)
            $0.trailing.equalTo(self.contentView.snp.trailing)
            $0.top.equalTo(emotionCollectionView.snp.bottom).offset(15)
            $0.height.equalTo(0.8)
        }
    }

}

extension PetEmotionCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/6,
                      height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        petEmotionCollectionViewCellProtocol?.selectEmotion(section: self.tag, item: indexPath.item)
    }
    
}

extension PetEmotionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.petsCollectionViewCell, for: indexPath) as? PetsCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.item == selectedCell {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath,
                                      animated: true,
                                      scrollPosition: .init())
        }
        return cell
    }
}
