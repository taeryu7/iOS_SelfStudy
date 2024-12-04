//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by 유태호 on 12/4/24.
//

import UIKit

// 테이블뷰의 각 셀을 구성하는 커스텀 셀 클래스
final class TableViewCell: UITableViewCell {
    
    // 셀 재사용을 위한 식별자
    static let id = "TableViewCell"
    
    // 날짜와 시간을 표시할 레이블
    private let dtTxtlabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    // 온도를 표시할 레이블
    private let templabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    // 코드로 셀을 초기화할 때 사용되는 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    // UI 구성 요소들의 레이아웃을 설정하는 메서드
    private func configureUI() {
        // 셀의 배경색 설정
        contentView.backgroundColor = .black
        
        // 레이블들을 contentView에 추가
        [
            dtTxtlabel,
            templabel
        ].forEach { contentView.addSubview($0) }
        
        // 날짜/시간 레이블의 제약조건 설정
        dtTxtlabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)  // 왼쪽 여백 20
            $0.centerY.equalToSuperview()            // 세로 중앙 정렬
        }
        
        // 온도 레이블의 제약조건 설정
        templabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20) // 오른쪽 여백 20
            $0.centerY.equalToSuperview()            // 세로 중앙 정렬
        }
    }
    
    // 셀에 데이터를 설정하는 public 메서드
    public func configureCell(forecastWeather: ForecastWeather) {
        dtTxtlabel.text = forecastWeather.dtTxt         // 날짜/시간 텍스트 설정
        templabel.text = "\(forecastWeather.main.temp)°C" // 온도 텍스트 설정
    }
    
    // 스토리보드로 셀을 초기화할 때 사용되는 초기화 메서드
    // 여기서는 스토리보드를 사용하지 않으므로 fatalError로 처리
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/**
 // SwiftUI 프리뷰를 위한 설정
 // 테스트를 위한 프리뷰. 임의의 데이터값을 넣어서 툴력확인
 #Preview {
     let cell = TableViewCell(style: .default, reuseIdentifier: "TableViewCell")
     // 테스트용 더미 데이터 생성
     let weatherMain = WeatherMain(temp: 25.5, temp_min: 20.0, temp_max: 30.0, humidity: 60)
     let forecastWeather = ForecastWeather(main: weatherMain, dtTxt: "2024-12-04 15:00:00")
     cell.configureCell(forecastWeather: forecastWeather)
     return cell
 }
 */
