//
//  ViewController2.swift
//  CoreDataStudy
//
//  Created by 유태호 on 12/3/24.
//

import UIKit

/**
 
 UserDefaults
 - `UserDefaults` 또한 `디스크`에 데이터를 저장할 수 있게 돕는 도구.
 - CoreData 보다 사용성이 간단.
 - `key` 와 `value` 를 이용해서 값을 저장.
 - 대량의 데이터를 담는데에는 `CoreData` 가, 비교적 단순한 데이터를 담는 데에는 `UserDefaults` 가 적절.

UserDefaults 의 CRUD
 - `UserDefaults.standard.set()` 메서드를 통해서 `Create`, `Update`
 - `UserDefaults.standard.string(forKey: "")` 메서드를 통해서 `Read` (각 타입에 맞는 메서드사용)
     - bool 타입 `Read`: `UserDefaults.standard.bool(forKey: "")`
     - Int 타입 `Read`: `UserDefaults.standard.integer(forKey: "")`
 - `UserDefaults.standard.removeObject(forKey: "")` 메서드를 통해서 `Delete`
 */

class UserDefaultsTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create
        UserDefaults.standard.set("010-1111-2222", forKey: "phoneNumber")
        
        // Read
        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
        print("저장된 전화번호: \(phoneNumber)")
        
        // Update
        // 같은 키에다가 set 을 하면 됨.
        UserDefaults.standard.set("010-6666-7777", forKey: "phoneNumber")
        let newPhoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
        print("바뀐 전화번호: \(newPhoneNumber)")
        
        // Delete
        UserDefaults.standard.removeObject(forKey: "phoneNumber")
        print("전화번호가 남아있는가: \(UserDefaults.standard.string(forKey: "phoneNumber"))")
    }
}
