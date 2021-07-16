//
//  CharacterCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/10.
//

import UIKit

protocol CharacterCollectionViewCellProtocol {
    func seletedCell(index: Int)
}

class CharacterCollectionViewCell: UICollectionViewCell {
    
    var pets: [PetImageModel] = []
    var selectedCell: [Int] = []
    var characterCollectionViewCellProtocol: CharacterCollectionViewCellProtocol?
    
    let characterCollectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                                     collectionViewLayout: UICollectionViewFlowLayout().then {
                                                                        $0.scrollDirection = .horizontal
                                                                     }).then {
        
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = UIColor.macoIvory
        $0.allowsMultipleSelection = true
        $0.allowsSelection = false
                                                                    
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutComponents()
        registerCollectionView()
        registerCollectionViewCell()
    }
    
    func updateVariable(pets: [PetImageModel], selectedCell: [Int], first: Bool = false) {
        self.pets = pets
        self.selectedCell = selectedCell
        print(self.selectedCell)
        self.characterCollectionView.reloadData()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func layoutComponents() {
        self.contentView.addSubview(characterCollectionView)

        characterCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    private func registerCollectionView() {
        self.characterCollectionView.delegate = self
        self.characterCollectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
        self.characterCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.registerMyPetCollectionViewCell, bundle: nil),
                                              forCellWithReuseIdentifier: AppConstants.CollectionViewCells.registerMyPetCollectionViewCell)
        
    }
    @objc
    func touchCell(sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {
            return
        }
        characterCollectionViewCellProtocol?.seletedCell(index: tag)
    }
}

extension CharacterCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 132)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

extension CharacterCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.registerMyPetCollectionViewCell, for: indexPath) as? RegisterMyPetCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.characterNumberLabel.text = pets[indexPath.item].name
        cell.myPetImage.updateServerImage(pets[indexPath.item].img)
        cell.tag = indexPath.item
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchCell)))
        
        if selectedCell[indexPath.item] > 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath,
                                      animated: false,
                                      scrollPosition: .init())
        } else {
            cell.isSelected = false
        }
        
        return cell
    }
    
}
