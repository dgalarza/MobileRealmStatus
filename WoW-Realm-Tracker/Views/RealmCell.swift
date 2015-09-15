import UIKit

class RealmCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        configureStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyles()
    }

    var viewModel: RealmViewModel? {
        didSet {
            update()
        }
    }

    func includeStatusImage() {
        if let viewModel = self.viewModel {
            imageView?.image = UIImage(named: viewModel.availabilityImage)
        }
    }

    private func configureStyles() {
        AppearanceManager.customizeRealmCell(self)
        textLabel?.font = UIFont.headlineFont()
        detailTextLabel?.font = UIFont.captionFont()
    }

    private func update() {
        if let viewModel = self.viewModel {
            let favoritedImage = UIImage(named: viewModel.favoritedImage)
            accessoryView = UIImageView(image: favoritedImage)
            textLabel?.text = viewModel.name
            detailTextLabel?.text = "Realm Type \(viewModel.type)"
        }
    }
}
