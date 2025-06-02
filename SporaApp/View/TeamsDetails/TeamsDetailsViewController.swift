//
//  TeamsDetailsViewController.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 01/06/2025.
//

import UIKit
import SwiftUI
import Kingfisher

class TeamsDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TeamsDetailsViewControllerProtocol {
    
    var team : TeamModel!
    var goalkeepers  : [Player] = []
    var defenders : [Player] = []
    var midfielders : [Player] = []
    var forwards : [Player] = []
    var coaches : [Coach] = []
    
    var presenter : TeamsDetailsPresenter!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getTeamDetails()
        
        let nib = UINib(nibName: "TeamsDetailsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
     
        // Do any additional setup after loading the view.
    }
    
    func displayTeamDetails(resevedTeam: TeamModel, sportName: String){
        self.team = resevedTeam
        self.teamName.text = resevedTeam.teamName
        let url = URL(string: resevedTeam.teamLogo ?? "")
        self.teamImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        if let coachArray = resevedTeam.coaches {
            self.coaches = coachArray
        }else{
            self.coaches = []
        }
        //self.coaches = resevedTeam.coaches ?? []
        
        let players = resevedTeam.players
        players?.forEach { player in
            switch player.playerType {
            case "Goalkeepers":
                goalkeepers.append(player)
                break
            case "Defenders":
                defenders.append(player)
                break
            case "Midfielders":
                midfielders.append(player)
                break
            default:
                forwards.append(player)
            }
        }
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return coaches.count
        case 1:
            return goalkeepers.count
        case 2:
            return defenders.count
        case 3:
            return midfielders.count
        default:
            return forwards.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TeamsDetailsTableViewCell
        switch indexPath.section {
        case 0:
            cell.playerImage.image = UIImage(named: "placeholder")
            cell.playerName.text = coaches[indexPath.row].coachName
            cell.noLabel.isHidden = true
            cell.playerNumber.isHidden = true
            break
        case 1:
            let goalkeeper = goalkeepers[indexPath.row]
            let url = URL(string: goalkeeper.playerImage ?? "")
            cell.playerImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            cell.playerName.text = goalkeeper.playerName
            cell.playerNumber.text = goalkeeper.playerNumber
            break
        case 2:
            let defender = defenders[indexPath.row]
            let url = URL(string: defender.playerImage ?? "")
            cell.playerImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            cell.playerName.text = defender.playerName
            cell.playerNumber.text = defender.playerNumber
            break
        case 3:
            let midfielder = midfielders[indexPath.row]
            let url = URL(string: midfielder.playerImage ?? "")
            cell.playerImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            cell.playerName.text = midfielder.playerName
            cell.playerNumber.text = midfielder.playerNumber
            break
        default:
            let forward = forwards[indexPath.row]
            let url = URL(string: forward.playerImage ?? "")
            cell.playerImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            cell.playerName.text = forward.playerName
            cell.playerNumber.text = forward.playerNumber
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 5, y: -10, width: (self.tableView.bounds.size.width ) - 32, height: 30))
        label.textColor = UIColor.black
        label.font = UIFont(name: "System", size: 18)
        
        switch section{
        case 0:
            label.text = "Coach"
            break
        case 1:
            label.text = "Goalkeepers"
            break
        case 2:
            label.text = "Defenders"
            break
        case 3:
            label.text = "Midfielders"
            break
        default:
            label.text = "Forwards"
            break
        }
        
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
