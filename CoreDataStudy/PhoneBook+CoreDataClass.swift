//
//  PhoneBook+CoreDataClass.swift
//  CoreDataStudy
//
//  Created by 유태호 on 12/3/24.
//
//

import Foundation
import CoreData


// NSManagedObject는 Core Data 프레임워크에서 관리되는 객체를 나타내는 기본 클래스
// 이 클래스는 Core Data 엔티티와의 상호작용을 관리하며, 속성 값의 저장 및 검색을 처리
@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className = "PhoneBook"   // static 프로퍼티는 그 타입에 대고 호출을 할 수 있는 프로퍼티
    public enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
    }
}
