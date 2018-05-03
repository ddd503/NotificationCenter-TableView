//
//  TableViewProvider.swift
//  NotificationCenter-TableView
//
//  Created by kawaharadai on 2018/05/03.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class TableViewProvider: NSObject {
    var outputData = [String]()
}

extension TableViewProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CostomCell.identifier, for: indexPath) as? CostomCell else {
            fatalError("cell is nil")
        }
        
        cell.buttonTitles = self.outputData
        
        return cell
    }
}
