//
//  ViewController.swift
//  ViewControllerLifeCycle
//
//  Created by 유태호 on 12/2/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("다른페이지로 이동", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // 뷰가 메모리에 적재되었다. 뷰가 로드되었다.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("ViewDidLoad")
    }
    
    // 뷰가 유저눈에 보이게 될 것이다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewWillAppear")
    }
    
    // 뷰가 유저눈에 나타나고있다.
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("ViewIsAppearing")
    }
    
    // 뷰가 유저눈에 나타났다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewDidAppear")
    }
    
    // 뷰가 사라질 예정이다
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewWillDisappear")
    }
    
    // 뷰가 사라진다.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappearing")
    }
    
    private func configureUI() {
        [button].forEach { view.addSubview($0)}
        view.backgroundColor = .white
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(300)
            $0.size.equalTo(120)
        }
    }
    
    @objc
    private func buttonTapped() {
        // 다음페이지로 넘어가는 코드 작성
        self.navigationController?.pushViewController(NextViewController(), animated: true)
    }
}

// MARK: - Preview Provider
/// SwiftUI 프리뷰를 위한 설정
#Preview {
    ViewController()
}
