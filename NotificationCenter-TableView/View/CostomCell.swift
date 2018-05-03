//
//  CostomCell.swift
//  NotificationCenter-TableView
//
//  Created by kawaharadai on 2018/05/03.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class CostomCell: UITableViewCell {

    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    // MARK: - Propaties
    static var identifier: String {
        return String(describing: self)
    }

    var buttonTitles = [String]() {
        didSet {
            guard buttonTitles.count >= 3 else {
                fatalError("表示データ不足")
            }
            self.blueButton.setTitle(buttonTitles[0], for: .normal)
            self.yellowButton.setTitle(buttonTitles[1], for: .normal)
            self.redButton.setTitle(buttonTitles[2], for: .normal)
        }
    }
    
    // MARK: - Actions
    // 通常の通知（値渡しはなし）
    @IBAction func blueButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: .blueNotification,
                                        object: nil)
    }
    
    // 通知に値を付与して送る（辞書型で送る、key:valueは複数送れる）
    @IBAction func yellowButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: .yellowNotification,
                                        object: nil,
                                        userInfo: ["yellow": "注意して進め",
                                                   "Yellow": "頑張って進め"])    }
    
    @IBAction func redButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: .redNotification,
                                        object: nil,
                                        userInfo: ["red": "止まれ"])
    }
    
}
