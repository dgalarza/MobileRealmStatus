class RealmsTableViewController: BaseRealmsTableViewController {
    var searchResultsController: UISearchController?
    var resultsViewController: ResultsTableViewController?
    var searchResultsUpdater: RealmSearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        resultsViewController = ResultsTableViewController()
        realms = favoriteRealmsController.map { $0.realms } ?? []
        searchResultsUpdater = RealmSearchController(realms: realms, searchDelegate: resultsViewController!)

        resultsViewController?.favoriteRealmsController = favoriteRealmsController
        searchResultsController = UISearchController(searchResultsController: resultsViewController)
        searchResultsController?.searchResultsUpdater = searchResultsUpdater!
        searchResultsController?.searchBar.sizeToFit()

        tableView.tableHeaderView = searchResultsController?.searchBar

        definesPresentationContext = true
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.translucent = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.translucent = false
    }
}
