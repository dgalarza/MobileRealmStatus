import UIKit

class RealmCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        configureStyles()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyles()
    }

    var viewModel: Realm? {
        didSet {
            update()
        }
    }

    func includeStatusImage() {
        imageView?.image = UIImage(named: "Available")
    }

    private func configureStyles() {
        AppearanceManager.customizeRealmCell(self)
        textLabel?.font = UIFont.headlineFont()
        detailTextLabel?.font = UIFont.captionFont()
    }

    private func update() {
        textLabel?.text = viewModel?.name

        viewModel.map { detailTextLabel?.text = "Realm Type \($0.displayType())" }
    }
}
