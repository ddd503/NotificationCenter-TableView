//
//  ViewController.swift
//  NotificationCenter-TableView
//
//  Created by kawaharadai on 2018/05/03.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    private let provider = TableViewProvider()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeNotification()
    }
    
    // MARK: - Setup
    private func setup() {
        self.tableView.dataSource = provider
        self.setupDataSource()
        self.registNotification()
    }
    
    private func setupDataSource() {
        self.provider.outputData = []
        self.provider.outputData = ["Blue", "Yellow", "Red"]
        self.tableView.reloadData()
    }
    
    // MARK: - Private
    /// 通知登録（今回は４つ登録）
    private func registNotification() {
        
        let center = NotificationCenter.default
        
        /// バックグラウンドから復帰した時の通知アクションを登録（元から用意された通知名）
        center.addObserver(self,
                           selector: #selector(willEnterForegroundAction(notification:)),
                           name: .UIApplicationWillEnterForeground,
                           object: nil)
        
        /// 青ボタンを押した時の通知アクションを登録（オリジナルの通知名）
        center.addObserver(self,
                           selector: #selector(blueNotificationAction(notification:)),
                           name: .blueNotification,
                           object: nil)
        
        /// 黄色ボタンを押した時の通知アクションを登録（オリジナルの通知名）
        center.addObserver(self,
                           selector: #selector(yellowNotificationAction(notification:)),
                           name: .yellowNotification,
                           object: nil)
        
        /// 赤ボタンを押した時の通知アクションを登録（オリジナルの通知名・クロージャVer & 通知先から値取得あり）
        center.addObserver(forName: .redNotification, object: nil, queue: nil) { notification in
            
            guard
                let userInfo = notification.userInfo as? [String: Any],
                let notificationText = userInfo["red"] as? String else {
                    print("valueの受け取りに失敗")
                    return
            }
            
            self.resultLabel.text = notificationText
        }
    }
    
    /// 通知削除
    private func removeNotification() {
        
        let center = NotificationCenter.default
        
        // 全ての通知登録を削除
        center.removeObserver(self)
        
        // 特定の通知登録を削除
//        center.removeObserver(self, name: .redNotification, object: nil)
    }
    
    // MARK: - Notification
    @objc private func willEnterForegroundAction(notification: Notification) {
        self.resultLabel.text = "バックグラウンドから復帰しました。"
    }
    
    @objc private func blueNotificationAction(notification: Notification) {
        self.resultLabel.text = "進め"
    }
    
    // 通知先から何かしらの値を取得
    @objc private func yellowNotificationAction(notification: Notification) {
        guard
            let userInfo = notification.userInfo as? [String: Any],
            let notificationText = userInfo["yellow"] as? String else {
                print("valueの受け取りに失敗")
                return
        }
        self.resultLabel.text = notificationText
    }
}

