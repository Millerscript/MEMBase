//
//  ViewController.swift
//  MEMBase
//
//  Created by Millerscript on 03/25/2024.
//  Copyright (c) 2024 Millerscript. All rights reserved.
//

import UIKit
import MEMBase

class ViewController: MEMBaseViewController {

    struct Constants {
          static let cellIdentifier = "DeeplinkCell"
          static let headerHeight = 100.0
          static let cellHeight = 50.0
      }
      let tableView = UITableView(frame: .zero)
      var model: [DeeplinkModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
          
          setTableView()
          setModel()
          
          hideNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(DeeplinkCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setModel() {
        model.append(DeeplinkModel(title: "Creators profile", deeplink: "membase://creators/algo/h/profile?next_deeplink=cfcreators://sign/in&user=h37dhg&permission_allowed=false"))
        //model.append(DeeplinkModel(title: "Track my pack", deeplink: "membase://tmpack?next_deeplink=cfcreators://sign/in"))
        //model.append(DeeplinkModel(title: "Questions", deeplink: "membase://questions?next_deeplink=cfcreators://sign/in"))
        model.append(DeeplinkModel(title: "Font Manager", deeplink: "membase://fontstyle"))
        model.append(DeeplinkModel(title: "Rendering images", deeplink: "membase://images"))
        model.append(DeeplinkModel(title: "Local database {core data}", deeplink: "membase://localdatabase"))
        model.append(DeeplinkModel(title: "Dates {Not implemented}", deeplink: "membase://dates"))
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = model[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? DeeplinkCell else {return UITableViewCell()}
        
        cell.set(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deeplink = model[indexPath.row]
        self.open(deeplink: deeplink.deeplink)
    }
    
}
