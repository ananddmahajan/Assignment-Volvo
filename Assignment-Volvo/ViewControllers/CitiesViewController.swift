//
//  ViewController.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import UIKit
import KRProgressHUD

class CitiesViewController: UITableViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, City>
    typealias DataSourceSnapShot = NSDiffableDataSourceSnapshot<Section, City>
    
    private var dataSource: DataSource?
    let viewModel = CitiesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeTableViewDataSource()
        applySnapshot()
    }
    
    
    /// Description - responsible to navigate to weather forecast detail screen after tapping on table cell.
     private func showWeatherForecastDetailsForTomorrow(){
        let cityWeatherDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "weatherForecastData") as CityWeatherDetailsViewController
        cityWeatherDetailsViewController.cityWeatherDetailsViewModel.consolidatedWeather = viewModel.weather
        self.navigationController?.pushViewController(cityWeatherDetailsViewController, animated: true)
        
    }
}

extension CitiesViewController {
    
    /// Description - table view delegate method
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        KRProgressHUD.show()
        let weather = viewModel.getlocationMetaDataForSelectedCity(selectedIndex: indexPath.row)
        if let earthId = weather?.earthId {
            viewModel.getWeatherForecastOfDate(with: earthId) { [weak self] (error) in
                if let error = error {
                    self?.removeHUD()
                    DispatchQueue.main.async {
                        self?.displayErrorMessage(errMessage: error.errorDescription ?? "")
                    }
                } else {
                    self?.removeHUD()
                    DispatchQueue.main.async {
                        self?.showWeatherForecastDetailsForTomorrow()
                    }
                }
            }
        }
    }
}

extension CitiesViewController {
    
    ///tableview diffable methods
    private func makeTableViewDataSource() {
         dataSource = DataSource(tableView: self.tableView) { [weak self] (tableView, indexPath, city) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "citiesIdentifier", for: indexPath)
            cell.textLabel?.text = self?.viewModel.citites[indexPath.row].cityName
            return cell
        }
    }
    
    ///tableview diffable methods
    private func applySnapshot(animation: Bool = true) {
        var snapShot = DataSourceSnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(self.viewModel.citites)
        dataSource?.apply(snapShot, animatingDifferences: animation, completion: nil)
    }
}
extension CitiesViewController {
    enum Section {
        case main
    }
    
    /// remove HUD from screen.
    private func removeHUD() {
        DispatchQueue.main.async {
            KRProgressHUD.dismiss()
        }
    }
}



