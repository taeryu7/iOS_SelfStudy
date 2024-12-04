//
//  PostIt.swift
//  CoreDataStudy
//
//  Created by 유태호 on 12/3/24.
//

import UIKit
import SnapKit

class PostIt: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "포스트잇"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = UserDefaults.standard.string(forKey: "memo")
        textView.layer.cornerRadius = 10
        textView.backgroundColor = UIColor(red: 75/255, green: 253/255, blue: 30/355, alpha: 1.0)
        textView.textColor = .black
        textView.font = .boldSystemFont(ofSize: 30)
        return textView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("적용", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        [
            label,
            textView,
            button
        ].forEach { view.addSubview($0) }
        
        view.backgroundColor = .white
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(200)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(50)
            $0.width.equalTo(60)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
 
    @objc
    private func buttonTapped() {
        UserDefaults.standard.set(textView.text, forKey: "memo")
        print("저장 완료")
    }
}

// MARK: - Preview Provider
/// SwiftUI 프리뷰를 위한 설정
#Preview {
    PostIt()
}
