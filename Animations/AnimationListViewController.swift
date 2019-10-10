//
//  ViewController.swift
//  Animations
//
//  Created by Ariel Fertman on 10/9/19.
//  Copyright © 2019 Ariel Fertman. All rights reserved.
//

import UIKit

struct ViewControllerDetail {
    var vc: UIViewController
    var name: String
}

class AnimationListViewController: UIViewController {
    
    let animationVCs = [
        ViewControllerDetail(vc: JitteryIconsViewController(), name: "Jittery Icons")
    ]
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
    }

}

extension AnimationListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animationVCs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimationRowCell")!
        cell.textLabel?.text = animationVCs[indexPath.row].name
        return cell
    }
    
}

extension AnimationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select: \(animationVCs[indexPath.row].name)")
        let vc = animationVCs[indexPath.row].vc
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
