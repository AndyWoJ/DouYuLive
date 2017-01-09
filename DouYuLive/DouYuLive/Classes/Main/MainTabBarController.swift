//
//  MainTabBarController.swift
//  DouYuLive
//
//  Created by wujian on 2017/1/4.
//  Copyright © 2017年 wujian. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addOneChildViewControl(storyBoardName: "Home")
        addOneChildViewControl(storyBoardName: "Live")
        addOneChildViewControl(storyBoardName: "Follow")
        addOneChildViewControl(storyBoardName: "User")
    }
    
    // add child View Controller
    private func addOneChildViewControl(storyBoardName: String){
        let childViewController = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childViewController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
