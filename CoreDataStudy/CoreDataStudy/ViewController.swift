//
//  ViewController.swift
//  CoreDataStudy
//
//  Created by 유태호 on 12/3/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var container: NSPersistentContainer! // ! 마크는 반드시 존재한다는 의미를 부여(추후 찾아볼 내용)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate // AppDelegate에 접근하기 위한 코드. UIApplication.shared.delegate : 기본제공하는 코프로퍼티
                                                                        // 뒤의 as는 AppDelegate를 타입캐스팅 하기 위해서 사용, 타입캐스팅을 하면 폴더의 AppDelegate에 접근가능
        self.container = appDelegate.persistentContainer
        
        createData(name: "Adam", phoneNumber: "010-1111-2222")
        readAllData()
        
    }

    // CoreDataStudy 에 데이터 Create.
    func createData(name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext) else { return }
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: "name")
        newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
        
        do {
            try self.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }
    
    // CoreDataStudy 에서 데이터 Read.
    func readAllData() {
        do {
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                if let name = phoneBook.value(forKey: "name") as? String,
                   let phoneNumber = phoneBook.value(forKey: "phoneNumber") as? String {
                    print("name: \(name), phoneNumber: \(phoneNumber)")
                }
            }
            
        } catch {
            print("데이터 읽기 실패")
        }
    }
}

