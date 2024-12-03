//
//  ReferenceCounting.swift
//  ViewControllerLifeCycle
//
//  Created by 유태호 on 12/2/24.
//

import UIKit

class MyClass {
    init() {
        print("MyClass 생성")
    }
    deinit {
        print("MyClass 소멸")
    }
}

// RC = 1
var myClass: MyClass? = MyClass()

// RC = 2
var myClass2 = myClass

// RC = 2-1 = 1
// myClass = nil


// RC = 1-1 = 0
// myClass2 = nil
