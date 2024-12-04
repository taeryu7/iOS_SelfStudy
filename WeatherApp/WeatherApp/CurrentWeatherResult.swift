//
//  Untitled.swift
//  WeatherApp
//
//  Created by 유태호 on 12/4/24.
//

import Foundation

// 현재 날씨 데이터를 담기 위한 모델 구조체
struct CurrentWeatherResult: Codable {
    // 날씨 정보를 담는 배열 (구름, 비, 맑음 등의 날씨 상태)
    let weather: [Weather]
    // 온도, 습도 등 주요 날씨 수치 데이터
    let main: WeatherMain
}

// 날씨 상태 정보를 담는 구조체
struct Weather: Codable {
    // 날씨 상태 ID (OpenWeather API에서 제공하는 고유 ID)
    let id: Int
    // 날씨 메인 카테고리 (Ex: Rain, Clear, Clouds 등)
    let main: String
    // 날씨 상태 상세 설명
    let description: String
    // 날씨 아이콘 코드 (날씨에 맞는 아이콘을 표시하기 위한 코드)
    let icon: String
}

// 날씨의 수치적 데이터를 담는 구조체
struct WeatherMain: Codable {
    // 현재 온도
    let temp: Double
    // 최저 온도
    let temp_min: Double
    // 최고 온도
    let temp_max: Double
    // 습도 (%)
    let humidity: Int
}
