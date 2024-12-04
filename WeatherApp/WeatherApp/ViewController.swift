//
//  ViewController.swift
//  WeatherApp
//
//  Created by 유태호 on 12/4/24.
//

// UIKit 프레임워크 임포트 - iOS 앱의 UI 구성요소들을 사용하기 위해 필요
import UIKit
// SnapKit 프레임워크 임포트 - Auto Layout을 코드로 쉽게 구현하기 위한 라이브러리
import SnapKit

// 메인 뷰 컨트롤러 클래스 정의
// UIViewController를 상속받아 화면의 생명주기와 뷰 계층을 관리
class ViewController: UIViewController {
    
    // MARK: - Properties (속성 정의)
    /// 테이블 뷰에 표시할 날씨 예보 데이터를 저장하는 배열
    /// private으로 선언하여 외부 접근을 제한하고 캡슐화
    private var dataSource = [ForecastWeather]()
    
    /// OpenWeather API 호출에 필요한 URL 쿼리 파라미터들
    /// let으로 선언하여 상수로 만들고, private으로 외부 접근 제한
    private let urlQueryItems: [URLQueryItem] = [
        URLQueryItem(name: "lat", value: "37.5"),      // 위도 (서울역 기준)
        URLQueryItem(name: "lon", value: "126.9"),     // 경도 (서울역 기준)
        URLQueryItem(name: "appid", value: "3d1be1b2d3419223212333eb2388ba4a"), // OpenWeather API 인증 키
        URLQueryItem(name: "units", value: "metric")   // 온도 단위를 섭씨로 설정
    ]
    
    // MARK: - UI Components (UI 컴포넌트 정의)
    /// 도시 이름을 표시하는 레이블
    /// 클로저를 사용한 프로퍼티 초기화 - 컴포넌트 생성과 설정을 한 번에 처리
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시"           // 레이블에 표시할 텍스트 설정
        label.textColor = .white          // 텍스트 색상을 흰색으로 설정
        label.font = .boldSystemFont(ofSize: 30)  // 굵은 시스템 폰트, 크기 30으로 설정
        return label
    }()
    
    /// 현재 온도를 표시하는 레이블
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white          // 텍스트 색상 흰색
        label.font = .boldSystemFont(ofSize: 50)  // 굵은 폰트, 크기 50
        return label
    }()
    
    /// 최저 온도를 표시하는 레이블
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    /// 최고 온도를 표시하는 레이블
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    /// 최저/최고 온도 레이블을 담는 수평 스택 뷰
    private let tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal           // 스택 뷰 내부 요소들을 수평으로 배치
        stackView.spacing = 20                 // 요소들 사이의 간격을 20포인트로 설정
        stackView.distribution = .fillEqually  // 요소들이 동일한 크기를 가지도록 설정
        return stackView
    }()
    
    /// 날씨 아이콘을 표시할 이미지 뷰
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit  // 이미지의 비율을 유지하면서 뷰에 맞게 크기 조정
        imageView.backgroundColor = .black       // 배경색 검정으로 설정
        return imageView
    }()
    
    /// 날씨 예보 목록을 표시할 테이블 뷰
    /// lazy var로 선언하여 실제 사용될 때 초기화되도록 설정 (메모리 효율화)
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        // 테이블 뷰의 delegate와 dataSource를 self(현재 뷰 컨트롤러)로 설정
        // delegate: 테이블 뷰의 동작과 외관을 관리
        tableView.delegate = self
        // dataSource: 테이블 뷰에 표시할 데이터를 관리
        tableView.dataSource = self
        // 테이블 뷰에서 사용할 커스텀 셀 클래스를 등록
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        return tableView
    }()
    
    // MARK: - Lifecycle Methods (생명주기 메서드)
    /// 뷰가 메모리에 로드된 직후 호출되는 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentWeatherData()  // 현재 날씨 데이터 요청
        fetchForecastData()        // 날씨 예보 데이터 요청
        configureUI()              // UI 구성 요소들의 레이아웃 설정
    }
    
    // MARK: - Network Methods (네트워크 메서드)
    /// 제네릭을 사용한 네트워크 데이터 요청 메서드
    /// - Parameters:
    ///   - url: API 요청을 보낼 URL
    ///   - completion: 데이터 요청 완료 후 실행될 완료 핸들러
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        // 기본 설정의 URLSession 인스턴스 생성
        let session = URLSession(configuration: .default)
        
        // URL 요청을 시작하고 완료 핸들러 설정
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            // 데이터가 존재하고 에러가 없는지 확인
            guard let data = data, error == nil else {
                print("데이터 로드 실패")
                completion(nil)
                return
            }
            
            // HTTP 응답 상태 코드가 성공 범위(200-299)인지 확인
            let successRange = 200..<300
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                // JSON 데이터를 지정된 타입으로 디코딩
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    print("JSON 디코딩 실패")
                    completion(nil)
                    return
                }
                completion(decodedData)
            } else {
                print("응답 오류")
                completion(nil)
            }
        }.resume()  // 데이터 태스크 시작
    }
    
    /// 현재 날씨 데이터를 가져오는 메서드
    private func fetchCurrentWeatherData() {
        // URL 컴포넌트 생성 및 쿼리 아이템 설정
        var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        urlComponents?.queryItems = self.urlQueryItems
        
        // URL이 유효한지 확인
        guard let url = urlComponents?.url else {
            print("잘못된 URL")
            return
        }
        
        // 현재 날씨 데이터 요청
        fetchData(url: url) { [weak self] (result: CurrentWeatherResult?) in
            // self와 result가 모두 존재하는지 확인 (메모리 누수 방지)
            guard let self, let result else { return }
            
            // UI 업데이트는 반드시 메인 쓰레드에서 실행
            DispatchQueue.main.async {
                // 온도 레이블들 업데이트
                self.tempLabel.text = "\(Int(result.main.temp))°C"
                self.tempMinLabel.text = "최소: \(Int(result.main.temp_min))°C"
                self.tempMaxLabel.text = "최고: \(Int(result.main.temp_max))°C"
            }
            
            // 날씨 아이콘 URL 생성
            guard let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(result.weather[0].icon)@2x.png") else { return }
    
            // 이미지 다운로드 (백그라운드 작업)
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    // 이미지 설정은 UI 작업이므로 메인 쓰레드에서 실행
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }

    /// 5일 날씨 예보 데이터를 가져오는 메서드
    private func fetchForecastData() {
        // URL 컴포넌트 생성 및 쿼리 아이템 설정
        var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast")
        urlComponents?.queryItems = self.urlQueryItems
        
        // URL이 유효한지 확인
        guard let url = urlComponents?.url else {
            print("잘못된 URL")
            return
        }
        
        // 날씨 예보 데이터 요청
        fetchData(url: url) { [weak self] (result: ForecastWeatherResult?) in
            guard let self, let result else { return }
            
            // 디버깅용 데이터 출력
            for forecastWeather in result.list {
                print("\(forecastWeather.main)\n\(forecastWeather.dtTxt)\n\n")
            }
            
            // 테이블 뷰 데이터 업데이트 (메인 쓰레드에서 실행)
            DispatchQueue.main.async {
                self.dataSource = result.list
                self.tableView.reloadData()  // 테이블 뷰 갱신
            }
        }
    }
    
    // MARK: - UI Configuration (UI 구성)
    /// UI 레이아웃을 설정하는 메서드
    private func configureUI() {
        // 뷰 배경색 설정
        view.backgroundColor = .black
        
        // 메인 뷰에 UI 컴포넌트들 추가
        [
            titleLabel,
            tempLabel,
            tempStackView,
            imageView,
            tableView
        ].forEach { view.addSubview($0) }  // 각 컴포넌트를 뷰 계층에 추가
        
        // 스택 뷰에 온도 레이블들 추가
        [
            tempMinLabel,
            tempMaxLabel
        ].forEach { tempStackView.addArrangedSubview($0) }  // 스택 뷰에 하위 뷰로 추가
        
        // SnapKit을 사용한 Auto Layout 제약조건 설정
        
        // 도시 이름 레이블 제약조건
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()  // 수평 중앙 정렬
            $0.top.equalToSuperview().offset(120)  // 상단 여백 120
        }
        
        // 현재 온도 레이블 제약조건
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()  // 수평 중앙 정렬
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)  // 도시 이름 레이블 아래 10포인트
        }
        
        // 온도 스택 뷰 제약조건
        tempStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()  // 수평 중앙 정렬
            $0.top.equalTo(tempLabel.snp.bottom).offset(10)  // 현재 온도 레이블 아래 10포인트
        }
        
        // 날씨 아이콘 이미지 뷰 제약조건
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()  // 수평 중앙 정렬
            $0.width.height.equalTo(160)   // 너비와 높이를 160으로 설정
            $0.top.equalTo(tempStackView.snp.bottom).offset(20)  // 스택 뷰 아래 20포인트
        }
        
        // 테이블 뷰 제약조건
        tableView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)  // 이미지 뷰 아래 30포인트
            $0.leading.trailing.equalToSuperview().inset(20)  // 좌우 여백 20
            $0.bottom.equalToSuperview().inset(50)  // 하단 여백 50
        }
    }
}

