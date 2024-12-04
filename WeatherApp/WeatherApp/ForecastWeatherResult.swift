//
//  ForecastWeatherResult.swift
//  WeatherApp
//
//  Created by 유태호 on 12/4/24.
//

import Foundation

// 날씨 예보 데이터를 담기 위한 모델 구조체
struct ForecastWeatherResult: Codable {
    // 시간별 날씨 예보 데이터 배열
    let list: [ForecastWeather]
}

// 각 시간대별 예보 데이터를 담는 구조체
struct ForecastWeather: Codable {
    // 해당 시간의 온도, 습도 등 날씨 정보
    let main: WeatherMain
    // 예보 날짜와 시간 (형식: "YYYY-MM-DD HH:mm:ss")
    let dtTxt: String
    
    // JSON 디코딩을 위한 CodingKeys 열거형
    // API에서 받는 'dt_txt' 키를 Swift의 'dtTxt' 변수명으로 매핑
    enum CodingKeys: String, CodingKey {
        case main
        case dtTxt = "dt_txt"
    }
}
