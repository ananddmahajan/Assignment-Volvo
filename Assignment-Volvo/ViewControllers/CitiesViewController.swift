//
//  ViewController.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import UIKit
import KRProgressHUD

class CitiesViewController: UITableViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, CityLocationData>
    typealias DataSourceSnapShot = NSDiffableDataSourceSnapshot<Section, CityLocationData>
    
    private var dataSource: DataSource?
    let viewModel = CitiesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLocations()
        makeTableViewDataSource()
    }
    
    
    /// Description - responsible to navigate to weather forecast detail screen after tapping on table cell.
     private func showWeatherForecastDetailsForTomorrow(){
        let cityWeatherDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "weatherForecastData") as CityWeatherDetailsViewController
        cityWeatherDetailsViewController.cityWeatherDetailsViewModel.consolidatedWeather = viewModel.weather
        self.navigationController?.pushViewController(cityWeatherDetailsViewController, animated: true)
        
    }
}

extension CitiesViewController {
    /// Description load locations
    private func loadLocations() {
        KRProgressHUD.show()
        viewModel.getLocations { [weak self] in
            DispatchQueue.main.async {
                self?.applySnapshot()
                KRProgressHUD.dismiss()
            }
        }
    }
    
    /// Description - get weather forecast data for selected city
    /// - Parameter index: selected city index
    private func getWeatherForecast(index: Int) {
           
            KRProgressHUD.show()
            let weather = viewModel.locations[index]
            
                viewModel.getWeatherForecastOfDate(with: weather.earthId) { [weak self] (error) in
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

extension CitiesViewController {
    
    ///tableview diffable methods
    private func makeTableViewDataSource() {
         dataSource = DataSource(tableView: self.tableView) { [weak self] (tableView, indexPath, city) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "citiesIdentifier", for: indexPath)
            //cell.textLabel?.text = self?.viewModel.citites[indexPath.row].cityName
            cell.textLabel?.text = self?.viewModel.locations[indexPath.row].title
            return cell
        }
    }
    
    ///tableview diffable methods
    private func applySnapshot(animation: Bool = true) {
        var snapShot = DataSourceSnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(self.viewModel.locations)
        dataSource?.apply(snapShot, animatingDifferences: animation, completion: nil)
    }
    
    /// Description - table view delegate method
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getWeatherForecast(index: indexPath.row)
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



