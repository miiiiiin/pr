//
//  TableViewDataSource.swift
//  Weather
//
//  Created by 민송경 on 30/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation
import UIKit

//generic datasource(will work on any kind of cell & any kind of view model)
class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? CellType else {
            fatalError("cell with cell identifier \(self.cellIdentifier) not found")
        }
        
        let vm = self.items[indexPath.row]
        self.configureCell(cell, vm) //passing in the cell that you want to configure and the viewmodel
        
        
        return cell
    }
    
    func updateItems(_ items: [ViewModel]) {
        
        self.items = items //assign items that we are receiving from the user
    }
    
    
    let cellIdentifier: String
    var items: [ViewModel]
    let configureCell: (CellType, ViewModel) -> ()
    //prividing closure : closure is going to give them access to the cell
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping (CellType, ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
}
