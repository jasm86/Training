//
//  GenericScreenProtocols.swift
//  Training
//
//  Created by Jorge Angel Sanchez Martinez on 5/25/19.
//  Copyright © 2019 Jorge Angel Sanchez Martinez. All rights reserved.
//

import UIKit

protocol DrawableCellProtocol {
    func cellForTableView(_ tableView: UITableView, atIndexPath: IndexPath) -> UITableViewCell
    func drawCell(_ cell: UITableViewCell) //optional
}
