//
//  ViewController.swift
//  TableViewStudy
//  Created by 김준혁 on 2023/01/06.

import UIKit

class ViewController: UIViewController {

    private let tableView = UITableView()
    
    var memberListManager = MemberListManager()
    
    // ?? 뷰 컨트롤러에 버튼 넣는게 가능..?
    // 네비게이션바에 올리는 경우 반드시 UIBarButtonItem 타입
    lazy var plusButton: UIBarButtonItem = {
        // 아하.. targetdl self니.. ViewController가 갖고 있는 뷰에 넣겠다는 뜻이겠구나
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    @objc func plusButtonTapped() {
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupDatas()
        setupNaviBar()
        setupTableViewConstraints()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - 테이블뷰 셋팅
    
    func setupTableView() {
        // 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 60
        // 셀의 등록⭐️ (타입인스턴스 - 메타타입)
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    // 어떠한 화면으로 갔다, 다시 돌아 올 때
    // 데이터 업데이트 사항이 있으면
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    
    func setupDatas() {
        memberListManager.makeMembersListDatas() // 일반적으로는 서버에 요청
    }
    
    func setupNaviBar() {
        title = "회원 목록"
        
        // 네비게이션바 설정관련
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션바 오른쪽 상단 버튼 설정
        self.navigationItem.rightBarButtonItem = self.plusButton // plusButton 은 우리가 지은 이름입니다
    }
    
    // 테이블 뷰 오토레이아웃 설정
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            
        ])
    }

}



extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
        cell.member = memberListManager[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}

// 클릭 했을 경우 다음 셀로 넘어갈 때 델리게이트 프로토콜을 사용합니다!
extension ViewController : UITableViewDelegate {
    
    // didSelectRowAt -> 몇 번째 셀이 눌렸을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 다음 화면으로 넘어가는 코드 구현
        let detailVC = DetailViewController()
        
        let array = memberListManager.getMembersList()
        detailVC.member = array[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true )
        
    }
    
}

