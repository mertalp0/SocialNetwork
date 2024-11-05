//
//  FeedTableView.swift
//  SocialNetwork
//
//  Created by mert alp on 4.11.2024.
//

import Foundation
import NeonSDK
import UIKit

class FeedTableView: NeonTableView<Post,FeedCell> {
    
    var customDelegate: FeedCellDelegate
    
    init(objects: [Post] = [], heightForRows: CGFloat = 44, style: UITableView.Style = .plain, delegate: FeedCellDelegate) {
        self.customDelegate = delegate
        super.init(objects: objects, heightForRows: heightForRows, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reuseIdentifier, for: indexPath) as! FeedCell
        if !isShimmerActive{
            let object = objects[indexPath.row]
            cell.configure(with: object)
            cell.delegate = customDelegate
        }
        cell.selectionStyle = .none
        return cell
    }
}
