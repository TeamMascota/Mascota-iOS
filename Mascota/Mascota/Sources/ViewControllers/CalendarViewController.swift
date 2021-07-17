//
//  CalendarViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/13.
//

import UIKit

import FSCalendar
import Moya
import SnapKit
import Then

class CalendarViewController: BaseViewController {
    
    private lazy var service = MoyaProvider<CalendarAPI>(plugins: [MoyaLoggingPlugin()])
    private var currentCalendar: GetCalendarModel?
    private lazy var part: Int = 1
    private lazy var i = 0
    
    private var delegate: CalendarDiaryDetailDelegator?
    
    private lazy var topBar = UIView()
    
    private lazy var nameLabel = UILabel().then {
        $0.font = .macoFont(type: .bold, size: 20)
        $0.textColor = .macoOrange
    }
    
    private lazy var topLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 20)
        $0.textColor = .macoBlack
        $0.text = "의 지나온 날들"
    }
    
    private lazy var writeLabel = UILabel().then {
        $0.text = "이야기 기록하기"
        $0.font = .macoFont(type: .regular, size: 14)
        $0.textColor = .macoDarkGray
    }
    
    private lazy var writeImageView = UIImageView().then {
        $0.image = UIImage(named: "icWriting")
    }
    
    private lazy var writeButton = UIButton().then {
        $0.layer.masksToBounds = true
        $0.backgroundColor = .macoWhite
        
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = Constant.round3
        
        let underLine = UIView().then {
            $0.backgroundColor = .macoOrange
        }
        
        $0.addSubview(underLine)
        
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        let label = UILabel().then {
            $0.font = .macoFont(type: .regular, size: 12)
            $0.textColor = .macoLightGray
            $0.text = "오늘은 주인공과 함께 어떤 하루를 보냈나요?"
        }
        
        $0.addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(9)
            $0.centerY.equalToSuperview()
        }
        
        $0.addTarget(self, action: #selector(tapWriteButton), for: .touchUpInside)
    }
    
    private lazy var calender = FSCalendar().then {
        $0.appearance.weekdayTextColor = .macoDarkGray
        $0.appearance.headerTitleColor = .macoDarkGray
        $0.appearance.eventDefaultColor = .macoDarkGray
        $0.appearance.selectionColor = .clear
        $0.appearance.titleSelectionColor = .macoDarkGray
        $0.appearance.todayColor = .clear
        $0.appearance.todaySelectionColor = .clear
        $0.appearance.titleTodayColor = .macoDarkGray
        $0.appearance.titleDefaultColor = .macoDarkGray
        
        $0.headerHeight = 50
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.appearance.headerTitleColor = .black
        $0.appearance.headerTitleFont = .systemFont(ofSize: 24)
        $0.appearance.headerSeparatorColor = .red
        
        $0.locale = Locale(identifier: "ko_KR")
        $0.weekdayHeight = 30
        $0.rowHeight = 75
        $0.appearance.separators = .interRows
        $0.scrollEnabled = false
        
    }
    
    private lazy var dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    private lazy var headerLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 18)
        $0.textAlignment = .left
        
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calender.currentPage)
        guard let year = values.year else { return }
        guard let month = values.month else { return }
        
        $0.text = "\(year)년 \(month)월"
        
        print(dateFormatter.string(from: self.calender.currentPage))
        
    }
    
    private lazy var monthWeekSeparatorView = UIView().then {
        $0.backgroundColor = .macoGray
    }
    
    private lazy var weekDateSeparatorView = UIView().then {
        $0.backgroundColor = .macoLightGray
    }
    
    private lazy var pastMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "icBackSmall"), for: .normal)
        $0.addTarget(self, action: #selector(tapMoveDateButton(_:)), for: .touchUpInside)
    }
    
    private lazy var nextMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "icNextSmall"), for: .normal)
        $0.addTarget(self, action: #selector(tapMoveDateButton(_:)), for: .touchUpInside)
    }
    
    private lazy var pastYearButton = UIButton().then {
        $0.setImage(UIImage(named: "icNextX2Back"), for: .normal)
        $0.addTarget(self, action: #selector(tapMoveDateButton(_:)), for: .touchUpInside)
    }
    
    private lazy var nextYearButton = UIButton().then {
        $0.setImage(UIImage(named: "icNextX2Small"), for: .normal)
        $0.addTarget(self, action: #selector(tapMoveDateButton(_:)), for: .touchUpInside)
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertGetCalender(date: Date())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        layoutCalender()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func convertGetCalender(date: Date) {
        i = 0
        let year = String(Calendar.current.component(.year, from: date))
        let month = String(Calendar.current.component(.month, from: date))
        let part = String(part)

        getCalendar(year: year, month: month, part: part)
    }
    
    func layoutCalender() {
        
        view.addSubviews(topBar, calender, headerLabel, monthWeekSeparatorView, weekDateSeparatorView, buttonStackView, writeImageView, writeLabel, writeButton)
        
        calender.delegate = self
        calender.dataSource = self
        
        calender.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        calender.register(MacoCalendarCell.self, forCellReuseIdentifier: MacoCalendarCell.identifier)

        calender.calendarHeaderView.isHidden = true
        
        view.addSubviews(nameLabel, topLabel)
        
        topBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(topBarHeight)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalTo(topBar)
        }
        
        topLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing)
            $0.centerY.equalTo(topBar)
        }

        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(calender.calendarWeekdayView.snp.top).offset(-8)
        }
        
        monthWeekSeparatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(calender.calendarWeekdayView.snp.top)
        }
        
        weekDateSeparatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(calender.collectionView.snp.top).inset(2)
        }
        
        writeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(topBar.snp.bottom).inset(-19)
            $0.width.equalTo(48)
            $0.height.equalTo(44)
        }
        
        writeLabel.snp.makeConstraints {
            $0.leading.equalTo(writeImageView.snp.trailing).inset(-13)
            $0.top.equalTo(topBar.snp.bottom).inset(-13)
        }
        
        writeButton.snp.makeConstraints {
            $0.leading.equalTo(writeImageView.snp.trailing).inset(-13)
            $0.top.equalTo(writeLabel.snp.bottom).inset(-7)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        buttonStackView.addArrangedSubviews(pastYearButton, pastMonthButton, nextMonthButton, nextYearButton)
        
        buttonStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(headerLabel.snp.centerY)
        }
    }
    
    @objc
    func tapMoveDateButton(_ sender: UIButton) {
        var moveDate: Date?
        
        switch sender {
        case pastMonthButton:
            moveDate = Calendar.current.date(byAdding: .month, value: -1, to: self.calender.currentPage)
        case pastYearButton:
            moveDate = Calendar.current.date(byAdding: .year, value: -1, to: self.calender.currentPage)
        case nextMonthButton:
           moveDate = Calendar.current.date(byAdding: .month, value: 1, to: self.calender.currentPage)
        case nextYearButton:
           moveDate = Calendar.current.date(byAdding: .year, value: 1, to: self.calender.currentPage)
        default:
            break
        }
        
        if let moveDate = moveDate {
            self.calender.setCurrentPage(moveDate, animated: true)
        }
    }
    
    @objc
    func tapWriteButton(_ sender: UIButton) {
        let diaryStoryboard = UIStoryboard(name: AppConstants.Storyboard.diaryWriteFirst, bundle: nil)
        guard let diaryWriteFirstViewController = diaryStoryboard.instantiateViewController(identifier: AppConstants.ViewController.diaryWriteFirst) as? DiaryWriteFirstViewController else {
            return
        }
        
        navigationController?.pushViewController(diaryWriteFirstViewController, animated: true)
    }
}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
      
       if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
       } else {
            if let currentCalendar = currentCalendar?.calendar {
                let day = Int(Calendar.current.component(.day, from: date))
                if let date = currentCalendar.date[day - 1] {
                    if date.id.count > 0 {
                        let calendarDiaryDetailViewController = CalendarDiaryDetailViewController()
                        self.delegate = calendarDiaryDetailViewController
                        self.delegate?.sendingDiariesId(id: date.id)
                        navigationController?.pushViewController(calendarDiaryDetailViewController, animated: true)
                    }
                }
            }
       }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.convertGetCalender(date: calendar.currentPage)
    }
    
}

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(withIdentifier: MacoCalendarCell.identifier, for: date, at: position) as? MacoCalendarCell else { return FSCalendarCell() }

        let nowMonth = String(Calendar.current.component(.month, from: Date()))
        let month = String(Calendar.current.component(.month, from: date))
        let nowDay = Int(Calendar.current.component(.day, from: Date()))
        let nowDate = Date()
        let nowYear = String(Calendar.current.component(.year, from: Date()))
        
        cell.setNumberLabel(count: -1)
        
        if date <= nowDate {
            if let currentCalendar = currentCalendar?.calendar {
                if month == currentCalendar.month {
                    if nowMonth == month && nowYear == currentCalendar.year {
                        if i < nowDay {
                            if let date = currentCalendar.date[i] {
                                cell.setNumberLabel(count: date.id.count)
                                cell.setEmoji(kind: date.kind, feeling: date.feeling)
                            } else {
                                cell.setNumberLabel(count: 0)
                            }
                        }
                    } else {
                        if let date = currentCalendar.date[i] {
                            cell.setNumberLabel(count: date.id.count)
                            cell.setEmoji(kind: date.kind, feeling: date.feeling)
                        } else {
                            cell.setNumberLabel(count: 0)
                        }
                    }
                    i += 1
                }
            } else {
                cell.setNumberLabel(count: -1)
            }
        }
        return cell
    }
   
}

extension CalendarViewController {
    private func getCalendar(year: String, month: String, part: String) {
        self.attachIndicator(.normal)
        service.request(CalendarAPI.getCalendar(year: year, month: month, part: part)) { [weak self] result in
            self?.detachIndicator()
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(GenericModel<GetCalendarModel>.self, from: response.data)
                    self.currentCalendar = data.data
                    self.setCalendar()
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    private func setCalendar() {
        guard let year = currentCalendar?.calendar.year else { return }
        guard let month = currentCalendar?.calendar.month else { return }
        headerLabel.text = "\(year)년 \(month)월"
        
        guard let name = currentCalendar?.name else { return }
        nameLabel.text = name
        
        i = 0
        calender.reloadData()
    }
}
