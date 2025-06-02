//
//  TeamsDetailsPresenter.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 01/06/2025.
//

import Foundation

class TeamsDetailsPresenter {
    
    var team : TeamModel!
    var teamsDetailsView : TeamsDetailsViewControllerProtocol!
    var sportName : String!
    
    init(team: TeamModel!, teamDetailsView: TeamsDetailsViewControllerProtocol, sportName: String) {
        self.team = team
        self.teamsDetailsView = teamDetailsView
        self.sportName = sportName
    }
    
    func getTeamDetails(){
        DispatchQueue.main.async {
            print("team: \(self.team)")
            self.teamsDetailsView.displayTeamDetails(resevedTeam: self.team, sportName: self.sportName)
        }
    }
}
