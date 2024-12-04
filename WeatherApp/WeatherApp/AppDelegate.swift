//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by 유태호 on 12/4/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        // window 에게 루트 뷰 지정.   // 페이지간 이동을 할거기 때문에 UINavigationController를 선언, 뒤의 rootViewController는 루트로 쓸 뷰 지정
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        
        // 이 메서드를 반드시 작성해줘야 윈도우가 활성화 됨.
        window.makeKeyAndVisible()
        self.window = window // 위의 var window 선언(넣어주겠다는 뜻)
        
        return true
    }
}

