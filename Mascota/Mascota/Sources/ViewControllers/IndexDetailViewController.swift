//
//  IndexDetailViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/06.
//

import UIKit

import SnapKit
import Then

import Moya

class IndexDetailViewController: BaseViewController {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var indexTitle: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    var tableContents: [IndexModel] = []
    var monthlyDiaries: [MonthlyDiariesModel] = []
    var currentID: String = ""
    
    var isToggled: Bool = false
    var calendarDiaryDetailDelegator: CalendarDiaryDetailDelegator?
    
    let chapterService = MoyaProvider<ChapterAPI>(plugins: [MoyaLoggingPlugin()])
    let diaryService = MoyaProvider<DiaryAPI>(plugins: [MoyaLoggingPlugin()])
    
    lazy var indexStackView: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alpha = 0.0
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.macoLightGray.cgColor
        $0.layer.cornerRadius = 3
    }
    
    lazy var indexDetailTableView: UITableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.allowsSelection = true
        $0.backgroundColor = .clear
        $0.tableHeaderView = nil
        $0.showsVerticalScrollIndicator = false
    }
    
    lazy var navigationBar: UIView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.indexDetailTableView.automaticallyAdjustsScrollIndicatorInsets = false
        layoutComponents()
        layoutStackView()
        registerTableView()
        registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        getChapterMonth(isFirst: true)
    }
    
    @IBOutlet weak var navigationBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarHeightConstraint.constant = (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    private func updateIndexTitle(title: String, index: Int) {
        indexTitle.text = title
        if index > 0 {
            indexLabel.text = "제 \(index)장"
        } else {
            indexLabel.text = "프롤로그"
        }
    }
    
    private func layoutComponents() {
        self.view.addSubview(indexDetailTableView)
        indexDetailTableView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-17)
            $0.bottom.equalToSuperview()
        }
        
        self.view.addSubview(indexStackView)
        
        indexStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.top.equalTo(navigationView.snp.bottom)
            $0.height.equalTo(42 * tableContents.count)
        }

    }

    private func layoutStackView() {
        for (index, chapter) in tableContents.enumerated() {
            let view: UIView = UIView().then {
                $0.backgroundColor = UIColor.macoWhite
            }
            
            let dropDownIndexLabel: UILabel = UILabel().then {
                $0.font = UIFont.macoFont(type: .regular, size: 14)
                $0.textColor = UIColor.macoDarkGray
                $0.textAlignment = .left
                $0.text = index == 0 ? "프롤로그" : "제 \(index)장"
            }
            
            let dropDownIndexTitleLabel: UILabel = UILabel().then {
                $0.font = UIFont.macoFont(type: .regular, size: 16)
                $0.textColor = UIColor.macoBlack
                $0.textAlignment = .left
                $0.text = chapter.chapterTitle
            }
            
            indexStackView.addArrangedSubview(view)
            view.addSubviews(dropDownIndexLabel, dropDownIndexTitleLabel)
            
            view.snp.makeConstraints {
                $0.height.equalTo(42)
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            
            view.tag = index
            view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                             action: #selector(touchDropDownView(_:))))
            dropDownIndexLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.equalTo(55)
                $0.leading.equalToSuperview().offset(21)
            }
            
            dropDownIndexTitleLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(dropDownIndexLabel.snp.trailing).offset(5)
                $0.trailing.equalToSuperview().offset(21)
            }
            
        }
    }
    
    private func deletePetDiary(diaryID: String) {
        self.attachIndicator(.translucent)
        diaryService.request(.deletePetDiary(diaryID: diaryID)) { [weak self] result in
            self?.detachIndicator()
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(GenericModel<IndexDetailModel>.self, from: response.data)
                    self.getChapterMonth()
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func reloadTableView(paramData: GenericModel<IndexDetailModel>) {
        guard let unwrappedPetChapterDiary = paramData.data?.petChapterDiary else {return}
        self.monthlyDiaries = unwrappedPetChapterDiary.monthly
        self.updateIndexTitle(title: unwrappedPetChapterDiary.chapterTitle,
                              index: unwrappedPetChapterDiary.chapter)
        self.indexDetailTableView.reloadData()
    }
    
    private func getChapterMonth(isFirst: Bool = false) {
        if isFirst {
            self.attachIndicator(.normal)
        } else {
            self.attachIndicator(.translucent)
        }
        
        chapterService.request(.getChapterMonth(chapterID: currentID)) { [weak self] result in
            self?.detachIndicator()
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(GenericModel<IndexDetailModel>.self, from: response.data)
                    self?.reloadTableView(paramData: value)
                    
                } catch (let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    

    private func registerTableView() {
        self.indexDetailTableView.delegate = self
        self.indexDetailTableView.dataSource = self
    }
    
    private func registerTableViewCells() {
        self.indexDetailTableView.register(UINib(nibName: AppConstants.TableCells.indexDetailTableViewCell, bundle: nil),
                                           forCellReuseIdentifier: AppConstants.TableCells.indexDetailTableViewCell)
        
        self.indexDetailTableView.register(IndexDetailHeaderView.self,
                                           forHeaderFooterViewReuseIdentifier: AppConstants.TableViewHeaders.indexDetailHeaderView)
    }
    
    @objc
    func touchDropDownView(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        indexStackView.arrangedSubviews[index].backgroundColor = .macoIvory
        displayStackViewAnimation(selected: true, index: index)
        if currentID != tableContents[index].chapterID {
            currentID = tableContents[index].chapterID
            getChapterMonth()
        }
    }
    
    private func displayStackViewAnimation(selected: Bool = false,
                                           index: Int = 0) {
        UIView.animate(withDuration: 0.5) {
            self.indexStackView.arrangedSubviews[index].backgroundColor = .macoWhite
            self.toggleButton.transform = self.isToggled ? CGAffineTransform(rotationAngle: .pi * 2): CGAffineTransform(rotationAngle: .pi)
            self.indexStackView.alpha = self.isToggled ? 0.0 : 1.0
        }
        isToggled.toggle()
    }
    
    @IBAction func touchToggleButton(_ sender: Any) {
        displayStackViewAnimation()
    }
    
    @IBAction func touchBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension IndexDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 18
        }
        else { return 61 }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "수정") {_,_,_ in
            print("edited")
        }.then {
            $0.backgroundColor = UIColor.lightGray
            $0.title = "수정"
            
        }
        
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") {_,_,_ in
            self.deletePetDiary(diaryID: self.monthlyDiaries[indexPath.section].diaries[indexPath.row].diaryID)
        }.then {
            $0.backgroundColor = UIColor.macoOrange
            $0.title = "삭제"
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let unwrappedCell = cell as? IndexDetailTableViewCell else {
            return
        }
        unwrappedCell.petImageView.kf.cancelDownloadTask()
    }
}

extension IndexDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "IndexDetailHeaderView") as? IndexDetailHeaderView else {
            return nil
        }
        header.initializeValues(month: "\(monthlyDiaries[section].month)",
                                total: "\(monthlyDiaries[section].episodePerMonthCount)")
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return monthlyDiaries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyDiaries[section].diaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.indexDetailTableViewCell,
                                                       for: indexPath) as? IndexDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.initializeData(data: monthlyDiaries[indexPath.section].diaries[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diaryId = monthlyDiaries[indexPath.section].diaries[indexPath.item].diaryID

        let vc = CalendarDiaryDetailViewController()
        self.calendarDiaryDetailDelegator = vc
        calendarDiaryDetailDelegator?.sendingDiariesId(id: [diaryId])
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
