//
//  PhoneBook+CoreDataProperties.swift
//  CoreDataStudy
//
//  Created by 유태호 on 12/3/24.
//
//

import Foundation
import CoreData


extension PhoneBook {
    
    // @nonobjc` = Objective-C 에서는 동작하지 않고 Swift 에서만 동작하는 메서드임을 명시.
    // fetchRequest()` = PhoneBook 에 대한 여러가지 데이터 검색을 도움.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }
    
    // @NSManaged` = CoreData 에 의해 관리되는 객체를 의미.
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}
// Identifiable` = PhoneBook 타입이 고유하게 식별될 수 있음을 의미.
extension PhoneBook : Identifiable {

}
/**
 - `@nonobjc` = Objective-C 에서는 동작하지 않고 Swift 에서만 동작하는 메서드임을 명시.
 - `fetchRequest()` = PhoneBook 에 대한 여러가지 데이터 검색을 도움.
 - `@NSManaged` = CoreData 에 의해 관리되는 객체를 의미.
 - `Identifiable` = PhoneBook 타입이 고유하게 식별될 수 있음을 의미.
 */
