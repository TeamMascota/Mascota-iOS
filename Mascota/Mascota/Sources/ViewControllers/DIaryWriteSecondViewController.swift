//
//  DIaryWriteSecondViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/12.
//

import UIKit

class DiaryWriteSecondViewController: UIViewController {
    @IBOutlet weak var scrollViewBackgroundView: UIView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var indexToggleButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var journalTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        registerCollectionView()
//        registerCollectionViewCell()
        
    }
    
    private func registerCollectionViewCell() {
        self.imageCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.plusCollectionViewCell,
                                                bundle: nil),
                                          forCellWithReuseIdentifier: AppConstants.CollectionViewCells.plusCollectionViewCell)
    }
    
    private func registerCollectionView() {
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
    }


}

extension DiaryWriteSecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


extension DiaryWriteSecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.plusCollectionViewCell,
                                                            for: indexPath) as? PlusCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.macoBlack.cgColor
        return cell
    }
    
    
}
