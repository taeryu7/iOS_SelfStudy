//
//  AppDelegate.swift
//  CoreDataStudy
//
//  Created by 유태호 on 12/3/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    // 원래는 없는 메서드지만 coredata를 추가해서 자동생성된 메서드
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        
        // - `NSPersistentContainer` 는 CoreData에서 데이터를 저장하고 관리하는 데 필요한 핵심 객체. → 직역해보면 영구적인 저장 장소.
        
        // 먼저 NSPersistentContainer 를 생성해줘야하는데, 프로젝트 생성할 때 CoreData 를 사용한다고 체크 해줬으므로,
        // AppDelegate.swift 에 기본적으로 NSPersistentContainer 를 세팅하는 코드가 존재.
        
        // NSPersistentConatiner 를 만들었으므로, ViewController 에서 이를 활용해서 데이터 접근.
        let container = NSPersistentContainer(name: "CoreDataStudy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    // 원래는 없는 메서드지만 coredata를 추가해서 자동생성된 메서드
    
    // AppDelegate.swift 아래쪽에보면 saveContext() 라는 메서드도 자동으로 생성되어있는데, 직역하면 문맥을 저장한다는 뜻.
    // 데이터의 업데이트(추가, 업데이트, 삭제 등)가 일어났으면 saveContext() 를 호출해서 그 문맥을 저장해야 함.
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

