//
//  LocalDatabaseViewController.swift
//  MCBaseExample
//
//  Created by Miller Mosquera on 2/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase

class LocalDatabaseViewController: MEMBaseViewController {
    
    let titleLbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "LocalStorage"
        label.textColor = .blue
        label.font = UIFont(name: "Poppins-Light", size: 28.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setTitle()
        
        savingLocalData()
        
        showNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle() {
        self.view.addSubview(titleLbl)
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func savingLocalData() {
        let userDataManager = MEMBaseDataManager<User>(modelName: "MEMBaseBD", entityName: "User")
        let tokenDataManager = MEMBaseDataManager<Token>(modelName: "MEMBaseBD", entityName: "Token")
        
        //let userCreated = dataManager.create(data: ["name": "Miller", "photo": "millermex.png", "token": "uiUkhsodJk372bm1-lKI67", "userid": "3482"])
        //print(userCreated ?? "none created")
        
        /*let results = dataManager.fetch()
        print(results ?? "None fetched")
        
        for item in results! {
            print(item.id)
            print(item.userid ?? "")
            print(item.name ?? "")
        }*/
     
        if let result = userDataManager.fetch(with: "userId", value: "8573") {
            print(result.name!)
        }

   
        if let result = userDataManager.fetch(with: "userId", value: "3482") {
            print(result.name!)
        }
  

        
        //let tokenCreated = dataManagerToken.create(data: ["token": "uUydhHHjksbasdk-u37bsndf-hsdf931"])
        //print(tokenCreated ?? "could'nt be created")
        
       
        if let tokenResult = tokenDataManager.fetch() {
            //print(tokenResult)
            let oldToken = tokenResult[0]
            print(oldToken.token!)
            //oldToken.token = "jkURklsdf)87234jkjskhsdf89798234-hsdkfh89"
            //dataManagerToken.update(entityObject: oldToken)
            
            /*for token in tokenResult {
             print(token.token)
             }*/
        }
     
        
        
        //let dataManager = DataManager<User>()
        //dataManager.modelName = "MCSessionData"
        
        //let userCreated = dataManager.createUser(data: ["name": "Matias", "photo": "matias288.png", "token": "khsdkjfahsdHRjk3hGDhk-lKIsd", "userid": "5249"])
        //print(userCreated ?? "none created")
        
        
        //let result = dataManager.fetchUser(userId: "3849")
        //print(result ?? "none fetched vc")
        
        //let results = dataManager.fetch()
        
        //print(results ?? "None fetched")
        
        /*for item in results! {
            print(item.id)
            print(item.userid ?? "")
            print(item.name ?? "")
        }*/
        
        //dataManager.removeAll()
        
    }
    
    
}
