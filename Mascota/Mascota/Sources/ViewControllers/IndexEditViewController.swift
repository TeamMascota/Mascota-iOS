//
//  IndexEditViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/06.
//

import UIKit

import SnapKit
import Then

class IndexEditViewController: UIViewController {

    @IBOutlet weak var separatorView: UIView!
    
    var cellCnt = 40
    
    lazy var indexCollectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                                      collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.macoIvory
    }
    
    lazy var tempView: UIView = UIView().then {
        $0.backgroundColor = UIColor.black
    }
    
    var confirmHandler: ((UIAlertAction) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        layoutComponents()
        registerCollectionView()
        registerCollectionViewCell()
        confirmHandler = { _ in
            self.dismiss(animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    private func registerCollectionView() {
        indexCollectionView.delegate = self
        indexCollectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
//        self.indexCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.IndexCollectionViewCell, bundle: nil),
//                                              forCellWithReuseIdentifier: AppConstants.CollectionViewCells.IndexCollectionViewCell)
        self.indexCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.indexEditCollectionViewCell,
                                                bundle: nil), forCellWithReuseIdentifier: AppConstants.CollectionViewCells.indexEditCollectionViewCell)
        self.indexCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.indexEditPrologueCollectionViewCell,
                                                bundle: nil), forCellWithReuseIdentifier: AppConstants.CollectionViewCells.indexEditPrologueCollectionViewCell)
        self.indexCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.mascotaPeopleImageCell,
                                                bundle: nil),
                                          forCellWithReuseIdentifier: AppConstants.CollectionViewCells.mascotaPeopleImageCell)
    }
    
    private func layoutComponents() {
        self.view.addSubview(indexCollectionView)
        
        indexCollectionView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc
    func touchDeleteButton(_ sender: UIButton) {
        print(sender.tag)
    }
    
    @objc
    func touchChangeButton(_ sender: UIButton) {
        print(sender.tag)
    }
    

    @IBAction func touchBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchPlusButton(_ sender: Any) {
        self.presentSingleCustomAlert(view: tempView,
                                      preferredSize: CGSize(width: 1000, height: 100), confirmHandler: confirmHandler)
        print("touchPlusButton")
    }

}

extension IndexEditViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return cellCnt
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.indexEditPrologueCollectionViewCell,
                                                                    for: indexPath) as? IndexEditPrologueCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.intializeData(indexPath.item)
                cell.changeButton.addTarget(self,
                                            action: #selector(touchChangeButton(_:)),
                                            for: .touchUpInside)
                cell.deleteButton.addTarget(self,
                                            action: #selector(touchDeleteButton(_:)),
                                            for: .touchUpInside)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.indexEditCollectionViewCell,
                                                                    for: indexPath) as? IndexEditCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.intializeData(indexPath.item)
                cell.changeButton.addTarget(self,
                                            action: #selector(touchChangeButton(_:)),
                                            for: .touchUpInside)
                cell.deleteButton.addTarget(self,
                                            action: #selector(touchDeleteButton(_:)),
                                            for: .touchUpInside)
                return cell
            }
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.mascotaPeopleImageCell, for: indexPath) as? MascotaPeopleImageCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
    }
    
    
}

extension IndexEditViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 41)
        default:
            let cellsHeight = CGFloat(41*cellCnt)
            let freeSpace = collectionView.bounds.height - cellsHeight
            let height = freeSpace > 142 ? freeSpace: 142
            return CGSize(width: collectionView.bounds.width,
                          height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
