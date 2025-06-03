//
//  FavTableViewController.swift
//  SporaApp
//
//  Created by macOS on 03/06/2025.
//

import UIKit

class FavTableViewController: UITableViewController ,FavoriteLeaguesViewProtocol{
    func showFavoriteLeagues(_ leagues: [LeagueModel]) {
        self.leagues = leagues
        print(leagues.count)
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchFavoriteLeagues()
    }

    
    func showNoInternetAlert() {
        let alert = UIAlertController(title: "No Internet", message: "Please check your connection.",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    var leagues : [LeagueModel] = []
    private var presenter: FavoriteLeaguesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoriteLeaguesPresenter(view: self)
        presenter.fetchFavoriteLeagues()
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        let league = leagues[indexPath.row]
        cell.leagueName.text = league.leagueName
        let url = URL(string: league.leagueLogo ?? "")
        cell.leagueImage.kf.setImage(with: url , placeholder: UIImage(named: "placeholder"))
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLeague = leagues[indexPath.row]
        let leagueId = selectedLeague.league_key ?? 0

        let detailsStoryboard = UIStoryboard(name: "Details", bundle: nil)
        let detailsVC = detailsStoryboard.instantiateViewController(withIdentifier: "DetailsLeaguesCollectionViewController") as! DetailsLeaguesCollectionViewController

        let detailsPresenter = LeagueDetailsPresenter(view: detailsVC, sportName: selectedLeague.sportName, leagueId: leagueId, league: selectedLeague)

        detailsVC.presenter = detailsPresenter
        
        NetworkManager.isInternetAvailable { isAvailable in
            DispatchQueue.main.async {
                if isAvailable {
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }else{
                    let alert = UIAlertController(title: "No Internet", message: "Please check your connection.",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure?",
                                          message: "Do you want to delete this favorite league?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.presenter.deleteLeague(league: self.leagues[indexPath.row])
            })
            present(alert, animated: true)
        }
    }
}
