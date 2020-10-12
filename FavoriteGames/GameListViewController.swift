//
//  GameListViewController.swift
//  FavoriteGames
//
//  Created by Jaehoon Lee on 2020/10/11.
//

import UIKit

protocol GameCellDelegate {
    func toggleLike(_ gameId: Int)
}

class GameCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    var gameId: Int!
    var delegate: GameCellDelegate?
    
    @IBAction func onToggleButton() {
        print("toggle like")
        delegate?.toggleLike(gameId)
    }
}

class GameListViewController: UITableViewController {
    
    var data = [
        Game(id: 0, title: "데스 스트랜딩"),
        Game(id: 1, title: "갓 오브 워"),
        Game(id: 2, title: "젤다의 전설 브레스 오브 더 와일드"),
        Game(id: 3, title: "언차티드 4: 해적왕과 최후의 보물"),
        Game(id: 4, title: "더 위쳐 3: 와일드 헌트"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        
        cell.delegate = self
        
        let item = data[indexPath.row]
        cell.titleLabel.text = item.title
        cell.gameId = item.id
        cell.likeButton.isSelected = item.like
        
        return cell
    }
}

extension GameListViewController: GameCellDelegate {
    func toggleLike(_ gameId: Int) {
        print("GameListViewController - like", gameId)
        for i in 0..<data.count {
            if data[i].id == gameId {
                data[i].like = !data[i].like
                
                let indexPath = IndexPath(row: i, section: 0)
                tableView.reloadRows(at: [indexPath], with: .automatic)
                break
            }
        }
    }
}

