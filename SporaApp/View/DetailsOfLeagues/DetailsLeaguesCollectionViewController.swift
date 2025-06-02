//
//  DetailsLeaguesCollectionViewController.swift
//  SporaApp
//
//  Created by macOS on 01/06/2025.
//

import UIKit
import Kingfisher
import Lottie

class DetailsLeaguesCollectionViewController: UICollectionViewController, LeagueDetailsViewProtocol, UICollectionViewDelegateFlowLayout {
    
    var lottieView: LottieAnimationView?
    var upcomingEvents: [Event] = []
    var latestEvents: [Event] = []
    var teams: [TeamModel] = []
    var tennisEvents : [TennisPlayerModel] = []
    var tennisPlayers : [TennisPlayerModel] = []
    var presenter: LeagueDetailsPresenter!
    var leagueId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib1 = UINib(nibName: "UpComingEventsCollectionViewCell", bundle: nil)
        let nib2 = UINib(nibName: "UpComingEventsCollectionViewCell", bundle: nil)
        
        collectionView.register(nib1, forCellWithReuseIdentifier: "section1")
        collectionView.register(nib2, forCellWithReuseIdentifier: "section2")
        
//        let lottieNib = UINib(nibName: "LottieeCollectionViewCell", bundle: nil)
//        collectionView.register(lottieNib, forCellWithReuseIdentifier: "section1")
        
        let teamsNib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        collectionView.register(teamsNib, forCellWithReuseIdentifier: "section3")

//        collectionView.register(SectionHeaderView.self,
//                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                withReuseIdentifier: SectionHeaderView.identifier)

        collectionView.collectionViewLayout = createCompositionalLayout()
        presenter.loadLeagueDetails()
        presenter.getTeamsFromAPI()
    }
    
    func displayUpcomingEvents(_ events: [Event]) {
        self.upcomingEvents = events
        collectionView.reloadSections(IndexSet(integer: 0))
        showLottieAnimationIfNeeded()
    }
    
    func displayLatestEvents(_ events: [Event]) {
        self.latestEvents = Array(events.prefix(10))
        collectionView.reloadSections(IndexSet(integer: 1))
        showLottieAnimationIfNeeded()
    }
    
    func displayTeams(_ teams: [TeamModel]) {
        self.teams = teams
        collectionView.reloadSections(IndexSet(integer: 2))
        showLottieAnimationIfNeeded()
    }
    
    func displayTennisEvents(_ tennisEvents: TennisPlayerResponse) {
        self.tennisEvents = Array(tennisEvents.result.dropFirst(30).prefix(30))
        self.collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func displayTennisPlayers(_ tennisPlayers: TennisPlayerResponse) {
        self.tennisPlayers = Array(tennisPlayers.result.dropFirst(30).prefix(30))
        self.collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            if self.presenter.sportName == "tennis"{
                switch sectionIndex {
                case 0: return self.createVerticalSection()
                default: return self.teamsSection()
                }
            }else{
                switch sectionIndex {
                case 0: return self.createHorizontalSection()
                case 1: return self.createVerticalSection()
                default: return self.teamsSection()
                }
            }
        }
    }
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        return section
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(170))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        return section
    }
    
    func teamsSection()->NSCollectionLayoutSection{
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(150))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0)
            section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.sportName == "tennis" ? 2 : 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if presenter.sportName == "tennis"{
                return max(tennisEvents.count, 0)
            }else{
                return max(upcomingEvents.count, 0)
            }
        case 1:
            if presenter.sportName == "tennis"{
                return max(tennisPlayers.count, 0)
            }else{
                return max(latestEvents.count, 0)
            }
        default:
            return max(teams.count, 0)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
