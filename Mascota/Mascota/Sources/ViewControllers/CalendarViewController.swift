//
//  CalendarViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/13.
//

import UIKit

import FSCalendar
import SnapKit
import Then

class CalendarViewController: UIViewController {
    private lazy var nameLabel = UILabel().then {
        $0.font = .macoFont(type: .bold, size: 20)
        $0.textColor = .macoOrange
        $0.text = "김윤서김윤서"
    }
    
    private lazy var topLabel = UILabel().then {
        $0.font = .macoFont(type: .bold, size: 20)
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
        setCalender()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setCalender() {
        
        view.addSubviews(calender, headerLabel, monthWeekSeparatorView, weekDateSeparatorView, nameLabel, topLabel, buttonStackView, writeImageView, writeLabel, writeButton)
        
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
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        topLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing)
            $0.centerY.equalTo(nameLabel.snp.centerY)
        }
        
        writeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(topLabel.snp.bottom).inset(-19)
            $0.width.equalTo(48)
            $0.height.equalTo(44)
        }
        
        writeLabel.snp.makeConstraints {
            $0.leading.equalTo(writeImageView.snp.trailing).inset(-13)
            $0.top.equalTo(topLabel.snp.bottom).inset(-13)
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
        switch sender {
        case pastMonthButton:
            guard let pastMonth = Calendar.current.date(byAdding: .month, value: -1, to: self.calender.currentPage) else { return }
            self.calender.setCurrentPage(pastMonth, animated: true)
        case pastYearButton:
            guard let pastYear = Calendar.current.date(byAdding: .year, value: -1, to: self.calender.currentPage) else { return }
            self.calender.setCurrentPage(pastYear, animated: true)
        case nextMonthButton:
            guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self.calender.currentPage) else { return }
        
            self.calender.setCurrentPage(nextMonth, animated: true)
        case nextYearButton:
            guard let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: self.calender.currentPage) else { return }
            
            self.calender.setCurrentPage(nextYear, animated: true)
        default:
            break
        }
    }
    
    @objc
    func tapWriteButton(_ sender: UIButton) {
        navigationController?.pushViewController(DiaryWriteFirstViewController(), animated: true)
    }
}

extension CalendarViewController: FSCalendarDelegate {
    //Date 선택시 알려주는 메서드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("didSelect            \(String(describing: self.dateFormatter.string(for: date)))")
      
        //Date를 클릭시 이전달이거나 다음달이면 해당 달로 이동
       if monthPosition == .previous || monthPosition == .next {
           calendar.setCurrentPage(date, animated: true)
       }else{
        navigationController?.pushViewController(HomeDiaryDetailViewController(), animated: true)
       }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("페이지 변경")
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: calendar.currentPage)
        guard let year = values.year else { return }
        guard let month = values.month else { return }
        
        headerLabel.text = "\(year)년 \(month)월"
        
    }
    
}

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: MacoCalendarCell.identifier, for: date, at: position)
       
            return cell
        }
   
}
