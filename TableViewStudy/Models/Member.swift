//
//  Member.swift
//  TableViewStudy
//
//  Created by 김준혁 on 2023/01/08.
//

import UIKit


// 클래스에서만 채택할 수 있는 프로토콜임을 알리기 위해
// 
protocol MemberDelegate : AnyObject {
    func addNewMember(_ member: Member)
    func update(index: Int, _ member : Member)
}



struct Member {
    
    lazy var memberImage: UIImage? = {
        // 이름이 없다면, 시스템 사람이미지 셋팅
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        // 해당이름으로된 이미지가 없다면, 시스템 사람이미지 셋팅
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    // 멤버의 (절대적) 순서를 위한 타입 저장 속성
    static var memberNumbers: Int = 0
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    // 생성자 구현
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
        // 0 일때는 0, 0이 아닐때는 타입저장속성의 절대적 값으로 셋팅 (자동순번)
        self.memberId = Member.memberNumbers == 0 ? 0 : Member.memberNumbers
        
        // 나머지 저장속성은 외부에서 셋팅
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        
        // 멤버를 생성한다면, 항상 타입 저장속성의 정수값 + 1
        Member.memberNumbers += 1
    }
}