//            if upcomingEvents.isEmpty {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LottieCell", for: indexPath) as! LottieeCollectionViewCell
//                return cell
//            } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "section1", for: indexPath) as? UpComingEventsCollectionViewCell else {
                fatalError("No Cell")
            }
            if presenter.sportName == "tennis"{
                let event = tennisEvents[indexPath.row]
                configureTennis(cell: cell, with: event, section: 0)
            }else{
                let event = upcomingEvents[indexPath.item]
                configure(cell: cell, with: event, section: 0)
            }
            return cell
            //}
            
        case 1:
            if presenter.sportName == "tennis"{
                guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "section3", for: indexPath) as? TeamsCollectionViewCell else {
                    fatalError("No Cell")
                }
                let players = tennisPlayers[indexPath.row]
                cell.teamName.text = players.eventFirstPlayer ?? "Unknown Player"
                let url = URL(string: players.eventFirstPlayerLogo ?? "")
                cell.teamImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
                return cell
            }else{
                guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "section2", for: indexPath) as? UpComingEventsCollectionViewCell else {
                    fatalError("No Cell")
                    
                }
                let event = latestEvents.isEmpty ? nil : latestEvents[indexPath.item]
                configure(cell: cell, with: event, section: 1)
                return cell
            }
            
        default:
            guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "section3", for: indexPath) as? TeamsCollectionViewCell else {
                fatalError("No Cell")
            }
            
            let team = teams[indexPath.row]
            cell.teamName.text = team.teamName
            let url = URL(string: team.teamLogo ?? "")
            cell.teamImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            return cell
        }
    }
    
    func configure(cell: UpComingEventsCollectionViewCell, with event: Event?, section: Int) {
        guard let event = event else {
            cell.team1name.text = "No data available"
            cell.team2name.text = ""
            cell.score.text = ""
            cell.date.text = ""
            cell.time.text = ""
            cell.team1Img.image = nil
            cell.team2Img.image = nil
            cell.layer.borderColor = nil
            return
        }
        
        cell.team1name.text = event.event_home_team
        cell.team2name.text = event.event_away_team
        cell.score.text = event.event_final_result ?? ""
        cell.date.text = event.event_date
        cell.time.text = event.event_time
        
        if let team1Url = URL(string: event.home_team_logo ?? "") {
            cell.team1Img.kf.setImage(with: team1Url)
        }
        
        if let team2Url = URL(string: event.away_team_logo ?? "") {
            cell.team2Img.kf.setImage(with: team2Url)
        }
        
        cell.layer.borderColor = (section == 0 ? UIColor.systemGreen : UIColor.systemOrange).cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 12
    }
    
    func configureTennis(cell: UpComingEventsCollectionViewCell, with event: TennisPlayerModel?, section: Int){
        guard let event = event else {
            cell.team1name.text = "No data available"
            cell.team2name.text = ""
            cell.score.text = ""
            cell.date.text = ""
            cell.time.text = ""
            cell.team1Img.image = nil
            cell.team2Img.image = nil
            cell.layer.borderColor = nil
            return
        }
        
        cell.team1name.text = event.eventFirstPlayer
        cell.team2name.text = event.eventSecondPlayer
        cell.score.text = event.eventFinalResult ?? ""
        cell.date.text = event.eventDate
        cell.time.text = event.eventTime
        
        if let team1Url = URL(string: event.eventFirstPlayerLogo ?? "") {
            cell.team1Img.kf.setImage(with: team1Url)
        }
        
        if let team2Url = URL(string: event.eventScoundPlayerLogo ?? "") {
            cell.team2Img.kf.setImage(with: team2Url)
        }
        
        cell.layer.borderColor = (UIColor.systemGreen ).cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 12
    }
    
    func showLottieAnimationIfNeeded() {
        let isEmpty = upcomingEvents.isEmpty && latestEvents.isEmpty
        
        if isEmpty {
            if lottieView == nil {
                setupLottieAnimation()
            }
         
            collectionView.backgroundView?.bringSubviewToFront(lottieView!)
        } else {
            removeLottieAnimation()
        }
    }

    private func setupLottieAnimation() {
        lottieView = LottieAnimationView(name: "splash")
        lottieView?.contentMode = .scaleAspectFit
        lottieView?.loopMode = .loop
        
        let containerView = UIView(frame: collectionView.bounds)
        containerView.backgroundColor = .clear
        
        lottieView?.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lottieView!)
        
        NSLayoutConstraint.activate([
            lottieView!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lottieView!.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lottieView!.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            lottieView!.heightAnchor.constraint(equalTo: lottieView!.widthAnchor)
        ])
        
        collectionView.backgroundView = containerView
        lottieView?.play()
    }

    private func removeLottieAnimation() {
        lottieView?.stop()
        lottieView?.removeFromSuperview()
        lottieView = nil
        collectionView.backgroundView = nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamStoryBoard = UIStoryboard(name: "TeamsDetails", bundle: nil)
        let teamDetailsVC = teamStoryBoard.instantiateViewController(identifier: "teamsDetails") as! TeamsDetailsViewController
        switch indexPath.section {
        case 2:
            let team = teams[indexPath.row]
            let teamDetailsPresenter = TeamsDetailsPresenter(team: team, teamDetailsView: teamDetailsVC, sportName: self.presenter.sportName)
            teamDetailsVC.presenter = teamDetailsPresenter
            self.navigationController?.pushViewController(teamDetailsVC, animated: true)
        default:
            break
        }
    }
}