// MARK: - UITableViewDelegate Extension (계속)
extension ViewController: UITableViewDelegate {
    /// 테이블 뷰 셀의 높이를 설정하는 메서드
    /// - Parameters:
    ///   - tableView: 높이를 설정할 테이블 뷰
    ///   - indexPath: 해당 셀의 위치
    /// - Returns: 셀의 높이 (CGFloat)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40  // 모든 셀의 높이를 40포인트로 고정
    }
}

// MARK: - UITableViewDataSource Extension
extension ViewController: UITableViewDataSource {
    /// 테이블 뷰의 각 셀을 구성하는 메서드
    /// - Parameters:
    ///   - tableView: 셀을 요청하는 테이블 뷰
    ///   - indexPath: 요청하는 셀의 위치
    /// - Returns: 구성된 UITableViewCell 인스턴스
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용 가능한 셀을 큐에서 가져오고 TableViewCell로 타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.id  // 셀 식별자로 재사용 셀 찾기
        ) as? TableViewCell else {
            // 셀 생성/캐스팅 실패 시 기본 UITableViewCell 반환
            return UITableViewCell()
        }
        
        // 데이터 소스에서 해당 인덱스의 날씨 데이터를 가져와 셀 구성
        let forecastWeather = dataSource[indexPath.row]
        cell.configureCell(forecastWeather: forecastWeather)
        
        return cell  // 구성된 셀 반환
    }
    
    /// 테이블 뷰의 총 행 개수를 반환하는 메서드
    /// - Parameters:
    ///   - tableView: 행 개수를 요청하는 테이블 뷰
    ///   - section: 섹션 인덱스 (이 앱에서는 단일 섹션만 사용)
    /// - Returns: 해당 섹션의 총 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count  // 데이터 소스 배열의 항목 개수만큼 행 생성
    }
}

// MARK: - SwiftUI Preview
/// SwiftUI 프리뷰를 위한 설정
/// Xcode의 캔버스에서 뷰 컨트롤러의 미리보기를 제공
#Preview {
    ViewController()  // 프리뷰할 뷰 컨트롤러 인스턴스 생성
}
