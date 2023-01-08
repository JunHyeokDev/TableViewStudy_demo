//
//  DetailViewController.swift
//  TableViewStudy
//
//  Created by 김준혁 on 2023/01/08.
//

import UIKit

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    
    var member: Member? //  멤버가 필요합니다. Main View Controller에서 셀을 클릭했을 때 member를 받아
    // 상세 뷰를 표시하기 위함이죠~!
    
    override func loadView() {
        view = detailView // 이 코드의 뜻은...
        // Controller -> Views -> DetailView를 해당 컨트롤러의 뷰로 정의하겠다 이 말 입니다.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonAction()
        // detailView.member 가 설정이 되어야 업데이트가 되겠구먼~~
        setupData() // ->>> detailView.member = member
    }
    
    private func setupData() {
        detailView.member = member

    }
    
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        // 업데이트는 어떻게 구현해야할까?
//        let memberId: Int
//        var name: String?
//        var age: Int?
//        var phone: String?
//        var address: String?
        
        if member == nil {
            
            let name = detailView.nameTextField.text ?? ""
            let age  = Int(detailView.ageTextField.text ?? "")
            let phoneNumber = detailView.phoneNumberTextField.text ?? ""
            let address = detailView.addressTextField.text ?? ""
            
            // 새로운 멤버 (구조체) 생성
            var newMember =
            Member(name: name, age: age, phone: phoneNumber, address: address)
            newMember.memberImage = detailView.mainImageView.image
            
            // 1) 델리게이트 방식이 아닌 구현⭐️
            let index = navigationController!.viewControllers.count - 2
            // 전 화면에 접근하기 위함
            let vc = navigationController?.viewControllers[index] as! ViewController
            // 전 화면의 모델에 접근해서 멤버를 추가
            vc.memberListManager.makeNewMember(newMember)
        
            
            // 2) 델리게이트 방식으로 구현⭐️
            //delegate?.addNewMember(newMember)
            
        } else {
            // 이미지뷰에 있는 것을 그대로 다시 멤버에 저장
            member!.memberImage = detailView.mainImageView.image
            
            let memberId = Int(detailView.memberIdTextField.text!) ?? 0
            member!.name = detailView.nameTextField.text ?? ""
            member!.age = Int(detailView.ageTextField.text ?? "") ?? 0
            member!.phone = detailView.phoneNumberTextField.text ?? ""
            member!.address = detailView.addressTextField.text ?? ""
            
            // 뷰에도 바뀐 멤버를 전달 (뷰컨트롤러 ==> 뷰)
            detailView.member = member
            
            // 1) 델리게이트 방식이 아닌 구현⭐️
            let index = navigationController!.viewControllers.count - 2
            // 전 화면에 접근하기 위함
            let vc = navigationController?.viewControllers[index] as! ViewController
            // 전 화면의 모델에 접근해서 멤버를 업데이트
            vc.memberListManager.updateMemberInfo(index: memberId, member!)
            
            
            // 델리게이트 방식으로 구현⭐️
            //delegate?.update(index: memberId, member!)
        
        // (일처리를 다한 후에) 전화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
        }
    }

}
