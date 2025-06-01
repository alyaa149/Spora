//
//  DetailsLeaguesCollectionViewController.swift
//  SporaApp
//
//  Created by macOS on 01/06/2025.
//

import UIKit
import Kingfisher
private let reuseIdentifier = "Cell"

class DetailsLeaguesCollectionViewController: UICollectionViewController ,LeagueDetailsViewProtocol{
    func displayUpcomingEvents(_ events: [Event]) {
        self.upcomingEvents = events
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func displayLatestEvents(_ events: [Event]) {
        self.latestEvents = events
        collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    var upcomingEvents: [Event] = []
    var latestEvents: [Event] = []

    var presenter: LeagueDetailsPresenter!
    var leagueId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "UpComingEventsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "UpComingEventsCell")
        
        let teamsNib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)

//        collectionView.register(SectionHeaderView.self,
//                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                withReuseIdentifier: SectionHeaderView.identifier)

       
        collectionView.collectionViewLayout = createCompositionalLayout()

        presenter = LeagueDetailsPresenter(view: self)
        presenter.loadLeagueDetails(leagueId: leagueId)

    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.createHorizontalSection()
            case 1:
                return self.createVerticalSection()
            default:
                return self.createThirdSection()
            }
        }
    }
    func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .estimated(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
//        section.boundarySupplementaryItems = [createHeader()]

        return section
    }
    func createVerticalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
//        section.boundarySupplementaryItems = [createHeader()]

        return section
    }
    func createThirdSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
//        section.boundarySupplementaryItems = [createHeader()]

        return section
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return upcomingEvents.count
        case 1: return latestEvents.count
          case 2: return 6
          default: return 0
          }    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventsCell", for: indexPath) as! UpComingEventsCollectionViewCell
            let event = upcomingEvents[indexPath.item]
            configure(cell: cell, with: event)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventsCell", for: indexPath) as! UpComingEventsCollectionViewCell
            let event = latestEvents[indexPath.item]
                    configure(cell: cell, with: event)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventsCell", for: indexPath) as! UpComingEventsCollectionViewCell
         
               return cell
        default:
            fatalError("Unexpected section")
        }
    }
    func configure(cell: UpComingEventsCollectionViewCell, with event: Event) {
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
            cell.layer.borderColor = UIColor(red: 185/255, green: 212/255, blue: 170/255, alpha: 1.0).cgColor
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 12
        }
     
    }

//    override func collectionView(
//        _ collectionView: UICollectionView,
//        viewForSupplementaryElementOfKind kind: String,
//        at indexPath: IndexPath
//    ) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionHeader else {
//            return UICollectionReusableView()
//        }
//
//        let header = collectionView.dequeueReusableSupplementaryView(
//            ofKind: kind,
//            withReuseIdentifier: SectionHeaderView.identifier,
//            for: indexPath
//        ) as! SectionHeaderView
//
//        switch indexPath.section {
//        case 0:
//            header.titleLabel.text = "Upcoming Events"
//        case 1:
//            header.titleLabel.text = "Latest Events"
//        case 2:
//            header.titleLabel.text = "Teams"
//        default:
//            header.titleLabel.text = ""
//        }
//
//        return header
//    }
//    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
//        return NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .absolute(30)
//            ),
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top
//        )
//    }

}
