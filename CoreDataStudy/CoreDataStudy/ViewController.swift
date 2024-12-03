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
    
    // 리팩토링 후
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        createData(name: "Adam", phoneNumber: "010-1111-2222")
        readAllData()
    }

    // CoreDataStudy 에 데이터 Create.
    func createData(name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        
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
                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
                   let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) {
                    print("name: \(name), phoneNumber: \(phoneNumber)")
                }
            }
        } catch {
            print("데이터 읽기 실패")
        }
    }
    
    // CoreDataStudy 에서 데이터 Update
    func updateData(currentName: String, updateName: String) {

        // 수정할 데이터를 찾기 위한 fetch request 생성
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName) // 예시: 이름이 "Adam"인 데이터 수정
        
        do {
            // fetch request 실행
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            // 결과 처리
            for data in result as [NSManagedObject] {
                // 데이터 수정
                data.setValue(updateName, forKey: PhoneBook.Key.name) // 이름을 "Adam"에서 "Abel"로 수정
                
                // 변경 사항 저장
                try self.container.viewContext.save()
                print("데이터 수정 완료")
            }
            
        } catch {
            print("데이터 수정 실패")
        }
    }
    
    // CoreDataStudy 에서 데이터 Delete
    func deleteData(name: String) {
        // 삭제할 데이터를 찾기 위한 fetch request 생성
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            // fetch request 실행
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            // 결과 처리
            for data in result as [NSManagedObject] {
                // 삭제
                // CRUD 의 D.
                self.container.viewContext.delete(data)
                print("삭제된 데이터: \(data)")
            }
            
            // 변경 사항 저장
            try self.container.viewContext.save()
            print("데이터 삭제 완료")
            
        } catch {
            print("데이터 삭제 실패: \(error)")
        }
    }

    /* 리팩토링 전
     
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
    */
}

